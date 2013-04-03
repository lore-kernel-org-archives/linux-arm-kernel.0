From: robherring2@gmail.com (Rob Herring)
Date: Wed, 03 Apr 2013 13:52:48 -0500
Subject: [PATCHv5 2/7] of: Remove duplicated code for validating property
 and value
In-Reply-To: <1364970291-17721-3-git-send-email-linux@prisktech.co.nz>
References: <1364970291-17721-1-git-send-email-linux@prisktech.co.nz>
 <1364970291-17721-3-git-send-email-linux@prisktech.co.nz>
Message-ID: <515C7A80.1040301@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/03/2013 01:24 AM, Tony Prisk wrote:
> Several functions in of/base.c have the same code duplicated for
> finding and validating a property and value.
> 
> struct property *prop = of_find_property(np, propname, NULL);
> if (!prop)
> 	return -EINVAL;
> if (!prop->value)
> 	return -ENODATA;
> if (<some length> > prop->length)
> 	return -EOVERFLOW;
> 
> This patch adds of_find_property_value_of_size() which performs the
> equivalent of the above code and removes the instances where it was
> duplicated in several functions.
> 
> Reported-by: Rob Herring <robherring2@gmail.com>
> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
> ---

I'd prefer the first 2 patches in reverse order, but its not a big deal.
So for both:

Acked-by: Rob Herring <rob.herring@calxeda.com>

>  drivers/of/base.c |   94 +++++++++++++++++++++++++++++------------------------
>  1 file changed, 51 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index f6c89ed..c6443de 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -746,6 +746,34 @@ struct device_node *of_find_node_by_phandle(phandle handle)
>  EXPORT_SYMBOL(of_find_node_by_phandle);
>  
>  /**
> + * of_find_property_value_of_size
> + *
> + * @np:		device node from which the property value is to be read.
> + * @propname:	name of the property to be searched.
> + * @len:	requested length of property value
> + *
> + * Search for a property in a device node and valid the requested size.
> + * Returns the property value on success, -EINVAL if the property does not
> + *  exist, -ENODATA if property does not have a value, and -EOVERFLOW if the
> + * property data isn't large enough.
> + *
> + */
> +static void *of_find_property_value_of_size(const struct device_node *np,
> +			const char *propname, u32 len)
> +{
> +	struct property *prop = of_find_property(np, propname, NULL);
> +
> +	if (!prop)
> +		return ERR_PTR(-EINVAL);
> +	if (!prop->value)
> +		return ERR_PTR(-ENODATA);
> +	if (len > prop->length)
> +		return ERR_PTR(-EOVERFLOW);
> +
> +	return prop->value;
> +}
> +
> +/**
>   * of_property_read_u32_index - Find and read a u32 from a multi-value property.
>   *
>   * @np:		device node from which the property value is to be read.
> @@ -764,16 +792,13 @@ int of_property_read_u32_index(const struct device_node *np,
>  				       const char *propname,
>  				       u32 index, u32 *out_value)
>  {
> -	struct property *prop = of_find_property(np, propname, NULL);
> +	const u32 *val = of_find_property_value_of_size(np, propname,
> +					((index + 1) * sizeof(*out_value)));
>  
> -	if (!prop)
> -		return -EINVAL;
> -	if (!prop->value)
> -		return -ENODATA;
> -	if (((index + 1) * sizeof(*out_value)) > prop->length)
> -		return -EOVERFLOW;
> +	if (IS_ERR(val))
> +		return PTR_ERR(val);
>  
> -	*out_value = be32_to_cpup(((__be32 *)prop->value) + index);
> +	*out_value = be32_to_cpup(((__be32 *)val) + index);
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(of_property_read_u32_index);
> @@ -799,17 +824,12 @@ EXPORT_SYMBOL_GPL(of_property_read_u32_index);
>  int of_property_read_u8_array(const struct device_node *np,
>  			const char *propname, u8 *out_values, size_t sz)
>  {
> -	struct property *prop = of_find_property(np, propname, NULL);
> -	const u8 *val;
> +	const u8 *val = of_find_property_value_of_size(np, propname,
> +						(sz * sizeof(*out_values)));
>  
> -	if (!prop)
> -		return -EINVAL;
> -	if (!prop->value)
> -		return -ENODATA;
> -	if ((sz * sizeof(*out_values)) > prop->length)
> -		return -EOVERFLOW;
> +	if (IS_ERR(val))
> +		return PTR_ERR(val);
>  
> -	val = prop->value;
>  	while (sz--)
>  		*out_values++ = *val++;
>  	return 0;
> @@ -837,17 +857,12 @@ EXPORT_SYMBOL_GPL(of_property_read_u8_array);
>  int of_property_read_u16_array(const struct device_node *np,
>  			const char *propname, u16 *out_values, size_t sz)
>  {
> -	struct property *prop = of_find_property(np, propname, NULL);
> -	const __be16 *val;
> +	const __be16 *val = of_find_property_value_of_size(np, propname,
> +						(sz * sizeof(*out_values)));
>  
> -	if (!prop)
> -		return -EINVAL;
> -	if (!prop->value)
> -		return -ENODATA;
> -	if ((sz * sizeof(*out_values)) > prop->length)
> -		return -EOVERFLOW;
> +	if (IS_ERR(val))
> +		return PTR_ERR(val);
>  
> -	val = prop->value;
>  	while (sz--)
>  		*out_values++ = be16_to_cpup(val++);
>  	return 0;
> @@ -874,17 +889,12 @@ int of_property_read_u32_array(const struct device_node *np,
>  			       const char *propname, u32 *out_values,
>  			       size_t sz)
>  {
> -	struct property *prop = of_find_property(np, propname, NULL);
> -	const __be32 *val;
> +	const __be32 *val = of_find_property_value_of_size(np, propname,
> +						(sz * sizeof(*out_values)));
>  
> -	if (!prop)
> -		return -EINVAL;
> -	if (!prop->value)
> -		return -ENODATA;
> -	if ((sz * sizeof(*out_values)) > prop->length)
> -		return -EOVERFLOW;
> +	if (IS_ERR(val))
> +		return PTR_ERR(val);
>  
> -	val = prop->value;
>  	while (sz--)
>  		*out_values++ = be32_to_cpup(val++);
>  	return 0;
> @@ -907,15 +917,13 @@ EXPORT_SYMBOL_GPL(of_property_read_u32_array);
>  int of_property_read_u64(const struct device_node *np, const char *propname,
>  			 u64 *out_value)
>  {
> -	struct property *prop = of_find_property(np, propname, NULL);
> +	const __be32 *val = of_find_property_value_of_size(np, propname,
> +						sizeof(*out_value));
>  
> -	if (!prop)
> -		return -EINVAL;
> -	if (!prop->value)
> -		return -ENODATA;
> -	if (sizeof(*out_value) > prop->length)
> -		return -EOVERFLOW;
> -	*out_value = of_read_number(prop->value, 2);
> +	if (IS_ERR(val))
> +		return PTR_ERR(val);
> +
> +	*out_value = of_read_number(val, 2);
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(of_property_read_u64);
> 
