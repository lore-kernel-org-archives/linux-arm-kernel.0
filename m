From: khilman@kernel.org (Kevin Hilman)
Date: Thu, 25 Sep 2014 15:23:10 -0700
Subject: [RFC PATCH 2/4] ARM: keystone: pm: switch to use generic pm
 domains
In-Reply-To: <1411657537-25238-3-git-send-email-grygorii.strashko@ti.com>
 (Grygorii Strashko's message of "Thu, 25 Sep 2014 18:05:35 +0300")
References: <1411657537-25238-1-git-send-email-grygorii.strashko@ti.com>
 <1411657537-25238-3-git-send-email-grygorii.strashko@ti.com>
Message-ID: <7hlhp79w6p.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Grygorii Strashko <grygorii.strashko@ti.com> writes:

> This patch switches Keystone 2 PM code to use Generic PM domains
> instead of PM  clock domains because of the lack of DT support
> for the last.
>
> Keystone 2 PM domain should be specified per device for which
> Runtime PM has to be enabled and handles the list of functional clocks
> to enable/disable device.
>
> Example:
>  qmss_domain: qmss_pm_controller {
> 	compatible = "ti,keystone-pm-controller";
> 	clocks = <&chipclk13>;
> 	#power-domain-cells = <0>;
>  };
>
>  qmss: qmss at 2a40000 {
> 	compatible = "ti,keystone-navigator-qmss";
> 	...
> 	power-domains = <&qmss_domain>;
>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

[...]

> +static int keystone_pm_domain_power_off(struct generic_pm_domain *genpd)
> +{
> +	int ret;
> +	struct keystone_domain *dm = container_of(genpd,
> +						  struct keystone_domain,
> +						  base);
> +
> +	/* Enable reset clocks for all devices in the PU domain */

This says enable clocks...

> +	ret = pm_clk_suspend(dm->dev);

...but this calls clk_disable().

> +	if (ret)
> +		dev_err(dm->dev, "can't turn off clocks %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static int keystone_pm_domain_power_on(struct generic_pm_domain *genpd)
> +{
> +	int ret;
> +	struct keystone_domain *dm = container_of(genpd,
> +						  struct keystone_domain,
> +						  base);
> +
> +	/* Disable reset clocks for all devices in the PU domain */

And this says disable clocks...

> +	ret = pm_clk_resume(dm->dev);

...but this calls clk_enable().

-ECONFUSED.

Kevin
