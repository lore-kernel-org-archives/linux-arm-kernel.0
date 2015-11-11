From: computersforpeace@gmail.com (Brian Norris)
Date: Wed, 11 Nov 2015 10:46:31 -0800
Subject: [PATCH 10/10] mtd: afs: add v2 partition parsing
In-Reply-To: <1444914533-27782-11-git-send-email-linus.walleij@linaro.org>
References: <1444914533-27782-1-git-send-email-linus.walleij@linaro.org>
 <1444914533-27782-11-git-send-email-linus.walleij@linaro.org>
Message-ID: <20151111184631.GD12143@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'll finish my review now...

On Thu, Oct 15, 2015 at 03:08:53PM +0200, Linus Walleij wrote:
> The AFS v2 partition type appear in later ARM reference designs
> such as RealView, Versatile Express and the 64bit Juno Development
> Platform.
> 
> The image informations is padded with a 32bit word (4 bytes) on
> the 32bit platforms and a 64bit word (8 bytes) on the 64bit
> platforms. The boot monitor source code gives at hand that this
> is because the first entry in the struct mapped over the image
> information is a "next" pointer for a linked list, filled in
> by firmware after reading in the info block, and always zero
> in the flash. We adjust padding by checking what padding gives
> the right checksum.
> 
> This was tested on:
> - Integrator/AP (v1 partitions)
> - RealView PB11MPCore (v2 32bit partitions)
> - Juno Development System (v2 64bit partitions)
> 
> All systems display the images in flash very nicely as separate
> partitions, e.g on Juno:
> 
> 4 afs partitions found on MTD device 8000000.flash
> Creating 4 MTD partitions on "8000000.flash":
> 0x000000040000-0x0000000c0000 : "fip"
> 0x000000ec0000-0x0000018c0000 : "Image"
> 0x000000f00000-0x000000f40000 : "juno"
> 0x000003ec0000-0x000003f00000 : "bl1"
> 
> Cc: Ryan Harkin <ryan.harkin@linaro.org>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/mtd/afs.c | 158 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 157 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/afs.c b/drivers/mtd/afs.c
> index 1ce6842c917c..e46b035bf4d2 100644
> --- a/drivers/mtd/afs.c
> +++ b/drivers/mtd/afs.c
> @@ -3,6 +3,7 @@
>      drivers/mtd/afs.c: ARM Flash Layout/Partitioning
>  
>      Copyright ? 2000 ARM Limited
> +    Copyright (C) 2015 Linus Walleij
>  
>     This program is free software; you can redistribute it and/or modify
>     it under the terms of the GNU General Public License as published by
> @@ -35,6 +36,8 @@
>  #include <linux/mtd/partitions.h>
>  
>  #define AFSV1_FOOTER_MAGIC 0xA0FFFF9F
> +#define AFSV2_FOOTER_MAGIC1 0x464C5348 /* "FLSH" */
> +#define AFSV2_FOOTER_MAGIC2 0x464F4F54 /* "FOOT" */
>  
>  struct footer_v1 {
>  	u32 image_info_base;	/* Address of first word of ImageFooter  */
> @@ -68,6 +71,22 @@ static u32 word_sum(void *words, int num)
>  	return sum;
>  }
>  
> +static u32 word_sum_v2(u32 *p, u32 num)

Nit: this uses a different prototype than word_sum(). That seems
unnecessarily inconsistent. Why is 'num' u32, when it could easily be
'int'?

> +{
> +	u32 sum = 0;
> +	int i;
> +
> +	for (i = 0; i < num; i++) {
> +		u32 val;
> +
> +		val = p[i];
> +		if (val > ~sum)
> +			sum++;
> +		sum += val;
> +	}
> +	return ~sum;
> +}
> +
>  static bool afs_is_v1(struct mtd_info *mtd, u_int off)
>  {
>  	/* The magic is 12 bytes from the end of the erase block */
> @@ -88,6 +107,27 @@ static bool afs_is_v1(struct mtd_info *mtd, u_int off)
>  	return (magic == AFSV1_FOOTER_MAGIC);
>  }
>  
> +static bool afs_is_v2(struct mtd_info *mtd, u_int off)
> +{
> +	/* The magic is the 8 last bytes of the erase block */
> +	u_int ptr = off + mtd->erasesize - 8;

This comment applies to the v1 refactoring as well: by trying to save
just a few bytes of read, you introduce more magic numbers. It'd be nice
if you didn't do that; either read the whole footer struct, or define
some kind of macros for this.

> +	u32 foot[2];
> +	size_t sz;
> +	int ret;
> +
> +	ret = mtd_read(mtd, ptr, 8, &sz, (u_char *)foot);
> +	if (ret < 0) {
> +		printk(KERN_ERR "AFS: mtd read failed at 0x%x: %d\n",
> +		       ptr, ret);
> +		return false;
> +	}
> +	if (ret >= 0 && sz != 8)
> +		return false;
> +
> +	return (foot[0] == AFSV2_FOOTER_MAGIC1 &&
> +		foot[1] == AFSV2_FOOTER_MAGIC2);

I think you have the same problem as I commented on in v1; you don't
check the checksum here -- causing minor potential memory allocation
waste -- and you do check it later, but you make it fatal -- making you
susceptible to complete failures on false positives; at least now you
have 2 magic numbers to falsely detect, making this less likely, but
still...

> +}
> +
>  static int afs_parse_v1_partition(struct mtd_info *mtd,
>  				  u_int off, struct mtd_partition *part)
>  {
> @@ -185,6 +225,113 @@ static int afs_parse_v1_partition(struct mtd_info *mtd,
>  	return 0;
>  }
>  
> +static int afs_parse_v2_partition(struct mtd_info *mtd,
> +				  u_int off, struct mtd_partition *part)
> +{
> +	u_int ptr;
> +	u32 footer[12];
> +	u32 imginfo[36];

Why don't you define structs for these? This is inconsistent with the v1
code, and it also means you have a lot more magic numbers scattered
around (you could fix this with more macro definitions, but I think a
struct would look nicer). I see that there are comments about 32- vs.
64-bit structs being slightly different, but I'm pretty sure that can be
handled. See comments below.

> +	char *name;
> +	u32 version;
> +	u32 entrypoint;
> +	u32 attributes;
> +	u32 region_count;
> +	u32 block_start;
> +	u32 block_end;
> +	u32 crc;
> +	size_t sz;
> +	int ret;
> +	int i;
> +	int pad = 0;
> +
> +	pr_debug("Parsing v2 partition @%08x-%08x\n",
> +		 off, off + mtd->erasesize);
> +
> +	/* First read the footer */
> +	ptr = off + mtd->erasesize - sizeof(footer);
> +	ret = mtd_read(mtd, ptr, sizeof(footer), &sz, (u_char *)footer);
> +	if ((ret < 0) || (ret >= 0 && sz != sizeof(footer))) {
> +		pr_err("AFS: mtd read failed at 0x%x: %d\n",
> +		       ptr, ret);
> +		return -EIO;
> +	}
> +	name = (char *) &footer[0];
> +	version = footer[9];
> +	ptr = off + mtd->erasesize - sizeof(footer) - footer[8];
> +
> +	pr_debug("found image \"%s\", version %08x, info @%08x\n",
> +		 name, version, ptr);
> +
> +	/* Then read the image information */
> +	ret = mtd_read(mtd, ptr, sizeof(imginfo), &sz, (u_char *)imginfo);
> +	if ((ret < 0) || (ret >= 0 && sz != sizeof(imginfo))) {
> +		pr_err("AFS: mtd read failed at 0x%x: %d\n",
> +		       ptr, ret);
> +		return -EIO;
> +	}
> +
> +	/* 32bit platforms have 4 bytes padding */
> +	crc = word_sum_v2(&imginfo[1], 34);

Magic number 34!

> +	if (!crc) {
> +		pr_debug("Padding 1 word (4 bytes)\n");
> +		pad = 1;
> +	} else {
> +		/* 64bit platforms have 8 bytes padding */

Wait, if this is really a 64- vs. 32-bit difference... can't you just
determine the padding ahead of time? AIUI, you shouldn't have to just
guess, and use the checksum to confirm...

One easy way (I think) is if you actually make the imginfo array into a
struct, you can make the first field a pointer, and the struct will be
sized appropriately on each kernel. e.g.:

	struct image_info_v2 {
		void *link;
		u32 regular_field_1;
		u32 etc;
		...
	};

or if you want to be somewhat clever to make the non-pointer part easily
checksummable and independent, you can embed one struct in another,
like:

	struct image_info_v2 {
		u32 regular_field_1;
		u32 etc;
		...
	};

	struct linked_image_info_v2 {
		void *link;
		struct image_info_v2 iis;
	};

Then you can do things like:

	struct linked_image_info_v2 linked;
	struct image_info_v2 *iis;

	...

	ret = mtd_read(mtd, ptr, sizeof(linked), &sz, (u_char *)&linked);
	...

	iis = &linked.img;

	crc = word_sum_v2(iis, sizeof(*iis) / sizeof(u32));
	...

> +		crc = word_sum_v2(&imginfo[2], 34);

Magic number 34 again! I won't point out the rest, but there are plenty
below.

> +		if (!crc) {
> +			pr_debug("Padding 2 words (8 bytes)\n");
> +			pad = 2;
> +		}
> +	}
> +	if (crc) {
> +		pr_err("AFS: bad checksum on v2 image info: %08x\n", crc);
> +		return -EINVAL;
> +	}
> +	entrypoint = imginfo[pad];

BTW, what's the endianness situation here? Is everything always in
native endianness? Or do we need to do le32_to_cpu() conversions? (Or is
this never tested in big endian?)

> +	attributes = imginfo[pad+1];
> +	region_count = imginfo[pad+2];
> +	block_start = imginfo[20];
> +	block_end = imginfo[21];
> +
> +	pr_debug("image entry=%08x, attr=%08x, regions=%08x, "
> +		 "bs=%08x, be=%08x\n",
> +		 entrypoint, attributes, region_count,
> +		 block_start, block_end);
> +
> +	for (i = 0; i < region_count; i++) {

No error-checking on region_count? You just trust that it won't make you
read off the end of your array/struct?

If you made imginfo[] into a struct, you might have an array field like:

	struct image_info_v2 {
		...
		u32 region_count;
		...
		struct {
			u32 region_load_addr;
			u32 region_size;
			u32 region_offset;
			u32 i_guess_theres_padding_here;
		} regions[how_big_is_this?];
	};

Then you can (before you get into this loop) check for:

	if (region_count > ARRAY_SIZE(iis->regions))
		bail out;

> +		u32 region_load_addr = imginfo[pad + 3 + i*4];
> +		u32 region_size = imginfo[pad + 4 + i*4];
> +		u32 region_offset = imginfo[pad + 5 + i*4];
> +		u32 region_start;
> +		u32 region_end;
> +
> +		pr_debug("  region %d: address: %08x, size: %08x, "
> +			 "offset: %08x\n",
> +			 i,
> +			 region_load_addr,
> +			 region_size,
> +			 region_offset);
> +
> +		region_start = off + region_offset;
> +		region_end = region_start + region_size;
> +		/* Align partition to end of erase block */
> +		region_end += (mtd->erasesize - 1);
> +		region_end &= ~(mtd->erasesize -1);
> +		pr_debug("   partition start = %08x, partition end = %08x\n",
> +			 region_start, region_end);
> +
> +		/* Create one partition per region */

Huh? How can you create one partition per region in this function?
You're only passed a single mtd_partition struct to fill out, but you
have potentially many regions here...

> +		part->name = kstrdup(name, GFP_KERNEL);

...so I guess you're just leaking all but the last region name, since
you keep reassigning part->name with a new string?

Brian

> +		if (!part->name)
> +			return -ENOMEM;
> +		part->offset = region_start;
> +		part->size = region_end - region_start;
> +		part->mask_flags = 0;
> +	}
> +
> +	return 0;
> +}
> +
>  static int parse_afs_partitions(struct mtd_info *mtd,
>  				struct mtd_partition **pparts,
>  				struct mtd_part_parser_data *data)
> @@ -200,6 +347,10 @@ static int parse_afs_partitions(struct mtd_info *mtd,
>  			sz += sizeof(struct mtd_partition);
>  			i += 1;
>  		}
> +		if (afs_is_v2(mtd, off)) {
> +			sz += sizeof(struct mtd_partition);
> +			i += 1;
> +		}
>  	}
>  
>  	if (!i)
> @@ -213,13 +364,18 @@ static int parse_afs_partitions(struct mtd_info *mtd,
>  	 * Identify the partitions
>  	 */
>  	for (i = off = 0; off < mtd->size; off += mtd->erasesize) {
> -
>  		if (afs_is_v1(mtd, off)) {
>  			ret = afs_parse_v1_partition(mtd, off, &parts[i]);
>  			if (ret)
>  				goto out_free_parts;
>  			i++;
>  		}
> +		if (afs_is_v2(mtd, off)) {
> +			ret = afs_parse_v2_partition(mtd, off, &parts[i]);
> +			if (ret)
> +				goto out_free_parts;
> +			i++;
> +		}
>  	}
>  
>  	*pparts = parts;
> -- 
> 2.4.3
> 
