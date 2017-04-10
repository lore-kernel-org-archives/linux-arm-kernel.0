From: dsterba@suse.cz (David Sterba)
Date: Mon, 10 Apr 2017 13:13:53 +0200
Subject: [PATCH] btrfs: scrub: use do_div() for 64-by-32 division
In-Reply-To: <20170408210737.5456-1-kilobyte@angband.pl>
References: <CAOMZO5B9J15qvrsjOb-e5gk47gA=+2p2yLNLhswG+H3S0L7LXg@mail.gmail.com>
 <20170408210737.5456-1-kilobyte@angband.pl>
Message-ID: <20170410111353.GX4781@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 08, 2017 at 11:07:37PM +0200, Adam Borowski wrote:
> Unbreaks ARM and possibly other 32-bit architectures.
> 
> Fixes: 7d0ef8b4d: Btrfs: update scrub_parity to use u64 stripe_len
> Reported-by: Icenowy Zheng <icenowy@aosc.io>
> Signed-off-by: Adam Borowski <kilobyte@angband.pl>
> ---
> You'd probably want to squash this with Liu's commit, to be nice to future
> bisects.

Thanks for finding it!

> Tested on amd64 where all is fine, and on arm (Odroid-U2) where scrub
> sometimes works, but, like most operations, randomly dies with some badness
> that doesn't look related: io_schedule, kunmap_high.  That badness wasn't
> there in 4.11-rc5, needs investigating, but since it's not connected to our
> issue at hand, I consider this patch sort-of tested.
> 
>  fs/btrfs/scrub.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index b6fe1cd08048..95372e3679f3 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -2407,7 +2407,7 @@ static inline void __scrub_mark_bitmap(struct scrub_parity *sparity,
>  
>  	start -= sparity->logic_start;
>  	start = div64_u64_rem(start, sparity->stripe_len, &offset);
> -	offset /= sectorsize;
> +	do_div(offset, sectorsize);

I'll use the div_u64 helper instead, I don't want to reintroduce do_div
to fs/btrfs , for-next will be updated in a minute.
