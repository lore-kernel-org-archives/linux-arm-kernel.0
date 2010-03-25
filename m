From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 25 Mar 2010 11:30:19 +0000
Subject: AACI broken with commit 29a4f2d3
In-Reply-To: <s5h39zou023.wl%tiwai@suse.de>
References: <1269438662.29073.121.camel@e102109-lin.cambridge.arm.com>
	<1269443418.29073.147.camel@e102109-lin.cambridge.arm.com>
	<s5h39zou023.wl%tiwai@suse.de>
Message-ID: <20100325113019.GA6590@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 25, 2010 at 12:12:52PM +0100, Takashi Iwai wrote:
> At Wed, 24 Mar 2010 15:18:06 -0000,
> Will Deacon wrote:
> > 
> > Hi Catalin,
> > 
> > > aaci: Use writew() to the AC97_POWERDOWN 16-bit register
> > > 
> > > From: Catalin Marinas <catalin.marinas@arm.com>
> > > 
> > > The writel() introduced by commit 29a4f2d3 generates an alignment fault
> > > on ARM.
> > > 
> > > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: Philby John <pjohn@in.mvista.com>
> > > Cc: Takashi Iwai <tiwai@suse.de>
> > > ---
> > >  sound/arm/aaci.c |    2 +-
> > >  1 files changed, 1 insertions(+), 1 deletions(-)
> > > 
> > > diff --git a/sound/arm/aaci.c b/sound/arm/aaci.c
> > > index 656e474..d66d4ff 100644
> > > --- a/sound/arm/aaci.c
> > > +++ b/sound/arm/aaci.c
> > > @@ -863,7 +863,7 @@ static int __devinit aaci_probe_ac97(struct aaci *aaci)
> > >  	struct snd_ac97 *ac97;
> > >  	int ret;
> > > 
> > > -	writel(0, aaci->base + AC97_POWERDOWN);
> > > +	writew(0, aaci->base + AC97_POWERDOWN);
> > >  	/*
> > >  	 * Assert AACIRESET for 2us
> > >  	 */
> > 
> > A writel() looks wrong anyway because even if it could succeed, it would
> > send half of its write to AC97_EXTENDED_ID, which sounds suspiciously read-only
> > to me.
> > 
> > Tested-by: Will Deacon <will.deacon@arm.com>
> 
> Looking back at the original patch again, I wonder now whether using
> AC97_* for the register offset here is really correct.  Usually AC97
> registers are accessed indirectly.
> 
> Is it just same 0x26, or is this intentional?

The original patch is total crap.

1. You can't access AC97 registers via writel.
2. If the offset is 0x26 (AACI_CSCH2 + AACI_IE + 2), this is writing to
   reserved bits in channel 2's interrupt enable register which has
   nothing to do with the slot 1/2 transmit registers.

The patch could never have been tested in the first place.
