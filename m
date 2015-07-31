From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 30 Jul 2015 22:51:06 -0700
Subject: [PATCH V3 07/16] PM / OPP: Add support to parse
 "operating-points-v2" bindings
In-Reply-To: <6d8d9cd0c3ae2d3fa8c3aadedb5ac403785b7675.1438166099.git.viresh.kumar@linaro.org>
References: <cover.1438166099.git.viresh.kumar@linaro.org>
 <6d8d9cd0c3ae2d3fa8c3aadedb5ac403785b7675.1438166099.git.viresh.kumar@linaro.org>
Message-ID: <20150731055106.GJ3159@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/29, Viresh Kumar wrote:
> This adds support in OPP library to parse and create list of OPPs from
> operating-points-v2 bindings. It takes care of most of the properties of
> new bindings (except shared-opp, which will be handled separately).
> 
> For backward compatibility, we keep supporting earlier bindings. We try
> to search for the new bindings first, in case they aren't present we
> look for the old deprecated ones.
> 
> There are few things marked as TODO:
> - Support for multiple OPP tables
> - Support for multiple regulators
> 
> They should be fixed separately.
> 
> Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

One question below:

> @@ -679,6 +691,125 @@ static int _opp_add_dynamic(struct device *dev, unsigned long freq,
>  	return ret;
>  }
>  
> +/* TODO: Support multiple regulators */
> +static int opp_get_microvolt(struct dev_pm_opp *opp, struct device *dev)
> +{
> +	u32 microvolt[3] = {0};
> +	int count, ret;
> +
> +	count = of_property_count_u32_elems(opp->np, "opp-microvolt");
> +	if (!count)
> +		return 0;
> +
> +	/* There can be one or three elements here */
> +	if (count != 1 && count != 3) {
> +		dev_err(dev, "%s: Invalid number of elements in opp-microvolt property (%d)\n",
> +			__func__, count);
> +		return -EINVAL;
> +	}
> +
> +	ret = of_property_read_u32_array(opp->np, "opp-microvolt", microvolt,
> +					 count);
> +	if (ret) {
> +		dev_err(dev, "%s: error parsing opp-microvolt: %d\n", __func__,
> +			ret);
> +		return -EINVAL;
> +	}
> +
> +	opp->u_volt = microvolt[0];
> +	opp->u_volt_min = microvolt[1];
> +	opp->u_volt_max = microvolt[2];

Should the default be 0 and ULONG_MAX for volt_min/volt_max when
there's on element?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
