From: sshtylyov@ru.mvista.com (Sergei Shtylyov)
Date: Thu, 26 Jan 2012 15:26:24 +0400
Subject: [PATCH 07/21] OMAP3+: PM: SR/Class3: disable errorgen before
 disable VP
In-Reply-To: <1327504583-13408-8-git-send-email-j-pihet@ti.com>
References: <1327504583-13408-1-git-send-email-j-pihet@ti.com>
 <1327504583-13408-8-git-send-email-j-pihet@ti.com>
Message-ID: <4F213860.9050600@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 25-01-2012 19:16, Jean Pihet wrote:

> From: Nishanth Menon<nm@ti.com>

> SmartReflex AVS Errorgen module supplies signals to Voltage
> Processor. It is suggested that by disabling Errorgen module
> before we disable VP, we might be able to ensure lesser
> chances of race condition to occur in the system.

> Change-Id: Id0145adacfa63d7652a29859ad6c95cc2ac61cc8

    Please remove this line.

> Signed-off-by: Nishanth Menon<nm@ti.com>
> Signed-off-by: Jean Pihet<j-pihet@ti.com>
[...]

> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
> index ee224df..d7294c6 100644
> --- a/arch/arm/mach-omap2/smartreflex.c
> +++ b/arch/arm/mach-omap2/smartreflex.c
> @@ -454,6 +454,50 @@ int sr_configure_errgen(struct voltagedomain *voltdm)
>   }
>
>   /**
> + * sr_disable_errgen() - Disables SmartReflex AVS module's errgen component
> + * @voltdm: voltagedomain pointer to which the SR module to be configured belongs to.
> + *
> + * This API is to be called from the smartreflex class driver to
> + * disable the error generator module inside the smartreflex module.
> + *
> + * Returns 0 on success and error value in case of failure.
> + */
> +int sr_disable_errgen(struct voltagedomain *voltdm)
> +{
> +	u32 errconfig_offs, vpboundint_en;
> +	u32 vpboundint_st;
> +	struct omap_sr *sr = _sr_lookup(voltdm);
> +
> +	if (IS_ERR(sr)) {
> +		pr_warning("%s: omap_sr struct for sr_%s not found\n",
> +			__func__, voltdm->name);
> +		return -EINVAL;

    Not PTR_ERR(sr)?

WBR, Sergei
