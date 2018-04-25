From: will.deacon@arm.com (Will Deacon)
Date: Wed, 25 Apr 2018 17:37:45 +0100
Subject: [PATCH] arm64: mm: Fix false positives in W+X checking
In-Reply-To: <3a105d2c-19b8-11fc-88d3-2da4fa846296@codeaurora.org>
References: <1524665611-14040-1-git-send-email-jhugo@codeaurora.org>
 <20180425150353.GG8383@arm.com>
 <381aee7b-9caa-b16b-3f5e-a47737405c03@codeaurora.org>
 <CAGXu5j+WhNdY09s_tPQ-BKqEqi_bbbp8XnRSnoGTN-HOPSJFPQ@mail.gmail.com>
 <3a105d2c-19b8-11fc-88d3-2da4fa846296@codeaurora.org>
Message-ID: <20180425163745.GJ8383@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 25, 2018 at 10:36:25AM -0600, Jeffrey Hugo wrote:
> On 4/25/2018 10:23 AM, Kees Cook wrote:
> >On Wed, Apr 25, 2018 at 8:12 AM, Jeffrey Hugo <jhugo@codeaurora.org> wrote:
> >>On 4/25/2018 9:03 AM, Will Deacon wrote:
> >>>On Wed, Apr 25, 2018 at 08:13:31AM -0600, Jeffrey Hugo wrote:
> >>>>diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> >>>>index 2dbb2c9..40d45fd 100644
> >>>>--- a/arch/arm64/mm/mmu.c
> >>>>+++ b/arch/arm64/mm/mmu.c
> >>>>@@ -503,6 +503,12 @@ void mark_rodata_ro(void)
> >>>>         update_mapping_prot(__pa_symbol(__start_rodata), (unsigned
> >>>>long)__start_rodata,
> >>>>                             section_size, PAGE_KERNEL_RO);
> >>>>   +     /*
> >>>>+        * load_module() results in W+X mappings, which are cleaned up
> >>>>with
> >>>>+        * call_rcu_sched().  Let's make sure that queued work is flushed
> >>>>so
> >>>>+        * that we don't hit false positives.
> >>>>+        */
> >>>>+       rcu_barrier_sched();
> >>>>         debug_checkwx();
> >>>>   }
> >>>
> >>>
> >>>Whilst this looks correct to me, it looks to me like other architectures
> >>>(e.g. x86) would be affected by this problem as well. Perhaps it would be
> >>>better to solve it in the core code before invoking mark_rodata_ro, or is
> >>>there some reason that we only run into this on arm64?
> >>>
> >>
> >>Thanks for the review.
> >>
> >>I was actually pondering pushing this into ptdump_check_wx() so that the
> >>"barrier" hit is only observed with CONFIG_DEBUG_WX.
> >>
> >>I agree, in principal this is not an arm64 specific issue.  I do not have
> >>sufficient equipment to validate other architectures.  On QDF2400, the
> >>reproduction rate is very low, roughly 1-3 instances in 2000-3000 reboots.
> >>I do have a system simulator which happens to repro the issue 100% of the
> >>time, which is what I used to debug and test this fix, before applying it to
> >>QDF2400.
> >>
> >>I'm waffling.  I see the benefit of fixing this in common code, but the
> >>"core" functionality of mark_rodata_ro doesn't need this barrier...
> >>
> >>I suppose I can push it up to core code, and see what the rest of the
> >>community says.  Is that what you recommend?
> >
> >I think fixing this in the general case makes sense.
> 
> Ok.  I'll give it until Monday to see if Laura has any insights into x86,
> and then spin a v2.

Thanks, Jeffrey.

Will
