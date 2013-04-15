From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 15 Apr 2013 11:12:53 +0100
Subject: [PATCHv2 1/7] of: Add support for reading a u32 from a
 multi-value property.
In-Reply-To: <1364015633-18580-2-git-send-email-linux@prisktech.co.nz>
References: <1364015633-18580-1-git-send-email-linux@prisktech.co.nz>
 <1364015633-18580-2-git-send-email-linux@prisktech.co.nz>
Message-ID: <20130415101253.C22ED3E0AA8@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 23 Mar 2013 18:13:47 +1300, Tony Prisk <linux@prisktech.co.nz> wrote:
> This patch adds an of_property_read_u32_index() function to allow
> reading a single indexed u32 value from a property containing multiple
> u32 values.
> 
> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
> ---
> cc: Grant Likely <grant.likely@secretlab.ca>
> cc: Rob Herring <rob.herring@calxeda.com>
> cc: devicetree-discuss at lists.ozlabs.org
> 
> Hi Rob/Grant,
> After a review of my pinctrl driver, it was suggested that one of the helper
> functions be moved into the OF subsystem. Could you review and ack this patch
> if you're happy with it.

Hey Tony,

Instead of implementing this as a sparate function, this should be done
as an extension to the of_proprety_read_u32_array() interface, just like
how of_property_read_u32() is implemented. It will result in less code
that way.  So, rename of_property_read_u32_array() to __of_property_read_u32()
and add a 'index' argument to it. Then of_property_read_u32_index()
can be implemented as:

static inline int of_property_read_u32_index(const struct device_node *np,
					     const char *propname,
					     int index, u32 *out_value)
{
	return __of_property_read_u32(np, propname, index, 1, out_value);
}

And the new of_property_read_u32_array() becomes:

static inline int of_property_read_u32_array(const struct device_node *np,
					     const char *propname,
					     int sz, u32 *out_value)
{
	return __of_property_read_u32(np, propname, 0, sz, out_value);
}

g.

> Regards
> Tony P
> 
>  drivers/of/base.c  |   33 +++++++++++++++++++++++++++++++++
>  include/linux/of.h |    9 +++++++++
>  2 files changed, 42 insertions(+)
> 
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 321d3ef..7dc001e 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -746,6 +746,39 @@ struct device_node *of_find_node_by_phandle(phandle handle)
>  EXPORT_SYMBOL(of_find_node_by_phandle);
>  
>  /**
> + * of_property_read_u32_index - Find and read a u32 from a multi-value property.
> + *
> + * @np:		device node from which the property value is to be read.
> + * @propname:	name of the property to be searched.
> + * @index:	index of the u32 in the list of values
> + * @out_value:	pointer to return value, modified only if no error.
> + *
> + * Search for a property in a device node and read nth 32-bit value from
> + * it. Returns 0 on success, -EINVAL if the property does not exist,
> + * -ENODATA if property does not have a value, and -EOVERFLOW if the
> + * property data isn't large enough.
> + *
> + * The out_value is modified only if a valid u32 value can be decoded.
> + */
> +int of_property_read_u32_index(const struct device_node *np,
> +				       const char *propname,
> +				       u32 index, u32 *out_value)
> +{
> +	struct property *prop = of_find_property(np, propname, NULL);
> +
> +	if (!prop)
> +		return -EINVAL;
> +	if (!prop->value)
> +		return -ENODATA;
> +	if ((index * sizeof(*out_value)) > prop->length)
> +		return -EOVERFLOW;
> +
> +	*out_value = be32_to_cpup(((__be32 *)prop->value) + index);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(of_property_read_u32_index);
> +
> +/**
>   * of_property_read_u8_array - Find and read an array of u8 from a property.
>   *
>   * @np:		device node from which the property value is to be read.
> diff --git a/include/linux/of.h b/include/linux/of.h
> index a0f1292..c0747a4 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -235,6 +235,9 @@ extern struct device_node *of_find_node_with_property(
>  extern struct property *of_find_property(const struct device_node *np,
>  					 const char *name,
>  					 int *lenp);
> +extern int of_property_read_u32_index(const struct device_node *np,
> +				       const char *propname,
> +				       u32 index, u32 *out_value);
>  extern int of_property_read_u8_array(const struct device_node *np,
>  			const char *propname, u8 *out_values, size_t sz);
>  extern int of_property_read_u16_array(const struct device_node *np,
> @@ -394,6 +397,12 @@ static inline struct device_node *of_find_compatible_node(
>  	return NULL;
>  }
>  
> +static inline int of_property_read_u32_index(const struct device_node *np,
> +			const char *propname, u32 index, u32 *out_value)
> +{
> +	return -ENOSYS;
> +}
> +
>  static inline int of_property_read_u8_array(const struct device_node *np,
>  			const char *propname, u8 *out_values, size_t sz)
>  {
> -- 
> 1.7.9.5
> 

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.
