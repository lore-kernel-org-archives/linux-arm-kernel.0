From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 15 Mar 2013 12:15:54 +0000
Subject: [PATCH v2 05/14] ARM: integrator: use clocksource_of_init for
 sp804
In-Reply-To: <CACRpkdZjddrHgTu+fjYVOb0Pk+1VYUU=S7LU_O_vdNKYH_vjiw@mail.gmail.com>
References: <1363108124-17484-1-git-send-email-haojian.zhuang@linaro.org>
 <1363108124-17484-6-git-send-email-haojian.zhuang@linaro.org>
 <513F7EBD.80207@gmail.com> <201303121933.47994.arnd@arndb.de>
 <513F9597.8050000@gmail.com>
 <CAD6h2NTNFZM4cgDmCJG+NrNbd27MdXGGsRCTpC1bJGeMAgcP-g@mail.gmail.com>
 <CACRpkdbCJd-ag1gLrJqJZ1D6+E5eX2tNuuNAtiKgtuBsxmrpmA@mail.gmail.com>
 <CAD6h2NRDJuGTTZ1B0iy__2SYYw7R18NRqQcwjsSvMJ3gA4E_WQ@mail.gmail.com>
 <CACRpkdZjddrHgTu+fjYVOb0Pk+1VYUU=S7LU_O_vdNKYH_vjiw@mail.gmail.com>
Message-ID: <20130315121554.GH4977@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 13, 2013 at 10:00:14AM +0100, Linus Walleij wrote:
> Then the Integrator/AP timer has this code in the
> integrator_clockevent_init() function:
> 
> 	clkevt_base = base;
> 	/* Calculate and program a divisor */
> 	if (rate > 0x100000 * HZ) {
> 		rate /= 256;
> 		ctrl |= TIMER_CTRL_DIV256;
> 	} else if (rate > 0x10000 * HZ) {
> 		rate /= 16;
> 		ctrl |= TIMER_CTRL_DIV16;
> 	}
> 
> It appears the SP804 has no code to handle this
> divisor/prescaler at all. Which means that you regress
> the Integrator/AP again.
> 
> It appears (from arm_timer.h) that the SP804 actually
> has this prescaler, but then first make a separate patch
> to make the SP804 driver use that divisor (like above) so
> you don't degrade the quality of the AP timer. The prescaler
> make it possible to let the system sleep for longer times
> when using NO_HZ so it's *pretty* important (and it will
> increas the quality of all SP804-based machines as well).
> 
> As you surely understand, since the counter on the
> Integrator/AP is only 16 bit this is very important, since
> we don't want it to wake up too often.
> 
> Then the clocksource init function has this:
> 
> 	if (rate >= 1500000) {
> 		rate /= 16;
> 		ctrl |= TIMER_CTRL_DIV16;
> 	}
> 
> Here I'm more uncertain. As I know from extensive
> discussions with John and Thomas, there are many many
> factors to decide the clocksource. Basically the above lines
> limits the precision of the clocksource in exchange for a
> longer time until wrap-around. Again, the 16bit nature of the
> Integrator/AP timer is a factor here.

Integrator/AP selects the prescaler based on the fact that it is only a
16-bit counter, which has to be clocked at a rate which gives us our
desired periodic tick interval.

SP804 does not do this because, being a 32-bit counter, it is completely
unnecessary to use the prescaler - and using the prescaler will result
in loss of fine-grained timing accuracy.  Making use of the prescaler
there is absurd - the timer will run to 4000 odd seconds before wrapping
with a prescaler of 1.

You end up needing 64-bit arithmetic if you try to apply the Integrator/AP
logic to SP804 - it becomes this:

 	if (rate > 0x1000000000 * HZ) {
 		rate /= 256;
 		ctrl |= TIMER_CTRL_DIV256;
 	} else if (rate > 0x100000000 * HZ) {
 		rate /= 16;
 		ctrl |= TIMER_CTRL_DIV16;
 	}

or more precisely:
	if (rate > HZ * 0x100 * ((unsigned long long)wrap + 1)) {
...
 	} else if (rate > HZ * 0x10 * ((unsigned long long)wrap + 1)) {
...

You need that wrap value anyway for clockevents_config_and_register.
