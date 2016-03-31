From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 31 Mar 2016 14:10:58 +0200
Subject: [PATCH v7 01/20] PM / devfreq: exynos: Add generic exynos bus
 frequency driver
In-Reply-To: <1459415165-32613-2-git-send-email-cw00.choi@samsung.com>
References: <1459415165-32613-1-git-send-email-cw00.choi@samsung.com>
 <1459415165-32613-2-git-send-email-cw00.choi@samsung.com>
Message-ID: <56FD13D2.1050300@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/31/2016 11:05 AM, Chanwoo Choi wrote:

> +static int exynos_bus_target(struct device *dev, unsigned long *freq, u32 flags)
> +{

> +	new_opp = devfreq_recommended_opp(dev, freq, flags);
> +	if (IS_ERR_OR_NULL(new_opp)) {
> +		dev_err(dev, "failed to get recommed opp instance\n");

s/recommed/recommended/

> +		rcu_read_unlock();
> +		return PTR_ERR(new_opp);
> +	}

> +}

> +static int exynos_bus_probe(struct platform_device *pdev)
> +{

> +	bus->devfreq = devm_devfreq_add_device(dev, profile, "simple_ondemand",
> +						ondemand_data);
> +	if (IS_ERR_OR_NULL(bus->devfreq)) {
> +		dev_err(dev, "failed to add devfreq device\n");
> +		return  PTR_ERR(bus->devfreq);
> +	}

> +}

You should use IS_ERR() instead of IS_ERR_OR_NULL(), since functions
of which the return value is being tested return only ERR_PTR() values.
IS_ERR_OR_NULL() suggest NULL values are possible and then constructs
like
	if (IS_ERR_OR_NULL(result))
		return PTR_ERR(result);

are not correct anyway.

-- 
Regards,
Sylwester
