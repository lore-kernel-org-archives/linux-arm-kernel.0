From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 4 Nov 2015 18:25:11 +0000
Subject: [GIT PULL] arm64 updates for 4.4
Message-ID: <20151104182508.GA28726@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

These are the main arm64 updates for 4.4. There are a few more conflicts
than usual caused by some reworking under arch/arm64 (the CPU feature
detection, EFI_STUB, relaxed atomics) and an arm64 fix that went in
during 4.3-rc7 and which I haven't pulled into the upstream branch for
arm64. The more complicated fix-up is in arch/arm64/kernel/cpufeature.c
where irqchip/GICv3 changes merged via tip are conflicting with the
arm64 CPU feature detection.

I included the conflict resolution (only the conflicting hunks) and the
end of this email. Please let me know if there are any issues.

The diffstat contains some kernel/irq/ changes that have been pulled
form tip/irq/for-arm as explained in the tag text.

Thanks.


The following changes since commit 049e6dde7e57f0054fdc49102e7ef4830c698b46:

  Linux 4.3-rc4 (2015-10-04 16:57:17 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-upstream

for you to fetch changes up to f8f8bdc48851da979c6e0e4808b6031122e4af47:

  arm64/efi: fix libstub build under CONFIG_MODVERSIONS (2015-11-02 13:50:17 +0000)

----------------------------------------------------------------
arm64 updates for 4.4:

- "genirq: Introduce generic irq migration for cpu hotunplugged" patch
  merged from tip/irq/for-arm to allow the arm64-specific part to be
  upstreamed via the arm64 tree

- CPU feature detection reworked to cope with heterogeneous systems
  where CPUs may not have exactly the same features. The features
  reported by the kernel via internal data structures or ELF_HWCAP are
  delayed until all the CPUs are up (and before user space starts)

- Support for 16KB pages, with the additional bonus of a 36-bit VA
  space, though the latter only depending on EXPERT

- Implement native {relaxed, acquire, release} atomics for arm64

- New ASID allocation algorithm which avoids IPI on roll-over, together
  with TLB invalidation optimisations (using local vs global where
  feasible)

- KASan support for arm64

- EFI_STUB clean-up and isolation for the kernel proper (required by
  KASan)

- copy_{to,from,in}_user optimisations (sharing the memcpy template)

- perf: moving arm64 to the arm32/64 shared PMU framework

- L1_CACHE_BYTES increased to 128 to accommodate Cavium hardware

- Support for the contiguous PTE hint on kernel mapping (16 consecutive
  entries may be able to use a single TLB entry)

- Generic CONFIG_HZ now used on arm64

- defconfig updates

----------------------------------------------------------------
Alexander Kuleshov (1):
      arm64/mm: use PAGE_ALIGNED instead of IS_ALIGNED

Alim Akhtar (1):
      arm64: defconfig: Enable samsung serial and mmc

Andrey Ryabinin (4):
      arm64: introduce VA_START macro - the first kernel virtual address.
      arm64: move PGD_SIZE definition to pgalloc.h
      arm64: add KASAN support
      Documentation/features/KASAN: arm64 supports KASAN now

Ard Biesheuvel (7):
      arm64/efi: remove /chosen/linux, uefi-stub-kern-ver DT property
      arm64: use ENDPIPROC() to annotate position independent assembler routines
      arm64/efi: isolate EFI stub from the kernel proper
      arm64: Add page size to the kernel image header
      arm64: remove bogus TASK_SIZE_64 check
      arm64/efi: move arm64 specific stub C code to libstub
      arm64/efi: fix libstub build under CONFIG_MODVERSIONS

Catalin Marinas (6):
      Merge branch 'irq/for-arm' of git://git.kernel.org/.../tip/tip
      arm64: Fix missing #include in hw_breakpoint.c
      Revert "arm64: ioremap: add ioremap_cache macro"
      arm64: Minor coding style fixes for kc_offset_to_vaddr and kc_vaddr_to_offset
      arm64: Make 36-bit VA depend on EXPERT
      Merge branch 'irq/for-arm' of git://git.kernel.org/.../tip/tip

Dave Martin (1):
      arm64: Constify hwcap name string arrays

Dietmar Eggemann (1):
      ARM64: Enable multi-core scheduler support by default

Feng Kan (2):
      arm64: Change memcpy in kernel to use the copy template file
      arm64: copy_to-from-in_user optimization using copy template

Jeremy Linton (6):
      arm64: Add contiguous page flag shifts and constants
      arm64: PTE/PMD contiguous bit definition
      arm64: Macros to check/set/unset the contiguous bit
      arm64: Default kernel pages should be contiguous
      arm64: Make the kernel page dump utility aware of the CONT bit
      arm64: Mark kernel page ranges contiguous

Jisheng Zhang (1):
      arm64: add cpu_idle tracepoints to arch_cpu_idle

Jungseok Lee (1):
      arm64: Synchronise dump_backtrace() with perf callchain

Kefeng Wang (1):
      arm64: make Timer Interrupt Frequency selectable

Linus Walleij (1):
      ARM64: kasan: print memory assignment

Mark Rutland (8):
      arm64: perf: move to shared arm_pmu framework
      arm64: perf: add Cortex-A53 support
      arm64: perf: add Cortex-A57 support
      arm64: dts: juno: describe PMUs separately
      MAINTAINERS: update ARM PMU profiling and debugging for arm64
      MAINTAINERS: add myself as arm perf reviewer
      arm64: Simplify NR_FIX_BTMAPS calculation
      arm64: page-align sections for DEBUG_RODATA

Mark Salyzyn (1):
      arm64: AArch32 user space PC alignment exception

Robin Murphy (2):
      arm64: Fix compat register mappings
      arm64: Fix build with CONFIG_ZONE_DMA=n

Suzuki K. Poulose (28):
      arm64: Move swapper pagetable definitions
      arm64: Handle section maps for swapper/idmap
      arm64: Introduce helpers for page table levels
      arm64: Calculate size for idmap_pg_dir at compile time
      arm64: Handle 4 level page table for swapper
      arm64: Clean config usages for page size
      arm64: Kconfig: Fix help text about AArch32 support with 64K pages
      arm64: Check for selected granule support
      arm64: Add 16K page size support
      arm64: 36 bit VA
      arm64: Make the CPU information more clear
      arm64: Delay ELF HWCAP initialisation until all CPUs are up
      arm64: Delay cpuinfo_store_boot_cpu
      arm64: Move cpu feature detection code
      arm64: Move mixed endian support detection
      arm64: Move /proc/cpuinfo handling code
      arm64: Handle width of a cpuid feature
      arm64: Keep track of CPU feature registers
      arm64: Consolidate CPU Sanity check to CPU Feature infrastructure
      arm64: Read system wide CPUID value
      arm64: Cleanup mixed endian support detection
      arm64: Refactor check_cpu_capabilities
      arm64: Delay cpu feature capability checks
      arm64/capabilities: Make use of system wide safe value
      arm64/HWCAP: Use system wide safe values
      arm64: Move FP/ASIMD hwcap handling to common code
      arm64/debug: Make use of the system wide safe value
      arm64/kvm: Make use of the system wide safe values

Thomas Gleixner (1):
      genirq: Make the cpuhotplug migration code less noisy

Tirumalesh Chalamarla (1):
      arm64: Increase the max granular size

Will Deacon (15):
      arm64: mm: remove unused cpu_set_idmap_tcr_t0sz function
      arm64: proc: de-scope TLBI operation during cold boot
      arm64: flush: use local TLB and I-cache invalidation
      arm64: mm: rewrite ASID allocator and MM context-switching code
      arm64: tlbflush: remove redundant ASID casts to (unsigned long)
      arm64: tlbflush: avoid flushing when fullmm == 1
      arm64: switch_mm: simplify mm and CPU checks
      arm64: mm: kill mm_cpumask usage
      arm64: tlb: remove redundant barrier from __flush_tlb_pgtable
      arm64: mm: remove dsb from update_mmu_cache
      arm64: hw_breakpoint: use target state to determine ABI behaviour
      arm64: atomics: implement native {relaxed, acquire, release} atomics
      arm64: kasan: fix issues reported by sparse
      arm64: cpufeature: declare enable_cpu_capabilities as static
      arm64: cachetype: fix definitions of ICACHEF_* flags

Yang Shi (1):
      arm64: debug: Fix typo in debug-monitors.c

Yang Yingliang (1):
      arm64: fix a migrating irq bug when hotplug cpu

yalin wang (2):
      arm64: ioremap: add ioremap_cache macro
      arm64: add kc_offset_to_vaddr and kc_vaddr_to_offset macro

 Documentation/arm/uefi.txt                         |    2 -
 Documentation/arm64/booting.txt                    |    7 +-
 Documentation/devicetree/bindings/arm/pmu.txt      |    2 +
 .../features/debug/KASAN/arch-support.txt          |    2 +-
 MAINTAINERS                                        |    9 +-
 arch/arm64/Kconfig                                 |   69 +-
 arch/arm64/Kconfig.debug                           |    2 +-
 arch/arm64/Makefile                                |    7 +
 arch/arm64/boot/dts/arm/juno-r1.dts                |   18 +-
 arch/arm64/boot/dts/arm/juno.dts                   |   18 +-
 arch/arm64/configs/defconfig                       |    9 +
 arch/arm64/include/asm/assembler.h                 |   11 +
 arch/arm64/include/asm/atomic.h                    |   63 +-
 arch/arm64/include/asm/atomic_ll_sc.h              |   98 +-
 arch/arm64/include/asm/atomic_lse.h                |  193 ++--
 arch/arm64/include/asm/cache.h                     |    2 +-
 arch/arm64/include/asm/cacheflush.h                |    7 +
 arch/arm64/include/asm/cachetype.h                 |    4 +-
 arch/arm64/include/asm/cmpxchg.h                   |  279 +++--
 arch/arm64/include/asm/cpu.h                       |    4 +
 arch/arm64/include/asm/cpufeature.h                |   91 +-
 arch/arm64/include/asm/cputype.h                   |   15 -
 arch/arm64/include/asm/fixmap.h                    |    7 +-
 arch/arm64/include/asm/hw_breakpoint.h             |    9 +-
 arch/arm64/include/asm/hwcap.h                     |    8 +
 arch/arm64/include/asm/irq.h                       |    1 -
 arch/arm64/include/asm/kasan.h                     |   38 +
 arch/arm64/include/asm/kernel-pgtable.h            |   83 ++
 arch/arm64/include/asm/memory.h                    |    6 +-
 arch/arm64/include/asm/mmu.h                       |   15 +-
 arch/arm64/include/asm/mmu_context.h               |  113 +--
 arch/arm64/include/asm/page.h                      |   27 +-
 arch/arm64/include/asm/pgalloc.h                   |    1 +
 arch/arm64/include/asm/pgtable-hwdef.h             |   48 +-
 arch/arm64/include/asm/pgtable.h                   |   30 +-
 arch/arm64/include/asm/pmu.h                       |   83 --
 arch/arm64/include/asm/processor.h                 |    2 +-
 arch/arm64/include/asm/ptrace.h                    |   16 +-
 arch/arm64/include/asm/string.h                    |   16 +
 arch/arm64/include/asm/sysreg.h                    |  157 ++-
 arch/arm64/include/asm/thread_info.h               |    5 +-
 arch/arm64/include/asm/tlb.h                       |   26 +-
 arch/arm64/include/asm/tlbflush.h                  |   18 +-
 arch/arm64/kernel/Makefile                         |   11 +-
 arch/arm64/kernel/arm64ksyms.c                     |    3 +
 arch/arm64/kernel/asm-offsets.c                    |    2 +-
 arch/arm64/kernel/cpu_errata.c                     |    2 +-
 arch/arm64/kernel/cpufeature.c                     |  851 +++++++++++++++-
 arch/arm64/kernel/cpuinfo.c                        |  254 +++--
 arch/arm64/kernel/debug-monitors.c                 |    8 +-
 arch/arm64/kernel/efi-entry.S                      |   10 +-
 arch/arm64/kernel/efi.c                            |    5 +-
 arch/arm64/kernel/entry.S                          |    2 +
 arch/arm64/kernel/fpsimd.c                         |   16 +-
 arch/arm64/kernel/head.S                           |   76 +-
 arch/arm64/kernel/hw_breakpoint.c                  |   19 +-
 arch/arm64/kernel/image.h                          |   38 +-
 arch/arm64/kernel/irq.c                            |   62 --
 arch/arm64/kernel/module.c                         |   16 +-
 arch/arm64/kernel/perf_event.c                     | 1066 ++++----------------
 arch/arm64/kernel/process.c                        |    3 +
 arch/arm64/kernel/setup.c                          |  245 +----
 arch/arm64/kernel/smp.c                            |   22 +-
 arch/arm64/kernel/suspend.c                        |    2 +-
 arch/arm64/kernel/traps.c                          |   15 +-
 arch/arm64/kernel/vmlinux.lds.S                    |    6 +-
 arch/arm64/kvm/Kconfig                             |    3 +
 arch/arm64/kvm/reset.c                             |    2 +-
 arch/arm64/kvm/sys_regs.c                          |   12 +-
 arch/arm64/lib/copy_from_user.S                    |   78 +-
 arch/arm64/lib/copy_in_user.S                      |   67 +-
 arch/arm64/lib/copy_template.S                     |  193 ++++
 arch/arm64/lib/copy_to_user.S                      |   67 +-
 arch/arm64/lib/memchr.S                            |    2 +-
 arch/arm64/lib/memcmp.S                            |    2 +-
 arch/arm64/lib/memcpy.S                            |  184 +---
 arch/arm64/lib/memmove.S                           |    9 +-
 arch/arm64/lib/memset.S                            |    5 +-
 arch/arm64/lib/strcmp.S                            |    2 +-
 arch/arm64/lib/strlen.S                            |    2 +-
 arch/arm64/lib/strncmp.S                           |    2 +-
 arch/arm64/mm/Makefile                             |    3 +
 arch/arm64/mm/cache.S                              |   10 +-
 arch/arm64/mm/context.c                            |  236 +++--
 arch/arm64/mm/dump.c                               |   18 +-
 arch/arm64/mm/fault.c                              |    2 +-
 arch/arm64/mm/init.c                               |   19 +-
 arch/arm64/mm/kasan_init.c                         |  165 +++
 arch/arm64/mm/mmu.c                                |  145 ++-
 arch/arm64/mm/pageattr.c                           |    2 +-
 arch/arm64/mm/pgd.c                                |    2 -
 arch/arm64/mm/proc.S                               |   10 +-
 drivers/firmware/efi/Makefile                      |    8 +
 drivers/firmware/efi/libstub/Makefile              |   42 +-
 .../firmware/efi/libstub/arm64-stub.c              |    0
 drivers/firmware/efi/libstub/fdt.c                 |    9 -
 drivers/firmware/efi/libstub/string.c              |   57 ++
 drivers/perf/Kconfig                               |    2 +-
 include/linux/irq.h                                |    2 +
 kernel/irq/Kconfig                                 |    4 +
 kernel/irq/Makefile                                |    1 +
 kernel/irq/cpuhotplug.c                            |   82 ++
 scripts/Makefile.kasan                             |    4 +-
 103 files changed, 3386 insertions(+), 2422 deletions(-)
 create mode 100644 arch/arm64/include/asm/kasan.h
 create mode 100644 arch/arm64/include/asm/kernel-pgtable.h
 delete mode 100644 arch/arm64/include/asm/pmu.h
 create mode 100644 arch/arm64/lib/copy_template.S
 create mode 100644 arch/arm64/mm/kasan_init.c
 rename arch/arm64/kernel/efi-stub.c => drivers/firmware/efi/libstub/arm64-stub.c (100%)
 create mode 100644 drivers/firmware/efi/libstub/string.c
 create mode 100644 kernel/irq/cpuhotplug.c


Conflict resolution with 66ef3493d4bb387f5a83915e33dc893102fd1b43:

-------------8<-------------------------
diff --cc Documentation/arm/uefi.txt
index 7b3fdfe0f7ba,7f1bed8872f3..000000000000
--- a/Documentation/arm/uefi.txt
+++ b/Documentation/arm/uefi.txt
@@@ -58,5 -58,5 +58,3 @@@ linux,uefi-mmap-desc-size | 32-bit | Si
  --------------------------------------------------------------------------------
  linux,uefi-mmap-desc-ver  | 32-bit | Version of the mmap descriptor format.
  --------------------------------------------------------------------------------
- linux,uefi-stub-kern-ver  | string | Copy of linux_banner from build.
- --------------------------------------------------------------------------------
 -
 -For verbose debug messages, specify 'uefi_debug' on the kernel command line.
diff --cc arch/arm64/include/asm/atomic.h
index 1e247ac2601a,5e13ad76a249..000000000000
--- a/arch/arm64/include/asm/atomic.h
+++ b/arch/arm64/include/asm/atomic.h
@@@ -54,8 -54,39 +54,39 @@@
  #define ATOMIC_INIT(i)	{ (i) }
  
  #define atomic_read(v)			READ_ONCE((v)->counter)
 -#define atomic_set(v, i)		(((v)->counter) = (i))
 +#define atomic_set(v, i)		WRITE_ONCE(((v)->counter), (i))
+ 
+ #define atomic_add_return_relaxed	atomic_add_return_relaxed
+ #define atomic_add_return_acquire	atomic_add_return_acquire
+ #define atomic_add_return_release	atomic_add_return_release
+ #define atomic_add_return		atomic_add_return
+ 
+ #define atomic_inc_return_relaxed(v)	atomic_add_return_relaxed(1, (v))
+ #define atomic_inc_return_acquire(v)	atomic_add_return_acquire(1, (v))
+ #define atomic_inc_return_release(v)	atomic_add_return_release(1, (v))
+ #define atomic_inc_return(v)		atomic_add_return(1, (v))
+ 
+ #define atomic_sub_return_relaxed	atomic_sub_return_relaxed
+ #define atomic_sub_return_acquire	atomic_sub_return_acquire
+ #define atomic_sub_return_release	atomic_sub_return_release
+ #define atomic_sub_return		atomic_sub_return
+ 
+ #define atomic_dec_return_relaxed(v)	atomic_sub_return_relaxed(1, (v))
+ #define atomic_dec_return_acquire(v)	atomic_sub_return_acquire(1, (v))
+ #define atomic_dec_return_release(v)	atomic_sub_return_release(1, (v))
+ #define atomic_dec_return(v)		atomic_sub_return(1, (v))
+ 
+ #define atomic_xchg_relaxed(v, new)	xchg_relaxed(&((v)->counter), (new))
+ #define atomic_xchg_acquire(v, new)	xchg_acquire(&((v)->counter), (new))
+ #define atomic_xchg_release(v, new)	xchg_release(&((v)->counter), (new))
  #define atomic_xchg(v, new)		xchg(&((v)->counter), (new))
+ 
+ #define atomic_cmpxchg_relaxed(v, old, new)				\
+ 	cmpxchg_relaxed(&((v)->counter), (old), (new))
+ #define atomic_cmpxchg_acquire(v, old, new)				\
+ 	cmpxchg_acquire(&((v)->counter), (old), (new))
+ #define atomic_cmpxchg_release(v, old, new)				\
+ 	cmpxchg_release(&((v)->counter), (old), (new))
  #define atomic_cmpxchg(v, old, new)	cmpxchg(&((v)->counter), (old), (new))
  
  #define atomic_inc(v)			atomic_add(1, (v))
diff --cc arch/arm64/kernel/cpufeature.c
index 305f30dc9e63,504526fa8129..000000000000
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@@ -33,41 -586,22 +588,37 @@@
  	return val >= entry->min_field_value;
  }
  
- #define __ID_FEAT_CHK(reg)						\
- static bool __maybe_unused						\
- has_##reg##_feature(const struct arm64_cpu_capabilities *entry)		\
- {									\
- 	u64 val;							\
- 									\
- 	val = read_cpuid(reg##_el1);					\
- 	return feature_matches(val, entry);				\
- }
+ static bool
+ has_cpuid_feature(const struct arm64_cpu_capabilities *entry)
+ {
+ 	u64 val;
  
- __ID_FEAT_CHK(id_aa64pfr0);
- __ID_FEAT_CHK(id_aa64mmfr1);
- __ID_FEAT_CHK(id_aa64isar0);
+ 	val = read_system_reg(entry->sys_reg);
+ 	return feature_matches(val, entry);
+ }
  
 +static bool has_useable_gicv3_cpuif(const struct arm64_cpu_capabilities *entry)
 +{
 +	bool has_sre;
 +
- 	if (!has_id_aa64pfr0_feature(entry))
++	if (!has_cpuid_feature(entry))
 +		return false;
 +
 +	has_sre = gic_enable_sre();
 +	if (!has_sre)
 +		pr_warn_once("%s present but disabled by higher exception level\n",
 +			     entry->desc);
 +
 +	return has_sre;
 +}
 +
  static const struct arm64_cpu_capabilities arm64_features[] = {
  	{
  		.desc = "GIC system register CPU interface",
  		.capability = ARM64_HAS_SYSREG_GIC_CPUIF,
 -		.matches = has_cpuid_feature,
 +		.matches = has_useable_gicv3_cpuif,
- 		.field_pos = 24,
+ 		.sys_reg = SYS_ID_AA64PFR0_EL1,
+ 		.field_pos = ID_AA64PFR0_GIC_SHIFT,
  		.min_field_value = 1,
  	},
  #ifdef CONFIG_ARM64_PAN
diff --cc arch/arm64/kernel/suspend.c
index 44ca4143b013,3c5e4e6dcf68..000000000000
--- a/arch/arm64/kernel/suspend.c
+++ b/arch/arm64/kernel/suspend.c
@@@ -80,21 -80,17 +80,21 @@@ int cpu_suspend(unsigned long arg, int 
  	if (ret == 0) {
  		/*
  		 * We are resuming from reset with TTBR0_EL1 set to the
 -		 * idmap to enable the MMU; restore the active_mm mappings in
 -		 * TTBR0_EL1 unless the active_mm == &init_mm, in which case
 -		 * the thread entered cpu_suspend with TTBR0_EL1 set to
 -		 * reserved TTBR0 page tables and should be restored as such.
 +		 * idmap to enable the MMU; set the TTBR0 to the reserved
 +		 * page tables to prevent speculative TLB allocations, flush
 +		 * the local tlb and set the default tcr_el1.t0sz so that
 +		 * the TTBR0 address space set-up is properly restored.
 +		 * If the current active_mm != &init_mm we entered cpu_suspend
 +		 * with mappings in TTBR0 that must be restored, so we switch
 +		 * them back to complete the address space configuration
 +		 * restoration before returning.
  		 */
 -		if (mm == &init_mm)
 -			cpu_set_reserved_ttbr0();
 -		else
 -			cpu_switch_mm(mm->pgd, mm);
 -
 +		cpu_set_reserved_ttbr0();
- 		flush_tlb_all();
+ 		local_flush_tlb_all();
 +		cpu_set_default_tcr_t0sz();
 +
 +		if (mm != &init_mm)
 +			cpu_switch_mm(mm->pgd, mm);
  
  		/*
  		 * Restore per-cpu offset before any kernel
-------------8<-------------------------

-- 
Catalin
