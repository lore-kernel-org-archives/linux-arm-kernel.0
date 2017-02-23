From: frowand.list@gmail.com (Frank Rowand)
Date: Thu, 23 Feb 2017 15:08:56 -0800
Subject: [RFC/PATCH] of: Mark property::value as const
In-Reply-To: <20170214025040.23955-1-stephen.boyd@linaro.org>
References: <20170214025040.23955-1-stephen.boyd@linaro.org>
Message-ID: <58AF6B88.6020709@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/13/17 18:50, Stephen Boyd wrote:
> The 'blob' we pass into populate_properties() is marked as const,
> but we cast that const away when we assign the result of
> fdt_getprop_by_offset() to pp->value. Let's mark value as const
> instead, so that code can't mistakenly write to the value of the
> property that we've so far advertised as const.

Instead of struct property field value being a pointer into the
FDT, I would rather copy the data to newly allocated memory and
have value be a pointer to that memory.  This is required if we
want to make /sys/firmware/fdt optional, which would allow us to
free the memory containing the initial boot FDT.

I also do not want overlay live subtrees to have any pointers
into the FDT that was used to populate the overlay, so copying
the data solves that problem also.


> Unfortunately, this exposes a problem with the fdt resolver code,
> where we overwrite the value member of properties of phandles to
> update them with their final value. Add a comment for now to
> indicate where we're potentially writing over const data.

Yes, the resolver code needs to adjust phandle values.

I think I can get rid of the resolver modifying the various phandle
values, and instead just modify the phandle value in struct
device_node.  At the same time, I think I can also remove all
instances of the phandle properties ('linux,phandle', 'ibm,phandle',
'phandle') in the live tree.  These properties should not be
accessed directly by any code outside of the device tree framework
since the phandle is located in the struct device_node.  A quick
grep does not show any such accesses of the phandle properties,
but I want to look more closely.


> 
> You can see the problem here by loading an overlay dtb into
> the kernel via the request firmware helper method (not direct
> loading) and then passing that tree to the resolver on an arm64
> device. In this case, the firmware data is vmapped with KERNEL_PAGE_RO
> and the code crashes when attempting to write to the blob to update
> the phandle properties.
> 
> Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
> ---
> 
> I was thinking perhaps it would work to store another __be32 variant
> of the phandle in each device node, but then we still have a problem

That would complicate the overlay code.  Once adjustments are done to
the phandle property value, the overlay code does not need to special
case phandle - phandle is just another property.  I am hoping I can
instead modify the resolver code as I described above.


> with properties that have phandles inside them at some offset that we
> need to update. I guess the only real solution is to deep copy the
> property in that case and then save around some info to free the
> duplicated property later on?
> 
>  drivers/of/base.c     |  2 +-
>  drivers/of/fdt.c      | 12 ++++++------
>  drivers/of/resolver.c |  3 +++
>  include/linux/of.h    |  2 +-
>  4 files changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index fb6bb855714e..8e5f29b814c9 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -1156,7 +1156,7 @@ EXPORT_SYMBOL_GPL(of_property_count_elems_of_size);
>   * property data is too small or too large.
>   *
>   */
> -static void *of_find_property_value_of_size(const struct device_node *np,
> +static const void *of_find_property_value_of_size(const struct device_node *np,
>  			const char *propname, u32 min, u32 max, size_t *len)
>  {
>  	struct property *prop = of_find_property(np, propname, NULL);
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index c9b5cac03b36..0635ef5dabf3 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -222,7 +222,7 @@ static void populate_properties(const void *blob,
>  
>  		pp->name   = (char *)pname;
>  		pp->length = sz;
> -		pp->value  = (__be32 *)val;
> +		pp->value  = val;
>  		*pprev     = pp;
>  		pprev      = &pp->next;
>  	}
> @@ -232,6 +232,7 @@ static void populate_properties(const void *blob,
>  	 */
>  	if (!has_name) {
>  		const char *p = nodename, *ps = p, *pa = NULL;
> +		char *b;
>  		int len;
>  
>  		while (*p) {
> @@ -250,13 +251,12 @@ static void populate_properties(const void *blob,
>  		if (!dryrun) {
>  			pp->name   = "name";
>  			pp->length = len;
> -			pp->value  = pp + 1;
> +			pp->value  = b = (char *)(pp + 1);

I would prefer not to hide an assignment in the middle of a statement.


>  			*pprev     = pp;
>  			pprev      = &pp->next;
> -			memcpy(pp->value, ps, len - 1);
> -			((char *)pp->value)[len - 1] = 0;
> -			pr_debug("fixed up name for %s -> %s\n",
> -				 nodename, (char *)pp->value);
> +			memcpy(b, ps, len - 1);
> +			b[len - 1] = 0;
> +			pr_debug("fixed up name for %s -> %s\n", nodename, b);

Nit: I would prefer 'value' to 'b'.  'value' would make the pr_debug longer
that 80 characters, which could be resolved by removing 'for ':

                        pr_debug("fixed up name %s -> %s\n", nodename, value);

>  		}
>  	}
>  
> diff --git a/drivers/of/resolver.c b/drivers/of/resolver.c
> index 8bf12e904fd2..6d88f8100318 100644
> --- a/drivers/of/resolver.c
> +++ b/drivers/of/resolver.c
> @@ -93,6 +93,7 @@ static void adjust_overlay_phandles(struct device_node *overlay,
>  		if (phandle == OF_PHANDLE_ILLEGAL)
>  			continue;
>  
> +		/* This is bad because we cast away const */
>  		*(uint32_t *)prop->value = cpu_to_be32(overlay->phandle);
>  	}
>  
> @@ -154,6 +155,7 @@ static int update_usages_of_a_phandle_reference(struct device_node *overlay,
>  			goto err_fail;
>  		}
>  
> +		/* This is bad because we cast away const */
>  		*(__be32 *)(prop->value + offset) = cpu_to_be32(phandle);
>  	}
>  
> @@ -222,6 +224,7 @@ static int adjust_local_phandle_references(struct device_node *local_fixups,
>  
>  			phandle = be32_to_cpu(*(__be32 *)(prop->value + off));
>  			phandle += phandle_delta;
> +			/* This is bad because we cast away const */
>  			*(__be32 *)(prop->value + off) = cpu_to_be32(phandle);
>  		}
>  	}
> diff --git a/include/linux/of.h b/include/linux/of.h
> index f22d4a83ca07..b0253886ef46 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -35,7 +35,7 @@ typedef u32 ihandle;
>  struct property {
>  	char	*name;
>  	int	length;
> -	void	*value;
> +	const void *value;

What is the result when all of the files that touch value are compiled?
Any warnings or errors?


>  	struct property *next;
>  	unsigned long _flags;
>  	unsigned int unique_id;
> 

-Frank
