From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 1 Feb 2012 22:35:34 +0800
Subject: Pinmux bindings proposal V2
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF1780DAB4CE@HQMAIL01.nvidia.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF1780DAB4CE@HQMAIL01.nvidia.com>
Message-ID: <20120201143530.GA2203@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

I had a talk with Dong about this binding, and we think that it should
work well for imx if we have a couple of small pieces added.

On Fri, Jan 20, 2012 at 02:22:20PM -0800, Stephen Warren wrote:
...
>                 pmx_sdhci: pinconfig-sdhci {
>                         /*
>                          * The mux property is a list of muxable entities
>                          * and the mux function to select for it. The number
>                          * of cells in each entry is the pin controller's
>                          * #pinmux-cells property. The pin controller's
>                          * binding defines what the cells mean. The pinctrl
>                          * driver is responsible for mapping this data to
>                          * the (group, function) pair required to fill in
>                          * the pinctrl subsystem's pinmux mapping table.
>                          */
>                         mux =
>                                 <TEGRA_PMX_PG_DTA TEGRA_PMX_MUX_SDIO1>
>                                 <TEGRA_PMX_PG_DTD TEGRA_PMX_MUX_SDIO1>;

We need a property like 'mux-unit' whose value can be either 'pin' or
'pingroup' to reflect something you mentioned as muxable entity.

The reason behind this is the DT logic inside pinctrl core needs to
know how the pinmux_map should be constructed from device tree.  In
tegra case, the 'mux-unit' is 'pingroup', the core should construct
pinmux_map entry for each row/element of 'mux'.  In imx case, the
'mux-unit' will be 'pin', and we would expect core construct only
one pinmux_map entry there, with all the pins listed in 'mux' composing
the group that pinmux_map needs.

And in case of 'mux-unit' is 'pin', we would need one more property
'mux-name' to present the group name.  Then we have all the pieces to
construct pinmux_map for cases like imx, where we do not define all
those functions, groups in pinctrl driver at all.

Regards,
Shawn

>                         /*
>                          * The config property is a list of muxable entities
>                          * and individual configuration setting. The number
>                          * of cells in each entry is the pin controller's
>                          * #pinconfig-cells property. The pin controller's
>                          * binding defines what the cells mean. The pinctrl
>                          * driver is responsible for mapping this data to
>                          * the (group, config) pair required to fill in
>                          * the pinctrl subsystem's pin configuration table.
>                          */
>                         config =
>                                 <TEGRA_PMX_PG_DTA TEGRA_PMX_CONF_DRIVE_STRENGTH 5>
>                                 <TEGRA_PMX_PG_DTD TEGRA_PMX_CONF_DRIVE_STRENGTH 5>
>                                 <TEGRA_PMX_PG_DTA TEGRA_PMX_CONF_SLEW_RATE 4>
>                                 <TEGRA_PMX_PG_DTD TEGRA_PMX_CONF_SLEW_RATE 8>;
>                 };
