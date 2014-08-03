From: olof@lixom.net (Olof Johansson)
Date: Sat, 2 Aug 2014 20:31:48 -0700
Subject: [FIX][RESEND PATCH v3] ARM: EXYNOS: Fix suspend/resume sequences
In-Reply-To: <20140803032718.GB16641@quad.lixom.net>
References: <1406883097-14157-1-git-send-email-tomasz.figa@gmail.com>
 <1910401.THJm9YLBl0@amdc1032>
 <081101cfad93$8615d810$92418830$@samsung.com>
 <20140803032718.GB16641@quad.lixom.net>
Message-ID: <20140803033148.GA18838@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 02, 2014 at 08:27:18PM -0700, Olof Johansson wrote:
> On Fri, Aug 01, 2014 at 11:18:53PM +0900, Kukjin Kim wrote:
> > Bartlomiej Zolnierkiewicz wrote:
> > > 
> > > Hi,
> > > 
> > Hi,
> > 
> > > On Friday, August 01, 2014 10:51:37 AM Tomasz Figa wrote:
> > > > From: Tomasz Figa <t.figa@samsung.com>
> > > >
> > > > Due to recent consolidation of Exynos suspend and cpuidle code, some
> > > > parts of suspend and resume sequences are executed two times, once from
> > > > exynos_pm_syscore_ops and then from exynos_cpu_pm_notifier() and thus it
> > > > breaks suspend, at least on Exynos4-based boards. In addition, simple
> > > > core power down from a cpuidle driver could, in case of CPU 0 could
> > > > result in calling functions that are specific to suspend and deeper idle
> > > > states.
> > > >
> > > > This patch fixes the issue by moving those operations outside the CPU PM
> > > > notifier into suspend and AFTR code paths. This leads to a bit of code
> > > > duplication, but allows additional code simplification, so in the end
> > > > more code is removed than added.
> > > >
> > > > Fixes: 85f9f90808b4 ("ARM: EXYNOS: Use the cpu_pm notifier for pm")
> > > > Cc: Kukjin Kim <kgene.kim@samsung.com>
> > > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > > Cc: Olof Johansson <olof@lixom.net>
> > > > Cc: arm at kernel.org
> > > > Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> > > > ---
> > > >  arch/arm/mach-exynos/pm.c        | 164 ++++++++++++++++++---------------------
> > > >  drivers/cpuidle/cpuidle-exynos.c |  25 +-----
> > > >  2 files changed, 80 insertions(+), 109 deletions(-)
> > > >
> > > > This is resend of a regression fix sent more than two weeks ago (July, 15;
> > > > [1]), without any response from respective maintainers. It fixes
> > > > a significant regression breaking suspend/resume on Exynos4-based systems.
> > > >
> > > > I know we already have -rc7, but this patch in its first iteration was
> > > > sent more than a month ago (June, 24; [2]) and it changed only for
> > > > convenience of authors of further patches, to either avoid conflicts ([3])
> > > > or reduce the need of changes to support more functionality later (as
> > > > discussed in [4]). However it should have had priority over clean-up or
> > > > functional patches, which was apparently not the case.
> > > 
> > > This is not quite right, your initial version needed to be changed also
> > > because of potential problems (https://lkml.org/lkml/2014/7/15/206).
> > > 
> > Yeah...hmm...maybe it should be updated in 3.17...
> > 
> > > However the current version (from two weeks ago) is fine and IMO still
> > > should be merged as a _regression_ fix for v3.16 (despite not being
> > > a tiny patch).
> > > 
> > Agreed. OK.
> > 
> > > Also FWIW:
> > > 
> > > Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > > 
> > Acked-by: Kukjin Kim <kgene.kim@samsung.com>
> > 
> > @Olof,
> > 
> > It's true this is a regression for v3.16 and I couldn't take this before
> > because of some dependencies...so I'd like to ask you to take for v3.16 even
> > though it's late and big...
> 
> It's really, really late in the release cycle to pick this up now. I'm also
> travelling right now and have limited email access to handle fall-out. :(
> 
> I'll apply this to the fixes branch for 3.17 and mark it for stable instead.
> 
> Kukjin, seems like you're not testing suspend/resume yourself, since you
> haven't known about the regression and the fix. Can you please make sure that
> you have appropriate test coverage? Thanks!

Actually, this has a bunch of merge conflicts with the 3.17 material that's
queued up. ;(

Please send a tested patch that applies on top of the 3.17 branches
without a lot of conflicts.


-Olof
