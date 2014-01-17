From: robherring2@gmail.com (Rob Herring)
Date: Fri, 17 Jan 2014 08:29:07 -0600
Subject: [PATCH] of: add function to count number of u32 elements in a
 property
In-Reply-To: <3781679.27UF2dWtKL@phil>
References: <27256277.YJ687suYy5@phil> <1669323.jqjZBfkRx4@phil>
 <20140116124527.GD19578@e106331-lin.cambridge.arm.com>
 <3781679.27UF2dWtKL@phil>
Message-ID: <CAL_JsqJmQOCAGmb1cYZwRA74Zb1OJ8F6UaEc03i7OUgxW0kaNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 16, 2014 at 12:04 PM, Heiko St?bner <heiko@sntech.de> wrote:
> The need to know the number of array elements in a property is
> a common pattern. To prevent duplication of open-coded implementations
> add a helper function that also centralises strict sanity checking
> and DTB format details.
>
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
> Hi Mark,
> did you mean it like this? I've tested it with the sram-reserve change and
> it made the part of the determining the number elements a lot nicer :-)
>
>  drivers/of/base.c  |   32 ++++++++++++++++++++++++++++++++
>  include/linux/of.h |    8 ++++++++
>  2 files changed, 40 insertions(+)
>
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index f807d0e..0f40ea5 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -920,6 +920,38 @@ int of_property_read_u32_index(const struct device_node *np,
>  EXPORT_SYMBOL_GPL(of_property_read_u32_index);
>
>  /**
> + * of_property_count_u32_elems - Count the number of u32 values in a property
> + *
> + * @np:                device node from which the property value is to be read.
> + * @propname:  name of the property to be searched.
> + *
> + * Search for a property in a device node and count the number of u32 elements
> + * in it. Returns number of elements on sucess, -EINVAL if the property does
> + * not exist or its length does not match a multiple of u32 and -ENODATA if the
> + * property does not have a value.
> + */
> +int of_property_count_u32_elems(const struct device_node *np,
> +                               const char *propname)
> +{
> +       int elem_size = sizeof(u32);

This should be a parameter, so functions for different sized
properties can be a simple wrapper function.

> +       int len;
> +       struct property *prop = of_find_property(np, propname, &len);
> +
> +       if (!prop)
> +               return -EINVAL;
> +       if (!prop->value)
> +               return -ENODATA;
> +
> +       if (prop->length % elem_size != 0) {
> +               pr_err("size of %s is not a multiple of u32\n", propname);

The node name would be useful here too.

> +               return -EINVAL;
> +       }
> +
> +       return len / elem_size;
> +}
> +EXPORT_SYMBOL_GPL(of_property_count_u32_elems);
> +
> +/**
>   * of_property_read_u8_array - Find and read an array of u8 from a property.
>   *
>   * @np:                device node from which the property value is to be read.
> diff --git a/include/linux/of.h b/include/linux/of.h
> index 276c546..5794942 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -253,6 +253,8 @@ extern struct property *of_find_property(const struct device_node *np,
>  extern int of_property_read_u32_index(const struct device_node *np,
>                                        const char *propname,
>                                        u32 index, u32 *out_value);
> +extern int of_property_count_u32_elems(const struct device_node *np,
> +                                      const char *propname);
>  extern int of_property_read_u8_array(const struct device_node *np,
>                         const char *propname, u8 *out_values, size_t sz);
>  extern int of_property_read_u16_array(const struct device_node *np,
> @@ -432,6 +434,12 @@ static inline int of_property_read_u32_index(const struct device_node *np,
>         return -ENOSYS;
>  }
>
> +static inline int of_property_count_u32_elems(const struct device_node *np,
> +                       const char *propname)
> +{
> +       return -ENOSYS;
> +}
> +
>  static inline int of_property_read_u8_array(const struct device_node *np,
>                         const char *propname, u8 *out_values, size_t sz)
>  {
> --
> 1.7.10.4
>
>
