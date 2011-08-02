From: B29396@freescale.com (Dong Aisheng-B29396)
Date: Tue, 2 Aug 2011 08:03:23 +0000
Subject: [PATCH 1/1] ASoC: core: cache index fix
In-Reply-To: <20110801115150.GB16629@opensource.wolfsonmicro.com>
References: <1312198690-13237-1-git-send-email-b29396@freescale.com>
	<20110801115150.GB16629@opensource.wolfsonmicro.com>
Message-ID: <65EE16ACC360FA4D99C96DC085B3F7721F410B@039-SN1MPN1-002.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie at opensource.wolfsonmicro.com]
> Sent: Monday, August 01, 2011 7:52 PM
> To: Dong Aisheng-B29396
> Cc: alsa-devel at alsa-project.org; linux-arm-kernel at lists.infradead.org;
> lrg at ti.com; s.hauer at pengutronix.de; w.sang at pengutronix.de
> Subject: Re: [PATCH 1/1] ASoC: core: cache index fix
> 
> On Mon, Aug 01, 2011 at 07:38:10PM +0800, Dong Aisheng wrote:
> 
> You've done this at the wrong abstraction level...
> 
> > @@ -62,8 +65,11 @@ static unsigned int hw_read(struct snd_soc_codec
> > *codec, unsigned int reg)  {
> >  	int ret;
> >  	unsigned int val;
> > +	unsigned int idx;
> > +
> > +	idx = snd_soc_cache_reg_to_idx(codec, reg);
> >
> > -	if (reg >= codec->driver->reg_cache_size ||
> > +	if (idx >= codec->driver->reg_cache_size ||
> >  	    snd_soc_codec_volatile_register(codec, reg) ||
> >  	    codec->cache_bypass) {
> >  		if (codec->cache_only)
> 
> ...hw_read() shouldn't need to know about this stuff
Here the reg_cache_size is the maximum cache index in the register cache array.
Therefore, the original code using reg to compare with reg_cache_size
is not correct when the reg_cache_step is not 1.
e.g. the reg to read is 0x30 and reg_cache_size maybe only 0x16.
So we use idx to check if it exceeds the cache size.

BTW, do you mean the soc_io layer does not need to know the details of idx&reg
Conversion?
Do I need to implement a help function like reg_is_cachable(reg) to be used here?

> and there's no way
> the rbtree cache should be using step sizes (which you did in the text I
> deleted) as it will naturally not create the cache entries for registers
> that don't exist.
> Whatever we do should be hidden in the flat (and
> possibly LZO, though I'd be tempted not to bother) cache, plus having a
> defualt readable_register() would be sensible.
The cache block in each rbnode is still using cache index to fetch value
which is similar like flat cache.
(see snd_soc_rbtree_get_register & snd_soc_rbtree_set_register).
Additionally, the snd_soc_rbtree_cache_init using cache index to do init
by default. However, the rbtree_cache_read/write still use reg to index.

If not change it, my test will fail (MX28EVK + sgtl5000).
(LZO showed the same result.)

The main problem is that the default cache array is indexed by cache index
like cache[idx] while all io function using reg to fetch data.
Many places in cache core miss used cache index and reg index.

The purpose of this patch is to use both of them in correct places.
The simple rule is converted to cache index to fetch data from cache when do
Register io.

> This may mean starting off with some factoring out of legacy code which
> still assumes flat caches, replacing them with a check that the register
> is cachable.
>
> The purpose of the step size is to save space in the register cache.
Yes.
	
