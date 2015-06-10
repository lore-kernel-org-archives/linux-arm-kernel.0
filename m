From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 10 Jun 2015 08:36:52 +0100
Subject: [PATCH 1/8] mfd: axp20x: Add missing registers, and mark more
 registers volatile
In-Reply-To: <1433885881-19809-2-git-send-email-hdegoede@redhat.com>
References: <1433885881-19809-1-git-send-email-hdegoede@redhat.com>
 <1433885881-19809-2-git-send-email-hdegoede@redhat.com>
Message-ID: <20150610073652.GY2982@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 09 Jun 2015, Hans de Goede wrote:

> From: Bruno Pr?mont <bonbons@linux-vserver.org>
> 
> Add an extra set of registers which is necessary tu support the PMICs
> battery charger function, and mark registers which contain status bits,
> gpio status, and adc readings as volatile.
> 
> Cc: Bruno Pr?mont <bonbons@linux-vserver.org>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/mfd/axp20x.c       | 6 ++++++
>  include/linux/mfd/axp20x.h | 5 +++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index 6df9155..6ffbc11 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -39,10 +39,16 @@ static const char * const axp20x_model_names[] = {
>  static const struct regmap_range axp20x_writeable_ranges[] = {
>  	regmap_reg_range(AXP20X_DATACACHE(0), AXP20X_IRQ5_STATE),
>  	regmap_reg_range(AXP20X_DCDC_MODE, AXP20X_FG_RES),
> +	regmap_reg_range(AXP20X_RDC_H, AXP20X_OCV(15)),

Define 15 please.

>  };
>  
>  static const struct regmap_range axp20x_volatile_ranges[] = {
> +	regmap_reg_range(AXP20X_PWR_INPUT_STATUS, AXP20X_USB_OTG_STATUS),
> +	regmap_reg_range(AXP20X_CHRG_CTRL1, AXP20X_CHRG_CTRL2),
>  	regmap_reg_range(AXP20X_IRQ1_EN, AXP20X_IRQ5_STATE),
> +	regmap_reg_range(AXP20X_ACIN_V_ADC_H, AXP20X_IPSOUT_V_HIGH_L),
> +	regmap_reg_range(AXP20X_GPIO20_SS, AXP20X_GPIO3_CTRL),
> +	regmap_reg_range(AXP20X_FG_RES, AXP20X_RDC_L),
>  };
>  
>  static const struct regmap_access_table axp20x_writeable_table = {
> diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
> index 95568eb..f4290ae 100644
> --- a/include/linux/mfd/axp20x.h
> +++ b/include/linux/mfd/axp20x.h
> @@ -151,6 +151,11 @@ enum {
>  #define AXP20X_CC_CTRL			0xb8
>  #define AXP20X_FG_RES			0xb9
>  
> +/* OCV */
> +#define AXP20X_RDC_H			0xba
> +#define AXP20X_RDC_L			0xbb
> +#define AXP20X_OCV(m)			(0xc0 + (m))
> +
>  /* AXP22X specific registers */
>  #define AXP22X_BATLOW_THRES1		0xe6
>  

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
