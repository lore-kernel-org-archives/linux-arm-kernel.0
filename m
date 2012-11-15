From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 15 Nov 2012 13:19:26 +0000
Subject: [PATCH 1/1] mtd: physmap_of: allow to specify the mtd name for
 retro compatiblity
In-Reply-To: <1352062641-31850-1-git-send-email-plagnioj@jcrosoft.com>
References: <1352062641-31850-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <20121115131926.47F853E0B12@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun,  4 Nov 2012 21:57:21 +0100, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com> wrote:
> linux,mtd-name allow to specify the mtd name for retro capability with
> physmap-flash drivers as boot loader pass the mtd partition via the old
> device name physmap-flash.

Ummm. I don't follow. Could you explain more about how this change will
be used?

Thanks,
g.

> 
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> ---
>  Documentation/devicetree/bindings/mtd/mtd-physmap.txt |    3 +++
>  drivers/mtd/maps/physmap_of.c                         |    5 ++++-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/mtd-physmap.txt b/Documentation/devicetree/bindings/mtd/mtd-physmap.txt
> index 94de19b..dab7847 100644
> --- a/Documentation/devicetree/bindings/mtd/mtd-physmap.txt
> +++ b/Documentation/devicetree/bindings/mtd/mtd-physmap.txt
> @@ -23,6 +23,9 @@ file systems on embedded devices.
>     unaligned accesses as implemented in the JFFS2 code via memcpy().
>     By defining "no-unaligned-direct-access", the flash will not be
>     exposed directly to the MTD users (e.g. JFFS2) any more.
> + - linux,mtd-name: allow to specify the mtd name for retro capability with
> +   physmap-flash drivers as boot loader pass the mtd partition via the old
> +   device name physmap-flash.
>  
>  For JEDEC compatible devices, the following additional properties
>  are defined:
> diff --git a/drivers/mtd/maps/physmap_of.c b/drivers/mtd/maps/physmap_of.c
> index 6f19aca..9a8db0c 100644
> --- a/drivers/mtd/maps/physmap_of.c
> +++ b/drivers/mtd/maps/physmap_of.c
> @@ -170,6 +170,7 @@ static int __devinit of_flash_probe(struct platform_device *dev)
>  	resource_size_t res_size;
>  	struct mtd_part_parser_data ppdata;
>  	bool map_indirect;
> +	const char *mtd_name;
>  
>  	match = of_match_device(of_flash_match, &dev->dev);
>  	if (!match)
> @@ -178,6 +179,8 @@ static int __devinit of_flash_probe(struct platform_device *dev)
>  
>  	reg_tuple_size = (of_n_addr_cells(dp) + of_n_size_cells(dp)) * sizeof(u32);
>  
> +	of_property_read_string(dp, "linux,mtd-name", &mtd_name);
> +
>  	/*
>  	 * Get number of "reg" tuples. Scan for MTD devices on area's
>  	 * described by each "reg" region. This makes it possible (including
> @@ -234,7 +237,7 @@ static int __devinit of_flash_probe(struct platform_device *dev)
>  			goto err_out;
>  		}
>  
> -		info->list[i].map.name = dev_name(&dev->dev);
> +		info->list[i].map.name = mtd_name ? mtd_name : dev_name(&dev->dev);
>  		info->list[i].map.phys = res.start;
>  		info->list[i].map.size = res_size;
>  		info->list[i].map.bankwidth = be32_to_cpup(width);
> -- 
> 1.7.10.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.
