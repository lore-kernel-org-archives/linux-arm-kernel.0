From: smasetty@codeaurora.org (Sharat Masetty)
Date: Fri, 5 Oct 2018 12:06:06 +0530
Subject: [PATCH 7/9] OPP: Add dev_pm_opp_get_interconnect_bw()
In-Reply-To: <20180827151112.25211-8-jcrouse@codeaurora.org>
References: <20180827151112.25211-1-jcrouse@codeaurora.org>
 <20180827151112.25211-8-jcrouse@codeaurora.org>
Message-ID: <49858ede-66db-b58f-e586-411896efad4b@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 8/27/2018 8:41 PM, Jordan Crouse wrote:
> Add dev_pm_opp_get_interconnect_bw() to read the interconnect
> bandwidth values for a given OPP.
> 
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> ---
>   drivers/opp/of.c       | 36 ++++++++++++++++++++++++++++++++++++
>   include/linux/pm_opp.h |  7 +++++++
>   2 files changed, 43 insertions(+)
> 
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index 7af0ddec936b..6a5eecaaf8c1 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -777,3 +777,39 @@ struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp)
>   	return of_node_get(opp->np);
>   }
>   EXPORT_SYMBOL_GPL(dev_pm_opp_get_of_node);
> +
> +/**
> + * dev_pm_opp_get_interconnect_bw() - Get the interconnect bandwidth for the opp
> + * @opp:	opp containing the bandwidth values
> + * @pathname:	name of the interconnect path for the bandwidth values
> + * @avgbw:	Pointer for the value to hold the average BW defined for the OPP
> + * @peakbw:	Pointer for the value to hold the peak BW defined for the OPP
> + *
> + * Return: Negative value on error or 0 on success
> + */
> +int dev_pm_opp_get_interconnect_bw(struct dev_pm_opp *opp,
> +		const char *pathname, u64 *avgbw, u64 *peakbw)
> +{
> +	char name[NAME_MAX];
> +	struct property *prop;
> +	int count;
> +
> +	if (IS_ERR_OR_NULL(opp))
> +		return -ENOENT;
> +
> +	snprintf(name, NAME_MAX, "opp-interconnect-bw-%s", pathname);
> +	prop = of_find_property(opp->np, name, NULL);
> +
> +	if (!prop)
> +		return -ENOENT;
> +
> +	count = of_property_count_u64_elems(opp->np, name);
> +	if (count != 2)
> +		return -EINVAL;
> +
> +	of_property_read_u64_index(opp->np, name, 0, avgbw);
> +	of_property_read_u64_index(opp->np, name, 0, peakbw);
This should be index 1 for peak bandwidth
	of_property_read_u64_index(opp->np, name, 1, peakbw);
I tested with this fix and the GPU's interconnect summary now shows
non zero values for peak bandwidth. Can you please raise a newer version 
of this patch? I will have it pulled into our downstream builds.
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_opp_get_interconnect_bw);
> diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
> index 099b31960dec..70e49e259d0e 100644
> --- a/include/linux/pm_opp.h
> +++ b/include/linux/pm_opp.h
> @@ -301,6 +301,7 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpuma
>   struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device *dev);
>   struct dev_pm_opp *of_dev_pm_opp_find_required_opp(struct device *dev, struct device_node *np);
>   struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp);
> +int dev_pm_opp_get_interconnect_bw(struct dev_pm_opp *opp, const char *pathname, u64 *avgbw, u64 *peakbw);
>   #else
>   static inline int dev_pm_opp_of_add_table(struct device *dev)
>   {
> @@ -343,6 +344,12 @@ static inline struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp)
>   {
>   	return NULL;
>   }
> +
> +static inline int dev_pm_opp_get_interconnect_bw(struct dev_pm_opp *opp, const char *pathname,
> +		u64 *avgbw, u64 *peakbw)
> +{
> +	return -ENOTSUPP;
> +}
>   #endif
>   
>   #endif		/* __LINUX_OPP_H__ */
> 

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
Linux Foundation Collaborative Project
