From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 08 Nov 2011 16:11:15 +0000
Subject: [RFC 3/6] ARM: vexpress: Add DT support in v2m
In-Reply-To: <4EB93A04.1020009@gmail.com>
References: <1320758169-22668-1-git-send-email-pawel.moll@arm.com>
 <1320758169-22668-4-git-send-email-pawel.moll@arm.com>
 <4EB93A04.1020009@gmail.com>
Message-ID: <1320768675.3259.114.camel@hornet.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-11-08 at 14:17 +0000, Rob Herring wrote:
> > +void __init v2m_dt_map_io(enum v2m_memory_map map)
> > +{
> > +	switch (map) {
> > +	case v2m_memory_map_legacy:
> > +		iotable_init(v2m_io_desc, ARRAY_SIZE(v2m_io_desc));
> > +		break;
> > +	default:
> > +		panic("%s: Unknown memory map requested!\n", __func__);
> > +		break;
> 
> I don't like this approach. Why don't you either have 2 DT machine_descs
> for legacy and new memory map 

Well, I do, actually :-)

> > +static void __init v2p_ca9_map_io(void)
> > +{
> > +       v2m_dt_map_io(v2m_memory_map_legacy);
> <...>
> > +DT_MACHINE_START(VEXPRESS_V2P_CA9, "ARM Versatile Express V2P-CA9")
> > +       .map_io         = v2p_ca9_map_io,
> > +       .init_early     = v2p_ca9_init_early,
> > +       .init_irq       = v2p_ca9_init_irq,
> > +       .timer          = &v2m_timer,
> > +       .init_machine   = v2p_ca9_init,
> > +       .dt_compat      = v2p_ca9_dt_match,
> > +MACHINE_END

... and...

> > +static void __init v2p_ca5s_map_io(void)
> > +{
> > +       v2m_dt_map_io(v2m_memory_map_rs1);
> > +       iotable_init(v2p_ca5s_io_desc,
> > ARRAY_SIZE(v2p_ca5s_io_desc));
> <...>
> > +DT_MACHINE_START(VEXPRESS_V2P_CA5, "ARM Versatile Express
> > V2P-CA5s")
> > +       .map_io         = v2p_ca5s_map_io,
> > +       .init_early     = v2p_ca5s_init_early,
> > +       .init_irq       = v2p_ca5s_init_irq,
> > +       .timer          = &v2m_timer,
> > +       .init_machine   = v2p_ca5s_init,
> > +       .dt_compat      = v2p_ca5s_dt_match,
> > +MACHINE_END

> or use the machine compatible strings to select the io table.

I have a way compat variant for the legacy motherboard already:

> +       model = "V2P-CA9";
> +       compatible = "arm,vexpress-v2p-ca9", "arm,vexpress-legacy", "arm,vexpress";

so I could use it in v2m_dt_map_io(), but it has to be called from the
tile code anyway. And as the tile code knows what memory map is to be
used, I made my life easier :-)

This will most likely change if the A9 and A5 tiles merge...

> > +	}
> > +
> > +	/* Will become nice ioremap()-s once allowed */
> > +	v2m_sysreg_base = V2M_PERIPH_P2V(v2m_dt_periph_offset("sysreg"));
> > +	v2m_sysctl_base = V2M_PERIPH_P2V(v2m_dt_periph_offset("sysctl"));
> > +	v2m_timer01_base = V2M_PERIPH_P2V(v2m_dt_periph_offset("timer01"));
> 
> Generally, timers can be ioremapped already.

Yeah, I suppose I could simply ioremap() the timers (and sysctl, while
we are on that) in v2m_timer_init() itself...

> > +static struct of_dev_auxdata v2m_legacy_dt_auxdata_lookup[] __initdata = {
> > +	OF_DEV_AUXDATA("arm,vexpress-flash", V2M_NOR0, "physmap-flash",
> > +			&v2m_flash_data),
> > +	OF_DEV_AUXDATA("arm,primecell", V2M_WDT, "mb:wdt", NULL),
> > +	OF_DEV_AUXDATA("arm,primecell", V2M_MMCI, "mb:mmci", &v2m_mmci_data),
> > +	OF_DEV_AUXDATA("arm,primecell", V2M_KMI0, "mb:kmi0", NULL),
> > +	OF_DEV_AUXDATA("arm,primecell", V2M_KMI1, "mb:kmi1", NULL),
> > +	OF_DEV_AUXDATA("arm,primecell", V2M_UART0, "mb:uart0", NULL),
> > +	OF_DEV_AUXDATA("arm,primecell", V2M_UART1, "mb:uart1", NULL),
> > +	OF_DEV_AUXDATA("arm,primecell", V2M_UART2, "mb:uart2", NULL),
> > +	OF_DEV_AUXDATA("arm,primecell", V2M_UART3, "mb:uart3", NULL),
> 
> You are only adding platform_data in 2 cases, so that probably means the
> rest are for clkdev lookups. You can just add the lookups directly.

You're right that most of the auxdata is there purely for the clock
framework's sake. And I just followed the mach-versatile... So what do
you exactly mean? Extending the v2m_lookups[] like that?

        }, {    /* UART0 */
                .dev_id		= "mb:uart0",
                .clk            = &osc2_clk,
	}, {	/* UART0 DT */
		.dev_id		= "1c090000.uart",
                .clk            = &osc2_clk,
	}

If so, I'm not sure, really... I think Grant wanted to avoid exactly
that (and that's why he used auxdata in case of versatile...)
The platform data for the flash and mmci will disappear once I'm done
with the relevant bindings, so it would be nice to get rid of the
auxdata then, not waiting for the DT&clocks wedding day ;-)

> > +	{}
> > +};
> > +
> > +struct of_dev_auxdata * __init v2m_dt_get_auxdata(enum v2m_memory_map map)
> > +{
> > +	switch (map) {
> > +	case v2m_memory_map_legacy:
> > +		return v2m_legacy_dt_auxdata_lookup;
> 
> Because auxdata is matched against addresses, you can just put all
> entries into 1 table for both legacy and new memory map.

Good point. Will do.

Cheers!

Pawel
