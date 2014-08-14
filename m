From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Thu, 14 Aug 2014 13:15:34 +0100
Subject: [PATCH 3/5] phy: miphy28lp: Provide support for the MiPHY28lp
 Generic PHY
In-Reply-To: <1407944075-8093-4-git-send-email-gabriel.fernandez@linaro.org>
References: <1407944075-8093-1-git-send-email-gabriel.fernandez@linaro.org>
 <1407944075-8093-4-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <53ECA866.2080306@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gabi,

I did not review the full patchset but this function caught my attention..

> +};
> +
> +static int miphy28lp_get_ressource_byname(struct device_node *child,
> +					  char *name, struct resource *res)
> +{

s/miphy28lp_get_ressource_byname/miphy28lp_get_resource_byname

> +	int index, ret = 0, count = 0;
> +	int reg_tuple_size;
> +	const __be32 *p;
> +
> +	reg_tuple_size = (of_n_addr_cells(child) +
> +			of_n_size_cells(child)) * sizeof(u32);
> +
> +	p = of_get_property(child, "reg", &count);
> +	if (count % reg_tuple_size != 0)
> +		ret = -EINVAL;
> +
> +	count /= reg_tuple_size;
> +
> +	for (index = 0; index < count; index++) {
> +		const char *rname = NULL;
> +
> +		ret = of_property_read_string_index(child, "reg-names",
> +						    index, &rname);
> +		if (!strcmp(name, rname))
> +			return of_address_to_resource(child, index, res);
> +	}
> +
> +	return 1;
This function looks bit complicated, can't we just use:

	index = of_property_match_string(np, "reg-names", rname);
	if (index < 0)
		return -ENODEV;

	return of_address_to_resource(child, index, res);



--srini
