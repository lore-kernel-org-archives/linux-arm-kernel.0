From: miquel.raynal@free-electrons.com (Miquel RAYNAL)
Date: Fri, 13 Oct 2017 09:29:16 +0200
Subject: [PATCH 04/16] serial: mvebu-uart: support probe of multiple ports
In-Reply-To: <87vajkblol.fsf@free-electrons.com>
References: <20171006101344.15590-1-miquel.raynal@free-electrons.com>
 <20171006101344.15590-5-miquel.raynal@free-electrons.com>
 <87poa0foro.fsf@free-electrons.com> <20171009091711.528adddd@xps13>
 <87vajkblol.fsf@free-electrons.com>
Message-ID: <20171013092916.2b97db55@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Gregory,

On Thu, 12 Oct 2017 14:22:18 +0200
Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:

> Hi Miquel,
>  
>  On lun., oct. 09 2017, Miquel RAYNAL
> <miquel.raynal@free-electrons.com> wrote:
> 
> > On Fri, 06 Oct 2017 14:23:55 +0200
> > Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:
> >  
> >> Hi Miquel,
> >>  
> >>  On ven., oct. 06 2017, Miquel Raynal
> >> <miquel.raynal@free-electrons.com> wrote:
> >>   
> >> > From: Allen Yan <yanwei@marvell.com>
> >> >
> >> > Until now, the mvebu-uart driver only supported probing a single
> >> > UART port. However, some platforms have multiple instances of
> >> > this UART controller, and therefore the driver should support
> >> > multiple ports.
> >> >
> >> > In order to achieve this, we make sure to assign port->line
> >> > properly, instead of hardcoding it to zero.
> >> >
> >> > Signed-off-by: Allen Yan <yanwei@marvell.com>
> >> > Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
> >> > ---
> >> >  drivers/tty/serial/mvebu-uart.c | 13 +++++++++++--
> >> >  1 file changed, 11 insertions(+), 2 deletions(-)
> >> >
> >> > diff --git a/drivers/tty/serial/mvebu-uart.c
> >> > b/drivers/tty/serial/mvebu-uart.c index
> >> > 7e0a3e9fee15..25b11ede3a97 100644 ---
> >> > a/drivers/tty/serial/mvebu-uart.c +++
> >> > b/drivers/tty/serial/mvebu-uart.c @@ -560,7 +560,16 @@ static
> >> > int mvebu_uart_probe(struct platform_device *pdev) return
> >> > -EINVAL; }
> >> >  
> >> > -	port = &mvebu_uart_ports[0];
> >> > +	if (pdev->dev.of_node)
> >> > +		pdev->id = of_alias_get_id(pdev->dev.of_node,
> >> > "serial");    
> >> 
> >> If the id is retrieved using an of_ function, then I think that the
> >> driver would depend on OF_CONFIG.  
> >
> > Is this okay?
> >
> > if (pdev->dev.of_node && IS_ENABLED(CONFIG_OF))
> >         pdev->id = of_alias_get_id(pdev->dev.of_node, "serial");  
> 
> Actually if CONFIG_OF is not enabled, then dev->dev.of_node. So you
> can keep the test but just remove the test on IS_ENABLED(CONFIG_OF).
> 
> But my remark about CONFIG_OF, was more to point that if there is no
> device tree support then this part of code won't work well if you have
> several ports using the same driver.

Ok.

> 
> So either you keep your driver as is but make it depends on CONFIG_OF
> to make it clear that it won't work with ACPI. Or you add the case for
> ACPI, but I think you don't have a board with ACPI support so you
> won't be able to test it.
> 
> A third solution would be to have a fallback when of_alias_get_id
> failed (either because there is no alias in the device tree or there
> is no device tree at all). In this case you can just increment the id
> for each new port.

This is the solution I choose. I used this driver as an example:
drivers/gpu/drm/omapdrm/dss/display.c

Please have a look at it in the next version.

Thanks,
Miqu?l

> 
> Gregory
> 
> 
> > else
> >         pdev->id = 0;
> >
> > BTW, I could not test without CONFIG_OF as it is defined by default
> > in our case: Selected by: ARM64 [=y]
> > I don't think there will be a 32-bit SoC with this UART IP?
> >
> > Thanks,
> > Miqu?l
> >  
> >> 
> >> Gregory
> >> 
> >>   
> >> > +
> >> > +	if (pdev->id >= MVEBU_NR_UARTS) {
> >> > +		dev_err(&pdev->dev, "cannot have more than %d
> >> > UART ports\n",
> >> > +			MVEBU_NR_UARTS);
> >> > +		return -EINVAL;
> >> > +	}
> >> > +
> >> > +	port = &mvebu_uart_ports[pdev->id];
> >> >  
> >> >  	spin_lock_init(&port->lock);
> >> >  
> >> > @@ -572,7 +581,7 @@ static int mvebu_uart_probe(struct
> >> > platform_device *pdev) port->fifosize   = 32;
> >> >  	port->iotype     = UPIO_MEM32;
> >> >  	port->flags      = UPF_FIXED_PORT;
> >> > -	port->line       = 0; /* single port: force line number
> >> > to  0 */
> >> > +	port->line       = pdev->id;
> >> >  
> >> >  	port->irq        = irq->start;
> >> >  	port->irqflags   = 0;
> >> > -- 
> >> > 2.11.0
> >> >
> >> >
> >> > _______________________________________________
> >> > linux-arm-kernel mailing list
> >> > linux-arm-kernel at lists.infradead.org
> >> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel    
> >>   
> >
> >
> >
> > -- 
> > Miquel Raynal, Free Electrons
> > Embedded Linux and Kernel engineering
> > http://free-electrons.com  
> 



-- 
Miquel Raynal, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
