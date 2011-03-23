From: marek.vasut@gmail.com (Marek Vasut)
Date: Wed, 23 Mar 2011 15:54:36 +0100
Subject: [PATCH] ARM: pxafb: Fix access to nonexistent member of pxafb_info
In-Reply-To: <201103231115.53082.anarsoul@gmail.com>
References: <1300796054-18697-1-git-send-email-marek.vasut@gmail.com>
	<201103231115.53082.anarsoul@gmail.com>
Message-ID: <201103231554.36178.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 23 March 2011 10:15:52 Vasily Khoruzhick wrote:
> On Tuesday 22 March 2011 14:14:14 Marek Vasut wrote:
> > In case CONFIG_FB_PXA_OVERLAY is not defined, the pxafb_freq_transition()
> > function tests nonexistent member of pxafb_info (since the member is not
> > part of the structure).
> > Fix this by wraping the test in ifdef, even if I don't really like how
> > the code looks now. The check doesn't have to happen if overlays are
> > disabled at all as the check is always true then.
> 
> Ok, but how you're going to implement it if overlay support is enabled, but
> SoC does not support it?

Implement what ? The member doesn't exist in the structure so it doesn't even 
compile with overlays disabled.

> 
> > Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> 
> Acked-by: Vasily Khoruzhick <anarsoul@gmail.com>
> 
> > ---
> > 
> >  drivers/video/pxafb.c |    4 +++-
> >  1 files changed, 3 insertions(+), 1 deletions(-)
> > 
> > diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
> > index a2e5b51..0f4e8c9 100644
> > --- a/drivers/video/pxafb.c
> > +++ b/drivers/video/pxafb.c
> > @@ -1648,7 +1648,9 @@ pxafb_freq_transition(struct notifier_block *nb,
> > unsigned long val, void *data)
> > 
> >  	switch (val) {
> > 
> >  	case CPUFREQ_PRECHANGE:
> > -		if (!fbi->overlay[0].usage && !fbi->overlay[1].usage)
> > +#ifdef CONFIG_FB_PXA_OVERLAY
> > +		if (!(fbi->overlay[0].usage || fbi->overlay[1].usage))
> > +#endif
> > 
> >  			set_ctrlr_state(fbi, C_DISABLE_CLKCHANGE);
> >  		
> >  		break;
