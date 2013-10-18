From: zhangfei.gao@linaro.org (zhangfei)
Date: Fri, 18 Oct 2013 21:59:14 +0800
Subject: [RFC PATCH] of/base: add helper of_property_read_u32_array_index
In-Reply-To: <1382103943-17812-1-git-send-email-zhangfei.gao@linaro.org>
References: <1382103943-17812-1-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <52613EB2.7080206@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Here is one question, is there any existing API could get nth array from 
arrays table?

For example:
		tune-table =
                         <26000000 1 1 3 3 13000000>,
                         <360000000 6 3 3 1 50000000>,
                         <0 0 0 0 0 0>,
                         <0 0 0 0 0 0>,
                         <26000000 1 1 3 3 13000000>,
                         <360000000 6 3 3 1 50000000>,
                         <0 0 0 0 0 0>,
                         <720000000 6 4 8 4 100000000>;

Can we get nth array with index?
Like:
u32 table[6];
ret = of_property_read_u32_array_index(np, "tune-table",
                                         table, 6, index);

Thanks

On 10/18/2013 09:45 PM, Zhangfei Gao wrote:
> of_property_read_u32_array_index is added for read nth array values from u32 arrays
>
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> ---
>   drivers/of/base.c  |   35 +++++++++++++++++++++++++++++++++++
>   include/linux/of.h |   12 ++++++++++++
>   2 files changed, 47 insertions(+)
>
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 865d3f6..5c5f877 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -1002,6 +1002,41 @@ int of_property_read_u32_array(const struct device_node *np,
>   EXPORT_SYMBOL_GPL(of_property_read_u32_array);
>
>   /**
> + * of_property_read_u32_array_index - Find and read an array of 32 bit integers
> + * pointed by index from a property.
> + *
> + * @np:		device node from which the property value is to be read.
> + * @propname:	name of the property to be searched.
> + * @out_values:	pointer to return value, modified only if return value is 0.
> + * @sz:		number of array elements to read
> + * @index:	index of the u32 array in the list of values
> + *
> + * Search for a property in a device node and read nth 32-bit value(s) from
> + * it. Returns 0 on success, -EINVAL if the property does not exist,
> + * -ENODATA if property does not have a value, and -EOVERFLOW if the
> + * property data isn't large enough.
> + *
> + * The out_values is modified only if a valid u32 value can be decoded.
> + */
> +int of_property_read_u32_array_index(const struct device_node *np,
> +			       const char *propname, u32 *out_values,
> +			       size_t sz, u32 index)
> +{
> +	const __be32 *val = of_find_property_value_of_size(np, propname,
> +				(index + 1) * (sz * sizeof(*out_values)));
> +
> +	if (IS_ERR(val))
> +		return PTR_ERR(val);
> +
> +	while (index--)
> +		val += sz;
> +	while (sz--)
> +		*out_values++ = be32_to_cpup(val++);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(of_property_read_u32_array_index);
> +
> +/**
>    * of_property_read_u64 - Find and read a 64 bit integer from a property
>    * @np:		device node from which the property value is to be read.
>    * @propname:	name of the property to be searched.
> diff --git a/include/linux/of.h b/include/linux/of.h
> index f95aee3..7103983 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -246,6 +246,10 @@ extern int of_property_read_u32_array(const struct device_node *np,
>   				      const char *propname,
>   				      u32 *out_values,
>   				      size_t sz);
> +extern int of_property_read_u32_array_index(const struct device_node *np,
> +				      const char *propname,
> +				      u32 *out_values,
> +				      size_t sz, u32 index);
>   extern int of_property_read_u64(const struct device_node *np,
>   				const char *propname, u64 *out_value);
>
> @@ -427,6 +431,14 @@ static inline int of_property_read_u32_array(const struct device_node *np,
>   	return -ENOSYS;
>   }
>
> +static inline int of_property_read_u32_array_index(const struct device_node *np,
> +				      const char *propname,
> +				      u32 *out_values,
> +				      size_t sz, u32 index)
> +{
> +	return -ENOSYS;
> +}
> +
>   static inline int of_property_read_string(struct device_node *np,
>   					  const char *propname,
>   					  const char **out_string)
>
