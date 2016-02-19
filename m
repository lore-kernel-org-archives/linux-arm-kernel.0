From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 19 Feb 2016 01:20:03 +0100
Subject: [PATCH v2 3/6] rockchip: power-domain: add support for sub-power
 domains
In-Reply-To: <1455764838-12928-4-git-send-email-zhangqing@rock-chips.com>
References: <1455764838-12928-1-git-send-email-zhangqing@rock-chips.com>
 <1455764838-12928-4-git-send-email-zhangqing@rock-chips.com>
Message-ID: <1828664.WUMlfLyMuz@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Elaine,

Am Donnerstag, 18. Februar 2016, 11:07:15 schrieb Elaine Zhang:
> This patch adds support for making one power domain a sub-domain of
> other domain. This is useful for modeling power dependences,
> which needs to have more than one power domain enabled to be operational.
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---
>  drivers/soc/rockchip/pm_domains.c | 54
> +++++++++++++++++++++++++++++++++++++++ 1 file changed, 54 insertions(+)
> 
> diff --git a/drivers/soc/rockchip/pm_domains.c
> b/drivers/soc/rockchip/pm_domains.c index 350527b..8cdf1b2 100644
> --- a/drivers/soc/rockchip/pm_domains.c
> +++ b/drivers/soc/rockchip/pm_domains.c
> @@ -372,6 +372,54 @@ static void rockchip_configure_pd_cnt(struct
> rockchip_pmu *pmu, regmap_write(pmu->regmap, domain_reg_offset + 4,
> count);
>  }
> 
> +static int rockchip_pm_add_subdomain(struct rockchip_pmu *pmu,
> +				     struct device_node *parent)
> +{
> +	struct device_node *np;
> +	int error;
> +
> +	for_each_child_of_node(parent, np) {
> +		struct generic_pm_domain *child_domain, *parent_domain;
> +		u32 idx = ~0;
> +
> +		if (of_property_read_u32(parent, "reg", &idx)) {
> +			dev_err(pmu->dev,
> +				"%s: failed to retrieve domain id (reg)\n",
> +				parent->name);
> +			of_node_put(parent);
> +			return -EINVAL;
> +		}
> +		parent_domain = pmu->genpd_data.domains[idx];
> +
> +		error = rockchip_pm_add_one_domain(pmu, np);
> +		if (error) {
> +			dev_err(pmu->dev, "failed to handle node %s: %d\n",
> +				np->name, error);
> +			of_node_put(np);
> +			return -ENODEV;
> +		}
> +
> +		if (of_property_read_u32(np, "reg", &idx)) {
> +			dev_err(pmu->dev,
> +				"%s: failed to retrieve domain id (reg)\n",
> +				np->name);
> +			of_node_put(np);
> +			return -EINVAL;
> +		}
> +		child_domain = pmu->genpd_data.domains[idx];
> +
> +		if (pm_genpd_add_subdomain(parent_domain, child_domain))
> +			pr_warn("%s failed to add subdomain: %s\n",
> +				parent_domain->name, child_domain->name);

should probably be dev_err here


> +		else
> +			pr_warn("%s add subdomain: %s\n",
> +				parent_domain->name, child_domain->name);

you don't need pr_warn / dev_warn on sucess

> +
> +		rockchip_pm_add_subdomain(pmu, np);
> +	}
> +	return 0;
> +}
> +

In general the code looks like you're going to group the domains 
hirarchically, like

       power: power-controller {
               compatible = "rockchip,rk3399-power-controller";

               pd_cci {
                       reg = <RK3399_PD_CCI>;
                       clocks = ...;

			pd_cci0 {
				reg = <RK3399_PD_CCI0>;
				clocks = ...;
			};
               };
       };

This isn't documented in the dt-binding and also isn't really improving
reading these declarations. Instead as I said before, I think I'd like more 
get inspiration from how Exynos is doing that already (arch/arm/mach-
exynos/pm_domains.c at "Assign the child power domains to their parents") 
simply declaring an additional power-domains property like:

       power: power-controller {
               compatible = "rockchip,rk3399-power-controller";

               pd_cci {
                       reg = <RK3399_PD_CCI>;
                       clocks = ...;
               };

		pd_cci0 {
			reg = <RK3399_PD_CCI0>;
			clocks = ...;
			power-domains = <&power RK3399_PD_CCI>;
		};
       };

>  static int rockchip_pm_domain_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -437,6 +485,12 @@ static int rockchip_pm_domain_probe(struct
> platform_device *pdev) node->name, error);
>  			goto err_out;
>  		}

blank line here

> +		error = rockchip_pm_add_subdomain(pmu, node);
> +		if (error < 0) {
> +			dev_err(dev, "failed to handle subdomain node %s: %d\n",
> +				node->name, error);
> +			goto err_out;
> +		}
>  	}
> 
>  	if (error) {
