From: steve.capper@linaro.org (Steve Capper)
Date: Fri, 22 Aug 2014 09:11:47 +0100
Subject: [PATH V2 0/6] RCU get_user_pages_fast and __get_user_pages_fast
In-Reply-To: <CALdTtnuuZBNGR5Ti3PsN3BdA=FQ7ErYuyHMsiSp_5TD-U0n2Lg@mail.gmail.com>
References: <1408635812-31584-1-git-send-email-steve.capper@linaro.org>
 <CALdTtnuuZBNGR5Ti3PsN3BdA=FQ7ErYuyHMsiSp_5TD-U0n2Lg@mail.gmail.com>
Message-ID: <20140822081146.GA23364@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 21, 2014 at 02:42:29PM -0600, Dann Frazier wrote:
> On Thu, Aug 21, 2014 at 9:43 AM, Steve Capper <steve.capper@linaro.org> wrote:
> > Hello,
> > This series implements general forms of get_user_pages_fast and
> > __get_user_pages_fast and activates them for arm and arm64.
> >
> > These are required for Transparent HugePages to function correctly, as
> > a futex on a THP tail will otherwise result in an infinite loop (due to
> > the core implementation of __get_user_pages_fast always returning 0).
> >
> > Unfortunately, a futex on THP tail can be quite common for certain
> > workloads; thus THP is unreliable without a __get_user_pages_fast
> > implementation.
> >
> > This series may also be beneficial for direct-IO heavy workloads and
> > certain KVM workloads.
> >
> > Changes since PATCH V1 are:
> >  * Rebase to 3.17-rc1
> >  * Switched to kick_all_cpus_sync as suggested by Mark Rutland.
> >
> > The main changes since RFC V5 are:
> >  * Rebased against 3.16-rc1.
> >  * pmd_present no longer tested for by gup_huge_pmd and gup_huge_pud,
> >    because the entry must be present for these leaf functions to be
> >    called.
> >  * Rather than assume puds can be re-cast as pmds, a separate
> >    function pud_write is instead used by the core gup.
> >  * ARM activation logic changed, now it will only activate
> >    RCU_TABLE_FREE and RCU_GUP when running with LPAE.
> >
> > The main changes since RFC V4 are:
> >  * corrected the arm64 logic so it now correctly rcu-frees page
> >    table backing pages.
> >  * rcu free logic relaxed for pre-ARMv7 ARM as we need an IPI to
> >    invalidate TLBs anyway.
> >  * rebased to 3.15-rc3 (some minor changes were needed to allow it to merge).
> >  * dropped Catalin's mmu_gather patch as that's been merged already.
> >
> > This series has been tested with LTP mm tests and some custom futex tests
> > that exacerbate the futex on THP tail case; on both an Arndale board and
> > a Juno board. Also debug counters were temporarily employed to ensure that
> > the RCU_TABLE_FREE logic was behaving as expected.
> >
> > I would really appreciate any comments (especially on the validity or
> > otherwise of the core fast_gup implementation) and testers.
> 
> Continues to gets rid of my gccgo hang issue w/ THP.
> 
> Tested-by: dann frazier <dann.frazier@canonical.com>
> 

Thanks Dann,
I've added your Tested-by to the mm and two arm64 patches.

Cheers,
-- 
Steve
