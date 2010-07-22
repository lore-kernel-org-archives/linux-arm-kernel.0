From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 22 Jul 2010 09:40:59 +0100
Subject: [PATCH 1/3] U6/U6715 ARM architecture files
In-Reply-To: <1279531495-16225-2-git-send-email-philippe.langlais@stericsson.com>
References: <1279531495-16225-1-git-send-email-philippe.langlais@stericsson.com>
	<1279531495-16225-2-git-send-email-philippe.langlais@stericsson.com>
Message-ID: <20100722084059.GJ6802@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 19, 2010 at 11:24:53AM +0200, Philippe Langlais wrote:
> +/*
> + * Macros to group U6xxx into cpu classes.
> + * These can be used in most places.
> + * cpu_is_u67xx():	True for U67XX
> + */
> +
> +#define GET_U6XXX_CLASS		((inl(SCON_SYSVER_REG)&0x0F00)>>8)
> +#define GET_U6XXX_SUBCLASS	((inl(SCON_SYSVER_REG)&0x0FF0)>>4)

Bah.  Still finding ISA/PCI IO macros in your source.  Can you review
your own patches and eliminate all {in,out}s?[bwl] calls please?
(that's inb, inw, inl, insb, insw, insl, and the out variants too...)

> +static void u6_clockevent_init_mmtu(void)
> +{
> +	printk(PKMOD "clockevent_init_mmtu\n");
> +
> +	/* prescale 13Mhz -> 1Mhz */
> +#ifndef U6_MMTU_CLOCK_SOURCE
> +	u6_mmtu_timer_init(0, 0, (MMTU_SYS_FRQ / MMTU_ROOT_FRQ), 0);
> +#endif
> +
> +/* issue it is shorter than reality and generates spurious irq */
> +/*      clockevent_mmtu.mult = div_sc(MMTU_ROOT_FRQ, NSEC_PER_SEC,
> + *      clockevent_mmtu.shift) + 1;*/

Shouldn't these comments be indented?

> +	clockevent_mmtu.mult =
> +	    div_sc(MMTU_ROOT_FRQ, NSEC_PER_SEC, clockevent_mmtu.shift);
> +
> +/*      clockevent_mmtu.max_delta_ns = div_sc(RELOAD_COUNTER_MMTU,
> + *      clockevent_mmtu.mult, clockevent_mmtu.shift);*/
> +/*  In fact it is wider than the 32bits variable !!! */

Ditto.

> +	clockevent_mmtu.max_delta_ns = 0xFFFFFFFF;
> +
> +/*  MMTU HW limitation: match register can't be set w/ tcval+1 */
> +/*      clockevent_mmtu.min_delta_ns = div_sc(1, clockevent_mmtu.mult,
> + *      clockevent_mmtu.shift)+1;*/

Ditto.
