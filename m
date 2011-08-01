From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 1 Aug 2011 20:51:52 +0900
Subject: [PATCH 1/1] ASoC: core: cache index fix
In-Reply-To: <1312198690-13237-1-git-send-email-b29396@freescale.com>
References: <1312198690-13237-1-git-send-email-b29396@freescale.com>
Message-ID: <20110801115150.GB16629@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 01, 2011 at 07:38:10PM +0800, Dong Aisheng wrote:

You've done this at the wrong abstraction level...

> @@ -62,8 +65,11 @@ static unsigned int hw_read(struct snd_soc_codec *codec, unsigned int reg)
>  {
>  	int ret;
>  	unsigned int val;
> +	unsigned int idx;
> +
> +	idx = snd_soc_cache_reg_to_idx(codec, reg);
>  
> -	if (reg >= codec->driver->reg_cache_size ||
> +	if (idx >= codec->driver->reg_cache_size ||
>  	    snd_soc_codec_volatile_register(codec, reg) ||
>  	    codec->cache_bypass) {
>  		if (codec->cache_only)

...hw_read() shouldn't need to know about this stuff, and there's no way
the rbtree cache should be using step sizes (which you did in the text I
deleted) as it will naturally not create the cache entries for registers
that don't exist.  Whatever we do should be hidden in the flat (and
possibly LZO, though I'd be tempted not to bother) cache, plus having a
defualt readable_register() would be sensible.

This may mean starting off with some factoring out of legacy code which
still assumes flat caches, replacing them with a check that the register
is cachable.

The purpose of the step size is to save space in the register cache.
