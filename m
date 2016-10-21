From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 21 Oct 2016 16:23:12 +0100
Subject: [PATCH] drm: convert DT component matching to
 component_match_add_release()
In-Reply-To: <CAOw6vbJ64JOugR2b3R87pFRDGDVs9HM3uZJM2z1-jHyhPf6WOA@mail.gmail.com>
References: <E1bwo6l-0005Io-Q1@rmk-PC.armlinux.org.uk>
 <CAOw6vbK=z3wJKTh8jZoU2Gj1PtTLLH_sAUUShbsxL=Qi7d+FLw@mail.gmail.com>
 <20161020215022.GZ1041@n2100.armlinux.org.uk>
 <CAOw6vbJ64JOugR2b3R87pFRDGDVs9HM3uZJM2z1-jHyhPf6WOA@mail.gmail.com>
Message-ID: <20161021152312.GB1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 20, 2016 at 07:15:56PM -0400, Sean Paul wrote:
> On Thu, Oct 20, 2016 at 5:50 PM, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> > On Thu, Oct 20, 2016 at 04:39:04PM -0400, Sean Paul wrote:
> >> On Wed, Oct 19, 2016 at 6:28 AM, Russell King
> >> <rmk+kernel@armlinux.org.uk> wrote:
> >> > Convert DT component matching to use component_match_add_release().
> >> >
> >> > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> >> > ---
> >> > Can we please get this patch from May merged into the drm-misc or
> >> > whatever trees so that we don't end up with conflicts?  I've no idea
> >> > who looks after drm-misc, as they have _still_ failed to add
> >> > themselves to MAINTAINERS.
> >>
> >> I think Daniel explained pretty clearly why this wasn't happening in
> >> the previous thread.
> >>
> >> Next time you send a v2, can you please mark it as such and include a
> >> "Changes in v2" section?
> >
> > Why - nothing's changed other than a rebase onto 4.9-rc1.  This isn't
> > a "I've changed it in XYZ way, so here's a new copy".
> 
> 
> Changes in v2: None
> 
> Is still useful since:
> a) the diffstat is different from v1, which necessitates me going
> through both versions to see what's changed from the previous reviews
> (only to find out myself that it's been rebased and a function has
> changed names)

Sorry, but I don't track in any fine detail what the changes are
between patches when I bring them forward: I have far too many patches
to do that (I have 300 right now) and I never know whether they're
going to result in a pull request or not.  It means finding some way
to manually attach a change log to each patch I send out, which will
be very time consuming.  I'd rather not send patches out than jump
through hoops like that, especially when the reason is that the
previous version was ignored.

> b) in June, you said you were going to roll a new version with the
> common OF bits extracted. it's nice to know at the outset that this
> has/hasn't happened

Now if you were following the rest of it, rather than just random parts
that suited you, you'd have noticed that I posted the new version, but
that caused more issues, so I publically said I was reverting back to
the original version.

> Also, prefacing the subject with [PATCH v2] or [PATCH RESEND] lets me
> know there is prior history with the change. Reading the previous
> version is helpful to see what reviewer's concerns were, and whether
> they've been addressed.

Yea, I'm very bad at changing the subject line in that way, and I'm
getting worse at it.  Sorry, I try my best, but I can't do better than
that.

> 
> 
> > It's being
> > posted in the hope that someone will finally either comment on it or
> > merge the damn thing, rather than ignoring it was done when it was
> > last posted.
> >
> >> >  drivers/gpu/drm/arm/hdlcd_drv.c                 |  3 ++-
> >> >  drivers/gpu/drm/arm/malidp_drv.c                |  4 +++-
> >> >  drivers/gpu/drm/armada/armada_drv.c             |  2 +-
> >> >  drivers/gpu/drm/drm_of.c                        | 28 +++++++++++++++++++++++--
> >> >  drivers/gpu/drm/etnaviv/etnaviv_drv.c           |  5 +++--
> >> >  drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c |  7 ++++---
> >> >  drivers/gpu/drm/mediatek/mtk_drm_drv.c          |  4 +++-
> >> >  drivers/gpu/drm/msm/msm_drv.c                   | 12 ++++++-----
> >> >  drivers/gpu/drm/rockchip/rockchip_drm_drv.c     |  6 ++++--
> >> >  drivers/gpu/drm/sti/sti_drv.c                   |  5 +++--
> >> >  drivers/gpu/drm/sun4i/sun4i_drv.c               |  3 ++-
> >> >  drivers/gpu/drm/tilcdc/tilcdc_external.c        |  4 +++-
> >> >  include/drm/drm_of.h                            | 12 +++++++++++
> >> >  13 files changed, 73 insertions(+), 22 deletions(-)
> >> >
> >> > diff --git a/drivers/gpu/drm/arm/hdlcd_drv.c b/drivers/gpu/drm/arm/hdlcd_drv.c
> >> > index fb6a418ce6be..6477d1a65266 100644
> >> > --- a/drivers/gpu/drm/arm/hdlcd_drv.c
> >> > +++ b/drivers/gpu/drm/arm/hdlcd_drv.c
> >> > @@ -453,7 +453,8 @@ static int hdlcd_probe(struct platform_device *pdev)
> >> >                 return -EAGAIN;
> >> >         }
> >> >
> >> > -       component_match_add(&pdev->dev, &match, compare_dev, port);
> >> > +       drm_of_component_match_add(&pdev->dev, &match, compare_dev, port);
> >> > +       of_node_put(port);
> >>
> >> There's no mention in your commit message about fixing these node leaks.
> >
> > Isn't that kind-of the whole point of this patch?
> >
> 
> Not according to the commit msg, it isn't.
> 
> You could have just done the of_node_put adds/relocations without
> wrapping component_match_add_release.

No, adding the of_node_put() there without the other changes means that
the OF layer can drop the "port" device node, kfree() it, and reallocate
it as a different device node - which means that we can end up matching
some random other device rather than the intended one.  Hence, it is
_fundamentally_ a part of this patch and isn't an independent change.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
