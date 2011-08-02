From: B29396@freescale.com (Dong Aisheng-B29396)
Date: Tue, 2 Aug 2011 13:17:12 +0000
Subject: [PATCH 1/1] ASoC: core: cache index fix
In-Reply-To: <65EE16ACC360FA4D99C96DC085B3F7721F427D@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1312198690-13237-1-git-send-email-b29396@freescale.com>
	<20110801115150.GB16629@opensource.wolfsonmicro.com>
	<65EE16ACC360FA4D99C96DC085B3F7721F410B@039-SN1MPN1-002.039d.mgd.msft.net>
	<20110802083850.GB9553@opensource.wolfsonmicro.com>
	<65EE16ACC360FA4D99C96DC085B3F7721F427D@039-SN1MPN1-002.039d.mgd.msft.net>
Message-ID: <65EE16ACC360FA4D99C96DC085B3F7721F4616@039-SN1MPN1-002.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-
> kernel-bounces at lists.infradead.org] On Behalf Of Dong Aisheng-B29396
> Sent: Tuesday, August 02, 2011 5:41 PM
> To: Mark Brown
> Cc: alsa-devel at alsa-project.org; s.hauer at pengutronix.de; lrg at ti.com;
> linux-arm-kernel at lists.infradead.org; w.sang at pengutronix.de
> Subject: RE: [PATCH 1/1] ASoC: core: cache index fix
> 
> > -----Original Message-----
> > From: Mark Brown [mailto:broonie at opensource.wolfsonmicro.com]
> > Sent: Tuesday, August 02, 2011 4:39 PM
> > To: Dong Aisheng-B29396
> > Cc: alsa-devel at alsa-project.org; linux-arm-kernel at lists.infradead.org;
> > lrg at ti.com; s.hauer at pengutronix.de; w.sang at pengutronix.de
> > Subject: Re: [PATCH 1/1] ASoC: core: cache index fix
> >
> > On Tue, Aug 02, 2011 at 08:03:23AM +0000, Dong Aisheng-B29396 wrote:
> >
> >
> > > > ...hw_read() shouldn't need to know about this stuff
> > > Here the reg_cache_size is the maximum cache index in the register
> > cache array.
> > > Therefore, the original code using reg to compare with
> > > reg_cache_size is not correct when the reg_cache_step is not 1.
> > > e.g. the reg to read is 0x30 and reg_cache_size maybe only 0x16.
> > > So we use idx to check if it exceeds the cache size.
> >
> > I see what you're doing, but like I say this is just legacy code that
> > shouldn't be peering at the cache size any more and layering
> > additional stuff in is just going to make the situation worse.
> >
> > > BTW, do you mean the soc_io layer does not need to know the details
> > > of idx&reg Conversion?
> >
> > Yes.
> >
> > > Do I need to implement a help function like reg_is_cachable(reg) to
> > > be
> > used here?
> >
> > No, I think we should hide these decisions completely within the cache
> > code.
> 
> Yes, but the issue is that hw_read will check if reg is in cache array
> And checking like " if (reg >= codec->driver->reg_cache_size ||" is wrong
> when the step is not 1 that will cause registers with their index are
> greater than cache index will not be able to fetch data from cache.
> 
> If we high this in cache code, do you mean hide it in snd_soc_cache_read?
> If that, the hw_read may fail and it looks not as we expected.
> 
> @@ -62,8 +65,11 @@ static unsigned int hw_read(struct snd_soc_codec
> *codec, unsigned int reg)  {
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
> 
> 
> > > The cache block in each rbnode is still using cache index to fetch
> > > value which is similar like flat cache.
> > > (see snd_soc_rbtree_get_register & snd_soc_rbtree_set_register).
> > > Additionally, the snd_soc_rbtree_cache_init using cache index to do
> > > init by default. However, the rbtree_cache_read/write still use reg
> > > to
> > index.
> >
> > This doesn't mean it's a good idea to add extra complexity here!
> I agree.
> 
> > A
> > register map with step size greater than one should never have more
> > than one register in a block anyway with the current code so the step
> > size should never be perceptible.
> The question is that rbtree uses reg index to index as follows:
>         if (rbnode) {
>                 snd_soc_rbtree_get_base_top_reg(rbnode, &base_reg,
> &top_reg);
>                 if (reg >= base_reg && reg <= top_reg) {
>                         reg_tmp = reg - base_reg;
>                         *value = snd_soc_rbtree_get_register(rbnode,
> reg_tmp);
>                         return 0;
>                 }
>         }
> So the block may be reg0, reg2, reg4.....
> And the block is flat, the value is get/set by rbnode->block[reg_tmp]:
> I understand right, there may be hole in the block, right?
> 
> > > The main problem is that the default cache array is indexed by cache
> > > index like cache[idx] while all io function using reg to fetch data.
> > > Many places in cache core miss used cache index and reg index.
> >
> > > The purpose of this patch is to use both of them in correct places.
> > > The simple rule is converted to cache index to fetch data from cache
> > > when do Register io.
> >
> > We need to deal with this sanely, dancing around with step sizes in
> > every place where we access registers is just not going to be
> maintainable.
> > Essentially no modern hardware uses step sizes other than one so
> > they'll get very little testing, especially with the advanced cache
> > mechanisms which aren't really useful on older CODECs, and the
> > additional complexity really hurts legibility.
> Yes, I agree that we should not introduce too much additional complexity.

> The better case may be that only change the rbtree init code to get
> correct Register value for the registers. Then the
> rbtree_cache_read/write can index the register correctly.
> (I also think the rbtree cache should not know step)

For rbtree, i tried that only changed snd_soc_rbtree_cache_init as follows
Could work. Then rbtree_cache_read/write do not need to care about step.
This could reduce many code changes and complexity.
But the disadvantage is that the rbtree cache may not be able to find a
adjacent register in the same block if the reg step is 2.
However it works.
Do you think this is acceptable?

@@ -426,7 +465,8 @@ static int snd_soc_rbtree_cache_init(struct snd_soc_codec *codec)
 					    word_size);
 		if (!val)
 			continue;
-		ret = snd_soc_rbtree_cache_write(codec, i, val);
+		reg = snd_soc_cache_idx_to_reg(codec, i);
+		ret = snd_soc_rbtree_cache_write(codec, reg, val);
 		if (ret)
 			goto err;
 	}

> Then the only complexity is checking reg index for flat cache read/write
> But that is really needed for different cache step of flat cache.
> 
> > It occurs to me that what we want to do here may be to make a new
> > register cache type for step sizes then hide all the complexity for
> > these devices in there.  That keeps everything together and ensures
> > that newer devices don't pay a complexity cost.
> If we add new cache type, does it have any big difference with FLAT?
> Maybe if we can fix the cache step issue, the FLAT cache can be reuse.
> 
> > For the register default tables it's probably sensible to just pad
> > them out with the zero registers; it'll cost a little space but not too
> much.
> Yes, it's the most easy way now.
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
