From: miquel.raynal@free-electrons.com (Miquel RAYNAL)
Date: Fri, 13 Oct 2017 13:17:11 +0200
Subject: [PATCH v2 04/16] serial: mvebu-uart: support probe of multiple
 ports
In-Reply-To: <877evz9yi7.fsf@free-electrons.com>
References: <20171013090200.31034-1-miquel.raynal@free-electrons.com>
 <20171013090200.31034-5-miquel.raynal@free-electrons.com>
 <877evz9yi7.fsf@free-electrons.com>
Message-ID: <20171013131711.4ef63ea0@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

On Fri, 13 Oct 2017 11:40:32 +0200
Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:

> Hi Miquel,
>  
>  On ven., oct. 13 2017, Miquel Raynal
> <miquel.raynal@free-electrons.com> wrote:
> 
> > -	port = &mvebu_uart_ports[0];
> > +	/* Assume that all UART ports have a DT alias or none has
> > */
> > +	id = of_alias_get_id(pdev->dev.of_node, "serial");  
> 
> You stil need to check the pdev->dev.of_node before calling
> of_alias_get_id.

Thanks for your feedback but I don't think we still need to check it,
because the of_alias_get_id() function will either return -ENOSYS if
CONFIG_OF is not defined, or -ENODEV if the node is not found. As the
function does not dereference pdev->dev.of_node at any moment but
instead compares the value with another pointer, I think this call is
safe like this.

Thanks,
Miqu?l

> 
> Once it will be fixed, you can add:
> 
> Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> 
> Thanks,
> 
> Gregory
> 
> 
> > +	if (!pdev->dev.of_node || id < 0)
> > +		pdev->id = uart_num_counter++;
> > +	else
> > +		pdev->id = id;
> > +
> > +	if (pdev->id >= MVEBU_NR_UARTS) {
> > +		dev_err(&pdev->dev, "cannot have more than %d UART
> > ports\n",
> > +			MVEBU_NR_UARTS);
> > +		return -EINVAL;
> > +	}
> > +
> > +	port = &mvebu_uart_ports[pdev->id];
> >  
> >  	spin_lock_init(&port->lock);
> >  
> > @@ -572,7 +588,7 @@ static int mvebu_uart_probe(struct
> > platform_device *pdev) port->fifosize   = 32;
> >  	port->iotype     = UPIO_MEM32;
> >  	port->flags      = UPF_FIXED_PORT;
> > -	port->line       = 0; /* single port: force line number
> > to  0 */
> > +	port->line       = pdev->id;
> >  
> >  	port->irq        = irq->start;
> >  	port->irqflags   = 0;
> > -- 
> > 2.11.0
> >  
> 



-- 
Miquel Raynal, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
