From: tiwai@suse.de (Takashi Iwai)
Date: Thu, 25 Mar 2010 12:12:52 +0100
Subject: AACI broken with commit 29a4f2d3
In-Reply-To: <000401cacb65$3466d3d0$9d347b70$@deacon@arm.com>
References: <1269438662.29073.121.camel@e102109-lin.cambridge.arm.com>
	<1269443418.29073.147.camel@e102109-lin.cambridge.arm.com>
Message-ID: <s5h39zou023.wl%tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At Wed, 24 Mar 2010 15:18:06 -0000,
Will Deacon wrote:
> 
> Hi Catalin,
> 
> > aaci: Use writew() to the AC97_POWERDOWN 16-bit register
> > 
> > From: Catalin Marinas <catalin.marinas@arm.com>
> > 
> > The writel() introduced by commit 29a4f2d3 generates an alignment fault
> > on ARM.
> > 
> > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Philby John <pjohn@in.mvista.com>
> > Cc: Takashi Iwai <tiwai@suse.de>
> > ---
> >  sound/arm/aaci.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/sound/arm/aaci.c b/sound/arm/aaci.c
> > index 656e474..d66d4ff 100644
> > --- a/sound/arm/aaci.c
> > +++ b/sound/arm/aaci.c
> > @@ -863,7 +863,7 @@ static int __devinit aaci_probe_ac97(struct aaci *aaci)
> >  	struct snd_ac97 *ac97;
> >  	int ret;
> > 
> > -	writel(0, aaci->base + AC97_POWERDOWN);
> > +	writew(0, aaci->base + AC97_POWERDOWN);
> >  	/*
> >  	 * Assert AACIRESET for 2us
> >  	 */
> 
> A writel() looks wrong anyway because even if it could succeed, it would
> send half of its write to AC97_EXTENDED_ID, which sounds suspiciously read-only
> to me.
> 
> Tested-by: Will Deacon <will.deacon@arm.com>

Looking back at the original patch again, I wonder now whether using
AC97_* for the register offset here is really correct.  Usually AC97
registers are accessed indirectly.

Is it just same 0x26, or is this intentional?


thanks,

Takashi
