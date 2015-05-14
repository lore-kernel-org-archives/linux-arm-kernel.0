From: jaegeuk@kernel.org (Jaegeuk Kim)
Date: Wed, 13 May 2015 17:23:09 -0700
Subject: [PATCH] f2fs: fix building on 32-bit architectures
In-Reply-To: <2179770.3R5P5nr1c7@wuerfel>
References: <2179770.3R5P5nr1c7@wuerfel>
Message-ID: <20150514002309.GB68412@jaegeuk-mac02>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Thank you for the patch.
Merged and pushed to -next. :)

Thanks,

On Wed, May 13, 2015 at 10:49:58PM +0200, Arnd Bergmann wrote:
> A bug fix to the debug output extended the type of some local
> variables to 64-bit, which now causes the kernel to fail building
> because of missing 64-bit division functions:
> 
> ERROR: "__aeabi_uldivmod" [fs/f2fs/f2fs.ko] undefined!
> 
> In the kernel, we have to use div_u64 or do_div to do this,
> in order to annotate that this is an expensive operation.
> 
> As the function is only called for debug out, we know this
> is not performance critical, so it is safe to use div_u64.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: d1f85bd38db19 ("f2fs: avoid value overflow in showing current status")
> ---
> This patch is required for ARM allmodconfig builds.
> 
> diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
> index efbc83f07305..75176e0dd6c8 100644
> --- a/fs/f2fs/debug.c
> +++ b/fs/f2fs/debug.c
> @@ -113,10 +113,10 @@ static void update_sit_info(struct f2fs_sb_info *sbi)
>  			ndirty++;
>  		}
>  	}
> -	dist = MAIN_SECS(sbi) * hblks_per_sec * hblks_per_sec / 100;
> -	si->bimodal = bimodal / dist;
> +	dist = div_u64(MAIN_SECS(sbi) * hblks_per_sec * hblks_per_sec, 100);
> +	si->bimodal = div_u64(bimodal, dist);
>  	if (si->dirty_count)
> -		si->avg_vblocks = total_vblocks / ndirty;
> +		si->avg_vblocks = div_u64(total_vblocks, ndirty);
>  	else
>  		si->avg_vblocks = 0;
>  }
