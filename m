From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 17 Jan 2014 16:53:34 +0000
Subject: [PATCH v2] of: add functions to count number of elements in a
 property
In-Reply-To: <1434798.oSb68sYmYT@phil>
References: <27256277.YJ687suYy5@phil> <3781679.27UF2dWtKL@phil>
 <20140117144456.GG19578@e106331-lin.cambridge.arm.com>
 <1434798.oSb68sYmYT@phil>
Message-ID: <20140117165333.GH19578@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 17, 2014 at 03:44:14PM +0000, Heiko St?bner wrote:
> The need to know the number of array elements in a property is
> a common pattern. To prevent duplication of open-coded implementations
> add a helper static function that also centralises strict sanity
> checking and DTB format details, as well as a set of wrapper functions
> for u8, u16, u32 and u64.
> 
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
> changes since v1:
> address comments from Rob Herring and Mark Rutland:
> - provide a helper and a set of wrappers for u8-u64
> - get rid of extra len variable, prop->length is enough
> - include node name in error message
> 
>  drivers/of/base.c  |   98 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/of.h |   32 +++++++++++++++++
>  2 files changed, 130 insertions(+)
> 
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index f807d0e..b6e6d4a 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -862,6 +862,104 @@ struct device_node *of_find_node_by_phandle(phandle handle)
>  EXPORT_SYMBOL(of_find_node_by_phandle);
>  
>  /**
> + * of_count_property_elems_of_size - Count the number of elements in a property
> + *
> + * @np:		device node from which the property value is to be read.
> + * @propname:	name of the property to be searched.
> + * @elem_size:	size of the individual element
> + */
> +static int of_count_property_elems_of_size(const struct device_node *np,
> +				const char *propname, int elem_size)

As a minor nit, it would be nicer to have 'count' and 'property' switch
places in the name (i.e. call this of_property_count_elems_of_size).
That way it's concistent with the naming of the wrappers.

> +{
> +	struct property *prop = of_find_property(np, propname, NULL);
> +
> +	if (!prop)
> +		return -EINVAL;
> +	if (!prop->value)
> +		return -ENODATA;
> +
> +	if (prop->length % elem_size != 0) {
> +		pr_err("size of %s in node %s is not a multiple of %d\n",
> +		       propname, np->name, elem_size);

It would be nice to use np->full_name so you get the absolute path of
the node -- it makes finding them easier later.

Otherwise, the patch looks good to me, thanks for implementing it!

With those changes:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Cheers,
Mark.
