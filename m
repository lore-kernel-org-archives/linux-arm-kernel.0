From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 3 Jun 2013 09:34:13 +0800
Subject: [PATCH 3/4] ARM: imx: clk-imx6q: AXI clock select index is
 incorrect
In-Reply-To: <1370034115-24006-3-git-send-email-b20788@freescale.com>
References: <1370034115-24006-1-git-send-email-b20788@freescale.com>
 <1370034115-24006-3-git-send-email-b20788@freescale.com>
Message-ID: <20130603013411.GD13970@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 31, 2013 at 05:01:54PM -0400, Anson Huang wrote:
> The AXI clock mux should be as below:
> 
> 00: periph;
> 01: pll2_pfd2_396m;
> 10: periph;
> 11: pll3_pfd1_540m;
> 
> So, we need to insert a dummy clock for index 2b'10, otherwise,
> if we want to select pll3_pfd1_540m as AXI's parent, it will
> still source from periph.
> 
> Signed-off-by: Anson Huang <b20788@freescale.com>
> ---
>  arch/arm/mach-imx/clk-imx6q.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
> index c501947..390950e 100644
> --- a/arch/arm/mach-imx/clk-imx6q.c
> +++ b/arch/arm/mach-imx/clk-imx6q.c
> @@ -181,7 +181,7 @@ static const char *periph_clk2_sels[]	= { "pll3_usb_otg", "osc", "osc", "dummy",
>  static const char *periph2_clk2_sels[]	= { "pll3_usb_otg", "pll2_bus", };
>  static const char *periph_sels[]	= { "periph_pre", "periph_clk2", };
>  static const char *periph2_sels[]	= { "periph2_pre", "periph2_clk2", };
> -static const char *axi_sels[]		= { "periph", "pll2_pfd2_396m", "pll3_pfd1_540m", };
> +static const char *axi_sels[]		= { "periph", "pll2_pfd2_396m", "dummy", "pll3_pfd1_540m", };

As we talked, I replaced "dummy" with "periph", updated the commit log
and applied the patch.

Shawn

>  static const char *audio_sels[]	= { "pll4_post_div", "pll3_pfd2_508m", "pll3_pfd3_454m", "pll3_usb_otg", };
>  static const char *gpu_axi_sels[]	= { "axi", "ahb", };
>  static const char *gpu2d_core_sels[]	= { "axi", "pll3_usb_otg", "pll2_pfd0_352m", "pll2_pfd2_396m", };
> -- 
> 1.7.9.5
> 
> 
