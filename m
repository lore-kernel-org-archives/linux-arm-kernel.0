From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 30 Nov 2009 14:21:16 +0100
Subject: kernel BUG at kernel/posix-cpu-timers.c:1389!
In-Reply-To: <20091102165441.GE5785@n2100.arm.linux.org.uk>
References: <3972542e0910300953s725bebd0ua5a0d1db557d408a@mail.gmail.com>
	<f17812d70910310732o5568a183i2504d2d926a95df1@mail.gmail.com>
	<4AEF0D3D.4070708@atmel.com>
	<20091102165441.GE5785@n2100.arm.linux.org.uk>
Message-ID: <20091130132116.GA18171@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 02, 2009 at 04:54:41PM +0000, Russell King - ARM Linux wrote:
> On Mon, Nov 02, 2009 at 05:47:57PM +0100, Nicolas Ferre wrote:
> > in arch/arm/mach-at91/at91sam926x_time.c +125
> >  .flags = IRQF_SHARED | IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
> > 
> > IRQF_DISABLED is positionned. But on the other hand, I saw in the kernel
> > booting messages that:
> > "IRQ 1/rtc0: IRQF_DISABLED is not guaranteed on shared IRQs"
> > 
> > What does this mean ? what is the difference with former way of managing
> > shared interrupts ?
> 
> If the first IRQ action which is run was registered without IRQF_DISABLED
> the entire set will be run without interrupts disabled.
... unless one of the handlers enables irqs, so all bets are off for all
but the first handler.
 
> > And above all, what is the proper way to set an IRQ on a shared
> > interrupt line ?
> 
> The only real solution is to ensure that all requesters use IRQF_DISABLED.
Back to the original problem: can you provide the contents of
/proc/interrupts and the output of dmesg?

I once saw that an oops containing the last time and location when irqs
where enabled and disabled.  That would be great here.  I don't know
off-hand where to find a patch and it doesn't seem to be supported in
mainline.  I will come back on this.

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
