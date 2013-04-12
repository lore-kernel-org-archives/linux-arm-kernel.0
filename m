From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 12 Apr 2013 13:29:48 +0200
Subject: [PATCH 1/3] ARM/MVF600: add Vybrid Family platform support
In-Reply-To: <1365749825-20601-2-git-send-email-b35083@freescale.com>
References: <1365749825-20601-1-git-send-email-b35083@freescale.com>
 <1365749825-20601-2-git-send-email-b35083@freescale.com>
Message-ID: <20130412112948.GC10373@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Some comments inline.

On Fri, Apr 12, 2013 at 02:57:03PM +0800, Jingchang Lu wrote:
> This patch adds Freescale Vybrid Family platform core definitions,
> core drivers including clock, period interrupt timer(PIT),
> and DTS based machine support with MVF600 Tower development board.
> 
> Signed-off-by: Jingchang Lu <b35083@freescale.com>
> ---
>  arch/arm/mach-imx/Kconfig       |  39 +++++
>  arch/arm/mach-imx/Makefile      |   4 +
>  arch/arm/mach-imx/Makefile.boot |   4 +
>  arch/arm/mach-imx/clk-mvf.c     | 320 ++++++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-imx/common.h      |   3 +
>  arch/arm/mach-imx/mach-mvf600.c | 121 +++++++++++++++
>  arch/arm/mach-imx/pit.c         | 254 +++++++++++++++++++++++++++++++
>  7 files changed, 745 insertions(+)
>  create mode 100644 arch/arm/mach-imx/clk-mvf.c
>  create mode 100644 arch/arm/mach-imx/mach-mvf600.c
>  create mode 100644 arch/arm/mach-imx/pit.c
> 
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index 4c9c6f9..173258b 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -55,6 +55,16 @@ config MXC_USE_EPIT
>  	  uses the same clocks as the GPT. Anyway, on some systems the GPT
>  	  may be in use for other purposes.
>  
> +config HAVE_PIT
> +	bool
> +
> +config MXC_USE_PIT
> +	bool "Use PIT"
> +	depends on HAVE_PIT
> +	help
> +          Use PIT as the system timer on systems that have it
> +	  such as Vybrid platform.

Indention broken here.

> +config MACH_MVF600_TWR
> +	bool "Vybrid MVF600 Tower support"
> +	select SOC_MVF600
> +
> +	help
> +          Include support for Freescale Vybrid Family Tower Board
> +	  based on MVF600 SOC.

and here.

> +
>  endif
>  
>  source "arch/arm/mach-imx/devices/Kconfig"

[...]

> +++ b/arch/arm/mach-imx/clk-mvf.c
> @@ -0,0 +1,320 @@
> +/*
> + * Copyright 2012-2013 Freescale Semiconductor, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, write to the Free Software Foundation, Inc.,
> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

Please remove the FSF address. It's wrong and we don't want to keep it
up to date in the kernel.

> +int __init mvf_clocks_init(void)
> +{
> +	struct device_node *np;
> +	__iomem void *base;
> +	int irq;
> +
> +	clk[dummy] = imx_clk_fixed("dummy", 0);
> +	clk[sirc] = imx_clk_fixed("sirc", 32000); /* slow internal IRC */
> +	clk[firc] = imx_clk_fixed("firc", 24000000);/* fast internal IRC */
> +
> +	for_each_compatible_node(np, NULL, "fixed-clock") {
> +		u32 rate;
> +
> +		if (of_property_read_u32(np, "clock-frequency", &rate))
> +			continue;
> +		if (of_device_is_compatible(np, "fsl,mvf-ckil"))
> +			clk[sxosc] = imx_clk_fixed("sxosc", rate);
> +		else if (of_device_is_compatible(np, "fsl,mvf-osc"))
> +			clk[fxosc] = imx_clk_fixed("fxosc", rate);
> +		else if (of_device_is_compatible(np, "fsl,mvf-audio-ext-clk"))
> +			clk[audio_ext_clk] =
> +					imx_clk_fixed("audio_ext_clk", rate);
> +		else if (of_device_is_compatible(np, "fsl,mvf-enet-ext-clk"))
> +			clk[enet_ext_clk] = imx_clk_fixed("enet_ext", rate);
> +	}

Rather than doing it this way you should use some variables which you
initialize to sane defaults and overwrite them as necessary in the
for_each_compatible_node loop. This way you won't end up with
unitialized clocks when some clock is missing in the devicetree.

> +
> +	np = of_find_compatible_node(NULL, NULL, "fsl,mvf-anatop");
> +	anatop_base = of_iomap(np, 0);
> +	WARN_ON(!anatop_base);
> +
> +	np = of_find_compatible_node(NULL, NULL, "fsl,mvf-ccm");
> +	ccm_base = of_iomap(np, 0);
> +	WARN_ON(!ccm_base);
> +
> +	clk[slow_clk] = imx_clk_mux("slow_clk", CCM_CCSR, 4, 1,
> +			slow_clk_sel, ARRAY_SIZE(slow_clk_sel));
> +	clk[fast_clk] = imx_clk_mux("fast_clk", CCM_CCSR, 5, 1,
> +			fast_clk_sel, ARRAY_SIZE(fast_clk_sel));
> +
> +	clk[pll1_main_528m] = imx_clk_fixed_factor("pll1_main",
> +						"fast_clk", 22, 1);
> +	clk[pll1_pfd1_500m] = imx_clk_pfd("pll1_pfd1", "pll1_main",
> +						PFD_528SYS_BASE, 0);
> +	clk[pll1_pfd2_452m] = imx_clk_pfd("pll1_pfd2", "pll1_main",
> +						PFD_528SYS_BASE, 1);
> +	clk[pll1_pfd3_396m] = imx_clk_pfd("pll1_pfd3", "pll1_main",
> +						PFD_528SYS_BASE, 2);
> +	clk[pll1_pfd4_528m] = imx_clk_pfd("pll1_pfd4", "pll1_main",
> +						PFD_528SYS_BASE, 3);
> +
> +	clk[pll2_main_528m] = imx_clk_fixed_factor("pll2_main",
> +						"fast_clk", 22, 1);
> +	clk[pll2_pfd1_500m] = imx_clk_pfd("pll2_pfd1", "pll2_main",
> +						PFD_528_BASE, 0);
> +	clk[pll2_pfd2_396m] = imx_clk_pfd("pll2_pfd2", "pll2_main",
> +						PFD_528_BASE, 1);
> +	clk[pll2_pfd3_339m] = imx_clk_pfd("pll2_pfd3", "pll2_main",
> +						PFD_528_BASE, 2);
> +	clk[pll2_pfd4_413m] = imx_clk_pfd("pll2_pfd4", "pll2_main",
> +						PFD_528_BASE, 3);

I suggest ignoring the 80 character limit for most of this file. It will
make for better readability.

> +
> +	/* USB pll, 480Mhz */
> +	clk[pll3_main_480m] = imx_clk_fixed_factor("usb_main",
> +						"fast_clk", 20, 1);
> +	/* Audio pll */
> +	clk[pll4_main] = imx_clk_fixed_factor("audio_main", "fast_clk", 25, 1);
> +	/* Enet pll, fixed to 50Mhz on Vybrid */
> +	clk[pll5_main] = imx_clk_fixed_factor("pll5_main", "fast_clk", 125, 6);
> +	clk[enet_50m] = imx_clk_fixed_factor("enet_50m", "pll5_main", 1, 10);
> +	clk[enet_25m] = imx_clk_fixed_factor("enet_25m", "pll5_main", 1, 20);
> +	/* Video pll: default 960Mhz */
> +	clk[pll6_main] = imx_clk_fixed_factor("video_main", "fast_clk", 40, 1);
> +
> +	clk[pll1_pfd_sw] = imx_clk_mux("pll1_sw", CCM_CCSR, 16, 3,
> +			pll1_pfd_sel, ARRAY_SIZE(pll1_pfd_sel));
> +
> +	clk[pll2_pfd_sw] = imx_clk_mux("pll2_sw", CCM_CCSR, 19, 3,
> +			pll2_pfd_sel, ARRAY_SIZE(pll2_pfd_sel));
> +
> +	clk[sys_clk_sw] = imx_clk_mux("sys_sw", CCM_CCSR, 0, 3,
> +			sys_clk_sel, ARRAY_SIZE(sys_clk_sel));
> +
> +	clk[ddr_clk_sw] = imx_clk_mux("ddr_sw", CCM_CCSR, 6, 1,
> +			ddr_clk_sel, ARRAY_SIZE(ddr_clk_sel));
> +
> +	clk[sys_bus_clk] = imx_clk_divider("sys_bus", "sys_sw",
> +						CCM_CACRR, 0, 3);
> +	clk[platform_bus_clk] = imx_clk_divider("platform_bus", "sys_bus",
> +						CCM_CACRR, 3, 3);
> +	clk[ipg_bus_clk] = imx_clk_divider("ipg_bus", "platform_bus",
> +						CCM_CACRR, 11, 2);
> +
> +	clk[qspi0_clk_sw] = imx_clk_mux("qspi0_sw", CCM_CSCMR1, 22, 2,
> +					qspi_clk_sel, ARRAY_SIZE(qspi_clk_sel));
> +	clk[qspi0_x4_div] = imx_clk_divider("qspi0_x4", "qspi0_sw",
> +						CCM_CSCDR3, 0, 2);
> +	clk[qspi0_x2_div] = imx_clk_divider("qspi0_x2", "qspi0_x4",
> +						CCM_CSCDR3, 2, 1);
> +	clk[qspi0_x1_div] = imx_clk_divider("qspi0_x1", "qspi0_x2",
> +					CCM_CSCDR3, 3, 1);
> +	clk[qspi0_clk_gate] = imx_clk_gate("qspi0_clk", "qspi0_x1",
> +					CCM_CSCDR3, 4);
> +
> +	clk[enet_clk_sw] = imx_clk_mux("enet_sw", CCM_CSCMR2, 4, 2,
> +				rmii_clk_sel, ARRAY_SIZE(rmii_clk_sel));
> +	clk[enet_clk_gate] = imx_clk_gate("enet_clk", "enet_sw",
> +				CCM_CSCDR1, 24);
> +	clk[enet_ts_sw] = imx_clk_mux("enet_ts_sw", CCM_CSCMR2, 0, 3,
> +				enet_ts_clk_sel, ARRAY_SIZE(enet_ts_clk_sel));
> +	clk[enet_ts_gate] = imx_clk_gate("enet_ts_clk", "enet_ts_sw",
> +				CCM_CSCDR1, 23);
> +
> +	clk[pit_clk_gate] = imx_clk_gate2("pit_clk", "ipg_bus", CCM_CCGR1,
> +						CCM_CCGRx_CGn_OFFSET(7));
> +	clk[uart0_clk_gate] = imx_clk_gate2("uart0_clk", "ipg_bus", CCM_CCGR0,
> +						CCM_CCGRx_CGn_OFFSET(7));
> +
> +	/* Add the clocks to provider list */
> +	clk_data.clks = clk;
> +	clk_data.clk_num = ARRAY_SIZE(clk);
> +	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
> +
> +	clk_register_clkdev(clk[pit_clk_gate], "mvf-pit", NULL);
> +	clk_register_clkdev(clk[uart0_clk_gate], "mvf-uart", NULL);
> +	clk_register_clkdev(clk[uart0_clk_gate], "mvf_uart.0", NULL);
> +	clk_register_clkdev(clk[uart0_clk_gate], "mvf_uart.1", NULL);
> +	clk_register_clkdev(clk[enet_clk_gate], "fec.0", NULL);
> +	clk_register_clkdev(clk[enet_clk_gate], "fec.1", NULL);
> +	clk_register_clkdev(clk[enet_clk_gate], "switch.0", NULL);
> +	clk_register_clkdev(clk[qspi0_clk_gate], "qspi.0", NULL);

These shouldn't be here. You have the lookups in the devicetree anyway.

> +
> +	clk_set_parent(clk[qspi0_x4_div], clk[pll1_pfd4_528m]);
> +	clk_set_rate(clk[qspi0_x4_div],
> +			clk_get_rate(clk[qspi0_x4_div]->parent) / 2);
> +	clk_set_rate(clk[qspi0_x2_div],
> +			clk_get_rate(clk[qspi0_x2_div]->parent) / 2);
> +	clk_set_rate(clk[qspi0_x1_div],
> +			clk_get_rate(clk[qspi0_x1_div]->parent) / 2);
> +
> +
> +	clk_prepare(clk[pit_clk_gate]);
> +	clk_prepare(clk[uart0_clk_gate]);

No. Do not enable driver clocks here.

> +	clk_prepare(clk[enet_clk_gate]);
> +
> +	/* init system timer */
> +	np = of_find_compatible_node(NULL, NULL, "fsl,mvf-pit");
> +	base = of_iomap(np, 0);
> +	WARN_ON(!base);
> +	irq = irq_of_parse_and_map(np, 0);
> +	pit_timer_init(base, irq);

This should be switched to CLOCKSOURCE_OF_DECLARE.

> +
> +	return 0;
> +}

[...]

> +
> +static struct clock_event_device clockevent_pit = {
> +	.name		= "pit",
> +	.features	= CLOCK_EVT_FEAT_PERIODIC,

Only periodic support? That's really boring. Why isn't oneshot mode
supported?

> +	.shift		= 32,
> +	.set_mode	= pit_set_mode,
> +	.set_next_event	= pit_set_next_event,
> +	.rating		= 100,
> +};
> +
> +static int __init pit_clockevent_init(struct clk *pit_clk)
> +{
> +	unsigned int c = clk_get_rate(pit_clk);
> +
> +	clockevent_pit.mult = div_sc(c, NSEC_PER_SEC,
> +					clockevent_pit.shift);
> +	clockevent_pit.max_delta_ns =
> +			clockevent_delta2ns(0xfffffffe, &clockevent_pit);
> +	clockevent_pit.min_delta_ns =
> +			clockevent_delta2ns(0x800, &clockevent_pit);
> +	clockevent_pit.cpumask = cpumask_of(0);
> +	clockevents_register_device(&clockevent_pit);
> +
> +	return 0;
> +}
> +
> +void __init pit_timer_init(void __iomem *base, int irq)
> +{
> +	struct clk *pit_clk;
> +
> +	pit_clk = clk_get_sys(NULL, "mvf-pit");
> +	if (IS_ERR(pit_clk)) {
> +		pr_err("Vybrid PIT timer: unable to get clk\n");
> +		return;
> +	}

base, irq and clk should really be taken from the devicetree. We have
all necessary stuff in the kernel (only the i.MX template you copied
from doesn't use it yet).

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
