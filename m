From: jonathanh@nvidia.com (Jon Hunter)
Date: Fri, 3 Mar 2017 15:32:22 +0000
Subject: [PATCH] arm64: restore get_current() optimisation
In-Reply-To: <20170302164654.GP19632@leverpostej>
References: <1483468021-8237-1-git-send-email-mark.rutland@arm.com>
 <ee26a4f0-e3e9-fb44-fe7c-c40a15c33b38@nvidia.com>
 <20170302123507.GD19632@leverpostej>
 <086dff0b-126d-b5b7-e877-d3d46efce618@nvidia.com>
 <20170302164654.GP19632@leverpostej>
Message-ID: <515e311c-b044-8759-8bf3-99ac4565840d@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 02/03/17 16:46, Mark Rutland wrote:

...

> Ok, so it appears that either map->cache is dodgy, or the reg passed to
> regcache_flat_read() is bogus, and we end up generating a cache index
> that is well out of bounds.
> 
> Perhaps a caller is deriving that from an uninitialised variable? The
> code and stack layout changes as a result of my patch could easily
> tickle that.
> 
> I'm not at all familiar with regmap, but IIUC we can catch that with:
> 
> ---->8----
> diff --git a/drivers/base/regmap/regcache-flat.c b/drivers/base/regmap/regcache-flat.c
> index 4d2e50b..2d42c01 100644
> --- a/drivers/base/regmap/regcache-flat.c
> +++ b/drivers/base/regmap/regcache-flat.c
> @@ -57,6 +57,8 @@ static int regcache_flat_read(struct regmap *map,
>  {
>         unsigned int *cache = map->cache;
>  
> +       BUG_ON(reg > map->max_register);
> +
>         *value = cache[regcache_flat_get_index(map, reg)];
>  
>         return 0;
> ---->8----

You are correct, the reg passed to regcache_flat_read() is indeed dodgy
and the above BUG() did trip it up.

Commit e411b0b5eb9b ('ASoC: dapm: Support second register for DAPM
control updates') introduced a 2nd register set into the
snd_soc_dapm_update struct and if the 'has_second_set' is true then it
tries to access this register. One of our out-of-tree audio patches was
not initialising the 'has_second_set' and hence it was trying to write a
bogus register (need to get this upstream!).

I should have caught this, but the bisect threw me off the scent! I
think that with reverting this patch we were just getting lucky and the
problem could have still occurred. I went back and tried it again and it
still works when reverting this change, but its just luck.

Sorry for the noise and thanks for pointing me in the right direction!

Cheers
Jon

-- 
nvpublic
