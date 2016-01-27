From: andre.przywara@arm.com (=?UTF-8?Q?Andr=c3=a9_Przywara?=)
Date: Wed, 27 Jan 2016 23:51:45 +0000
Subject: [PATCH 3/3] clk: Provide OF helper to mark clocks as CRITICAL
In-Reply-To: <1453127331-20616-4-git-send-email-lee.jones@linaro.org>
References: <1453127331-20616-1-git-send-email-lee.jones@linaro.org>
 <1453127331-20616-4-git-send-email-lee.jones@linaro.org>
Message-ID: <56A95811.8010200@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 18/01/16 14:28, Lee Jones wrote:
> This call matches clocks which have been marked as critical in DT
> and sets the appropriate flag.  These flags can then be used to
> mark the clock core flags appropriately prior to registration.

I like the idea of having a generic property very much. Also this solves
a problem I have in a very elegant way.

I guess you need to document this in the bindings documentation, I'd
suggest Documentation/devicetree/bindings/clock/clock-bindings.txt.

Also by doing so you should clarify it's exact meaning:
The singular form of "critical-clock" hints as either having a scalar
value only or even being a flag only.
But the code actually reads as it being _a list_ of indices of the
output clocks, so wouldn't "critical-clocks" (plural) be a better name?
This goes along the line of using the plural for the other standard
clock node properties as well.

So is this the intended usage?
some_clk {
	#clock-cells = <1>;
	clock-output-names = "just_led", "cpu";
	critical-clocks = <1>;
	....

to mark the "cpu" clock as critical?
Or matching the clock-indeces property values if that is used?

Also since it is a generic property, isn't there some way of parsing it
and setting the flag automatically for each and every clock provider?
Without driver authors having to explicitly call this function you
provide? The nature of being a generic clock flag makes me think this is
worthwhile.

Cheers,
Andre.

> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  include/linux/clk-provider.h | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index ffa0b2e..6f178b7 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -707,6 +707,23 @@ const char *of_clk_get_parent_name(struct device_node *np, int index);
>  
>  void of_clk_init(const struct of_device_id *matches);
>  
> +static inline int of_clk_mark_if_critical(struct device_node *np,
> +					  int index, unsigned long *flags)
> +{
> +	struct property *prop;
> +	const __be32 *cur;
> +	uint32_t idx;
> +
> +	if (!np || !flags)
> +		return -EINVAL;
> +
> +	of_property_for_each_u32(np, "critical-clock", prop, cur, idx)
> +		if (index == idx)
> +			*flags |= CLK_IS_CRITICAL;
> +
> +	return 0;
> +}
> +
>  #else /* !CONFIG_OF */
>  
>  static inline int of_clk_add_provider(struct device_node *np,
> @@ -742,6 +759,11 @@ static inline const char *of_clk_get_parent_name(struct device_node *np,
>  {
>  	return NULL;
>  }
> +static inline int of_clk_mark_if_critical(struct device_node *np, int index,
> +					  unsigned long *flags)
> +{
> +	return 0;
> +}
>  #define of_clk_init(matches) \
>  	{ while (0); }
>  #endif /* CONFIG_OF */
> 
