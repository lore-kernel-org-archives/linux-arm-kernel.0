From: nm@ti.com (Nishanth Menon)
Date: Fri, 5 Oct 2018 15:14:53 -0500
Subject: [PATCH 4/4] firmware: ti_sci: Add helper apis to mange resources
In-Reply-To: <20181005143006.18284-5-lokeshvutla@ti.com>
References: <20181005143006.18284-1-lokeshvutla@ti.com>
 <20181005143006.18284-5-lokeshvutla@ti.com>
Message-ID: <20181005201453.g3p2jhpigcvijpce@kahuna>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14:30-20181005, Lokesh Vutla wrote:
> +struct ti_sci_resource *
> +devm_ti_sci_get_of_resource(const struct ti_sci_handle *handle,
> +			    struct device *dev, char *of_prop)
> +{
> +	u32 resource_type, resource_subtype;
> +	struct ti_sci_resource *res;
> +	int sets, i, ret;
> +
> +	res = devm_kzalloc(dev, sizeof(*res), GFP_KERNEL);
> +	if (!res)
> +		return ERR_PTR(-ENOMEM);
> +
> +	sets = of_property_count_elems_of_size(dev_of_node(dev), of_prop,
> +					       sizeof(u32));
> +	if (sets < 0) {
> +		dev_err(dev, "%s resource type ids not available\n", of_prop);
> +		return ERR_PTR(sets);
> +	}
> +
> +	res->sets = sets / 2;
> +
> +	res->desc = devm_kcalloc(dev, res->sets, sizeof(*res->desc),
> +				 GFP_KERNEL);
> +	if (!res->desc)
> +		return ERR_PTR(-ENOMEM);
> +
> +	for (i = 0; i < res->sets; i++) {
> +		ret = of_property_read_u32_index(dev_of_node(dev), of_prop,
> +						 i * 2, &resource_type);
> +		if (ret)
> +			return ERR_PTR(-EINVAL);
> +
> +		ret = of_property_read_u32_index(dev_of_node(dev), of_prop,
> +						 (i * 2) + 1,
> +						 &resource_subtype);
> +		if (ret)
> +			return ERR_PTR(-EINVAL);
> +
> +		ret = handle->ops.rm_core_ops.get_range(handle, resource_type,
> +							resource_subtype,
> +							&res->desc[i].start,
> +							&res->desc[i].num);
> +		if (ret) {
> +			dev_err(dev, "type %d subtype %d not allocated for host %d\n",
> +				resource_type, resource_subtype,
> +				handle_to_ti_sci_info(handle)->host_id);
> +			return ERR_PTR(ret);
> +		}
> +
> +		dev_dbg(dev, "res type = %d, subtype = %d, start = %d, num = %d\n",
> +			resource_type, resource_subtype, res->desc[i].start,
> +			res->desc[i].num);

NAK. Where is the binding for this? What is this decoding? Please don't
decode binding without having an official binding.

-- 
Regards,
Nishanth Menon
