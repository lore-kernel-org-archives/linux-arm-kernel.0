From: frans.klaver@xsens.com (Frans Klaver)
Date: Wed, 20 Aug 2014 11:39:37 +0200
Subject: [PATCH 03/15] tty: serial: 8250_core: add run time pm
In-Reply-To: <20140820092319.GA20775@ci00147.xsens-tech.local>
References: <1408124563-31541-1-git-send-email-bigeasy@linutronix.de>
 <1408124563-31541-4-git-send-email-bigeasy@linutronix.de>
 <20140820092319.GA20775@ci00147.xsens-tech.local>
Message-ID: <20140820093936.GB20775@ci00147.xsens-tech.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 20, 2014 at 11:23:21AM +0200, Frans Klaver wrote:
> Hi,
> 
> On Fri, Aug 15, 2014 at 07:42:31PM +0200, Sebastian Andrzej Siewior wrote:
> > --- a/drivers/tty/serial/8250/8250_core.c
> > +++ b/drivers/tty/serial/8250/8250_core.c
> > @@ -1899,12 +1984,22 @@ static void wait_for_xmitr(struct uart_8250_port *up, int bits)
> >  
> >  static int serial8250_get_poll_char(struct uart_port *port)
> >  {
> > -	unsigned char lsr = serial_port_in(port, UART_LSR);
> > +	unsigned char lsr;
> > +	int status;
> > +
> > +	serial8250_rpm_get(up);
> 
> or up won't be defined below. You probably need 

Obviously I meant to say that 'up' won't be defined here.


> +	struct uart_8250_port *up = up_to_u8250p(port);
> somewhere in there.
> 
> > -	if (!(lsr & UART_LSR_DR))
> > -		return NO_POLL_CHAR;
> > +	lsr = serial_port_in(port, UART_LSR);
> >  
> > -	return serial_port_in(port, UART_RX);
> > +	if (!(lsr & UART_LSR_DR)) {
> > +		status = NO_POLL_CHAR;
> > +		goto out;
> > +	}
> > +
> > +	status = serial_port_in(port, UART_RX);
> > +out:
> > +	serial8250_rpm_put(up);
> > +	return status;
> >  }
> 
> Cheers,
> Frans
