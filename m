From: bpicco@meloft.net (Bob Picco)
Date: Tue, 19 Dec 2017 12:41:30 -0500
Subject: [PATCH 00/10] arm64: 52-bit physical address support
In-Reply-To: <ec1d1613-0005-3a5d-f623-837c743e683d@arm.com>
References: <1513184845-8711-1-git-send-email-kristina.martsenko@arm.com>
 <20171214175259.GA4219@zareason>
 <ec1d1613-0005-3a5d-f623-837c743e683d@arm.com>
Message-ID: <20171219174130.GA4759@zareason>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kristina Martsenko wrote:	[Tue Dec 19 2017, 12:15:46PM EST]
> On 14/12/17 17:52, Bob Picco wrote:
> > Kristina Martsenko wrote:	[Wed Dec 13 2017, 12:07:15PM EST]
> >> Hi,
> >>
> >> This series adds 52-bit physical address space support to arm64, up from
> >> the current 48 bits. This is an ARMv8.2 feature (ARMv8.2-LPA).
> >>
> >> The series is based on 4.15-rc3. It has been lightly tested on an ARM
> >> Fast Model. There's still some cases and areas to think through, as well
> >> as more testing to do.
> >>
> >> Patches for SMMU 52-bit PA support have been sent separately [1]. A GIC
> >> ITS patch has already been merged [2]. ARMv8.2 also allows 52-bit IPA,
> >> but support for that is not part of this series.
> >>
> >> This version mostly addresses various review comments received.
> >>
> >> Changes from RFC:
> >>  - Split kconfig symbol into two patches, to enable 52-bit PA at the end
> >>  - Patch #3: Changed phys_to_ttbr to use a macro, added an #include
> >>  - Patch #4: Changed phys_to_pte to use a macro
> >>  - Patch #6: Replaced __phys_to_pte with __phys_to_pte_val (same for
> >>    pmd/pud/pgd)
> >>  - Patch #6: Changed __phys_to_pte_val, __pte_to_phys, and
> >>    pgtable-hwdef.h macros
> >>  - Patches #5, #6: Removed kvm_extended_idmap_pgd, inlined its code,
> >>    moved the comment
> >>  - Patch #5: Added pfn_pud definition (to make the kernel build on that
> >>    commit)
> >>
> >> Thanks,
> >> Kristina
> >>
> >> [1] https://www.spinics.net/lists/arm-kernel/msg619040.html
> >> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=30ae9610d275f8f03f5bf7612ce71d8af6fc400b
> >>
> >>
> >> Kristina Martsenko (10):
> >>   arm64: add kconfig symbol to configure physical address size
> >>   arm64: limit PA size to supported range
> >>   arm64: handle 52-bit addresses in TTBR
> >>   arm64: head.S: handle 52-bit PAs in PTEs in early page table setup
> >>   arm64: don't open code page table entry creation
> >>   arm64: handle 52-bit physical addresses in page table entries
> >>   arm64: increase PHYS_MASK to 52 bits
> >>   arm64: increase sparsemem MAX_PHYSMEM_BITS to 52
> >>   arm64: allow ID map to be extended to 52 bits
> >>   arm64: enable 52-bit physical address support
> >>
> >>  arch/arm/include/asm/kvm_mmu.h         |   7 ++
> >>  arch/arm64/Kconfig                     |  29 ++++++++
> >>  arch/arm64/include/asm/assembler.h     |  31 ++++++++-
> >>  arch/arm64/include/asm/kvm_mmu.h       |  21 +++++-
> >>  arch/arm64/include/asm/mmu_context.h   |  16 ++++-
> >>  arch/arm64/include/asm/pgalloc.h       |   6 +-
> >>  arch/arm64/include/asm/pgtable-hwdef.h |  19 +++++-
> >>  arch/arm64/include/asm/pgtable.h       |  53 ++++++++++++---
> >>  arch/arm64/include/asm/sparsemem.h     |   2 +-
> >>  arch/arm64/include/asm/sysreg.h        |   8 +++
> >>  arch/arm64/kernel/head.S               | 118 +++++++++++++++++++++------------
> >>  arch/arm64/kernel/hibernate-asm.S      |  12 ++--
> >>  arch/arm64/kernel/hibernate.c          |   5 +-
> >>  arch/arm64/kvm/hyp-init.S              |  26 ++++----
> >>  arch/arm64/kvm/hyp/s2-setup.c          |   2 +
> >>  arch/arm64/mm/mmu.c                    |  15 +++--
> >>  arch/arm64/mm/pgd.c                    |   8 +++
> >>  arch/arm64/mm/proc.S                   |  19 +++---
> >>  virt/kvm/arm/arm.c                     |   2 +-
> >>  virt/kvm/arm/mmu.c                     |  12 ++--
> >>  20 files changed, 302 insertions(+), 109 deletions(-)
> >>
> >> -- 
> >> 2.1.4
> > Hi Kristina,
> > 
> > I boot tested but on VM and had a couple issues. I will examine and share
> > should the issues be of value.
> > Tested-by: Bob Picco <bob.picco@oracle.com>
> 
> Thanks for testing! I assume it was on a VM with less than 52 bits of
> PA? In any case, let me know if you find any issues.
Hi Kristina,

Yes it was substantially less than 52b PA. I was surprised we booted.
> 
> > I reviewed and thank you. Your effort caused me to return to some code
> > examined/learned during the last few months.
> > Reviewed-by: Bob Picco <bob.picco@oracle.com>
> 
> Thanks for reviewing! Hope it was useful.
You are welcome. Well I had to commence at some point. I happened to review
most of boot up two months ago. Your effort caused me to return and review
more... A few more iterations before being reasonably solid.

bob
> 
> Kristina
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
