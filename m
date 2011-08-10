From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 10 Aug 2011 09:37:13 +0200
Subject: [PATCH] iomux-mx53: fix PAD_CTRL for I2C1_SDA and I2C1_SCL
In-Reply-To: <1312902763-15817-1-git-send-email-m.grzeschik@pengutronix.de>
References: <1312902763-15817-1-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <20110810073713.GW31404@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 09, 2011 at 05:12:43PM +0200, Michael Grzeschik wrote:
> Derived from the fsl kernel, this is needed to make connection work on
> the mx53 loco with devices connected to i2c1.
> 
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> ---
>  arch/arm/plat-mxc/include/mach/iomux-mx53.h |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)

This issue should be fixed with the following currently on its way to
arnd:

commit 4e606d68d2939128a15f56cbf546d44872230aad
Author: Eric Miao <eric.miao@linaro.org>
Date:   Tue Jun 14 15:19:47 2011 +0800

    ARM: mx53: add pad configuration for I2C signals
    
    I2C signals SDA/SCL are a bit different, they need to be pull-up and
    open-drain (so to support multiple I2C devices).
    
    Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
    Signed-off-by: Eric Miao <eric.miao@linaro.org>
    Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>


> 
> diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx53.h b/arch/arm/plat-mxc/include/mach/iomux-mx53.h
> index 9440b9e..281cc9c 100644
> --- a/arch/arm/plat-mxc/include/mach/iomux-mx53.h
> +++ b/arch/arm/plat-mxc/include/mach/iomux-mx53.h
> @@ -30,6 +30,10 @@
>  #define MX53_SDHC_PAD_CTRL 	(PAD_CTL_HYS | PAD_CTL_PKE | PAD_CTL_PUE | \
>  				PAD_CTL_PUS_47K_UP | PAD_CTL_DSE_HIGH | \
>  				PAD_CTL_SRE_FAST)
> +#define MX53_I2C_PAD_CTRL_2	(PAD_CTL_SRE_FAST | PAD_CTL_ODE | \
> +				PAD_CTL_PKE | PAD_CTL_PUE | \
> +				PAD_CTL_DSE_HIGH | PAD_CTL_PUS_100K_UP | \
> +				PAD_CTL_HYS)
>  
>  #define _MX53_PAD_GPIO_19__KPP_COL_5		IOMUX_PAD(0x348, 0x20, 0, 0x840, 0, 0)
>  #define _MX53_PAD_GPIO_19__GPIO4_5		IOMUX_PAD(0x348, 0x20, 1, 0x0, 0, 0)
> @@ -1536,7 +1540,7 @@
>  #define MX53_PAD_CSI0_DAT8__KPP_COL_7		(_MX53_PAD_CSI0_DAT8__KPP_COL_7 | MUX_PAD_CTRL(NO_PAD_CTRL))
>  #define MX53_PAD_CSI0_DAT8__ECSPI2_SCLK		(_MX53_PAD_CSI0_DAT8__ECSPI2_SCLK | MUX_PAD_CTRL(NO_PAD_CTRL))
>  #define MX53_PAD_CSI0_DAT8__USBOH3_USBH3_OC		(_MX53_PAD_CSI0_DAT8__USBOH3_USBH3_OC | MUX_PAD_CTRL(NO_PAD_CTRL))
> -#define MX53_PAD_CSI0_DAT8__I2C1_SDA		(_MX53_PAD_CSI0_DAT8__I2C1_SDA | MUX_PAD_CTRL(NO_PAD_CTRL))
> +#define MX53_PAD_CSI0_DAT8__I2C1_SDA		(_MX53_PAD_CSI0_DAT8__I2C1_SDA | MUX_PAD_CTRL(MX53_I2C_PAD_CTRL_2))
>  #define MX53_PAD_CSI0_DAT8__EMI_EMI_DEBUG_37		(_MX53_PAD_CSI0_DAT8__EMI_EMI_DEBUG_37 | MUX_PAD_CTRL(NO_PAD_CTRL))
>  #define MX53_PAD_CSI0_DAT8__TPIU_TRACE_5		(_MX53_PAD_CSI0_DAT8__TPIU_TRACE_5 | MUX_PAD_CTRL(NO_PAD_CTRL))
>  #define MX53_PAD_CSI0_DAT9__IPU_CSI0_D_9		(_MX53_PAD_CSI0_DAT9__IPU_CSI0_D_9 | MUX_PAD_CTRL(NO_PAD_CTRL))
> @@ -1544,7 +1548,7 @@
>  #define MX53_PAD_CSI0_DAT9__KPP_ROW_7		(_MX53_PAD_CSI0_DAT9__KPP_ROW_7 | MUX_PAD_CTRL(NO_PAD_CTRL))
>  #define MX53_PAD_CSI0_DAT9__ECSPI2_MOSI		(_MX53_PAD_CSI0_DAT9__ECSPI2_MOSI | MUX_PAD_CTRL(NO_PAD_CTRL))
>  #define MX53_PAD_CSI0_DAT9__USBOH3_USBH3_PWR		(_MX53_PAD_CSI0_DAT9__USBOH3_USBH3_PWR | MUX_PAD_CTRL(NO_PAD_CTRL))
> -#define MX53_PAD_CSI0_DAT9__I2C1_SCL		(_MX53_PAD_CSI0_DAT9__I2C1_SCL | MUX_PAD_CTRL(NO_PAD_CTRL))
> +#define MX53_PAD_CSI0_DAT9__I2C1_SCL		(_MX53_PAD_CSI0_DAT9__I2C1_SCL | MUX_PAD_CTRL(MX53_I2C_PAD_CTRL_2))
>  #define MX53_PAD_CSI0_DAT9__EMI_EMI_DEBUG_38		(_MX53_PAD_CSI0_DAT9__EMI_EMI_DEBUG_38 | MUX_PAD_CTRL(NO_PAD_CTRL))
>  #define MX53_PAD_CSI0_DAT9__TPIU_TRACE_6		(_MX53_PAD_CSI0_DAT9__TPIU_TRACE_6 | MUX_PAD_CTRL(NO_PAD_CTRL))
>  #define MX53_PAD_CSI0_DAT10__IPU_CSI0_D_10		(_MX53_PAD_CSI0_DAT10__IPU_CSI0_D_10 | MUX_PAD_CTRL(NO_PAD_CTRL))
> -- 
> 1.7.5.4
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
