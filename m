From: computersforpeace@gmail.com (Brian Norris)
Date: Tue, 10 Nov 2015 19:09:04 -0800
Subject: [PATCH 06/10] mtd: afs: simplify partition detection
In-Reply-To: <1444914533-27782-7-git-send-email-linus.walleij@linaro.org>
References: <1444914533-27782-1-git-send-email-linus.walleij@linaro.org>
 <1444914533-27782-7-git-send-email-linus.walleij@linaro.org>
Message-ID: <20151111030904.GX12143@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Thu, Oct 15, 2015 at 03:08:49PM +0200, Linus Walleij wrote:
> Instead of reading out the AFS footers twice, create a separate
> function to just check if there is a footer or not. Rids a few
> local variables and prepare us to join the actual parser into
> one function.
> 
> Cc: Ryan Harkin <ryan.harkin@linaro.org>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/mtd/afs.c | 33 ++++++++++++++++++++++-----------
>  1 file changed, 22 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/mtd/afs.c b/drivers/mtd/afs.c
> index 9e6089615f16..2307f54195f5 100644
> --- a/drivers/mtd/afs.c
> +++ b/drivers/mtd/afs.c
> @@ -68,6 +68,26 @@ static u32 word_sum(void *words, int num)
>  	return sum;
>  }
>  
> +static bool afs_is_v1(struct mtd_info *mtd, u_int off)
> +{
> +	/* The magic is 12 bytes from the end of the erase block */
> +	u_int ptr = off + mtd->erasesize - 12;
> +	u32 magic;
> +	size_t sz;
> +	int ret;
> +
> +	ret = mtd_read(mtd, ptr, 4, &sz, (u_char *)&magic);
> +	if (ret < 0) {
> +		printk(KERN_ERR "AFS: mtd read failed at 0x%x: %d\n",
> +		       ptr, ret);
> +		return false;
> +	}
> +	if (ret >= 0 && sz != 4)
> +		return false;
> +
> +	return (magic == AFSV1_FOOTER_MAGIC);
> +}
> +
>  static int
>  afs_read_footer_v1(struct mtd_info *mtd, u_int *img_start, u_int *iis_start,
>  		   u_int off, u_int mask)
> @@ -176,18 +196,9 @@ static int parse_afs_partitions(struct mtd_info *mtd,
>  	 */
>  	mask = mtd->size - 1;
>  
> -	/*
> -	 * First, calculate the size of the array we need for the
> -	 * partition information.  We include in this the size of
> -	 * the strings.
> -	 */
> +	/* Count the partitions by looping over all erase blocks */
>  	for (i = off = sz = 0; off < mtd->size; off += mtd->erasesize) {
> -		u_int iis_ptr, img_ptr;
> -
> -		ret = afs_read_footer_v1(mtd, &img_ptr, &iis_ptr, off, mask);
> -		if (ret < 0)
> -			return ret;
> -		if (ret) {
> +		if (afs_is_v1(mtd, off)) {
>  			sz += sizeof(struct mtd_partition);
>  			i += 1;
>  		}

I think this change is more subtle than it looks at first glance. There
are a few points:

(1) This kind of flash format is naturally fairly imprecise and
unfocused; the parser is scanning every block on the device, so its
scans have to have pretty good heuristics to ensure that it doesn't
treat some other block of data as containing AFS metadata. This usually
works out OK when using magic strings and checksums, but it's still not
100% foolproof.

(2) You're dropping some of the safeguards -- particularly the checksum
-- from the first pass that calculates the number of partitions. This
seems OK for now, since you still do the same checks later, and if they
fail, you just skip the block. But it means that if the block isn't
exactly perfect (whether it's due to malice, coincidence, or
corruption), then we have a problem in the second pass through the
device.

(3) The "problem" from (2) is currently only a slightly
larger-than-necessary memory allocation -- we allocate for too many
partitions -- which is benign. But in later patches, you change the
second loop's behavior so that checksum errors become fatal. That means
that any block that happens to have the magic number in the right (or
wrong, depending on your POV) place will cause the entire parsing
process to fail. That's probably a bug, not a feature.

So, is it really worth saving mtd_read()'ing 16 bytes of flash really
worth this extra fragility? I think you should still read the whole
footer and check its checksum before declaring it a 'v1' footer. And
don't make a checksum failure completely fatal; just make it skip the
block.

Regards,
Brian
