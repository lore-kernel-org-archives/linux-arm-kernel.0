From: stefan@agner.ch (Stefan Agner)
Date: Fri, 03 Oct 2014 10:30:46 +0200
Subject: [PATCH v2 3/5] ARM: imx6sl: add BYPASS support for PLL clocks
In-Reply-To: <1409559244-22483-4-git-send-email-shawn.guo@freescale.com>
References: <1409559244-22483-1-git-send-email-shawn.guo@freescale.com>
 <1409559244-22483-4-git-send-email-shawn.guo@freescale.com>
Message-ID: <235f9cbf6fcb52944fed11f662a4bb78@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

I know it's too late since that patchset is already applied, but....

Am 2014-09-01 10:14, schrieb Shawn Guo:
> This is the same change for imx6sl clock driver as "ARM: imx6q: add BYPASS
> support for PLL clocks" for imx6q.  The difference is that only anaclk1
> is available on imx6sl.
> 
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> ---
>  arch/arm/mach-imx/clk-imx6sl.c           | 69 ++++++++++++++++++++++++++++----
>  include/dt-bindings/clock/imx6sl-clock.h | 27 ++++++++++++-
>  2 files changed, 87 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/clk-imx6sl.c b/arch/arm/mach-imx/clk-imx6sl.c
> index 11908e8bf9ab..e5c93d81aecc 100644
> --- a/arch/arm/mach-imx/clk-imx6sl.c
> +++ b/arch/arm/mach-imx/clk-imx6sl.c
> @@ -56,6 +56,20 @@ static const char *epdc_pix_sels[]	= { "pll2_bus",
> "pll3_usb_otg", "pll5_video_d
>  static const char *audio_sels[]		= { "pll4_audio_div", "pll3_pfd2",
> "pll3_pfd3", "pll3_usb_otg", };
>  static const char *ecspi_sels[]		= { "pll3_60m", "osc", };
>  static const char *uart_sels[]		= { "pll3_80m", "osc", };
> +static const char *lvds_sels[]		= {
> +	"pll1_sys", "pll2_bus", "pll2_pfd0", "pll2_pfd1", "pll2_pfd2",
> "dummy", "pll4_audio", "pll5_video",
> +	"dummy", "enet_ref", "dummy", "dummy", "pll3_usb_otg",
> "pll7_usb_host", "pll3_pfd0", "pll3_pfd1",
> +	"pll3_pfd2", "pll3_pfd3", "osc", "dummy", "dummy", "dummy", "dummy", "dummy",
> +	 "dummy", "dummy", "dummy", "dummy", "dummy", "dummy", "dummy", "dummy",
> +};
> +static const char *pll_bypass_src_sels[] = { "osc", "lvds1_in", };
> +static const char *pll1_bypass_sels[]	= { "pll1", "pll1_bypass_src", };
> +static const char *pll2_bypass_sels[]	= { "pll2", "pll2_bypass_src", };
> +static const char *pll3_bypass_sels[]	= { "pll3", "pll3_bypass_src", };
> +static const char *pll4_bypass_sels[]	= { "pll4", "pll4_bypass_src", };
> +static const char *pll5_bypass_sels[]	= { "pll5", "pll5_bypass_src", };
> +static const char *pll6_bypass_sels[]	= { "pll6", "pll6_bypass_src", };
> +static const char *pll7_bypass_sels[]	= { "pll7", "pll7_bypass_src", };
>  
>  static struct clk_div_table clk_enet_ref_table[] = {
>  	{ .val = 0, .div = 20, },
> @@ -176,20 +190,59 @@ static void __init imx6sl_clocks_init(struct
> device_node *ccm_node)
>  	clks[IMX6SL_CLK_DUMMY] = imx_clk_fixed("dummy", 0);
>  	clks[IMX6SL_CLK_CKIL] = imx_obtain_fixed_clock("ckil", 0);
>  	clks[IMX6SL_CLK_OSC] = imx_obtain_fixed_clock("osc", 0);
> +	/* Clock source from external clock via CLK1 PAD */
> +	clks[IMX6SL_CLK_ANACLK1] = imx_obtain_fixed_clock("anaclk1", 0);
>  
>  	np = of_find_compatible_node(NULL, NULL, "fsl,imx6sl-anatop");
>  	base = of_iomap(np, 0);
>  	WARN_ON(!base);
>  	anatop_base = base;
>  
> -	/*                                             type              
> name            parent  base         div_mask */
> -	clks[IMX6SL_CLK_PLL1_SYS]      = imx_clk_pllv3(IMX_PLLV3_SYS,	 
> "pll1_sys",	   "osc", base,        0x7f);
> -	clks[IMX6SL_CLK_PLL2_BUS]      = imx_clk_pllv3(IMX_PLLV3_GENERIC,
> "pll2_bus",	   "osc", base + 0x30, 0x1);
> -	clks[IMX6SL_CLK_PLL3_USB_OTG]  = imx_clk_pllv3(IMX_PLLV3_USB,	 
> "pll3_usb_otg",  "osc", base + 0x10, 0x3);
> -	clks[IMX6SL_CLK_PLL4_AUDIO]    = imx_clk_pllv3(IMX_PLLV3_AV,	 
> "pll4_audio",	   "osc", base + 0x70, 0x7f);
> -	clks[IMX6SL_CLK_PLL5_VIDEO]    = imx_clk_pllv3(IMX_PLLV3_AV,	 
> "pll5_video",	   "osc", base + 0xa0, 0x7f);
> -	clks[IMX6SL_CLK_PLL6_ENET]     = imx_clk_pllv3(IMX_PLLV3_ENET,	 
> "pll6_enet",	   "osc", base + 0xe0, 0x3);
> -	clks[IMX6SL_CLK_PLL7_USB_HOST] = imx_clk_pllv3(IMX_PLLV3_USB,    
> "pll7_usb_host", "osc", base + 0x20, 0x3);
> +	clks[IMX6SL_PLL1_BYPASS_SRC] = imx_clk_mux("pll1_bypass_src", base +
> 0x00, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
> +	clks[IMX6SL_PLL2_BYPASS_SRC] = imx_clk_mux("pll2_bypass_src", base +
> 0x30, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
> +	clks[IMX6SL_PLL3_BYPASS_SRC] = imx_clk_mux("pll3_bypass_src", base +
> 0x10, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
> +	clks[IMX6SL_PLL4_BYPASS_SRC] = imx_clk_mux("pll4_bypass_src", base +
> 0x70, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
> +	clks[IMX6SL_PLL5_BYPASS_SRC] = imx_clk_mux("pll5_bypass_src", base +
> 0xa0, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
> +	clks[IMX6SL_PLL6_BYPASS_SRC] = imx_clk_mux("pll6_bypass_src", base +
> 0xe0, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
> +	clks[IMX6SL_PLL7_BYPASS_SRC] = imx_clk_mux("pll7_bypass_src", base +
> 0x20, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
> +
> +	/*                                    type               name   
> parent_name        base         div_mask */
> +	clks[IMX6SL_CLK_PLL1] = imx_clk_pllv3(IMX_PLLV3_SYS,     "pll1",
> "pll1_bypass_src", base + 0x00, 0x7f);
> +	clks[IMX6SL_CLK_PLL2] = imx_clk_pllv3(IMX_PLLV3_GENERIC, "pll2",
> "pll2_bypass_src", base + 0x30, 0x1);
> +	clks[IMX6SL_CLK_PLL3] = imx_clk_pllv3(IMX_PLLV3_USB,     "pll3",
> "pll3_bypass_src", base + 0x10, 0x3);
> +	clks[IMX6SL_CLK_PLL4] = imx_clk_pllv3(IMX_PLLV3_AV,      "pll4",
> "pll4_bypass_src", base + 0x70, 0x7f);
> +	clks[IMX6SL_CLK_PLL5] = imx_clk_pllv3(IMX_PLLV3_AV,      "pll5",
> "pll5_bypass_src", base + 0xa0, 0x7f);
> +	clks[IMX6SL_CLK_PLL6] = imx_clk_pllv3(IMX_PLLV3_ENET,    "pll6",
> "pll6_bypass_src", base + 0xe0, 0x3);
> +	clks[IMX6SL_CLK_PLL7] = imx_clk_pllv3(IMX_PLLV3_USB,     "pll7",
> "pll7_bypass_src", base + 0x20, 0x3);
> +
> +	clks[IMX6SL_PLL1_BYPASS] = imx_clk_mux_flags("pll1_bypass", base +
> 0x00, 16, 1, pll1_bypass_sels, ARRAY_SIZE(pll1_bypass_sels),
> CLK_SET_RATE_PARENT);
> +	clks[IMX6SL_PLL2_BYPASS] = imx_clk_mux_flags("pll2_bypass", base +
> 0x30, 16, 1, pll2_bypass_sels, ARRAY_SIZE(pll2_bypass_sels),
> CLK_SET_RATE_PARENT);
> +	clks[IMX6SL_PLL3_BYPASS] = imx_clk_mux_flags("pll3_bypass", base +
> 0x10, 16, 1, pll3_bypass_sels, ARRAY_SIZE(pll3_bypass_sels),
> CLK_SET_RATE_PARENT);
> +	clks[IMX6SL_PLL4_BYPASS] = imx_clk_mux_flags("pll4_bypass", base +
> 0x70, 16, 1, pll4_bypass_sels, ARRAY_SIZE(pll4_bypass_sels),
> CLK_SET_RATE_PARENT);
> +	clks[IMX6SL_PLL5_BYPASS] = imx_clk_mux_flags("pll5_bypass", base +
> 0xa0, 16, 1, pll5_bypass_sels, ARRAY_SIZE(pll5_bypass_sels),
> CLK_SET_RATE_PARENT);
> +	clks[IMX6SL_PLL6_BYPASS] = imx_clk_mux_flags("pll6_bypass", base +
> 0xe0, 16, 1, pll6_bypass_sels, ARRAY_SIZE(pll6_bypass_sels),
> CLK_SET_RATE_PARENT);
> +	clks[IMX6SL_PLL7_BYPASS] = imx_clk_mux_flags("pll7_bypass", base +
> 0x20, 16, 1, pll7_bypass_sels, ARRAY_SIZE(pll7_bypass_sels),
> CLK_SET_RATE_PARENT);
> +
> +	/* Do not bypass PLLs initially */
> +	clk_set_parent(clks[IMX6SL_PLL1_BYPASS], clks[IMX6SL_CLK_PLL1]);
> +	clk_set_parent(clks[IMX6SL_PLL2_BYPASS], clks[IMX6SL_CLK_PLL2]);
> +	clk_set_parent(clks[IMX6SL_PLL3_BYPASS], clks[IMX6SL_CLK_PLL3]);
> +	clk_set_parent(clks[IMX6SL_PLL4_BYPASS], clks[IMX6SL_CLK_PLL4]);
> +	clk_set_parent(clks[IMX6SL_PLL5_BYPASS], clks[IMX6SL_CLK_PLL5]);
> +	clk_set_parent(clks[IMX6SL_PLL6_BYPASS], clks[IMX6SL_CLK_PLL6]);
> +	clk_set_parent(clks[IMX6SL_PLL7_BYPASS], clks[IMX6SL_CLK_PLL7]);
> +
> +	clks[IMX6SL_CLK_PLL1_SYS]      = imx_clk_gate("pll1_sys",     
> "pll1_bypass", base + 0x00, 13);
> +	clks[IMX6SL_CLK_PLL2_BUS]      = imx_clk_gate("pll2_bus",     
> "pll2_bypass", base + 0x30, 13);
> +	clks[IMX6SL_CLK_PLL3_USB_OTG]  = imx_clk_gate("pll3_usb_otg", 
> "pll3_bypass", base + 0x10, 13);
> +	clks[IMX6SL_CLK_PLL4_AUDIO]    = imx_clk_gate("pll4_audio",   
> "pll4_bypass", base + 0x70, 13);
> +	clks[IMX6SL_CLK_PLL5_VIDEO]    = imx_clk_gate("pll5_video",   
> "pll5_bypass", base + 0xa0, 13);
> +	clks[IMX6SL_CLK_PLL6_ENET]     = imx_clk_gate("pll6_enet",    
> "pll6_bypass", base + 0xe0, 13);
> +	clks[IMX6SL_CLK_PLL7_USB_HOST] = imx_clk_gate("pll7_usb_host",
> "pll7_bypass", base + 0xe0, 13);

                        ^^^^

This is probably wrong and should be 0x20. imx6sx and imx6qdl are
affected too. Just realized that when looking into applying this BYPASS
stuff for Vybrid.

--
Stefan


> +
> +	clks[IMX6SL_CLK_LVDS1_SEL] = imx_clk_mux("lvds1_sel", base + 0x160,
> 0, 5, lvds_sels, ARRAY_SIZE(lvds_sels));
> +	clks[IMX6SL_CLK_LVDS1_OUT] = imx_clk_gate_exclusive("lvds1_out",
> "lvds1_sel", base + 0x160, 10, BIT(12));
> +	clks[IMX6SL_CLK_LVDS1_IN] = imx_clk_gate_exclusive("lvds1_in",
> "anaclk1", base + 0x160, 12, BIT(10));
>  
>  	/*
>  	 * usbphy1 and usbphy2 are implemented as dummy gates using reserve
> diff --git a/include/dt-bindings/clock/imx6sl-clock.h
> b/include/dt-bindings/clock/imx6sl-clock.h
> index b91dd462ba85..f10a928fe2dd 100644
> --- a/include/dt-bindings/clock/imx6sl-clock.h
> +++ b/include/dt-bindings/clock/imx6sl-clock.h
> @@ -146,6 +146,31 @@
>  #define IMX6SL_CLK_PLL4_AUDIO_DIV	133
>  #define IMX6SL_CLK_SPBA			134
>  #define IMX6SL_CLK_ENET			135
> -#define IMX6SL_CLK_END			136
> +#define IMX6SL_CLK_LVDS1_SEL		136
> +#define IMX6SL_CLK_LVDS1_OUT		137
> +#define IMX6SL_CLK_LVDS1_IN		138
> +#define IMX6SL_CLK_ANACLK1		139
> +#define IMX6SL_PLL1_BYPASS_SRC		140
> +#define IMX6SL_PLL2_BYPASS_SRC		141
> +#define IMX6SL_PLL3_BYPASS_SRC		142
> +#define IMX6SL_PLL4_BYPASS_SRC		143
> +#define IMX6SL_PLL5_BYPASS_SRC		144
> +#define IMX6SL_PLL6_BYPASS_SRC		145
> +#define IMX6SL_PLL7_BYPASS_SRC		146
> +#define IMX6SL_CLK_PLL1			147
> +#define IMX6SL_CLK_PLL2			148
> +#define IMX6SL_CLK_PLL3			149
> +#define IMX6SL_CLK_PLL4			150
> +#define IMX6SL_CLK_PLL5			151
> +#define IMX6SL_CLK_PLL6			152
> +#define IMX6SL_CLK_PLL7			153
> +#define IMX6SL_PLL1_BYPASS		154
> +#define IMX6SL_PLL2_BYPASS		155
> +#define IMX6SL_PLL3_BYPASS		156
> +#define IMX6SL_PLL4_BYPASS		157
> +#define IMX6SL_PLL5_BYPASS		158
> +#define IMX6SL_PLL6_BYPASS		159
> +#define IMX6SL_PLL7_BYPASS		160
> +#define IMX6SL_CLK_END			161
>  
>  #endif /* __DT_BINDINGS_CLOCK_IMX6SL_H */
