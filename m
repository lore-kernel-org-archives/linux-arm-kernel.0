From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 14 Aug 2013 11:47:56 +0800
Subject: [PATCH 2/2] arm: mach-imx: anatop: add two APIs for USB driver
In-Reply-To: <1376292414-22922-2-git-send-email-peter.chen@freescale.com>
References: <1376292414-22922-1-git-send-email-peter.chen@freescale.com>
 <1376292414-22922-2-git-send-email-peter.chen@freescale.com>
Message-ID: <20130814034754.GD16915@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 12, 2013 at 03:26:54PM +0800, Peter Chen wrote:
> imx_anatop_usb1_disconnect_line is used to disconnect dp/dm between
> PHY and controller, after that, the controller always gets SE0
> for the status of dp/dm, it is not any wakeup signal for controller.
> It is used to avoid unknown interrupt due to dp/dm is floading
> after the USB PHY is no powered when there is no vbus supplied.
> 
> imx_anatop_set_stop_mode_config is used to keep internal regualtor on
> when the system enters suspend mode, it will increase power consumption,
> we only enable it when the user enables USB wakeup (default is off).
> 
> Signed-off-by: Peter Chen <peter.chen@freescale.com>
> ---
>  arch/arm/mach-imx/anatop.c |   22 ++++++++++++++++++++++
>  arch/arm/mach-imx/common.h |    2 ++
>  2 files changed, 24 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/anatop.c b/arch/arm/mach-imx/anatop.c
> index 71f1a08..7f96bbc 100644
> --- a/arch/arm/mach-imx/anatop.c
> +++ b/arch/arm/mach-imx/anatop.c
> @@ -26,6 +26,7 @@
>  #define ANADIG_ANA_MISC0	0x150
>  #define ANADIG_ANA_MISC2	0x170
>  #define ANADIG_USB1_CHRG_DETECT	0x1b0
> +#define ANADIG_USB1_LOOPBACK	0x1e0
>  #define ANADIG_USB2_CHRG_DETECT	0x210
>  #define ANADIG_DIGPROG		0x260
>  
> @@ -34,6 +35,8 @@
>  #define BM_ANADIG_ANA_MISC0_STOP_MODE_CONFIG	0x1000
>  #define BM_ANADIG_USB_CHRG_DETECT_CHK_CHRG_B	0x80000
>  #define BM_ANADIG_USB_CHRG_DETECT_EN_B		0x100000
> +#define BM_ANADIG_USB1_LOOPBACK_UTMI_DIG_TST1	0x00000004
> +#define BM_ANADIG_USB1_LOOPBACK_TSTI_TX_EN	0x00000020
>  
>  #define ANADIG_ANA_MISC2_REG1_STEP_OFFSET	26
>  #define ANADIG_ANA_MISC2_REG_STEP_MASK		0x3
> @@ -142,6 +145,25 @@ u32 imx_anatop_get_digprog(void)
>  	return digprog;
>  }
>  
> +void imx_anatop_usb1_disconnect_line(bool enable)
> +{
> +	if (enable)
> +		regmap_write(anatop, ANADIG_USB1_LOOPBACK,
> +			BM_ANADIG_USB1_LOOPBACK_UTMI_DIG_TST1 |
> +				BM_ANADIG_USB1_LOOPBACK_TSTI_TX_EN);
> +	else
> +		regmap_write(anatop, ANADIG_USB1_LOOPBACK, 0);
> +}
> +EXPORT_SYMBOL(imx_anatop_usb1_disconnect_line);
> +
> +void imx_anatop_set_stop_mode_config(bool enable)
> +{
> +	regmap_write(anatop, ANADIG_ANA_MISC0 +
> +		(enable ? REG_SET : REG_CLR),
> +			BM_ANADIG_ANA_MISC0_STOP_MODE_CONFIG);
> +}
> +EXPORT_SYMBOL(imx_anatop_set_stop_mode_config);
> +

Where do you want to call these two functions from?

Shawn

>  void __init imx_anatop_init(void)
>  {
>  	anatop = syscon_regmap_lookup_by_compatible("fsl,imx6q-anatop");
> diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
> index df1d7b0..dcb3305 100644
> --- a/arch/arm/mach-imx/common.h
> +++ b/arch/arm/mach-imx/common.h
> @@ -137,6 +137,8 @@ extern void imx_anatop_init(void);
>  extern void imx_anatop_pre_suspend(void);
>  extern void imx_anatop_post_resume(void);
>  extern u32 imx_anatop_get_digprog(void);
> +extern void imx_anatop_usb1_disconnect_line(bool);
> +extern void imx_anatop_set_stop_mode_config(bool);
>  extern int imx6q_set_lpm(enum mxc_cpu_pwr_mode mode);
>  extern void imx6q_set_chicken_bit(void);
>  
> -- 
> 1.7.1
> 
> 
