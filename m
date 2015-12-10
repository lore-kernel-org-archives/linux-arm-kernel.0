From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 10 Dec 2015 11:34:47 +0000
Subject: [PATCH 0/2] arm64: Non-racy PTE setting in the presence of HW
 AF/DBM
In-Reply-To: <CACVXFVPaAUWMPgrinF7pO1h6Lwx8e64ijCkEs3aMYsN99ez8Eg@mail.gmail.com>
References: <1449682017-23729-1-git-send-email-catalin.marinas@arm.com>
 <CACVXFVPaAUWMPgrinF7pO1h6Lwx8e64ijCkEs3aMYsN99ez8Eg@mail.gmail.com>
Message-ID: <20151210113446.GF26759@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 10, 2015 at 11:11:26AM +0800, Ming Lei wrote:
> On Thu, Dec 10, 2015 at 1:26 AM, Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> > This series addresses a potentially racy default implementation of
> > ptep_set_access_flags() when hardware update of the access or dirty
> > states is enabled. The first patch is some clean-up in set_pte_at() to
> > improve the information reporting and replace BUG with WARN. The second
> > patch contains the arm64-specific ptep_set_access_flags()
> > implementation.
> >
> > Possible racy scenarios are described in patch 2. I think this series
> > could be simplified on the following assumptions:
> >
> > a) if the CPUs do not support HW AF/DBM or it is disabled, no other
> >    agent in the system will perform such updates
> >
> > b) if one CPU supports HW AF/DBM, all of them must do (don't mix such
> >    features)
> >
> > Point (a) means that the current code works fine and BUG_ON() is not
> > necessary.
> >
> > Point (b) however requires a ptep_set_access_flags() similar to the x86
> > one, i.e. only do the setting if (changed && dirty), otherwise let the
> > hardware handle the updates.
> >
> > Anyway, while patch 2 is still debatable, I'd like to merge the first
> > patch in 4.4 to avoid an unnecessary BUG_ON on hardware that doesn't
> > even do DBM.
> >
> > Catalin
> >
> >
> > Catalin Marinas (2):
> >   arm64: Improve error reporting on set_pte_at() checks
> >   arm64: Implement ptep_set_access_flags() for hardware AF/DBM
> >
> >  arch/arm64/include/asm/pgtable.h | 16 ++++++++---
> >  arch/arm64/mm/fault.c            | 57 ++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 69 insertions(+), 4 deletions(-)
> >
> 
> With the two patches, looks no BUG is triggered any more, and just
> with the following warning:
> 
> [   98.303645] set_pte_at: racy access flag clearing: 00e80040db000b51
> -> 00e80040db000b50
> [   98.303660] ------------[ cut here ]------------
> [   98.303666] WARNING: at ./arch/arm64/include/asm/pgtable.h:282
> [   98.303669] Modules linked in:
> 
> [   98.303679] CPU: 2 PID: 2445 Comm: stress-ng-minco Tainted: G
>  W       4.4.0-rc3-next-20151203+ #65
> [   98.303683] Hardware name: AppliedMicro Mustang/Mustang, BIOS 2.0.0
> Oct 23 2015
> [   98.303686] task: ffffffc7c0caad00 ti: ffffffc7c0d10000 task.ti:
> ffffffc7c0d10000
> [   98.303696] PC is at pmdp_invalidate+0x104/0x11c

I triggered the pmdp_invalidate() warning as well last night. The
change here is safe, it's just some assumptions that
split_huge_page_to_list() makes. It always marks the resulting PTEs as
dirty, so we don't care about the race. I added this fix-up to the first
patch:

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 002dc61a4dff..88c21c6a40fd 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -276,7 +276,8 @@ static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
 	 * hardware updates of the pte (ptep_set_access_flags safely changes
 	 * valid ptes without going through an invalid entry).
 	 */
-	if (IS_ENABLED(CONFIG_ARM64_HW_AFDBM) && pte_valid(*ptep)) {
+	if (IS_ENABLED(CONFIG_ARM64_HW_AFDBM) &&
+	    pte_valid(*ptep) && pte_valid(pte)) {
 		VM_WARN_ONCE(!pte_young(pte),
 			     "%s: racy access flag clearing: %016llx -> %016llx",
 			     __func__, pte_val(*ptep), pte_val(pte));

-- 
Catalin
