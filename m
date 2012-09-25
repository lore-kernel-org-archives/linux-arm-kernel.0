From: t-kristo@ti.com (Tero Kristo)
Date: Tue, 25 Sep 2012 17:17:56 +0300
Subject: [PATCHv5 00/10] ARM: OMAP: PM usecounting changes
In-Reply-To: <5061A22B.1030603@ti.com>
References: <1348565565-14744-1-git-send-email-t-kristo@ti.com>
 <506186E9.7070908@ti.com> <1348574001.10702.291.camel@sokoban>
 <5061A22B.1030603@ti.com>
Message-ID: <1348582676.10702.302.camel@sokoban>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-09-25 at 17:53 +0530, Rajendra Nayak wrote:
> On Tuesday 25 September 2012 05:23 PM, Tero Kristo wrote:
> > On Tue, 2012-09-25 at 15:56 +0530, Rajendra Nayak wrote:
> >> Hi Tero,
> >>
> >> On Tuesday 25 September 2012 03:02 PM, Tero Kristo wrote:
> >>> Hi,
> >>>
> >>> Changes compared to previous version:
> >>
> >> Did you get a chance to look at the issue I reported about autodeps?
> >> http://www.mail-archive.com/linux-omap at vger.kernel.org/msg72876.html
> >
> > Not really, I didn't think that bug report was meant for me, I kind of
> > thought it only happened with your set. But now looking at your email in
> > detail, I guess you are saying there is a bug in this code (the one that
> > touches iclk stuff), which causes the USB / DSS domains to follow
> > MPU/CORE, is that right?
> 
> Yes, basically the autodeps remain set, even while the module is not in
> use at all, which causes them to come in and out of sleep along with MPU.

Actually I think I accidentally fixed this problem with the latest rev,
due to the fact that I am using generic clkdm_clk_enable / disable calls
from iclk now.

I also just tested this (while fixing the complaint from Russell), and
it looks like both USB and DSS pwrdms are remaining nicely idle on
OMAP3.

-Tero

> 
> >
> > -Tero
> >
> >>
> >> regards,
> >> Rajendra
> >>
> >>>
> >>> - Fixed OMAP4 support (patches 7-10)
> >>> - Dropped debugging support from this set for now
> >>> - Rebased on top of 3.6-rc5 + func-pwrst + omap4-ret code
> >>>     (omap4 support easier to test with these)
> >>> - Patch #1:
> >>>     * dropped clkdm_usecount_inc / clkdm_usecount_dec APIs
> >>>     * clkdm_clk_enable / disable are used now instead
> >>>     * some code ordering changed for the new setup to work properly
> >>>     * changed BUG_ON calls to WARN_ON
> >>> - Patch #2:
> >>>     * added spinlock for protecting voltdm callbacks
> >>>     * pwrdm lock extended to protect pwrdm callbacks
> >>> - Patch #3:
> >>>     * dropped generic API call for the cpu pwrdm idle / wakeup
> >>>     * instead use pwrdm_clkdm_enable / disable calls directly from PM code
> >>>     * omap4 support fixed to work properly with SMP, added omap4 specific
> >>>       CPU pwrdm idle / wakeup calls for this purpose
> >>> - Patch #4:
> >>>     * no changes
> >>>     * added 'Reviewed-by' tag for Rajendra
> >>> - Patch #5:
> >>>     * no changes, just rebase
> >>> - Patch #6:
> >>>     * no changes
> >>>
> >>> Tested with OMAP3 beagle, omap4460 GP panda + omap4430 EMU blaze boards.
> >>>
> >>> I will be posting new versions for the voltdm fixes + auto retention +
> >>> panda board tps6236x support code later on today, which are based on top
> >>> of this set.
> >>>
> >>> Branch also available here:
> >>>
> >>> git://gitorious.org/~kristo/omap-pm/omap-pm-work.git
> >>> branch: mainline-3.6-rc5-pwrdm-changes-v5
> >>>
> >>> -Tero
> >>>
> >>>
> >>> --
> >>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> >>> the body of a message to majordomo at vger.kernel.org
> >>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>>
> >>
> >
> >
> 
