From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 14 Aug 2013 11:46:34 +0800
Subject: [PATCH 1/2] arm: mach-imx: Move anatop related from board file
 to anatop driver
In-Reply-To: <1376292414-22922-1-git-send-email-peter.chen@freescale.com>
References: <1376292414-22922-1-git-send-email-peter.chen@freescale.com>
Message-ID: <20130814034632.GC16915@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I change the subject prefix to "ARM: imx: ".

On Mon, Aug 12, 2013 at 03:26:53PM +0800, Peter Chen wrote:
> Move anatop related (For USB) from board file to anatop driver
> 
> Signed-off-by: Peter Chen <peter.chen@freescale.com>
> ---
>  arch/arm/mach-imx/anatop.c     |    4 +++-
>  arch/arm/mach-imx/common.h     |    1 -
>  arch/arm/mach-imx/mach-imx6q.c |    5 -----
>  3 files changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/anatop.c b/arch/arm/mach-imx/anatop.c
> index f7efabe..71f1a08 100644
> --- a/arch/arm/mach-imx/anatop.c
> +++ b/arch/arm/mach-imx/anatop.c
> @@ -115,7 +115,7 @@ void imx_anatop_post_resume(void)
>  	imx_anatop_enable_weak2p5(false);
>  }
>  
> -void imx_anatop_usb_chrg_detect_disable(void)
> +static void imx_anatop_usb_chrg_detect_disable(void)
>  {
>  	regmap_write(anatop, ANADIG_USB1_CHRG_DETECT,
>  		BM_ANADIG_USB_CHRG_DETECT_EN_B
> @@ -157,4 +157,6 @@ void __init imx_anatop_init(void)
>  	 */
>  	imx_anatop_pu_enable(true);
>  	imx_gpc_xpu_enable();
> +
> +	imx_anatop_usb_chrg_detect_disable();

The patch was generated from vendor tree.  I fixed it up and applied the
patch.  Please do not do this next time.

Shawn

>  }
> diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
> index 558e95f..df1d7b0 100644
> --- a/arch/arm/mach-imx/common.h
> +++ b/arch/arm/mach-imx/common.h
> @@ -136,7 +136,6 @@ extern void imx_gpc_xpu_enable(void);
>  extern void imx_anatop_init(void);
>  extern void imx_anatop_pre_suspend(void);
>  extern void imx_anatop_post_resume(void);
> -extern void imx_anatop_usb_chrg_detect_disable(void);
>  extern u32 imx_anatop_get_digprog(void);
>  extern int imx6q_set_lpm(enum mxc_cpu_pwr_mode mode);
>  extern void imx6q_set_chicken_bit(void);
> diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
> index e04abe9..846731d 100644
> --- a/arch/arm/mach-imx/mach-imx6q.c
> +++ b/arch/arm/mach-imx/mach-imx6q.c
> @@ -185,10 +185,6 @@ static void __init imx6q_1588_init(void)
>  		pr_err("failed to find fsl,imx6q-iomux-gpr regmap\n");
>  
>  }
> -static void __init imx6q_usb_init(void)
> -{
> -	imx_anatop_usb_chrg_detect_disable();
> -}
>  
>  static void __init imx6q_init_machine(void)
>  {
> @@ -198,7 +194,6 @@ static void __init imx6q_init_machine(void)
>  
>  	imx_anatop_init();
>  	imx6q_pm_init();
> -	imx6q_usb_init();
>  	imx6q_1588_init();
>  }
>  
> -- 
> 1.7.1
> 
> 
