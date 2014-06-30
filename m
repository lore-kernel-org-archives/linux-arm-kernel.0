From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 30 Jun 2014 18:32:17 +0100
Subject: [PATCHv5 1/3] ARM: mm: add support for HW coherent systems in
 PL310 cache
In-Reply-To: <1402585772-10405-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1402585772-10405-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1402585772-10405-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140630173217.GT28951@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 12, 2014 at 04:09:30PM +0100, Thomas Petazzoni wrote:
> --- a/arch/arm/mm/cache-l2x0.c
> +++ b/arch/arm/mm/cache-l2x0.c
> @@ -1069,6 +1069,33 @@ static const struct l2c_init_data of_l2c310_data __initconst = {
>  };
>  
>  /*
> + * This is a variant of the of_l2c310_data with .sync set to
> + * NULL. Outer sync operations are not needed when the system is I/O
> + * coherent, and potentially harmful in certain situations (PCIe/PL310
> + * deadlock on Armada 375/38x due to hardware I/O coherency). The
> + * other operations are kept because they are infrequent (therefore do
> + * not cause the deadlock in practice) and needed for secondary CPU
> + * boot and other power management activities.
> + */
> +static const struct l2c_init_data of_l2c310_coherent_data __initconst = {
> +	.type = "L2C-310 Coherent",
> +	.way_size_0 = SZ_8K,
> +	.num_lock = 8,
> +	.of_parse = l2c310_of_parse,
> +	.enable = l2c310_enable,
> +	.fixup = l2c310_fixup,
> +	.save  = l2c310_save,
> +	.outer_cache = {
> +		.inv_range   = l2c210_inv_range,
> +		.clean_range = l2c210_clean_range,
> +		.flush_range = l2c210_flush_range,
> +		.flush_all   = l2c210_flush_all,
> +		.disable     = l2c310_disable,
> +		.resume      = l2c310_resume,
> +	},
> +};
> +
> +/*
>   * Note that the end addresses passed to Linux primitives are
>   * noninclusive, while the hardware cache range operations use
>   * inclusive start and end addresses.
> @@ -1487,6 +1514,10 @@ int __init l2x0_of_init(u32 aux_val, u32 aux_mask)
>  
>  	data = of_match_node(l2x0_ids, np)->data;
>  
> +	if (of_device_is_compatible(np, "arm,pl310-cache") &&
> +	    of_property_read_bool(np, "arm,io-coherent"))
> +		data = &of_l2c310_coherent_data;

I don't have a better way without duplicating the l2c_init_data
structure since the fixup function does not take a device_node
pointer. If it did, you could have added the check in l2c310_fixup and
zeroed the sync pointer there.

Anyway, your approach works for me as well:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
