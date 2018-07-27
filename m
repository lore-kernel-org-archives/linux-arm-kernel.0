From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 27 Jul 2018 17:56:21 +0200
Subject: [PATCH v3 02/23] thermal: armada: remove useless register accesses
In-Reply-To: <20180716144206.30985-3-miquel.raynal@bootlin.com>
References: <20180716144206.30985-1-miquel.raynal@bootlin.com>
 <20180716144206.30985-3-miquel.raynal@bootlin.com>
Message-ID: <8b241e12-f7fe-1992-d634-0d38d956014f@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/07/2018 16:41, Miquel Raynal wrote:
> Prepare the migration to use regmaps by first simplifying the
> initialization functions: avoid unnecessary write/read cycles on
> configuration registers.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Good catch. I'm wondering why it was done this way ...

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>  drivers/thermal/armada_thermal.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
> index 077e8e562306..6fdb90b3c001 100644
> --- a/drivers/thermal/armada_thermal.c
> +++ b/drivers/thermal/armada_thermal.c
> @@ -103,16 +103,13 @@ static void armadaxp_init_sensor(struct platform_device *pdev,
>  
>  	reg = readl_relaxed(priv->control1);
>  	reg |= PMU_TDC0_OTF_CAL_MASK;
> -	writel(reg, priv->control1);
>  
>  	/* Reference calibration value */
>  	reg &= ~PMU_TDC0_REF_CAL_CNT_MASK;
>  	reg |= (0xf1 << PMU_TDC0_REF_CAL_CNT_OFFS);
> -	writel(reg, priv->control1);
>  
>  	/* Reset the sensor */
> -	reg = readl_relaxed(priv->control1);
> -	writel((reg | PMU_TDC0_SW_RST_MASK), priv->control1);
> +	reg |= PMU_TDC0_SW_RST_MASK;
>  
>  	writel(reg, priv->control1);
>  
> @@ -129,14 +126,13 @@ static void armada370_init_sensor(struct platform_device *pdev,
>  
>  	reg = readl_relaxed(priv->control1);
>  	reg |= PMU_TDC0_OTF_CAL_MASK;
> -	writel(reg, priv->control1);
>  
>  	/* Reference calibration value */
>  	reg &= ~PMU_TDC0_REF_CAL_CNT_MASK;
>  	reg |= (0xf1 << PMU_TDC0_REF_CAL_CNT_OFFS);
> -	writel(reg, priv->control1);
>  
>  	reg &= ~PMU_TDC0_START_CAL_MASK;
> +
>  	writel(reg, priv->control1);
>  
>  	msleep(10);
> 


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
