From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 31 Mar 2017 14:48:10 +0100
Subject: [PATCH v2] drm: hdlcd: Fix the calculation of the scanout start
 address
In-Reply-To: <20170331131830.GK13355@e110455-lin.cambridge.arm.com>
References: <20170222153036.GI31595@intel.com>
 <20170308163025.31098-1-Liviu.Dudau@arm.com>
 <20170331094937.GO7909@n2100.armlinux.org.uk>
 <20170331131830.GK13355@e110455-lin.cambridge.arm.com>
Message-ID: <20170331134810.GA25244@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 31, 2017 at 02:18:31PM +0100, Liviu Dudau wrote:
> On Fri, Mar 31, 2017 at 10:49:38AM +0100, Russell King - ARM Linux wrote:
> > On Wed, Mar 08, 2017 at 04:30:25PM +0000, Liviu Dudau wrote:
> > > The calculation of the framebuffer's start address was wrongly using
> > > the CRTC's x and y position rather than the one of the source
> > > framebuffer. To fix that we need to update the plane_check code to
> > > call drm_plane_helper_check_state() to clip the src and dst coordinates.
> > > While there so some minor cleanup of redundant freeing of
> > > devm_alloc-ated memory.
> > 
> > The following series is what I came up with, although I've had no time
> > to test it.
> 
> I'm afraid I'm going to NAK this series. It would've been nicer for you to
> comment on the v2 patch that I have sent rather than going around and coming
> back with effectively the same thing but split into 2 patches. I'm having
> trouble applying your series to the v4.11-rc4 (specially 2/3). Also 3/3 is
> superfluous, as we don't expose the DRM_ROTATE property to userspace.

Rather than throwing accusations, let's look at what happened.

I reported the bug on 18th November 2016 - I quote:

   Something I also noticed is this:

        scanout_start = gem->paddr + plane->state->fb->offsets[0] +
                plane->state->crtc_y * plane->state->fb->pitches[0] +
                plane->state->crtc_x * bpp / 8;

   Surely this should be using src_[xy] (which are the position in the
   source - iow, memory, and not crtc_[xy] which is the position on the
   CRTC displayed window.  To put it another way, the src_* define the
   region of the source material that is mapped onto a rectangular area
   on the display defined by crtc_*.

This got ignored, and on 21st November, I came up with an initial patch
to solve it at the time, but we were busy discussing the base address
issue.

I sent a reminder on 20th February about it, and we discussed it, and I
said at the time I did not have time to test your patch.  Ville commented
on your patch, which confused me a little, but having worked it out, I
reworked the patch from 21st November to fix that, creating this patch
series.

I did not post it, because I hadn't tested it (since the Juno requires
a long-winded way to update the kernel), so I never got around to
testing this.  So, this series pre-dates your v2 patch by a good few
weeks.

You posted your v2 patch on March 8th, and I've not had a chance to
test that, nor have I had a chance to test my own three patch series.

Today, I noticed that I still had the three patch series, so I thought
I ought to get it out in the wild.

Now, due to the amount of patches I carry:

$ git lg origin.. | wc -l
491

I work against Linus' tree _only_, so all patches I post are based on
Linus' kernel, and not random other git trees.  I do not randomly fetch
other git trees to base patches on them, because that would cause me
insane merging issues so that I can test half the stuff I'm carrying.

Now, it's true that they're not against -rc, but are currently against
4.10 - it seems that I missed rebasing _this_ particular branch to
4.11-rc yet, although most of my other branches are.

What was I so busy with when you posted your patch on the 8th March?
Oh yes, that was the week _after_ the merge window closed, and was the
week I was doing the mass rebase of about 500 patches.

Sorry I didn't get around to testing your patch, and sorry for eventually
getting around to posting my patches.  Obviously, I should just fuck off
and do something else.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
