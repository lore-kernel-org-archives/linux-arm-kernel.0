From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Tue, 01 Apr 2014 16:52:07 +0200
Subject: [PATCH RFC v4 2/2] clk: Add handling of clk parent and rate
 assigned from DT
In-Reply-To: <1965445.mLnp8rmPxd@avalon>
References: <1396284116-19178-1-git-send-email-s.nawrocki@samsung.com>
 <1396284116-19178-3-git-send-email-s.nawrocki@samsung.com>
 <1965445.mLnp8rmPxd@avalon>
Message-ID: <533AD297.2020302@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

On 01/04/14 15:15, Laurent Pinchart wrote:
[...]
>> +/**
>> + * of_clk_device_init() - parse and set clk configuration assigned to a
>> device
>> + * @node: device node to apply the configuration for
>> + *
>> + * This function parses 'clock-parents' and 'clock-rates' properties and
>> sets
>> + * any specified clock parents and rates.
>> + */
>> +int of_clk_device_init(struct device_node *node)
>> +{
>> +	struct property	*prop;
>> +	const __be32 *cur;
>> +	int rc, index, num_parents;
>> +	struct clk *clk, *pclk;
>> +	u32 rate;
>> +
>> +	num_parents = of_count_phandle_with_args(node, "clock-parents",
>> +						 "#clock-cells");
>> +	if (num_parents == -EINVAL)
>> +		pr_err("clk: Invalid value of clock-parents property at %s\n",
>> +		       node->full_name);
> 
> This is an implementation detail, but wouldn't it simplify the code if you 
> merged the two loops by iterating of the 	clocks property instead of over the 
> clock-parents and clock-rates properties separately ?

The issue here is that all clock parents should be set before we start setting
clock rates. Otherwise the clock frequencies could be incorrect if clk_set_rate()
is followed by clk_set_parent().

>> +	for (index = 0; index < num_parents; index++) {
>> +		pclk = of_clk_get_by_property(node, "clock-parents", index);
>> +		if (IS_ERR(pclk)) {
>> +			/* skip empty (null) phandles */
>> +			if (PTR_ERR(pclk) == -ENOENT)
>> +				continue;
>> +
>> +			pr_warn("clk: couldn't get parent clock %d for %s\n",
>> +				index, node->full_name);
>> +			return PTR_ERR(pclk);
>> +		}
>> +
>> +		clk = of_clk_get(node, index);
>> +		if (IS_ERR(clk)) {
>> +			pr_warn("clk: couldn't get clock %d for %s\n",
>> +				index, node->full_name);
>> +			return PTR_ERR(clk);
>> +		}
>> +
>> +		rc = clk_set_parent(clk, pclk);
>> +		if (rc < 0)
>> +			pr_err("clk: failed to reparent %s to %s: %d\n",
>> +			       __clk_get_name(clk), __clk_get_name(pclk), rc);
>> +		else
>> +			pr_debug("clk: set %s as parent of %s\n",
>> +				 __clk_get_name(pclk), __clk_get_name(clk));
>> +	}
>> +
>> +	index = 0;
>> +	of_property_for_each_u32(node, "clock-rates", prop, cur, rate) {
>> +		if (rate) {
>> +			clk = of_clk_get(node, index);
>> +			if (IS_ERR(clk)) {
>> +				pr_warn("clk: couldn't get clock %d for %s\n",
>> +					index, node->full_name);
>> +				return PTR_ERR(clk);
>> +			}
>> +
>> +			rc = clk_set_rate(clk, rate);
>> +			if (rc < 0)
>> +				pr_err("clk: couldn't set %s clock rate: %d\n",
>> +				       __clk_get_name(clk), rc);
>> +			else
>> +				pr_debug("clk: set rate of clock %s to %lu\n",
>> +					 __clk_get_name(clk), clk_get_rate(clk));
>> +		}
>> +		index++;
>> +	}
>> +
>> +	return 0;
>> +}
>> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
>> index dff0373..ea6d8bd 100644
>> --- a/drivers/clk/clk.c
>> +++ b/drivers/clk/clk.c
> 
> [snip]
> 
>> @@ -2620,7 +2621,15 @@ void __init of_clk_init(const struct of_device_id
>> *matches) list_for_each_entry_safe(clk_provider, next,
>>  					&clk_provider_list, node) {
>>  			if (force || parent_ready(clk_provider->np)) {
>> +
>>  				clk_provider->clk_init_cb(clk_provider->np);
>> +
>> +				/* Set any assigned clock parents and rates */
>> +				np = of_get_child_by_name(clk_provider->np,
>> +							  "assigned-clocks");
>> +				if (np)
>> +					of_clk_device_init(np);
> 
> Aren't you missing an of_node_put() here ?

Indeed, it's missing. Will fix that in next version, thanks for pointing out.

>>  				list_del(&clk_provider->node);
>>  				kfree(clk_provider);
>>  				is_init_done = true;

--
Regards,
Sylwester
