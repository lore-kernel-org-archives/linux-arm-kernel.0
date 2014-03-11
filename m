From: steve.capper@linaro.org (Steve Capper)
Date: Tue, 11 Mar 2014 10:14:52 +0000
Subject: [RFC PATCH V2 4/4] arm64: mm: implement get_user_pages_fast
In-Reply-To: <20140211154859.GG3748@arm.com>
References: <1391703531-12845-1-git-send-email-steve.capper@linaro.org>
 <1391703531-12845-5-git-send-email-steve.capper@linaro.org>
 <20140211154859.GG3748@arm.com>
Message-ID: <20140311101451.GA3660@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 11, 2014 at 03:48:59PM +0000, Catalin Marinas wrote:
> On Thu, Feb 06, 2014 at 04:18:51PM +0000, Steve Capper wrote:
> > An implementation of get_user_pages_fast for arm64. It is based on the
> > arm implementation (it has the added ability to walk huge puds) which
> > is loosely on the PowerPC implementation. We disable interrupts in the
> > walker to prevent the call_rcu_sched pagetable freeing code from
> > running under us.
> > 
> > We also explicitly fire an IPI in the Transparent HugePage splitting
> > case to prevent splits from interfering with the fast_gup walker.
> > As THP splits are relatively rare, this should not have a noticable
> > overhead.
> > 
> > Signed-off-by: Steve Capper <steve.capper@linaro.org>
> > ---
> >  arch/arm64/include/asm/pgtable.h |   4 +
> >  arch/arm64/mm/Makefile           |   2 +-
> >  arch/arm64/mm/gup.c              | 297 +++++++++++++++++++++++++++++++++++++++
> 
> Why don't you make a generic gup.c implementation and let architectures
> select it? I don't see much arm64-specific code in here.

Hi Catalin,
I've had a stab at generalising the gup, but I've found that it varies
too much between architectures to make this practical for me:
 * x86 blocks on TLB invalidate so does not need the speculative page
   cache logic. Also x86 does not have 64-bit single-copy atomicity for
   pte reads, so needs a work around.
 * mips is similar-ish to x86.
 * powerpc has extra is_hugepd codepaths to identify huge pages.
 * superh has sub-architecture pte flags and no 64-bit single-copy
   atomicity.
 * sparc has hypervisor tlb logic for the pte flags.
 * s390 has extra pmd derefence logic and extra barriers that I do not
   quite understand.

My plan was to introduce pte_special(.) for arm with LPAE, add
pte_special logic to fast_gup and share the fast_gup between arm and
arm64.

Does this approach sound reasonable?

Thanks,
-- 
Steve
