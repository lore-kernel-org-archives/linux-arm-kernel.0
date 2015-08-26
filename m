From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 26 Aug 2015 18:00:24 +0200 (CEST)
Subject: [PATCH 1/1] irqchip: imx-gpcv2: Simplify the implemenation
In-Reply-To: <1440604166-2624-1-git-send-email-shenwei.wang@freescale.com>
References: <1440604166-2624-1-git-send-email-shenwei.wang@freescale.com>
Message-ID: <alpine.DEB.2.11.1508261756540.15006@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 26 Aug 2015, Shenwei Wang wrote:
>  u32 imx_gpcv2_get_wakeup_source(u32 **sources)
>  {
> -	if (!imx_gpcv2_instance)
> +	struct gpcv2_irqchip_data *cd;
> +	void __iomem *reg;
> +	int i;
> +
> +	cd = imx_gpcv2_instance;
> +	if (!cd)
>  		return 0;
>  
> +	for (i = 0; i < IMR_NUM; i++) {
> +		reg = cd->gpc_base + cd->cpu2wakeup + i * 4;
> +		cd->wakeup_sources[i] = readl_relaxed(reg);
> +	}
> +
>  	if (sources)
> -		*sources = imx_gpcv2_instance->wakeup_sources;
> +		*sources = cd->wakeup_sources;
>  
>  	return IMR_NUM;

You do not need the intermediate storage at all.

u32 imx_gpcv2_get_wakeup_source(u32 *sources)
{
	if (sources) {
		for (i = 0; i < IMR_NUM; i++) {
			reg = cd->gpc_base + cd->cpu2wakeup + i * 4;
			sources[i] = readl_relaxed(reg);
		}
	}
	....

Hmm?
