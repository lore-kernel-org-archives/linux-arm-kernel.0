From: neilb@suse.com (NeilBrown)
Date: Wed, 16 Dec 2015 15:02:19 +1100
Subject: [PATCH] md: avoid warning for 32-bit sector_t
In-Reply-To: <65226011.NWtA6TWNA3@wuerfel>
References: <65226011.NWtA6TWNA3@wuerfel>
Message-ID: <87si339h2s.fsf@notabene.neil.brown.name>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 24 2015, Arnd Bergmann wrote:

> When CONFIG_LBDAF is not set, sector_t is only 32-bits wide, which
> means we cannot have devices with more than 2TB, and the code that
> is trying to handle compatibility support for large devices in
> md version 0.90 is meaningless but also causes a compile-time warning:
>
> drivers/md/md.c: In function 'super_90_load':
> drivers/md/md.c:1029:19: warning: large integer implicitly truncated to unsigned type [-Woverflow]
> drivers/md/md.c: In function 'super_90_rdev_size_change':
> drivers/md/md.c:1323:17: warning: large integer implicitly truncated to unsigned type [-Woverflow]
>
> This adds a check for CONFIG_LBDAF to avoid even getting into this
> code path, and also adds an explicit cast to let the compiler know
> it doesn't have to warn about the truncation.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Noticed on ARM randconfig builds with recent gcc versions.
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 0b48c5d7c489..ee9a7ab44f32 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -1025,8 +1025,9 @@ static int super_90_load(struct md_rdev *rdev, struct md_rdev *refdev, int minor
>  	 * (not needed for Linear and RAID0 as metadata doesn't
>  	 * record this size)
>  	 */
> -	if (rdev->sectors >= (2ULL << 32) && sb->level >= 1)
> -		rdev->sectors = (2ULL << 32) - 2;
> +	if (IS_ENABLED(CONFIG_LBDAF) && (u64)rdev->sectors >= (2ULL << 32) &&
> +	    sb->level >= 1)
> +		rdev->sectors = (sector_t)(2ULL << 32) - 2;
>  
>  	if (rdev->sectors < ((sector_t)sb->size) * 2 && sb->level >= 1)
>  		/* "this cannot possibly happen" ... */
> @@ -1319,8 +1320,9 @@ super_90_rdev_size_change(struct md_rdev *rdev, sector_t num_sectors)
>  	/* Limit to 4TB as metadata cannot record more than that.
>  	 * 4TB == 2^32 KB, or 2*2^32 sectors.
>  	 */
> -	if (num_sectors >= (2ULL << 32) && rdev->mddev->level >= 1)
> -		num_sectors = (2ULL << 32) - 2;
> +	if (IS_ENABLED(CONFIG_LBDAF) && (u64)num_sectors >= (2ULL << 32) &&
> +	    rdev->mddev->level >= 1)
> +		num_sectors = (sector_t)(2ULL << 32) - 2;
>  	md_super_write(rdev->mddev, rdev, rdev->sb_start, rdev->sb_size,
>  		       rdev->sb_page);
>  	md_super_wait(rdev->mddev);

applied, thanks.
NeilBrown
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151216/561d4a2b/attachment-0001.sig>
