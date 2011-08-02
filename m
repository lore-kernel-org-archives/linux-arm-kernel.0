From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 2 Aug 2011 17:38:52 +0900
Subject: [PATCH 1/1] ASoC: core: cache index fix
In-Reply-To: <65EE16ACC360FA4D99C96DC085B3F7721F410B@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1312198690-13237-1-git-send-email-b29396@freescale.com>
	<20110801115150.GB16629@opensource.wolfsonmicro.com>
	<65EE16ACC360FA4D99C96DC085B3F7721F410B@039-SN1MPN1-002.039d.mgd.msft.net>
Message-ID: <20110802083850.GB9553@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 02, 2011 at 08:03:23AM +0000, Dong Aisheng-B29396 wrote:


> > ...hw_read() shouldn't need to know about this stuff
> Here the reg_cache_size is the maximum cache index in the register cache array.
> Therefore, the original code using reg to compare with reg_cache_size
> is not correct when the reg_cache_step is not 1.
> e.g. the reg to read is 0x30 and reg_cache_size maybe only 0x16.
> So we use idx to check if it exceeds the cache size.

I see what you're doing, but like I say this is just legacy code that
shouldn't be peering at the cache size any more and layering additional
stuff in is just going to make the situation worse.

> BTW, do you mean the soc_io layer does not need to know the details of idx&reg
> Conversion?

Yes.

> Do I need to implement a help function like reg_is_cachable(reg) to be used here?

No, I think we should hide these decisions completely within the cache
code.

> The cache block in each rbnode is still using cache index to fetch value
> which is similar like flat cache.
> (see snd_soc_rbtree_get_register & snd_soc_rbtree_set_register).
> Additionally, the snd_soc_rbtree_cache_init using cache index to do init
> by default. However, the rbtree_cache_read/write still use reg to index.

This doesn't mean it's a good idea to add extra complexity here!  A
register map with step size greater than one should never have more than
one register in a block anyway with the current code so the step size
should never be perceptible.

> The main problem is that the default cache array is indexed by cache index
> like cache[idx] while all io function using reg to fetch data.
> Many places in cache core miss used cache index and reg index.

> The purpose of this patch is to use both of them in correct places.
> The simple rule is converted to cache index to fetch data from cache when do
> Register io.

We need to deal with this sanely, dancing around with step sizes in
every place where we access registers is just not going to be
maintainable.  Essentially no modern hardware uses step sizes other than
one so they'll get very little testing, especially with the advanced
cache mechanisms which aren't really useful on older CODECs, and the
additional complexity really hurts legibility.

It occurs to me that what we want to do here may be to make a new
register cache type for step sizes then hide all the complexity for
these devices in there.  That keeps everything together and ensures that
newer devices don't pay a complexity cost.

For the register default tables it's probably sensible to just pad them
out with the zero registers; it'll cost a little space but not too much.
