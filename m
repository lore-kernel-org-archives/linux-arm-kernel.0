From: hjk@linutronix.de (Hans J. Koch)
Date: Thu, 12 Aug 2010 14:15:04 +0200
Subject: [PATCH v2] mx35: Fix boot ROM hang in internal boot mode
In-Reply-To: <20100812112938.GB8670@local>
References: <20100811233721.GB6411@local>
	<20100812055753.GB9763@pengutronix.de>
	<20100812112938.GB8670@local>
Message-ID: <20100812121504.GC8670@local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 12, 2010 at 01:29:40PM +0200, Hans J. Koch wrote:
> On Thu, Aug 12, 2010 at 07:57:53AM +0200, Uwe Kleine-K?nig wrote:
> > > +	}
> > > +
> > > +	__raw_writel(cgr2, CCM_BASE + CCM_CGR2);
> > > +	__raw_writel(cgr3, CCM_BASE + CCM_CGR3);
> > Note that my question concerning the UART clock was less about UART1 vs
> > UART0 but more if the ROM really needs a UART clock.
> 
> In my tests on an mx35pdk board, I found these three clocks being the
> minimum set of additional clocks that need to be turned on. That means,
> if you turn off any of the three, it won't boot anymore.

For my tests, I didn't fully boot the kernel but inserted a while(1) after
the clock init sequence. I had the wachdog already initialized in the
bootloader, so after a few seconds it would boot again - or not.

If you fully boot the kernel, then the driver will probably switch on
the UART1 clock, so you don't notice the effect anymore. But the kernel
can hang _before_ drivers come up, and it should still work. That's
what hardware watchdogs are for.

As a sidenote, it should be clear that this patch is a workaround for
a serious chip bug of the MX35. The MX35 promises a watchdog that cannot
be turned off once triggered. That's true, but of course, in case of a
kernel crash, the watchdog has to be able to reliably reboot the system.
That is not the case. Any driver going wild and writing a zero to the
wrong register can easily turn the CPU into a desperate piece of silicon
as soon as the watchdog reset occurs.

Also note that this also affects a normal system reboot using arch_reset()
since that one also uses the hardware watchdog.

Thanks,
Hans
