From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 13 Mar 2013 10:00:14 +0100
Subject: [PATCH v2 05/14] ARM: integrator: use clocksource_of_init for
 sp804
In-Reply-To: <CAD6h2NRDJuGTTZ1B0iy__2SYYw7R18NRqQcwjsSvMJ3gA4E_WQ@mail.gmail.com>
References: <1363108124-17484-1-git-send-email-haojian.zhuang@linaro.org>
 <1363108124-17484-6-git-send-email-haojian.zhuang@linaro.org>
 <513F7EBD.80207@gmail.com> <201303121933.47994.arnd@arndb.de>
 <513F9597.8050000@gmail.com>
 <CAD6h2NTNFZM4cgDmCJG+NrNbd27MdXGGsRCTpC1bJGeMAgcP-g@mail.gmail.com>
 <CACRpkdbCJd-ag1gLrJqJZ1D6+E5eX2tNuuNAtiKgtuBsxmrpmA@mail.gmail.com>
 <CAD6h2NRDJuGTTZ1B0iy__2SYYw7R18NRqQcwjsSvMJ3gA4E_WQ@mail.gmail.com>
Message-ID: <CACRpkdZjddrHgTu+fjYVOb0Pk+1VYUU=S7LU_O_vdNKYH_vjiw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 13, 2013 at 8:09 AM, Haojian Zhuang
<haojian.zhuang@linaro.org> wrote:
> On 13 March 2013 14:41, Linus Walleij <linus.walleij@linaro.org> wrote:

>> Please restrict the patch set to Integrator/CP.
>
> According to Rob's comment, I thought that only prime-cell ID registers
> are not contained in integrator-timer controller.

No, you have missed the most important aspect of all.

The Integrator/AP timer is only 16 bit. Look:

static void integrator_clocksource_init(unsigned long inrate,
					void __iomem *base)
{
(...)
	clocksource_mmio_init(base + TIMER_VALUE, "timer2",
			rate, 200, 16, clocksource_mmio_readl_down);
(...)
}

Compare:

void __init __sp804_clocksource_and_sched_clock_init(void __iomem *base,
						     const char *name,
						     int use_sched_clock)
{
(...)
	clocksource_mmio_init(base + TIMER_VALUE, name,
		rate, 200, 32, clocksource_mmio_readl_down);
(...)
}

I had the idea of merging the drivers in the past so I'm
positive to the change from a larger perspective.
But then you also have to take the bit-width precision
into account.

If you apply the patch, the Integrator/AP will appear
to work, then if you leave it dormant until the counter
wraps around it will hang or screw up the timeline.

Another part of the problem I see is that the code in the
SP804 driver is lacking features found in the code for the
driver inside integrator_ap.c, I detail these below...

> Yes, I missed to include lookup to handle integrator-ap timer. I think that
> we can use a string name that are binded to different compatible name.
> Code is in below.
(...)
> sp804_get_clock_rate():
>     char dev_id_buf[ID_BUF_SIZE];
>     if (match->data)
>         snprintf(dev_id_buf, ID_BUF_SIZE, "ap_timer");
>     else
>         snprintf(dev_id_buf, ID_BUF_SIZE, "sp804");
>     clk = clk_get_sys(dev_id_buf, name);
>
> sp804_dt_init_clk():
>     char dev_id_buf[ID_BUF_SIZE];
>     if (match->data)
>         snprintf(dev_id_buf, ID_BUF_SIZE, "ap_timer");
>     else
>         snprintf(dev_id_buf, ID_BUF_SIZE, "sp804");
>     lookup = clkdev_alloc(clk, name, dev_id_buf);

If this is what you want to attain, I think it would be better to
just patch the clock lookups in
drivers/clk/clk-integrator.c and rename the "ap_timer"
lookup to "sp804" and skip all the above.

> I think it won't break out code any more. Since most code are same, we
> could handle it in the same driver.

So it will definately break stuff. Being 16bit is not all,
here are other differences:

static u32 notrace integrator_read_sched_clock(void)
{
	return -readl((void __iomem *) TIMER2_VA_BASE + TIMER_VALUE);
}

static void integrator_clocksource_init(unsigned long inrate,
					void __iomem *base)
{
(...)
	setup_sched_clock(integrator_read_sched_clock, 16, rate);
}

Since you do not call even integrator_clocksource_init() anymore
after this, you are breaking sched_clock() for the Integrator/AP.
The SP804 doesn't even have a sched_clock option.
You make it fall back to using jiffies.

So you would have to add this to the SP804 driver, and make
sure sched_clock() is registered for the "arm,integrator"
compatible string.

Then the Integrator/AP timer has this code in the
integrator_clockevent_init() function:

	clkevt_base = base;
	/* Calculate and program a divisor */
	if (rate > 0x100000 * HZ) {
		rate /= 256;
		ctrl |= TIMER_CTRL_DIV256;
	} else if (rate > 0x10000 * HZ) {
		rate /= 16;
		ctrl |= TIMER_CTRL_DIV16;
	}

It appears the SP804 has no code to handle this
divisor/prescaler at all. Which means that you regress
the Integrator/AP again.

It appears (from arm_timer.h) that the SP804 actually
has this prescaler, but then first make a separate patch
to make the SP804 driver use that divisor (like above) so
you don't degrade the quality of the AP timer. The prescaler
make it possible to let the system sleep for longer times
when using NO_HZ so it's *pretty* important (and it will
increas the quality of all SP804-based machines as well).

As you surely understand, since the counter on the
Integrator/AP is only 16 bit this is very important, since
we don't want it to wake up too often.

Then the clocksource init function has this:

	if (rate >= 1500000) {
		rate /= 16;
		ctrl |= TIMER_CTRL_DIV16;
	}

Here I'm more uncertain. As I know from extensive
discussions with John and Thomas, there are many many
factors to decide the clocksource. Basically the above lines
limits the precision of the clocksource in exchange for a
longer time until wrap-around. Again, the 16bit nature of the
Integrator/AP timer is a factor here.

Yours,
Linus Walleij
