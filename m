From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Thu, 12 Dec 2013 10:53:52 +0100
Subject: [PATCH 1/5] clk: samsung: exynos5250: Add CLK_IGNORE_UNUSED flag
 for the sysreg clock
In-Reply-To: <CAM4voanSSqqAzRqrNrRc+HYh4vtq3zgNeGQYCVG6sE6nB_eWGA@mail.gmail.com>
References: <1386763029-8516-1-git-send-email-a.kesavan@samsung.com>
 <CAD=FV=XG+5n+SW_bDiFtQB7ieViAxVAO5E12+y-DgY34maT6DQ@mail.gmail.com>
 <CAM4voanSSqqAzRqrNrRc+HYh4vtq3zgNeGQYCVG6sE6nB_eWGA@mail.gmail.com>
Message-ID: <57785646.ACHYxksEZV@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 12 of December 2013 10:06:36 Abhilash Kesavan wrote:
> Hi Tomasz and Doug,
> 
> Thanks for the review.
> On Thu, Dec 12, 2013 at 6:00 AM, Doug Anderson <dianders@chromium.org> wrote:
> > Tomasz,
> >
> > On Wed, Dec 11, 2013 at 4:13 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
[snip]
> >> Still, I discussed about such cases as this with Sylwester a bit today and
> >> maybe a bit different approach would be better. There is a number of clocks
> >> that need to be always on, such as PMU (but also a lot of currently undefined
> >> ones). IMHO it would be nice to make sure they are enabled at boot time
> >> and do one of following:
> >> 1) claim and enable them directly from the clock controller driver
> >> 2) define them with CLK_IGNORE_UNUSED flag and enable them directly from
> >>    the clock controller driver (without increasing the refcount, so users could
> >>    possibly disable them later),
> >> 3) add a generic flag, such as CLK_BOOT_ENABLE (or something), that would
> >>    make the CCF enable such clock at bootup (in addition to implying
> >>    CLK_IGNORE_UNUSED).
> >>
> >> For me, the most sensible option would be 2) as it doesn't bloat the CCF with
> >> yet another flag and doesn't encourage people to leave clocks always on
> >> just because of laziness stopping them from implementing proper clock
> >> support in drivers.
> >
> > Right, we're using #2 for this now, but one problem is that it's
> > possible that the firmware may turn off one of these misc-type clocks.
> >  On exynos5250-snow we ran into this.  The firmware actually gates the
> > clock needed for accessing the chip_id, though perhaps that's not one
> > of the clocks that needs to be on all the time.
> 
> Yes, If the firmware gates sysreg then we should see failures at
> boot-up or later.
> Is this patch OK for now ? How would you guys like me to proceed on this ?

Yes, as I wrote in my original reply, for now your patch is fine as we
don't have the infrastructure for handling such clocks in a stricter
way yet.

Best regards,
Tomasz
