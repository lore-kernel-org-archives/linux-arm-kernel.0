From: marek.vasut@gmail.com (Marek Vasut)
Date: Wed, 16 Jun 2010 01:59:08 +0200
Subject: [PATCH] ixp4xx: add support for static flash partitions
In-Reply-To: <20100614161519.GB24877@riccoc20.at.omicron.at>
References: <20100531162434.GA4599@riccoc20.at.omicron.at>
	<1276420566.19028.184.camel@localhost>
	<20100614161519.GB24877@riccoc20.at.omicron.at>
Message-ID: <201006160159.08491.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne Po 14. ?ervna 2010 18:15:19 Richard Cochran napsal(a):
> On Sun, Jun 13, 2010 at 12:16:06PM +0300, Artem Bityutskiy wrote:
> > I could fix your patch up myself, but I do not know the code, so please,
> > re-send a patch against the latest mtd-2.6 tree.
> 
> Okay, here it is again, this time against today's master branch of
> git://git.infradead.org/mtd-2.6.git
> 
> Thanks,
> Richard
> 
> 
> This patch adds support for static flash partitioning from a platform
> device. Also, we clean up some weirdness where statements were separated
> by commas instead of semicolons. While we are at it, fix some minor bad
> white space, too.
> 
> Signed-off-by: Richard Cochran <richard.cochran@omicron.at>
> ---
>  drivers/mtd/maps/ixp4xx.c |   35 +++++++++++++++++++++++++++--------
>  1 files changed, 27 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mtd/maps/ixp4xx.c b/drivers/mtd/maps/ixp4xx.c
> index e0a5e04..1f9fde0 100644
> --- a/drivers/mtd/maps/ixp4xx.c
> +++ b/drivers/mtd/maps/ixp4xx.c
> @@ -118,7 +118,7 @@ static void ixp4xx_copy_from(struct map_info *map, void
> *to, *dest++ = BYTE1(data);
>  		src += 2;
>  		len -= 2;
> -        }
> +	}
> 
>  	if (len > 0)
>  		*dest++ = BYTE0(flash_read16(src));
> @@ -185,6 +185,8 @@ static int ixp4xx_flash_probe(struct platform_device
> *dev) {
>  	struct flash_platform_data *plat = dev->dev.platform_data;
>  	struct ixp4xx_flash_info *info;
> +	const char *part_type = NULL;
> +	int nr_parts = 0;
>  	int err = -1;
> 
>  	if (!plat)
> @@ -218,9 +220,9 @@ static int ixp4xx_flash_probe(struct platform_device
> *dev) */
>  	info->map.bankwidth = 2;
>  	info->map.name = dev_name(&dev->dev);
> -	info->map.read = ixp4xx_read16,
> -	info->map.write = ixp4xx_probe_write16,
> -	info->map.copy_from = ixp4xx_copy_from,
> +	info->map.read = ixp4xx_read16;
> +	info->map.write = ixp4xx_probe_write16;
> +	info->map.copy_from = ixp4xx_copy_from;
> 
>  	info->res = request_mem_region(dev->resource->start,
>  			resource_size(dev->resource),
> @@ -248,11 +250,28 @@ static int ixp4xx_flash_probe(struct platform_device
> *dev) info->mtd->owner = THIS_MODULE;
> 
>  	/* Use the fast version */
> -	info->map.write = ixp4xx_write16,
> +	info->map.write = ixp4xx_write16;
> +
> +#ifdef CONFIG_MTD_PARTITIONS
> +	nr_parts = parse_mtd_partitions(info->mtd, probes, &info->partitions,
> +					dev->resource->start);
> +#endif
> +	if (nr_parts > 0) {
> +		part_type = "dynamic";
> +	} else {
> +		info->partitions = plat->parts;
> +		nr_parts = plat->nr_parts;
> +		part_type = "static";
> +	}
> +	if (nr_parts == 0) {
> +		printk(KERN_NOTICE "IXP4xx flash: no partition info "
> +			"available, registering whole flash\n");
> +		err = add_mtd_device(info->mtd);
> +	} else {
> +		printk(KERN_NOTICE "IXP4xx flash: using %s partition "
> +			"definition\n", part_type);
> +		err = add_mtd_partitions(info->mtd, info->partitions, nr_parts);
> 
> -	err = parse_mtd_partitions(info->mtd, probes, &info->partitions,
> dev->resource->start); -	if (err > 0) {
> -		err = add_mtd_partitions(info->mtd, info->partitions, err);
>  		if(err)
>  			printk(KERN_ERR "Could not parse partitions\n");
>  	}


Maybe send the formating fixes in a separate patch. Thanks
