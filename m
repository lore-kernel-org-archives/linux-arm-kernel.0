From: khilman@kernel.org (Kevin Hilman)
Date: Tue, 26 May 2015 15:35:14 -0700
Subject: [PATCH 2/4] soc: Mediatek: Add SCPSYS power domain driver
In-Reply-To: <1431349882-12260-3-git-send-email-s.hauer@pengutronix.de>
 (Sascha Hauer's message of "Mon, 11 May 2015 15:11:20 +0200")
References: <1431349882-12260-1-git-send-email-s.hauer@pengutronix.de>
 <1431349882-12260-3-git-send-email-s.hauer@pengutronix.de>
Message-ID: <7hlhgbotlp.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sascha Hauer <s.hauer@pengutronix.de> writes:

> This adds a power domain driver for the Mediatek SCPSYS unit.
>
> The System Control Processor System (SCPSYS) has several power
> management related tasks in the system. The tasks include thermal
> measurement, dynamic voltage frequency scaling (DVFS), interrupt
> filter and lowlevel sleep control. The System Power Manager (SPM)
> inside the SCPSYS is for the MTCMOS power domain control.
>
> For now this driver only adds power domain support, the more
> advanced features are not yet supported. The driver implements
> the generic PM domain device tree bindings, the first user will
> most likely be the Mediatek AFE audio driver.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/soc/mediatek/Kconfig             |   6 +
>  drivers/soc/mediatek/Makefile            |   1 +
>  drivers/soc/mediatek/mtk-scpsys.c        | 345 +++++++++++++++++++++++++++++++
>  include/dt-bindings/power/mt8173-power.h |  15 ++
>  4 files changed, 367 insertions(+)
>  create mode 100644 drivers/soc/mediatek/mtk-scpsys.c
>  create mode 100644 include/dt-bindings/power/mt8173-power.h
>
> diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
> index bcdb22d..1d34819 100644
> --- a/drivers/soc/mediatek/Kconfig
> +++ b/drivers/soc/mediatek/Kconfig
> @@ -9,3 +9,9 @@ config MTK_PMIC_WRAP
>  	  Say yes here to add support for MediaTek PMIC Wrapper found
>  	  on different MediaTek SoCs. The PMIC wrapper is a proprietary
>  	  hardware to connect the PMIC.
> +
> +config MTK_SCPSYS
> +	tristate "MediaTek SCPSYS Support"

depends on ARCH_MEDIATEK ?

> +	help
> +	  Say yes here to add support for the MediaTek SCPSYS power domain
> +	  driver.

[...]

> +static int scpsys_probe(struct platform_device *pdev)
> +{
> +	struct genpd_onecell_data *pd_data;
> +	struct resource *res;
> +	int i;
> +	struct scp *scp;
> +
> +	scp = devm_kzalloc(&pdev->dev, sizeof(*scp), GFP_KERNEL);
> +	if (!scp)
> +		return -ENOMEM;
> +
> +	scp->dev = &pdev->dev;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	scp->base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(scp->base))
> +		return PTR_ERR(scp->base);
> +
> +	pd_data = &scp->pd_data;
> +
> +	pd_data->domains = scp->pmd;
> +	pd_data->num_domains = NUM_DOMAINS;
> +
> +	for (i = 0; i < NUM_DOMAINS; i++) {
> +		struct scp_domain *scpd = &scp->domains[i];
> +		struct generic_pm_domain *pmd = &scpd->pmd;
> +
> +		scp->pmd[i] = pmd;
> +		scpd->data = &scp_domain_data[i];
> +		scpd->scp = scp;
> +
> +		pmd->name = scp_domain_data[i].name;
> +		pmd->power_off = scpsys_power_off;
> +		pmd->power_on = scpsys_power_on;
> +		pmd->power_off_latency_ns = 20000;
> +		pmd->power_on_latency_ns = 20000;

I think I mentioned this before... are these numbers really identical
for all domains?  I suggest you make these each a field in the domain
data so they can be different for each domain, and eventually come from
DT data.

> +		pd_data->domains[i] = pmd;
> +		pm_genpd_init(pmd, NULL, 1);
> +
> +		/*
> +		 * If PM is disabled turn on all domains by default so that
> +		 * consumers can work.
> +		 */
> +		if (!IS_ENABLED(CONFIG_PM))
> +			pmd->power_on(pmd);
> +	}
> +
> +	return of_genpd_add_provider_onecell(pdev->dev.of_node, pd_data);
> +}

Kevin
