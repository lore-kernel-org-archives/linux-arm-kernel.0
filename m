From: will.deacon@arm.com (Will Deacon)
Date: Tue, 15 Apr 2014 13:41:00 +0100
Subject: [PATCH v2] ARM: perf: save/restore pmu registers in pm notifier
In-Reply-To: <175CCF5F49938B4D99B2E3EF7F558EBE55075F1873@SC-VEXCH4.marvell.com>
References: <1397439742-28337-1-git-send-email-zhangwm@marvell.com>
 <20140415084749.GG17408@arm.com>
 <175CCF5F49938B4D99B2E3EF7F558EBE55075F1873@SC-VEXCH4.marvell.com>
Message-ID: <20140415124100.GK17408@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 15, 2014 at 01:37:17PM +0100, Neil Zhang wrote:
> > On Mon, Apr 14, 2014 at 02:42:22AM +0100, Neil Zhang wrote:
> > > From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> > >
> > > This adds core support for saving and restoring CPU PMU registers for
> > > suspend/resume support i.e. deeper C-states in cpuidle terms.
> > > This patch adds support only to ARMv7 PMU registers save/restore.
> > > It needs to be extended to xscale and ARMv6 if needed.
> > >
> > > [Neil] We found that DS-5 not work on our CA7 based SoCs.
> > > After debuging, found PMU registers were lost because of core power down.
> > > Then i found Sudeep had a patch to fix it about two years ago but not
> > > in the mainline, just port it.
> > 
> > What I don't like about this patch is that we're introducing significant
> > overhead for SoCs that don't require save/restore of the PMU state. I'd much
> > rather see core power down disabled whilst the PMU is in use but, if that's not
> > possible, then I think we need to:
> > 
> >  (1) Make this conditional for cores that really need it
> > 
> >  (2) Only save/restore if the PMU is in use (even better, just save/restore
> >      the live registers, but that's probably not worth the effort
> >      initially).
> > 
> 
> The patch has check the ARMV7_PMNC_E bit when save / restore, 
> so suppose only the core's that use PMU will do the save / restore work.

Seems pretty fragile to base our save/restore decision on the value of one
of the registers, though. What happens if the control register is zeroed by
the core power down?

Will
