From: jonathan.austin@arm.com (Jonathan Austin)
Date: Mon, 17 Jun 2013 16:25:13 +0100
Subject: [GIT PULL] nommu-fixes, r7 and MPU support for 3.11
In-Reply-To: <20130617131927.GE2718@n2100.arm.linux.org.uk>
References: <51B232CA.9060700@arm.com> <51B27207.8060208@arm.com>
 <20130617131927.GE2718@n2100.arm.linux.org.uk>
Message-ID: <51BF2A59.6070400@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

(Adding Will to Cc as some of this covers one of his patches)

On 17/06/13 14:19, Russell King - ARM Linux wrote:
> On Sat, Jun 08, 2013 at 12:51:35AM +0100, Jonathan Austin wrote:
>> This is rebased (and re-tested) on your devel-stable branch because
>> otherwise there were going to be conflicts with Uwe's V7M work now that
>> you've merged that. I've included the fix for limiting MPU to CPU_V7.
> 
> It looks like you have some rebasing errors:
> 
> In your 75709659007e7c33153129082bd85dfb74427078:
> 
> @@ -1414,7 +1414,8 @@ config SMP
>          depends on CPU_V6K || CPU_V7
>          depends on GENERIC_CLOCKEVENTS
>          depends on HAVE_SMP
> -       depends on MMU
> +       depends on MMU || ARM_MPU
> +       select HAVE_ARM_SCU if !ARCH_MSM_SCORPIONMP
> 
> Yet, 4c3ffffdbca2e6f6f5125fa7b149d87a13f92c94 (ARM: Push selects for TWD/SCU into
> machine entries), that select was removed because it was moved elsewhere:
> 

Thanks - that's a rebase error on my part, sorry.

As this one is trivial I've pushed a v2 branch (ja-nommu-for-rmk-v2) with just this
fixed (ie I fixed up that patch). There's a properly formatted pull request at the
end of this mail.

The other two comments are addressed below...

> @@ -1400,7 +1402,6 @@ config SMP
>          depends on GENERIC_CLOCKEVENTS
>          depends on HAVE_SMP
>          depends on MMU
> -       select HAVE_ARM_SCU if !ARCH_MSM_SCORPIONMP
> 
> In arch/arm/include/asm/tlbflush.h:
> 
> +static inline void local_flush_tlb_all(void)                                                                  { }
> 
> Yes, the lines are really that long - needlessly.  What's wrong with:
> 
> +static inline void local_flush_tlb_all(void)
> +{
> +}
> 

Will is the author of this patch (and is away today). From memory this
formatting was intentional in and attempt to keep the location of the
"{ }"s for all the "local_flush_tlb_* operations in the same column for
tidiness - local_flush_tlb_range() seems to be the one dictating the
longer length there.

There's a later patch from me that follows that style when adding
local_flush_bp_all() too, so if you really want to change this then I
will modify that additional patch too.

Applying your suggested format (and optimistically assuming what you see
is not mangled by our mail servers) I would end up with:

----
static inline void local_flush_tlb_all(void)
{
}
static inline void local_flush_tlb_mm(struct mm_struct *mm)
{
}
static inline void local_flush_tlb_page(struct vm_area_struct *vma, unsigned long uaddr)
{
}
static inline void local_flush_tlb_kernel_page(unsigned long kaddr)
{
}
static inline void local_flush_tlb_range(struct vm_area_struct *vma, unsigned long start, unsigned long end)
{
}
static inline void local_flush_tlb_kernel_range(unsigned long start, unsigned long end)
{
}
static inline void local_flush_bp_all(void)
{
}
---

which to me looks kinda chunky - but there *are* fewer long lines now... 

> ?
> 
> +               if ((cpsr & MODE32_BIT) && !IS_ENABLED(CONFIG_ARM_MPU)) {
>                          /*
>                           * 32-bit code can use the new high-page
> -                        * signal return code support.
> +                        * signal return code support except when the MPU has
> +                        * protected the vectors page from PL0
> 
> Note that this means you can't support NX, because you need your stack to
> be executable. 

Yea, this is a downside I was aware of an am I'm prepared to deal with for now,
especially as we don't have plans to extend the MPU support to cover individual
parts of userspace processes. If someone wanted to implement that level of
fine-grained MPU control then making the vectors protection sophisticated enough
to remove this restriction is just a small part of that job...

> You need to ensure that arm_elf_read_implies_exec()
> returns appropriately for MPU (it needs to return 1 for MPU.)
> 

This requirement I wasn't aware of, however. Is it still relevant when we don't have
elf support (which we don't, without an MMU?)

It looks to me like binfmt_flat never uses elf_read_implies_exec()...

Thanks. Pull request for the branched with fixed rebase issue is below.

Jonny

--------8<---------

The following changes since commit 78ecad0183bd7e49131da2b5aa82bee017db1cf0:

  Merge tag '3.10-rc2-psci-ops-11-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/sstabellini/xen into devel-stable (2013-05-22 10:53:20 +0100)

are available in the git repository at:


  git://linux-arm.org/linux-ja.git ja-nommu-for-rmk-v2

for you to fetch changes up to de8297765def67ec40b69522f3e405a61e0217b3:

  ARM: mpu: Ensure that MPU depends on CPU_V7 (2013-06-17 15:13:18 +0100)

----------------------------------------------------------------
Jonathan Austin (14):
      ARM: nommu: Don't build smp_tlb.c for !CONFIG_MMU
      ARM: nommu: add stub local_flush_bp_all() for !CONFIG_MMUU
      ARM: select CPU_CPU15_MMU/MPU appropriately
      ARM: add Cortex-R7 Processor Info
      ARM: vexpress: Add Cortex-R Series UART, selectable via DEBUG_LL
      ARM: mpu: add PMSA related registers and bitfields to existing headers
      ARM: mpu: add header for MPU register layouts and region data
      ARM: mpu: add early bring-up code for the ARMv7 PMSA-compliant MPU
      ARM: mpu: add MPU probe and initialisation functions in C
      ARM: mpu: Complete initialisation of the MPU after reaching the C-world
      ARM: mpu: add MPU initialisation for secondary cores
      ARM: mpu: Allow enabling of the MPU via kconfig
      ARM: mpu: protect the vectors page with an MPU region
      ARM: mpu: Ensure that MPU depends on CPU_V7

Will Deacon (5):
      ARM: nommu: add entry point for secondary CPUs to head-nommu.S
      ARM: nommu: define dummy TLB operations for nommu configurations
      ARM: nommu: provide dummy cpu_switch_mm implementation
      ARM: nommu: do not initialise page tables in secondary_data structure
      ARM: suspend: fix CPU suspend code for !CONFIG_MMU configurations

 arch/arm/Kconfig                  |    4 +-
 arch/arm/Kconfig-nommu            |   12 ++
 arch/arm/Kconfig.debug            |   10 +-
 arch/arm/include/asm/cp15.h       |    5 +
 arch/arm/include/asm/cputype.h    |    1 +
 arch/arm/include/asm/mpu.h        |   76 +++++++++++
 arch/arm/include/asm/proc-fns.h   |    4 +
 arch/arm/include/asm/smp.h        |    5 +-
 arch/arm/include/asm/smp_plat.h   |    4 +
 arch/arm/include/asm/tlbflush.h   |   25 +++-
 arch/arm/include/debug/vexpress.S |   10 ++
 arch/arm/kernel/Makefile          |    5 +-
 arch/arm/kernel/head-nommu.S      |  160 ++++++++++++++++++++++-
 arch/arm/kernel/signal.c          |    9 +-
 arch/arm/kernel/smp.c             |   10 +-
 arch/arm/kernel/suspend.c         |   64 +++++----
 arch/arm/mm/Kconfig               |    3 +-
 arch/arm/mm/nommu.c               |  257 ++++++++++++++++++++++++++++++++++++-
 arch/arm/mm/proc-v6.S             |    6 +-
 arch/arm/mm/proc-v7.S             |   27 +++-
 20 files changed, 646 insertions(+), 51 deletions(-)
 create mode 100644 arch/arm/include/asm/mpu.h
