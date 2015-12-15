From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Tue, 15 Dec 2015 07:41:36 -0800
Subject: [PATCH LINUX v4 06/13] tty: xuartps: Move request_irq to after
 setting up the HW
In-Reply-To: <5669F172.6020503@hurleysoftware.com>
References: <1449376769-13369-1-git-send-email-soren.brinkmann@xilinx.com>
 <1449376769-13369-7-git-send-email-soren.brinkmann@xilinx.com>
 <5669F172.6020503@hurleysoftware.com>
Message-ID: <20151215154136.GU3358@xsjsorenbubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-12-10 at 01:41PM -0800, Peter Hurley wrote:
> On 12/05/2015 08:39 PM, Soren Brinkmann wrote:
> > Request_irq() should be _after_ h/w programming, otherwise an
> > interrupt could be triggered and in-progress before the h/w has been
> > setup.
> 
> Slight misunderstanding. My fault; I should have been more explicit.
> 
> 1. Any setup necessary for the isr not to be confused and misdirect spurious
>    interrupts (or hang) should be before installing the isr with request_irq()
>    None of this code should trigger an interrupt.
> 2. Clear pending interrupts
> 3. Install the isr with request_irq()
> 4. Enable interrupts

Isn't that what the startup function is doing now - more or less. I
think 3 and 4 are swapped to release the lock and then do the
request_irq, but I believe that should be OK.
The startup function configures the HW. Clears the ISR. Enables the
intended IRQs and then does the request_irq call.

> 
> For extra safety, first disable interrupts before starting h/w programming.

It's done within spin_lock_irqsave, which gives us at least locally
disabled IRQs. I guess we could add a disabling all IRQs in the UART
core, but it should not really be necessary.

> 
> I would do the v5 series in the same order as the v3 series only up to
> what I reviewed. Then do another series with the remainder plus new changes, ok?

Sure.

	S?ren

> 
> Regards,
> Peter Hurley
> 
> > Reported-by: Peter Hurley <peter@hurleysoftware.com>
> > Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> > ---
> > v4:
> >  - this patch has been added. Thanks to Peter for pointing it out and providing
> >    commit message
> > ---
> >  drivers/tty/serial/xilinx_uartps.c | 9 ++-------
> >  1 file changed, 2 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
> > index 6ffd3bbe3e18..1e9053656610 100644
> > --- a/drivers/tty/serial/xilinx_uartps.c
> > +++ b/drivers/tty/serial/xilinx_uartps.c
> > @@ -759,12 +759,7 @@ static void cdns_uart_set_termios(struct uart_port *port,
> >  static int cdns_uart_startup(struct uart_port *port)
> >  {
> >  	unsigned long flags;
> > -	unsigned int retval = 0, status = 0;
> > -
> > -	retval = request_irq(port->irq, cdns_uart_isr, 0, CDNS_UART_NAME,
> > -								(void *)port);
> > -	if (retval)
> > -		return retval;
> > +	unsigned int status = 0;
> >  
> >  	spin_lock_irqsave(&port->lock, flags);
> >  
> > @@ -818,7 +813,7 @@ static int cdns_uart_startup(struct uart_port *port)
> >  
> >  	spin_unlock_irqrestore(&port->lock, flags);
> >  
> > -	return retval;
> > +	return request_irq(port->irq, cdns_uart_isr, 0, CDNS_UART_NAME, port);
> >  }
> >  
> >  /**
> > 
> 
