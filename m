From: lars@metafoo.de (Lars-Peter Clausen)
Date: Thu, 4 Aug 2016 17:39:01 +0200
Subject: [PATCH 1/2] regmap: Add a function to check if a regmap register
 is cached
In-Reply-To: <1470322558-7501-2-git-send-email-cristian.birsan@microchip.com>
References: <1470322558-7501-1-git-send-email-cristian.birsan@microchip.com>
 <1470322558-7501-2-git-send-email-cristian.birsan@microchip.com>
Message-ID: <925b5dd1-df5e-3be6-8dc0-3043d79cc1bd@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/04/2016 04:55 PM, Cristian Birsan wrote:
> Add a function to check if a regmap register is cached. This will be used
> in debugfs to dump the cached values of write only registers.
> 
> Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
> ---
>  drivers/base/regmap/internal.h |  1 +
>  drivers/base/regmap/regmap.c   | 14 ++++++++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/drivers/base/regmap/internal.h b/drivers/base/regmap/internal.h
> index 3df9770..cae04f4 100644
> --- a/drivers/base/regmap/internal.h
> +++ b/drivers/base/regmap/internal.h
> @@ -171,6 +171,7 @@ struct regcache_ops {
>  	int (*drop)(struct regmap *map, unsigned int min, unsigned int max);
>  };
>  
> +bool regmap_cached(struct regmap *map, unsigned int reg);
>  bool regmap_writeable(struct regmap *map, unsigned int reg);
>  bool regmap_readable(struct regmap *map, unsigned int reg);
>  bool regmap_volatile(struct regmap *map, unsigned int reg);
> diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
> index 4ac63c0..e07f3a9 100644
> --- a/drivers/base/regmap/regmap.c
> +++ b/drivers/base/regmap/regmap.c
> @@ -92,6 +92,20 @@ bool regmap_writeable(struct regmap *map, unsigned int reg)
>  	return true;
>  }
>  
> +bool regmap_cached(struct regmap *map, unsigned int reg)
> +{
> +	if (map->cache == REGCACHE_NONE)
> +		return false;
> +
> +	if (!map->cache_ops)
> +		return false;
> +
> +	if (map->max_register && reg > map->max_register)
> +		return false;	

There is a problem with this approach. It does not check if the register is
cached it only checks if the register is cacheable.

This works very poorly for devices with sparse register maps. Sparse
register maps do not assign a register to each register number. There are
often even large gaps in the register map and some devices use up their full
16-bit register space.

Now this change combined with the next patch will cause the register file to
contain an entry for every possible register number, even if the register
number is not assigned. Since unassigned registers are not cached
regcache_read() will return an error and the registers file will print XX
for the register value. This means for sparse register maps the registers
file will be full of thousands of such entries.
