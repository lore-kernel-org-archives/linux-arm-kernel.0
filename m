From: varkabhadram@gmail.com (Varka Bhadram)
Date: Mon, 20 Oct 2014 14:39:48 +0530
Subject: [PATCH v4 1/3] power-domain: add power domain drivers for Rockchip
 platform
In-Reply-To: <1413795824-3453-2-git-send-email-jinkun.hong@rock-chips.com>
References: <1413795824-3453-1-git-send-email-jinkun.hong@rock-chips.com>
 <1413795824-3453-2-git-send-email-jinkun.hong@rock-chips.com>
Message-ID: <5444D15C.4030308@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/20/2014 02:33 PM, jinkun.hong wrote:
> From: "jinkun.hong" <jinkun.hong@rock-chips.com>
>
> Add power domain drivers based on generic power domain for Rockchip platform,
> and support RK3288.
>
> Signed-off-by: Jack Dai <jack.dai@rock-chips.com>
> Signed-off-by: jinkun.hong <jinkun.hong@rock-chips.com>
>
> ---
>
(...)

> +static int rockchip_pd_power(struct rockchip_domain *pd, bool power_on)
> +{
> +	int i = 0;
> +	int ret = 0;
> +	struct rockchip_dev_entry *de;
> +
> +	spin_lock_irq(&pd->dev_lock);
> +
> +	list_for_each_entry(de, &pd->dev_list, node) {
> +		i += 1;
> +		pm_clk_resume(pd->dev);
> +	}
> +
> +	/* no clk, set power domain will fail */
> +	if (i == 0) {
> +		pr_err("%s: failed to on/off power domain!", __func__);

Missed terminating new line  :-)

> +		spin_unlock_irq(&pd->dev_lock);
> +		return ret;
> +	}
> +
> +	ret = rockchip_pmu_set_power_domain(pd, power_on);
> +
> +	list_for_each_entry(de, &pd->dev_list, node) {
> +		pm_clk_suspend(pd->dev);
> +	}
> +
> +	spin_unlock_irq(&pd->dev_lock);
> +
> +	return ret;
> +}
> +

(...)

> +static int rockchip_pm_domain_probe(struct platform_device *pdev)
> +{
> +	struct device_node *node;
> +	struct regmap *regmap_pmu;
> +	struct rockchip_domain *pd;
> +	const struct of_device_id *match;
> +
> +	match = of_match_node(rockchip_pm_domain_dt_match, pdev->dev.of_node);
> +	pd = (struct rockchip_domain *)match->data;
> +

Unnecessary one line space..

> +	if (!pd)
> +		return -ENOMEM;
> +
> +	node = of_parse_phandle(pdev->dev.of_node, "rockchip,pmu", 0);
> +	regmap_pmu = syscon_node_to_regmap(node);
> +	of_node_put(node);
> +	if (IS_ERR(regmap_pmu)) {
> +		pr_err("%s: failed to get regmap_pmu", __func__);

Terminating new line missed...  :-)

> +		return PTR_ERR(regmap_pmu);
> +	}
> +
> +	pd->regmap_pmu = regmap_pmu;
> +	pd->dev = &pdev->dev;
> +
> +	INIT_LIST_HEAD(&pd->dev_list);
> +
> +	spin_lock_init(&pd->idle_lock);
> +	spin_lock_init(&pd->pmu_lock);
> +	spin_lock_init(&pd->dev_lock);
> +
> +	pm_genpd_init(&pd->base, NULL, false);
> +
> +	return of_genpd_add_provider_simple(pdev->dev.of_node, &pd->base);
> +}
> +
>
-- 
Thanks and Regards,
Varka Bhadram.
