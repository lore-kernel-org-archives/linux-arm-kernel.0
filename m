From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 16 Mar 2014 15:29:53 +0000
Subject: PL310 errata workarounds
In-Reply-To: <20140314144835.GP21483@n2100.arm.linux.org.uk>
References: <20140314144835.GP21483@n2100.arm.linux.org.uk>
Message-ID: <20140316152953.GX21483@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Okay, I've been going through the various initialisations of the L2x0
cache code, and there's some really fun stuff going on here:

arch/arm/mach-imx/system.c:
	/* Configure the L2 PREFETCH and POWER registers */
	val = readl_relaxed(l2x0_base + L2X0_PREFETCH_CTRL);
	val |= 0x70800000;
	/*
	 * The L2 cache controller(PL310) version on the i.MX6D/Q is r3p1-50rel0
	 * The L2 cache controller(PL310) version on the i.MX6DL/SOLO/SL is r3p2
	 * But according to ARM PL310 errata: 752271
	 * ID: 752271: Double linefill feature can cause data corruption
	 * Fault Status: Present in: r3p0, r3p1, r3p1-50rel0. Fixed in r3p2
	 * Workaround: The only workaround to this erratum is to disable the
	 * double linefill feature. This is the default behavior.
	 */
	if (cpu_is_imx6q())
		val &= ~(1 << 30 | 1 << 23);
	writel_relaxed(val, l2x0_base + L2X0_PREFETCH_CTRL);
        val = L2X0_DYNAMIC_CLK_GATING_EN | L2X0_STNDBY_MODE_EN;
        writel_relaxed(val, l2x0_base + L2X0_POWER_CTRL);

You can wonder why we don't have 752271 implemented by the core code.

arch/arm/mach-prima2/l2x0.c:
struct l2x0_aux
{
        u32 val;
        u32 mask;
};

static struct l2x0_aux prima2_l2x0_aux __initconst = {
        .val = 2 << L2X0_AUX_CTRL_WAY_SIZE_SHIFT,
        .mask = 0,
};

static struct l2x0_aux marco_l2x0_aux __initconst = {
        .val = (2 << L2X0_AUX_CTRL_WAY_SIZE_SHIFT) |
                (1 << L2X0_AUX_CTRL_ASSOCIATIVITY_SHIFT),
        .mask = L2X0_AUX_CTRL_MASK,
};

static struct of_device_id sirf_l2x0_ids[] __initconst = {
        { .compatible = "sirf,prima2-pl310-cache", .data = &prima2_l2x0_aux, },
        { .compatible = "sirf,marco-pl310-cache", .data = &marco_l2x0_aux, },
        {},
};

static int __init sirfsoc_l2x0_init(void)
{
        struct device_node *np;
        const struct l2x0_aux *aux;

        np = of_find_matching_node(NULL, sirf_l2x0_ids);
        if (np) {
                aux = of_match_node(sirf_l2x0_ids, np)->data;
                return l2x0_of_init(aux->val, aux->mask);
        }

        return 0;
}
early_initcall(sirfsoc_l2x0_init);

This shows everything that is /BAD/ about DT.  People go running around
stuffing crap like this in rather than thinking about the generic problem.
The sole function of the above compatible strings is to select between
different cache property configurations.  Now go back and look at the
iMX code above, which is doing the same thing but at runtime.

Now think: why don't we _already_ have a dt property or two to specify
this information?

The reason why we don't have that is because people do not think beyond
their nose when they encounter a problem.  They will not think whether
it should be fixed in a generic way.  They will not look to see whether
other people are suffering the same problem.

The big problem is that _now_ we have to support this fuckage for ever,
and all because people can't look beyond their immediate problem.

arch/arm/mach-zynq/common.c:
static void __init zynq_init_machine(void)
{
        /*
         * 64KB way size, 8-way associativity, parity disabled
         */
        l2x0_of_init(0x02060000, 0xF0F0FFFF);

Oh look, same problem again.

arch/arm/mach-ux500/cache-l2x0.c:
        /* DBx540's L2 has 128KB way size */
        if (cpu_is_ux540_family())
                /* 128KB way size */
                aux_val |= (0x4 << L2X0_AUX_CTRL_WAY_SIZE_SHIFT);
        else
                /* 64KB way size */
                aux_val |= (0x3 << L2X0_AUX_CTRL_WAY_SIZE_SHIFT);

        /* 64KB way size, 8 way associativity, force WA */
        if (of_have_populated_dt())
                l2x0_of_init(aux_val, 0xc0000fff);
        else
                l2x0_init(l2x0_base, aux_val, 0xc0000fff);

Okay, this has to cope with non-DT as well, but for the DT case, it is
again the same damned problem.

arch/arm/mach-nomadik/cpu-8815.c:
#ifdef CONFIG_CACHE_L2X0
        /* At full speed latency must be >=2, so 0x249 in low bits */
        l2x0_of_init(0x00730249, 0xfe000fff);
#endif

Do we actually end up with 0x249 in the low bits - because the fff in
the mask field preserves the values already in the aux register.
Moreover, don't we have DT properties to specify this information already,
so why isn't nomadik using them?  Nomadik is using a DT compatible string
of "arm,l210-cache", which has the properties "arm,tag-latency",
"arm,data-latency", "arm,dirty-latency" which allow that 0x249 to be
specified.

What the real painful bit here is that we have all these DT files out
there now which make the assumption that this code is going to always be
there, and there's not a /damned/ thing we can do with this crap now.
The best we can do is to try and stop this crap spreading further than
it already has.

Yes, I'm pissed off with DT.  I'm pissed off with people not thinking
before creating this crap as well.  I'm pissed off with the people who
allegedly reviewed this crap.  I'm pissed off with the people who
allegedly reviewed the creation of these SoC specific compatible
strings just to be able to specify configuration data.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
