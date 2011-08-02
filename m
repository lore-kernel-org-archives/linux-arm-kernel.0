From: tiwai@suse.de (Takashi Iwai)
Date: Tue, 02 Aug 2011 14:52:29 +0200
Subject: [alsa-devel] [PATCH 1/1] ASoC: core: cache index fix
In-Reply-To: <65EE16ACC360FA4D99C96DC085B3F7721F45A8@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1312198690-13237-1-git-send-email-b29396@freescale.com>
	<20110801115150.GB16629@opensource.wolfsonmicro.com>
	<65EE16ACC360FA4D99C96DC085B3F7721F410B@039-SN1MPN1-002.039d.mgd.msft.net>
	<20110802083850.GB9553@opensource.wolfsonmicro.com>
	<65EE16ACC360FA4D99C96DC085B3F7721F427D@039-SN1MPN1-002.039d.mgd.msft.net>
	<s5hy5zcnlu8.wl%tiwai@suse.de>
	<65EE16ACC360FA4D99C96DC085B3F7721F43AA@039-SN1MPN1-002.039d.mgd.msft.net>
	<s5hoc08nk7t.wl%tiwai@suse.de>
	<65EE16ACC360FA4D99C96DC085B3F7721F443D@039-SN1MPN1-002.039d.mgd.msft.net>
	<s5hlivcnhe2.wl%tiwai@suse.de>
	<65EE16ACC360FA4D99C96DC085B3F7721F45A8@039-SN1MPN1-002.039d.mgd.msft.net>
Message-ID: <s5haabsnfg2.wl%tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At Tue, 2 Aug 2011 12:29:48 +0000,
Dong Aisheng-B29396 wrote:
> 
> > -----Original Message-----
> > From: Takashi Iwai [mailto:tiwai at suse.de]
> > Sent: Tuesday, August 02, 2011 8:10 PM
> > To: Dong Aisheng-B29396
> > Cc: Mark Brown; alsa-devel at alsa-project.org; s.hauer at pengutronix.de;
> > lrg at ti.com; linux-arm-kernel at lists.infradead.org; w.sang at pengutronix.de
> > Subject: Re: [alsa-devel] [PATCH 1/1] ASoC: core: cache index fix
> > 
> > At Tue, 2 Aug 2011 11:15:28 +0000,
> > Dong Aisheng-B29396 wrote:
> > >
> > > > -----Original Message-----
> > > > From: Takashi Iwai [mailto:tiwai at suse.de]
> > > > Sent: Tuesday, August 02, 2011 7:09 PM
> > > > To: Dong Aisheng-B29396
> > > > Cc: Mark Brown; alsa-devel at alsa-project.org; s.hauer at pengutronix.de;
> > > > lrg at ti.com; linux-arm-kernel at lists.infradead.org;
> > > > w.sang at pengutronix.de
> > > > Subject: Re: [alsa-devel] [PATCH 1/1] ASoC: core: cache index fix
> > > >
> > > > > > reg_cache_size is supposed to be the real size of the cache table.
> > > > > > This isn't influenced by reg_cache_step value.  So, the behavior
> > > > > > in
> > > > > > soc- io.c (and other ASoC core) is correct.
> > > > > But the reg is related to step.
> > > > > So reg and reg_cache_size are un-match when step > 1, right?
> > > >
> > > > I'm not sure what is referred here as reg, but the argument passed
> > > > to
> > > > snd_soc_{read|write}() is the raw register index.  reg = 2 is 2 no
> > > > matter whether reg_cache_step is 1 or 2.  This is passed down to
> > > > hw_read(), thus reg and reg_cache_size do match even when step > 1.
> > > >
> > > Yes, it is raw register index here.
> > > The case is that cache array is [reg0, reg1, reg2, reg3], So the size
> > > is 4.
> > > But when step is 2, reg0 is 0x0, reg1 is 0x2, reg3 is 0x6.
> > > So check if reg3 > reg_cache_size is not correct.
> > > I mean this mismatch. Am I correct?
> > 
> > No, the (flat) cache array held in codec instance contains padding, e.g.
> > [reg0, 0, reg1, 0, reg2, 0, reg3, 0] in the case above.
> > cache_reg_step is there just for avoiding the access to invalid registers
> > in the table-lookup code in soc-*.c.
> I saw most codec drivers with cache_reg_step of 2 do not have padding such
> as wm9705, wm9712 driver(you can check the code).
> So It looks the cache_reg_step here causes some misleading.

Yeah, there have been confusion about the usage of these (I vaguely
remember I complained years ago :), and I guess something is
significantly broken there now.

> > Thus it's a bug of the driver if it passes reg_cache_default with a
> > packed array with reg_cache_step > 1.  If the size matters, we may fix it
> > in soc-core.c to accept packed arrays, but I'm not sure whether it's
> > worth alone.
> > 
> > (For the sparse data like wm8995, it's a different question; Obviously
> > it can be better packed in a form of {index,data} pairs instead of  the
> > whole sparse array as initial data.  Then we'd need to introduce  another
> > type of default-data copier in soc-core.c.)
> > 
> > And, in principle, the driver shouldn't access codec->reg_cache contents
> > directly but use helper functions.  Then the most of inconsistency issue
> > should go away.
> Yes.
> The problem is that if the cache array is not padded, the snd_soc_read/write
> may work incorrectly.

Well, the problem is that there are inconsistencies in the code.
Especially soc-cache.c doesn't consider about reg_cache_step at all
(e.g. snd_soc_flat_cache_sync()).

Mark, Liam, could you guys take a deeper look and clean these messes
up?


thanks,

Takashi
