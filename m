From: ynvich@gmail.com (Sergei Ianovich)
Date: Fri, 06 Dec 2013 13:16:52 +0400
Subject: [PATCH] serial: rewrite pxa2xx-uart to use 8250_core
In-Reply-To: <20131206024211.GK16425@us.netrek.org>
References: <20131205043544.GA28580@kroah.com>
 <1386286149-2855-1-git-send-email-ynvich@gmail.com>
 <20131206024211.GK16425@us.netrek.org>
Message-ID: <1386321412.7152.25.camel@host5.omatika.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-12-06 at 13:42 +1100, James Cameron wrote:
> On Fri, Dec 06, 2013 at 03:28:37AM +0400, Sergei Ianovich wrote:
> > +/* Uart divisor latch write */
> > +static void serial_pxa_dl_write(struct uart_8250_port *up, int value)
> > +{
> > +	serial_out(up, UART_DLL, value & 0xff);
> > +	serial_out(up, UART_DLM, value >> 8 & 0xff);
> > +}
> 
> This is a change.  drivers/tty/serial/pxa.c did read back UART_DLL as
> an errata work around:
> 
> > -	/*
> > -	 * work around Errata #75 according to Intel(R) PXA27x Processor Family
> > -	 * Specification Update (Nov 2005)
> > -	 */
> > -	dll = serial_in(up, UART_DLL);
> > -	WARN_ON(dll != (quot & 0xff));
> 
> If this is no longer needed, serial_pxa_dl_write can be removed
> because it is same as default_serial_dl_write.

Thanks for spotting this. I prepared infrastructure, but the tests never
failed so I never returned here. I've filed v2 with correct dl_write.

> I did not check the other errata work arounds.

I've intentionally dropped workaround for E20 from old pxa.c
receive_chars(). 8250_core reads FIFO immediately after it checks DR bit
in LSR, so that issue never happens. New version states this in commit
message.
