From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 28 Mar 2013 15:20:58 +0800
Subject: [PATCH v2 04/11] ARM i.MX6q: Add audio/video PLL post dividers
 for i.MX6q rev 1.1
In-Reply-To: <1364405445-5271-5-git-send-email-p.zabel@pengutronix.de>
References: <1364405445-5271-1-git-send-email-p.zabel@pengutronix.de>
 <1364405445-5271-5-git-send-email-p.zabel@pengutronix.de>
Message-ID: <20130328072056.GL5429@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 27, 2013 at 06:30:38PM +0100, Philipp Zabel wrote:
> Query silicon revision to determine clock tree and add post
> dividers for newer revisions.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  arch/arm/mach-imx/clk-imx6q.c | 30 +++++++++++++++++++++++-------
>  1 file changed, 23 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
> index 2f9ff93..fbab4a9 100644
> --- a/arch/arm/mach-imx/clk-imx6q.c
> +++ b/arch/arm/mach-imx/clk-imx6q.c
> @@ -22,6 +22,7 @@
>  
>  #include "clk.h"
>  #include "common.h"
> +#include "hardware.h"
>  
>  #define CCGR0				0x68
>  #define CCGR1				0x6c
> @@ -109,29 +110,32 @@ static const char *periph_clk2_sels[]	= { "pll3_usb_otg", "osc", };
>  static const char *periph_sels[]	= { "periph_pre", "periph_clk2", };
>  static const char *periph2_sels[]	= { "periph2_pre", "periph2_clk2", };
>  static const char *axi_sels[]		= { "periph", "pll2_pfd2_396m", "pll3_pfd1_540m", };
> -static const char *audio_sels[]	= { "pll4_audio", "pll3_pfd2_508m", "pll3_pfd3_454m", "pll3_usb_otg", };
> +static const char *audio_sels[]	= { "pll4_test_div", "pll3_pfd2_508m", "pll3_pfd3_454m", "pll3_usb_otg", };
>  static const char *gpu_axi_sels[]	= { "axi", "ahb", };
>  static const char *gpu2d_core_sels[]	= { "axi", "pll3_usb_otg", "pll2_pfd0_352m", "pll2_pfd2_396m", };
>  static const char *gpu3d_core_sels[]	= { "mmdc_ch0_axi", "pll3_usb_otg", "pll2_pfd1_594m", "pll2_pfd2_396m", };
>  static const char *gpu3d_shader_sels[] = { "mmdc_ch0_axi", "pll3_usb_otg", "pll2_pfd1_594m", "pll2_pfd9_720m", };
>  static const char *ipu_sels[]		= { "mmdc_ch0_axi", "pll2_pfd2_396m", "pll3_120m", "pll3_pfd1_540m", };
> -static const char *ldb_di_sels[]	= { "pll5_video", "pll2_pfd0_352m", "pll2_pfd2_396m", "mmdc_ch1_axi", "pll3_pfd1_540m", };
> -static const char *ipu_di_pre_sels[]	= { "mmdc_ch0_axi", "pll3_usb_otg", "pll5_video", "pll2_pfd0_352m", "pll2_pfd2_396m", "pll3_pfd1_540m", };
> +static const char *ldb_di_sels[]	= { "pll5_control3", "pll2_pfd0_352m", "pll2_pfd2_396m", "mmdc_ch1_axi", "pll3_pfd1_540m", };
> +static const char *ipu_di_pre_sels[]	= { "mmdc_ch0_axi", "pll3_usb_otg", "pll5_control3", "pll2_pfd0_352m", "pll2_pfd2_396m", "pll3_pfd1_540m", };
>  static const char *ipu1_di0_sels[]	= { "ipu1_di0_pre", "dummy", "dummy", "ldb_di0", "ldb_di1", };
>  static const char *ipu1_di1_sels[]	= { "ipu1_di1_pre", "dummy", "dummy", "ldb_di0", "ldb_di1", };
>  static const char *ipu2_di0_sels[]	= { "ipu2_di0_pre", "dummy", "dummy", "ldb_di0", "ldb_di1", };
>  static const char *ipu2_di1_sels[]	= { "ipu2_di1_pre", "dummy", "dummy", "ldb_di0", "ldb_di1", };
>  static const char *hsi_tx_sels[]	= { "pll3_120m", "pll2_pfd2_396m", };
>  static const char *pcie_axi_sels[]	= { "axi", "ahb", };
> -static const char *ssi_sels[]		= { "pll3_pfd2_508m", "pll3_pfd3_454m", "pll4_audio", };
> +static const char *ssi_sels[]		= { "pll3_pfd2_508m", "pll3_pfd3_454m", "pll4_test_div", };
>  static const char *usdhc_sels[]	= { "pll2_pfd2_396m", "pll2_pfd0_352m", };
>  static const char *enfc_sels[]	= { "pll2_pfd0_352m", "pll2_bus", "pll3_usb_otg", "pll2_pfd2_396m", };
>  static const char *emi_sels[]		= { "axi", "pll3_usb_otg", "pll2_pfd2_396m", "pll2_pfd0_352m", };
>  static const char *vdo_axi_sels[]	= { "axi", "ahb", };
>  static const char *vpu_axi_sels[]	= { "axi", "pll2_pfd2_396m", "pll2_pfd0_352m", };
> -static const char *cko1_sels[]	= { "pll3_usb_otg", "pll2_bus", "pll1_sys", "pll5_video",
> +static const char *cko1_sels[]	= { "pll3_usb_otg", "pll2_bus", "pll1_sys", "pll5_control3",
>  				    "dummy", "axi", "enfc", "ipu1_di0", "ipu1_di1", "ipu2_di0",
> -				    "ipu2_di1", "ahb", "ipg", "ipg_per", "ckil", "pll4_audio", };
> +				    "ipu2_di1", "ahb", "ipg", "ipg_per", "ckil", "pll4_test_div", };
> +
> +static struct clk_div_table test_div_table[] = { { 2, 1 }, { 1, 2 }, { 0, 4 }, { 0, 0 }, };
> +static struct clk_div_table control3_table[] = { { 0, 1 }, { 1, 2 }, { 3, 4 }, { 0, 0 }, };

Please rewrite the tables in the way how clk_enet_ref_table is written.
Also, why { 0, 0 } at the end of both tables?

>  
>  enum mx6q_clks {
>  	dummy, ckil, ckih, osc, pll2_pfd0_352m, pll2_pfd1_594m, pll2_pfd2_396m,
> @@ -165,7 +169,7 @@ enum mx6q_clks {
>  	pll4_audio, pll5_video, pll8_mlb, pll7_usb_host, pll6_enet, ssi1_ipg,
>  	ssi2_ipg, ssi3_ipg, rom, usbphy1, usbphy2, ldb_di0_div_3_5, ldb_di1_div_3_5,
>  	sata_ref, sata_ref_100m, pcie_ref, pcie_ref_125m, enet_ref, usbphy1_gate,
> -	usbphy2_gate, clk_max
> +	usbphy2_gate, pll4_test_div, pll5_test_div, pll5_control3, clk_max
>  };
>  
>  static struct clk *clk[clk_max];
> @@ -208,6 +212,14 @@ int __init mx6q_clocks_init(void)
>  	base = of_iomap(np, 0);
>  	WARN_ON(!base);
>  
> +	/* Audio/video PLL post dividers do not work on i.MX6q revision 1.0 */
> +	if (imx6q_revision() == IMX_CHIP_REVISION_1_0) {
> +		test_div_table[1].div = 1;
> +		test_div_table[2].div = 1;
> +		control3_table[1].div = 1;
> +		control3_table[2].div = 1;
> +	};
> +
>  	/*                   type                               name         parent_name  base     div_mask */
>  	clk[pll1_sys]      = imx_clk_pllv3(IMX_PLLV3_SYS,	"pll1_sys",	"osc", base,        0x7f);
>  	clk[pll2_bus]      = imx_clk_pllv3(IMX_PLLV3_GENERIC,	"pll2_bus",	"osc", base + 0x30, 0x1);
> @@ -260,6 +272,10 @@ int __init mx6q_clocks_init(void)
>  	clk[pll3_60m]  = imx_clk_fixed_factor("pll3_60m",  "pll3_usb_otg",   1, 8);
>  	clk[twd]       = imx_clk_fixed_factor("twd",       "arm",            1, 2);
>  
> +	clk[pll4_test_div] = clk_register_divider_table(NULL, "pll4_test_div", "pll4_audio", CLK_SET_RATE_PARENT, base + 0x70, 19, 2, 0, test_div_table, NULL);
> +	clk[pll5_test_div] = clk_register_divider_table(NULL, "pll5_test_div", "pll5_video", CLK_SET_RATE_PARENT, base + 0xa0, 19, 2, 0, test_div_table, NULL);
> +	clk[pll5_control3] = clk_register_divider_table(NULL, "pll5_control3", "pll5_test_div", CLK_SET_RATE_PARENT, base + 0x170, 30, 2, 0, control3_table, NULL);
> +

I'm wondering how the dividers are named.  Why "test" and "control3"?

Also, shouldn't the last argument be &imx_ccm_lock rather than NULL?

Shawn

>  	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-ccm");
>  	base = of_iomap(np, 0);
>  	WARN_ON(!base);
> -- 
> 1.8.2.rc2
> 
