From: computersforpeace@gmail.com (Brian Norris)
Date: Tue, 10 Nov 2015 18:28:09 -0800
Subject: [PATCH 05/10] mtd: afs: simplify partition parsing
In-Reply-To: <1444914533-27782-6-git-send-email-linus.walleij@linaro.org>
References: <1444914533-27782-1-git-send-email-linus.walleij@linaro.org>
 <1444914533-27782-6-git-send-email-linus.walleij@linaro.org>
Message-ID: <20151111022809.GW12143@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Thu, Oct 15, 2015 at 03:08:48PM +0200, Linus Walleij wrote:
> This simplifies the AFS partition parsing to make the code
> more straight-forward and readable.
> 
> Before this patch the code tried to calculate the memory required
> to hold the partition info by adding up the sizes of the strings
> of the names and adding that to a single memory allocation,
> indexing the name pointers in front of the struct mtd_partition
> allocations so all allocated data was in one chunk.
> 
> This is overzealous. Instead use kstrdup and bail out,
> kfree():ing the memory used for MTD partitions and names alike
> on the errorpath.
> 
> In the process rename the index variable from idx to i.
> 
> Cc: Ryan Harkin <ryan.harkin@linaro.org>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/mtd/afs.c | 67 ++++++++++++++++++++++++++-----------------------------
>  1 file changed, 32 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/mtd/afs.c b/drivers/mtd/afs.c
> index a1eea50ce180..9e6089615f16 100644
> --- a/drivers/mtd/afs.c
> +++ b/drivers/mtd/afs.c
> @@ -166,9 +166,9 @@ static int parse_afs_partitions(struct mtd_info *mtd,
>  				struct mtd_part_parser_data *data)
>  {
>  	struct mtd_partition *parts;
> -	u_int mask, off, idx, sz;
> +	u_int mask, off, sz;
>  	int ret = 0;
> -	char *str;
> +	int i;
>  
>  	/*
>  	 * This is the address mask; we use this to mask off out of
> @@ -181,78 +181,75 @@ static int parse_afs_partitions(struct mtd_info *mtd,
>  	 * partition information.  We include in this the size of
>  	 * the strings.
>  	 */

Nit: you rewrite this comment in the next patch, when it really should
be rewritten here, since this is where you change the allocation
behavior. I wouldn't worry about this, except that I have other comments
below that I think you'll need to address.

> -	for (idx = off = sz = 0; off < mtd->size; off += mtd->erasesize) {
> -		struct image_info_v1 iis;
> +	for (i = off = sz = 0; off < mtd->size; off += mtd->erasesize) {
>  		u_int iis_ptr, img_ptr;
>  
>  		ret = afs_read_footer_v1(mtd, &img_ptr, &iis_ptr, off, mask);
>  		if (ret < 0)
> -			break;
> +			return ret;
>  		if (ret) {
> -			ret = afs_read_iis_v1(mtd, &iis, iis_ptr);
> -			if (ret < 0)
> -				break;
> -			if (ret == 0)
> -				continue;
> -
>  			sz += sizeof(struct mtd_partition);
> -			sz += strlen(iis.name) + 1;
> -			idx += 1;
> +			i += 1;
>  		}
>  	}
>  
> -	if (!sz)
> -		return ret;
> +	if (!i)
> +		return 0;
>  
>  	parts = kzalloc(sz, GFP_KERNEL);
>  	if (!parts)
>  		return -ENOMEM;
>  
> -	str = (char *)(parts + idx);
> -
>  	/*
>  	 * Identify the partitions
>  	 */
> -	for (idx = off = 0; off < mtd->size; off += mtd->erasesize) {
> +	for (i = off = 0; off < mtd->size; off += mtd->erasesize) {
>  		struct image_info_v1 iis;
>  		u_int iis_ptr, img_ptr;
>  
>  		/* Read the footer. */
>  		ret = afs_read_footer_v1(mtd, &img_ptr, &iis_ptr, off, mask);
>  		if (ret < 0)
> -			break;
> +			goto out_free_parts;
>  		if (ret == 0)
>  			continue;
>  
>  		/* Read the image info block */
>  		ret = afs_read_iis_v1(mtd, &iis, iis_ptr);
>  		if (ret < 0)
> -			break;
> +			goto out_free_parts;
>  		if (ret == 0)
>  			continue;
>  
> -		strcpy(str, iis.name);
> +		parts[i].name = kstrdup(iis.name, GFP_KERNEL);

Unfortunately, there's a (sort of) good reason the name strings were
allocated along with the partition info all in one go; the calling code
expects to be able to kfree() just the struct to free up all the
parser's memory (see mtd_device_parse_register(), which does
kfree(real_parts)). So you're introducing N string allocations that will
never be freed in the "success" case -- i.e., a memory leak.

Now, it kinda sucks that MTD has such limited cleanup facilities for its
parsers. I believe we either have similar ugly code (or just more memory
leaks) in other parsers. It'd be nice if we added a cleanup hook to
struct mtd_part_parser, so we can allow parsers to do arbitrary
cleanups.

Brian

> +		if (!parts[i].name) {
> +			ret = -ENOMEM;
> +			goto out_free_parts;
> +		}
>  
> -		parts[idx].name		= str;
> -		parts[idx].size		= (iis.length + mtd->erasesize - 1) & ~(mtd->erasesize - 1);
> -		parts[idx].offset	= img_ptr;
> -		parts[idx].mask_flags	= 0;
> +		parts[i].size		= (iis.length + mtd->erasesize - 1) & ~(mtd->erasesize - 1);
> +		parts[i].offset	= img_ptr;
> +		parts[i].mask_flags	= 0;
>  
>  		printk("  mtd%d: at 0x%08x, %5lluKiB, %8u, %s\n",
> -			idx, img_ptr, parts[idx].size / 1024,
> -			iis.imageNumber, str);
> -
> -		idx += 1;
> -		str = str + strlen(iis.name) + 1;
> -	}
> +			i, img_ptr, parts[i].size / 1024,
> +			iis.imageNumber, parts[i].name);
>  
> -	if (!idx) {
> -		kfree(parts);
> -		parts = NULL;
> +		i += 1;
>  	}
>  
>  	*pparts = parts;
> -	return idx ? idx : ret;
> +	return i;
> +
> +out_free_parts:
> +	while (i >= 0) {
> +		if (parts[i].name)
> +			kfree(parts[i].name);
> +		i--;
> +	}
> +	kfree(parts);
> +	*pparts = NULL;
> +	return ret;
>  }
>  
>  static struct mtd_part_parser afs_parser = {
> -- 
> 2.4.3
> 
