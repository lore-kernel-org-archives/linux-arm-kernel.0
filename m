From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Sat, 6 Oct 2018 13:08:58 +0530
Subject: [PATCH 4/4] firmware: ti_sci: Add helper apis to mange resources
In-Reply-To: <20181005201453.g3p2jhpigcvijpce@kahuna>
References: <20181005143006.18284-1-lokeshvutla@ti.com>
 <20181005143006.18284-5-lokeshvutla@ti.com>
 <20181005201453.g3p2jhpigcvijpce@kahuna>
Message-ID: <176f77cf-d295-0f37-ea9d-26f76f6d79c7@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/6/2018 1:44 AM, Nishanth Menon wrote:
> On 14:30-20181005, Lokesh Vutla wrote:
>> +struct ti_sci_resource *
>> +devm_ti_sci_get_of_resource(const struct ti_sci_handle *handle,
>> +			    struct device *dev, char *of_prop)
>> +{
>> +	u32 resource_type, resource_subtype;
>> +	struct ti_sci_resource *res;
>> +	int sets, i, ret;
>> +
>> +	res = devm_kzalloc(dev, sizeof(*res), GFP_KERNEL);
>> +	if (!res)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	sets = of_property_count_elems_of_size(dev_of_node(dev), of_prop,
>> +					       sizeof(u32));
>> +	if (sets < 0) {
>> +		dev_err(dev, "%s resource type ids not available\n", of_prop);
>> +		return ERR_PTR(sets);
>> +	}
>> +
>> +	res->sets = sets / 2;
>> +
>> +	res->desc = devm_kcalloc(dev, res->sets, sizeof(*res->desc),
>> +				 GFP_KERNEL);
>> +	if (!res->desc)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	for (i = 0; i < res->sets; i++) {
>> +		ret = of_property_read_u32_index(dev_of_node(dev), of_prop,
>> +						 i * 2, &resource_type);
>> +		if (ret)
>> +			return ERR_PTR(-EINVAL);
>> +
>> +		ret = of_property_read_u32_index(dev_of_node(dev), of_prop,
>> +						 (i * 2) + 1,
>> +						 &resource_subtype);
>> +		if (ret)
>> +			return ERR_PTR(-EINVAL);
>> +
>> +		ret = handle->ops.rm_core_ops.get_range(handle, resource_type,
>> +							resource_subtype,
>> +							&res->desc[i].start,
>> +							&res->desc[i].num);
>> +		if (ret) {
>> +			dev_err(dev, "type %d subtype %d not allocated for host %d\n",
>> +				resource_type, resource_subtype,
>> +				handle_to_ti_sci_info(handle)->host_id);
>> +			return ERR_PTR(ret);
>> +		}
>> +
>> +		dev_dbg(dev, "res type = %d, subtype = %d, start = %d, num = %d\n",
>> +			resource_type, resource_subtype, res->desc[i].start,
>> +			res->desc[i].num);
> 
> NAK. Where is the binding for this? What is this decoding? Please don't
> decode binding without having an official binding.

This is a helper library for the clients to get resource range from DT
and is not compulsory for clients to use this library to managing these
resources. So in my understanding DT bindings should go into the client
DT doc as posted here[1].  If you really insist I can add these details
in ti,sci documentation but not sure if we are doing the same for all
other helper apis.

[1] https://patchwork.kernel.org/patch/10629215/

Thanks and regards,
Lokesh
