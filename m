From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 8 Sep 2014 08:27:17 +0100
Subject: [PATCH] mfd: mc13xxx: Configure WDI reset
In-Reply-To: <1410159671-25873-1-git-send-email-mpa@pengutronix.de>
References: <1410159671-25873-1-git-send-email-mpa@pengutronix.de>
Message-ID: <20140908072717.GH1397@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 08 Sep 2014, Markus Pargmann wrote:

> Setup the PMIC to make a restart when a watchdog interrupt occures.
> If this is not configured, the PMIC will shut down the power supply
> without a restart.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  drivers/mfd/mc13xxx-core.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Applied, thanks.

> diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.c
> index 2b6bc868cd3d..64dde5d24b32 100644
> --- a/drivers/mfd/mc13xxx-core.c
> +++ b/drivers/mfd/mc13xxx-core.c
> @@ -36,6 +36,9 @@
>  #define MC34708_REVISION_FIN		(0x07 <<  6)
>  #define MC34708_REVISION_FAB		(0x07 <<  9)
>  
> +#define MC13XXX_PWRCTRL		15
> +#define MC13XXX_PWRCTRL_WDIRESET	(1 << 12)
> +
>  #define MC13XXX_ADC1		44
>  #define MC13XXX_ADC1_ADEN		(1 << 0)
>  #define MC13XXX_ADC1_RAND		(1 << 1)
> @@ -416,6 +419,11 @@ int mc13xxx_common_init(struct device *dev)
>  
>  	mc13xxx->variant->print_revision(mc13xxx, revision);
>  
> +	ret = mc13xxx_reg_rmw(mc13xxx, MC13XXX_PWRCTRL,
> +			MC13XXX_PWRCTRL_WDIRESET, MC13XXX_PWRCTRL_WDIRESET);
> +	if (ret)
> +		return ret;
> +
>  	for (i = 0; i < ARRAY_SIZE(mc13xxx->irqs); i++) {
>  		mc13xxx->irqs[i].reg_offset = i / MC13XXX_IRQ_PER_REG;
>  		mc13xxx->irqs[i].mask = BIT(i % MC13XXX_IRQ_PER_REG);

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
