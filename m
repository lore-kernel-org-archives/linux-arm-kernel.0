From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 18 Aug 2013 14:02:07 +0800
Subject: [PATCH v2] ARM: i.MX6Q clocks: Fix CKIH clock name
In-Reply-To: <1376720153-19659-1-git-send-email-shc_work@mail.ru>
References: <1376720153-19659-1-git-send-email-shc_work@mail.ru>
Message-ID: <20130818060205.GC1545@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 17, 2013 at 10:15:53AM +0400, Alexander Shiyan wrote:
> i.MX6Q have only one High-frequency reference clock (CKIH).
> Patch removes index from CKIH and makes name according datasheet.
> This is just a cosmetic fix and since this clock currently is not
> used by any DTS, change should be safe.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  arch/arm/boot/dts/imx6qdl.dtsi | 4 ++--
>  arch/arm/mach-imx/clk-imx6q.c  | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> index ccd55c2..d8a2f5fd 100644
> --- a/arch/arm/boot/dts/imx6qdl.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> @@ -54,8 +54,8 @@
>  			clock-frequency = <32768>;
>  		};
>  
> -		ckih1 {
> -			compatible = "fsl,imx-ckih1", "fixed-clock";
> +		ckih {
> +			compatible = "fsl,imx-ckih", "fixed-clock";
>  			clock-frequency = <0>;
>  		};
>  
> diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
> index 9181a24..8f2a8b5 100644
> --- a/arch/arm/mach-imx/clk-imx6q.c
> +++ b/arch/arm/mach-imx/clk-imx6q.c
> @@ -292,7 +292,7 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
>  
>  	clk[dummy] = imx_clk_fixed("dummy", 0);
>  	clk[ckil] = imx_obtain_fixed_clock("ckil", 0);
> -	clk[ckih] = imx_obtain_fixed_clock("ckih1", 0);
> +	clk[ckih] = imx_obtain_fixed_clock("ckih", 0);

We're entering a stage where we need to consider the device tree
compatibility.  Since imx_obtain_fixed_clock() will try to look
for the node using full path, the change will break the support for
existing device tree.

Shawn

>  	clk[osc] = imx_obtain_fixed_clock("osc", 0);
>  
>  	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-anatop");
> -- 
> 1.8.1.5
> 
