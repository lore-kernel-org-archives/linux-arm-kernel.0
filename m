From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Fri, 31 May 2013 12:37:57 +0200
Subject: [PATCH 1/4] ARM: imx: clk-imx6q: Add necessary clock nodes.
In-Reply-To: <1370034115-24006-1-git-send-email-b20788@freescale.com>
References: <1370034115-24006-1-git-send-email-b20788@freescale.com>
Message-ID: <51A87D85.9000802@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31.05.2013 23:01, Anson Huang wrote:
> Some clock gates are useful when we try to disable them
> to save power, so we need to add these useful clock gate
> into clock tree.
>
> Signed-off-by: Anson Huang <b20788@freescale.com>
> ---
>   .../devicetree/bindings/clock/imx6q-clock.txt      |   13 +++++++++++++
>   arch/arm/mach-imx/clk-imx6q.c                      |   17 ++++++++++++++++-
>   2 files changed, 29 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/clock/imx6q-clock.txt b/Documentation/devicetree/bindings/clock/imx6q-clock.txt
> index 6deb6fd..df68f99 100644
> --- a/Documentation/devicetree/bindings/clock/imx6q-clock.txt
> +++ b/Documentation/devicetree/bindings/clock/imx6q-clock.txt
> @@ -208,6 +208,19 @@ clocks and IDs.
>   	pll4_post_div		193
>   	pll5_post_div		194
>   	pll5_video_div		195
> +	aips_tz1		196
> +	aips_tz2		197
> +	caam_mem		198
> +	caam_aclk		199
> +	caam_ipg		200
> +	tzasc1			201
> +	tzasc2			202
> +	vdoa			203
> +	mmdc_ch0_ipg		204
> +	mmdc_ch1_ipg		205
> +	mx6fast1		206
> +	per2_main		207
> +	emi_slow		208
>
>   Examples:
>
> diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
> index dda9a2b..dfb77c1 100644
> --- a/arch/arm/mach-imx/clk-imx6q.c
> +++ b/arch/arm/mach-imx/clk-imx6q.c
> @@ -238,7 +238,9 @@ enum mx6q_clks {
>   	pll4_audio, pll5_video, pll8_mlb, pll7_usb_host, pll6_enet, ssi1_ipg,
>   	ssi2_ipg, ssi3_ipg, rom, usbphy1, usbphy2, ldb_di0_div_3_5, ldb_di1_div_3_5,
>   	sata_ref, sata_ref_100m, pcie_ref, pcie_ref_125m, enet_ref, usbphy1_gate,
> -	usbphy2_gate, pll4_post_div, pll5_post_div, pll5_video_div, clk_max
> +	usbphy2_gate, pll4_post_div, pll5_post_div, pll5_video_div, aips_tz1,
> +	aips_tz2, caam_mem, caam_aclk, caam_ipg, tzasc1, tzasc2, vdoa, mmdc_ch0_ipg,
> +	mmdc_ch1_ipg, mx6fast1, per2_main, emi_slow, clk_max
>   };
>
>   static struct clk *clk[clk_max];
> @@ -466,8 +468,13 @@ int __init mx6q_clocks_init(void)
>   	clk[ahb]               = imx_clk_busy_divider("ahb",               "periph",      base + 0x14, 10,  3,   base + 0x48, 1);
>
>   	/*                                name             parent_name          reg         shift */
> +	clk[aips_tz1]     = imx_clk_gate2("aips_tz1",      "ahb",               base + 0x68, 0);
> +	clk[aips_tz2]     = imx_clk_gate2("aips_tz2",      "ahb",               base + 0x68, 2);
>   	clk[apbh_dma]     = imx_clk_gate2("apbh_dma",      "usdhc3",            base + 0x68, 4);
>   	clk[asrc]         = imx_clk_gate2("asrc",          "asrc_podf",         base + 0x68, 6);
> +	clk[caam_mem]     = imx_clk_gate2("caam_mem",      "ahb",               base + 0x68, 8);
> +	clk[caam_aclk]    = imx_clk_gate2("caam_aclk",     "ahb",               base + 0x68, 10);
> +	clk[caam_ipg]     = imx_clk_gate2("caam_ipg",      "ipg",               base + 0x68, 12);
>   	clk[can1_ipg]     = imx_clk_gate2("can1_ipg",      "ipg",               base + 0x68, 14);
>   	clk[can1_serial]  = imx_clk_gate2("can1_serial",   "can_root",          base + 0x68, 16);
>   	clk[can2_ipg]     = imx_clk_gate2("can2_ipg",      "ipg",               base + 0x68, 18);
> @@ -490,6 +497,9 @@ int __init mx6q_clocks_init(void)
>   	clk[i2c3]         = imx_clk_gate2("i2c3",          "ipg_per",           base + 0x70, 10);
>   	clk[iim]          = imx_clk_gate2("iim",           "ipg",               base + 0x70, 12);
>   	clk[enfc]         = imx_clk_gate2("enfc",          "enfc_podf",         base + 0x70, 14);
> +	clk[tzasc1]       = imx_clk_gate2("tzasc1",        "mmdc_ch0_axi_podf", base + 0x70, 22);
> +	clk[tzasc2]       = imx_clk_gate2("tzasc2",        "mmdc_ch0_axi_podf", base + 0x70, 24);
> +	clk[vdoa]         = imx_clk_gate2("vdoa",          "vdo_axi",           base + 0x70, 26);
>   	clk[ipu1]         = imx_clk_gate2("ipu1",          "ipu1_podf",         base + 0x74, 0);
>   	clk[ipu1_di0]     = imx_clk_gate2("ipu1_di0",      "ipu1_di0_sel",      base + 0x74, 2);
>   	clk[ipu1_di1]     = imx_clk_gate2("ipu1_di1",      "ipu1_di1_sel",      base + 0x74, 4);
> @@ -502,10 +512,14 @@ int __init mx6q_clocks_init(void)
>   	clk[mlb]          = imx_clk_gate2("mlb",           "axi",               base + 0x74, 18);
>   	clk[mmdc_ch0_axi] = imx_clk_gate2("mmdc_ch0_axi",  "mmdc_ch0_axi_podf", base + 0x74, 20);
>   	clk[mmdc_ch1_axi] = imx_clk_gate2("mmdc_ch1_axi",  "mmdc_ch1_axi_podf", base + 0x74, 22);
> +	clk[mmdc_ch0_ipg] = imx_clk_gate2("mmdc_ch0_ipg",  "ipg",               base + 0x74, 24);
> +	clk[mmdc_ch1_ipg] = imx_clk_gate2("mmdc_ch1_ipg",  "ipg",               base + 0x74, 26);
>   	clk[ocram]        = imx_clk_gate2("ocram",         "ahb",               base + 0x74, 28);
>   	clk[openvg_axi]   = imx_clk_gate2("openvg_axi",    "axi",               base + 0x74, 30);
>   	clk[pcie_axi]     = imx_clk_gate2("pcie_axi",      "pcie_axi_sel",      base + 0x78, 0);
> +	clk[mx6fast1]     = imx_clk_gate2("mx6fast1",      "ahb",               base + 0x78, 8);
>   	clk[per1_bch]     = imx_clk_gate2("per1_bch",      "usdhc3",            base + 0x78, 12);
> +	clk[per2_main]    = imx_clk_gate2("per2_main",     "ahb",               base + 0x78, 14);
>   	clk[pwm1]         = imx_clk_gate2("pwm1",          "ipg_per",           base + 0x78, 16);
>   	clk[pwm2]         = imx_clk_gate2("pwm2",          "ipg_per",           base + 0x78, 18);
>   	clk[pwm3]         = imx_clk_gate2("pwm3",          "ipg_per",           base + 0x78, 20);
> @@ -528,6 +542,7 @@ int __init mx6q_clocks_init(void)
>   	clk[usdhc2]       = imx_clk_gate2("usdhc2",        "usdhc2_podf",       base + 0x80, 4);
>   	clk[usdhc3]       = imx_clk_gate2("usdhc3",        "usdhc3_podf",       base + 0x80, 6);
>   	clk[usdhc4]       = imx_clk_gate2("usdhc4",        "usdhc4_podf",       base + 0x80, 8);
> +	clk[emi_slow]     = imx_clk_gate2("emi_slow",      "emi_slow_podf",     base + 0x80, 10);
>   	clk[vdo_axi]      = imx_clk_gate2("vdo_axi",       "vdo_axi_sel",       base + 0x80, 12);
>   	clk[vpu_axi]      = imx_clk_gate2("vpu_axi",       "vpu_axi_podf",      base + 0x80, 14);
>   	clk[cko1]         = imx_clk_gate("cko1",           "cko1_podf",         base + 0x60, 7);

I think we have the emi_slow already:

https://git.linaro.org/gitweb?p=people/shawnguo/linux-2.6.git;a=commitdiff;h=5e569c675297733dec9f5b65aed3fe694c6e6975

Best regards

Dirk
