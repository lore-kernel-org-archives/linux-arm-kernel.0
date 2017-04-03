From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Mon, 3 Apr 2017 11:31:34 +0100
Subject: [PATCH v2] drm: hdlcd: Fix the calculation of the scanout start
 address
In-Reply-To: <20170331134810.GA25244@n2100.armlinux.org.uk>
References: <20170222153036.GI31595@intel.com>
 <20170308163025.31098-1-Liviu.Dudau@arm.com>
 <20170331094937.GO7909@n2100.armlinux.org.uk>
 <20170331131830.GK13355@e110455-lin.cambridge.arm.com>
 <20170331134810.GA25244@n2100.armlinux.org.uk>
Message-ID: <20170403103133.GL13355@e110455-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 31, 2017 at 02:48:10PM +0100, Russell King - ARM Linux wrote:
> On Fri, Mar 31, 2017 at 02:18:31PM +0100, Liviu Dudau wrote:
> > On Fri, Mar 31, 2017 at 10:49:38AM +0100, Russell King - ARM Linux wrote:
> > > On Wed, Mar 08, 2017 at 04:30:25PM +0000, Liviu Dudau wrote:
> > > > The calculation of the framebuffer's start address was wrongly using
> > > > the CRTC's x and y position rather than the one of the source
> > > > framebuffer. To fix that we need to update the plane_check code to
> > > > call drm_plane_helper_check_state() to clip the src and dst coordinates.
> > > > While there so some minor cleanup of redundant freeing of
> > > > devm_alloc-ated memory.
> > > 
> > > The following series is what I came up with, although I've had no time
> > > to test it.
> > 
> > I'm afraid I'm going to NAK this series. It would've been nicer for you to
> > comment on the v2 patch that I have sent rather than going around and coming
> > back with effectively the same thing but split into 2 patches. I'm having
> > trouble applying your series to the v4.11-rc4 (specially 2/3). Also 3/3 is
> > superfluous, as we don't expose the DRM_ROTATE property to userspace.
> 
> Rather than throwing accusations, let's look at what happened.

No accusations were thrown, just explanations of my decision.

> 
> I reported the bug on 18th November 2016 - I quote:
> 
>    Something I also noticed is this:
> 
>         scanout_start = gem->paddr + plane->state->fb->offsets[0] +
>                 plane->state->crtc_y * plane->state->fb->pitches[0] +
>                 plane->state->crtc_x * bpp / 8;
> 
>    Surely this should be using src_[xy] (which are the position in the
>    source - iow, memory, and not crtc_[xy] which is the position on the
>    CRTC displayed window.  To put it another way, the src_* define the
>    region of the source material that is mapped onto a rectangular area
>    on the display defined by crtc_*.
> 
> This got ignored, and on 21st November, I came up with an initial patch
> to solve it at the time, but we were busy discussing the base address
> issue.

As I've replied to the 20th February email, I did not ignore it, just lost
track of it.

> 
> I sent a reminder on 20th February about it, and we discussed it, and I
> said at the time I did not have time to test your patch.  Ville commented
> on your patch, which confused me a little, but having worked it out, I
> reworked the patch from 21st November to fix that, creating this patch
> series.
> 
> I did not post it, because I hadn't tested it (since the Juno requires
> a long-winded way to update the kernel), so I never got around to
> testing this.  So, this series pre-dates your v2 patch by a good few
> weeks.

That information was privy to you and would've been nice to share with me.

> 
> You posted your v2 patch on March 8th, and I've not had a chance to
> test that, nor have I had a chance to test my own three patch series.
> 
> Today, I noticed that I still had the three patch series, so I thought
> I ought to get it out in the wild.

Hey, look, a clasic case of comedy of errors when people don't talk to each other!!!

Sorry, Russell, but I'm not inside your brain or your computer, so I don't know
intimately the history of things. Thanks for enlightening me but I also
read your story as a clear example why a small paragraph after the commit
log explaining why this series has been submitted would have gone a long
way clearing the fog.

> 
> Now, due to the amount of patches I carry:
> 
> $ git lg origin.. | wc -l
> 491
> 
> I work against Linus' tree _only_, so all patches I post are based on
> Linus' kernel, and not random other git trees.  I do not randomly fetch
> other git trees to base patches on them, because that would cause me
> insane merging issues so that I can test half the stuff I'm carrying.

I understand (to the best of my abilities) your position and the fact that
as a maintainer of a large subsystem you have a specific workflow that you
don't want to polute with minor exceptions. I would also ask you to understand
that not everyone works in the same way as you and that other maintainers
and other subsystems have different workflows and requirements. Having my
tree as part of the DRM subtree means that we work mostly on the recent
Linus' -rc up until about -rc4 and the quickly switch to linux-next. So one
way of approaching this is to drop the arch/arm frame of thought when
contributing to other trees and adopt their workflow (you know, the "when
in Rome, do what romans do" attitude). The other way is to go to different
maintainers and ask for special status and tell them that their puny drivers
and tree don't matter that much compared to your mighty workflow and they
should all bend to your greatness (the "all your bases belong to us" mindset).

> 
> Now, it's true that they're not against -rc, but are currently against
> 4.10 - it seems that I missed rebasing _this_ particular branch to
> 4.11-rc yet, although most of my other branches are.

And how would you have handled this situation? Another maintainer sending
you a patchset based on an older tree that doesn't match your currently
published one? Would you have gone to the trouble of rebasing their work,
or ask them do get back to you with a better series?

> 
> What was I so busy with when you posted your patch on the 8th March?
> Oh yes, that was the week _after_ the merge window closed, and was the
> week I was doing the mass rebase of about 500 patches.

I've seen people sending emails (not while they are busy, 8th March was 3
weeks prior to this whole thread) saying "I'm still interested in this, I
will test it when I get a chance". Or something more personal, like "I
already had something in my tree, if I don't get around testing your
patch then I will publish mine based on an old tree, so be prepared"

> 
> Sorry I didn't get around to testing your patch, and sorry for eventually
> getting around to posting my patches.  Obviously, I should just fuck off
> and do something else.

Please don't! I am happy that you show interest in this driver and you help
me improve it, and I do not wish to repeat the current conflict in the future.
I'm just hoping that we can improve the flow of information between us and
give you more peace of mind.

Best regards,
Liviu


> 
> -- 
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> according to speedtest.net.

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
