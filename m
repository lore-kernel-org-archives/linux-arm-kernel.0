From: inki.dae@samsung.com (Inki Dae)
Date: Wed, 14 Feb 2018 14:57:08 +0900
Subject: [PATCH] drm: exynos: Use proper macro definition for
 HDMI_I2S_PIN_SEL_1
In-Reply-To: <20180205174212.10791-1-s.nawrocki@samsung.com>
References: <CGME20180205174229epcas1p1e15e6f8ef5248ee28fa2e649faa8a866@epcas1p1.samsung.com>
 <20180205174212.10791-1-s.nawrocki@samsung.com>
Message-ID: <5A83CFB4.6000207@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sylwester,

2018? 02? 06? 02:42? Sylwester Nawrocki ?(?) ? ?:
> Bit field [2:0] of HDMI_I2S_PIN_SEL_1 corresponds to SDATA_0,
> not SDATA_2. This patch removes redefinition of HDMI_I2S_SEL_DATA2
> constant and adds missing HDMI_I2S_SEL_DATA0. There is no functional
> change.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  drivers/gpu/drm/exynos/exynos_hdmi.c | 7 +++++--
>  drivers/gpu/drm/exynos/regs-hdmi.h   | 2 +-
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exynos/exynos_hdmi.c
> index a4b75a46f946..abd84cbcf1c2 100644
> --- a/drivers/gpu/drm/exynos/exynos_hdmi.c
> +++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
> @@ -1068,10 +1068,13 @@ static void hdmi_audio_config(struct hdmi_context *hdata)
>  	/* Configuration I2S input ports. Configure I2S_PIN_SEL_0~4 */
>  	hdmi_reg_writeb(hdata, HDMI_I2S_PIN_SEL_0, HDMI_I2S_SEL_SCLK(5)
>  			| HDMI_I2S_SEL_LRCK(6));
> -	hdmi_reg_writeb(hdata, HDMI_I2S_PIN_SEL_1, HDMI_I2S_SEL_SDATA1(1)
> -			| HDMI_I2S_SEL_SDATA2(4));
> +
> +	hdmi_reg_writeb(hdata, HDMI_I2S_PIN_SEL_1, HDMI_I2S_SEL_SDATA1(3)

Seems you fixed pin_sel_3 field value of I2S_PIN_SEL_1 register. According to datasheet, 0x3 should be set to this field to select SDATA_1 not 0x1.
So could you update the description of this patch?

Thanks,
Inki Dae

> +			| HDMI_I2S_SEL_SDATA0(4));
> +
>  	hdmi_reg_writeb(hdata, HDMI_I2S_PIN_SEL_2, HDMI_I2S_SEL_SDATA3(1)
>  			| HDMI_I2S_SEL_SDATA2(2));
> +
>  	hdmi_reg_writeb(hdata, HDMI_I2S_PIN_SEL_3, HDMI_I2S_SEL_DSD(0));
>  
>  	/* I2S_CON_1 & 2 */
> diff --git a/drivers/gpu/drm/exynos/regs-hdmi.h b/drivers/gpu/drm/exynos/regs-hdmi.h
> index 04be0f7e8193..4420c203ac85 100644
> --- a/drivers/gpu/drm/exynos/regs-hdmi.h
> +++ b/drivers/gpu/drm/exynos/regs-hdmi.h
> @@ -464,7 +464,7 @@
>  
>  /* I2S_PIN_SEL_1 */
>  #define HDMI_I2S_SEL_SDATA1(x)		(((x) & 0x7) << 4)
> -#define HDMI_I2S_SEL_SDATA2(x)		((x) & 0x7)
> +#define HDMI_I2S_SEL_SDATA0(x)		((x) & 0x7)
>  
>  /* I2S_PIN_SEL_2 */
>  #define HDMI_I2S_SEL_SDATA3(x)		(((x) & 0x7) << 4)
> 
