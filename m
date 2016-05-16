From: will.deacon@arm.com (Will Deacon)
Date: Mon, 16 May 2016 18:48:23 +0100
Subject: [GIT PULL] arm64: updates for 4.7
Message-ID: <20160516174823.GA22358@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Here's the arm64 queue for 4.7 -- the highlights are detailed in the tag.

There are a few changes here outside of arch/arm64/ as a result of
dependencies (all acked by the relevant maintainers), but these have
generated some conflicts in linux-next:

  1. KVM: There is a conflict in arch/arm/kvm/arm.c with mainline
     (06a71a24bae5). The resolution is small, but slightly confusing,
     since the conflict is around a register_cpu_notifier and the
     resolution removes the corresponding unregister_cpu_notifier.

  2. Xen: Minor conflict due to everybody changing their initialisation
     order in setup_arch.

  3. EFI: Minor conflict with removal of global 'memmap' symbol

  4. Irqchip: Churn in the GIC driver (ARM's interrupt controller)
     conflicting with the rework of our CPU feature interface, which
     is used to detect broken firmware/hardware.

I've included the resolutions from linux-next in order below. The pull
request follows the resolutions.

Thanks,

Will

--->8

diff --cc arch/arm/kvm/arm.c
index dded1b763c16,1687e1450c3a..000000000000
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@@ -1198,8 -1226,6 +1233,7 @@@ static void teardown_hyp_mode(void
  	free_hyp_pgds();
  	for_each_possible_cpu(cpu)
  		free_page(per_cpu(kvm_arm_hyp_stack_page, cpu));
- 	unregister_cpu_notifier(&hyp_init_cpu_nb);
 +	hyp_cpu_pm_exit();
  }
  
  static int init_vhe_mode(void)

--->8

diff --cc arch/arm64/kernel/setup.c
index 65f515949baa,7cf992fe6684..000000000000
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@@ -277,13 -336,13 +278,11 @@@ void __init setup_arch(char **cmdline_p
  
  	early_ioremap_reset();
  
 -	if (acpi_disabled) {
 -		unflatten_device_tree();
 +	if (acpi_disabled)
  		psci_dt_init();
 -	} else {
 +	else
  		psci_acpi_init();
 -	}
  
- 	xen_early_init();
- 
  	cpu_read_bootcpu_ops();
  	smp_init_cpus();
  	smp_build_mpidr_hash();

--->8

diff --cc drivers/firmware/efi/arm-init.c
index fac567c3b66a,ef90f0c4b70a..000000000000
--- a/drivers/firmware/efi/arm-init.c
+++ b/drivers/firmware/efi/arm-init.c
@@@ -143,15 -178,7 +178,15 @@@ static __init void reserve_regions(void
  	if (efi_enabled(EFI_DBG))
  		pr_info("Processing EFI memory map:\n");
  
 +	/*
 +	 * Discard memblocks discovered so far: if there are any at this
 +	 * point, they originate from memory nodes in the DT, and UEFI
 +	 * uses its own memory map instead.
 +	 */
 +	memblock_dump_all();
 +	memblock_remove(0, (phys_addr_t)ULLONG_MAX);
 +
- 	for_each_efi_memory_desc(&memmap, md) {
+ 	for_each_efi_memory_desc(md) {
  		paddr = md->phys_addr;
  		npages = md->num_pages;

--->8

diff --cc drivers/irqchip/irq-gic.c
index 095bb5b5c3f2,113e2d02c812..000000000000
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@@ -489,8 -486,9 +486,10 @@@ static int gic_cpu_init(struct gic_chip
  		/*
  		 * Get what the GIC says our CPU mask is.
  		 */
- 		BUG_ON(cpu >= NR_GIC_CPU_IF);
+ 		if (WARN_ON(cpu >= NR_GIC_CPU_IF))
+ 			return -EINVAL;
+ 
 +		gic_check_cpu_features();
  		cpu_mask = gic_get_cpumask(gic);
  		gic_cpu_map[cpu] = cpu_mask;
  
@@@ -1012,24 -1029,28 +1030,26 @@@ static const struct irq_domain_ops gic_
  	.unmap = gic_irq_domain_unmap,
  };
  
- static void __init __gic_init_bases(unsigned int gic_nr, int irq_start,
- 			   void __iomem *dist_base, void __iomem *cpu_base,
- 			   u32 percpu_offset, struct fwnode_handle *handle)
+ static int __init __gic_init_bases(struct gic_chip_data *gic, int irq_start,
+ 				   struct fwnode_handle *handle)
  {
  	irq_hw_number_t hwirq_base;
- 	struct gic_chip_data *gic;
- 	int gic_irqs, irq_base, i;
- 
- 	BUG_ON(gic_nr >= CONFIG_ARM_GIC_MAX_NR);
+ 	int gic_irqs, irq_base, i, ret;
  
- 	gic = &gic_data[gic_nr];
+ 	if (WARN_ON(!gic || gic->domain))
+ 		return -EINVAL;
  
 -	gic_check_cpu_features();
 -
  	/* Initialize irq_chip */
- 	if (static_key_true(&supports_deactivate) && gic_nr == 0) {
- 		gic->chip = gic_eoimode1_chip;
+ 	gic->chip = gic_chip;
+ 
+ 	if (static_key_true(&supports_deactivate) && gic == &gic_data[0]) {
+ 		gic->chip.irq_mask = gic_eoimode1_mask_irq;
+ 		gic->chip.irq_eoi = gic_eoimode1_eoi_irq;
+ 		gic->chip.irq_set_vcpu_affinity = gic_irq_set_vcpu_affinity;
+ 		gic->chip.name = kasprintf(GFP_KERNEL, "GICv2");
  	} else {
- 		gic->chip = gic_chip;
- 		gic->chip.name = kasprintf(GFP_KERNEL, "GIC-%d", gic_nr);
+ 		gic->chip.name = kasprintf(GFP_KERNEL, "GIC-%d",
+ 					   (int)(gic - &gic_data[0]));
  	}
  
  #ifdef CONFIG_SMP

--->8

The following changes since commit bf16200689118d19de1b8d2a3c314fc21f5dc7bb:

  Linux 4.6-rc3 (2016-04-10 17:58:30 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-upstream

for you to fetch changes up to e6d9a52543338603e25e71e0e4942f05dae0dd8a:

  arm64: do not enforce strict 16 byte alignment to stack pointer (2016-05-12 14:20:49 +0100)

----------------------------------------------------------------
arm64 updates for 4.7:

- virt_to_page/page_address optimisations

- Support for NUMA systems described using device-tree

- Support for hibernate/suspend-to-disk

- Proper support for maxcpus= command line parameter

- Detection and graceful handling of AArch64-only CPUs

- Miscellaneous cleanups and non-critical fixes

----------------------------------------------------------------
AKASHI Takahiro (1):
      arm64: kvm: allows kvm cpu hotplug

Anna-Maria Gleixner (2):
      arm64/debug: Remove superfluous SMP function call
      arm64: hw-breakpoint: Remove superfluous SMP function call

Ard Biesheuvel (30):
      arm64/mm: ensure memstart_addr remains sufficiently aligned
      arm64: choose memstart_addr based on minimum sparsemem section alignment
      Revert "arm64: account for sparsemem section alignment when choosing vmemmap offset"
      arm64: add the initrd region to the linear mapping explicitly
      arm64: remove the now unneeded relocate_initrd()
      arm64: vdso: avoid virt_to_page() translations on kernel symbols
      arm64: mm: free __init memory via the linear mapping
      arm64: mm: avoid virt_to_page() translation for the zero page
      arm64: insn: avoid virt_to_page() translations on core kernel symbols
      arm64: mm: move vmemmap region right below the linear region
      arm64: mm: restrict virt_to_page() to the linear mapping
      arm64: use 'segment' rather than 'chunk' to describe mapped kernel regions
      arm64: move early boot code to the .init segment
      arm64: cover the .head.text section in the .text segment mapping
      arm64: simplify kernel segment mapping granularity
      efi: ARM/arm64: ignore DT memory nodes instead of removing them
      nios2: use correct void* return type for page_to_virt()
      openrisc: drop wrongly typed definition of page_to_virt()
      mm: replace open coded page to virt conversion with page_to_virt()
      arm64: ptdump: use static initializers for vmemmap region boundaries
      arm64: ptdump: add region marker for kasan shadow region
      arm64: kernel: don't export local symbols from head.S
      arm64: kernel: use literal for relocated address of __secondary_switched
      arm64: kernel: perform relocation processing from ID map
      arm64: introduce mov_q macro to move a constant into a 64-bit register
      arm64: kernel: replace early 64-bit literal loads with move-immediates
      arm64: don't map TEXT_OFFSET bytes below the kernel if we can avoid it
      arm64: relocatable: deal with physically misaligned kernel images
      arm64: acpi: add acpi=on cmdline option to prefer ACPI boot over DT
      arm64: kaslr: increase randomization granularity

Arnd Bergmann (1):
      efi: ARM: avoid warning about phys_addr_t cast

Catalin Marinas (5):
      arm64: Implement ptep_set_access_flags() for hardware AF/DBM
      arm64: Fix typo in the pmdp_huge_get_and_clear() definition
      arm64: Implement pmdp_set_access_flags() for hardware AF/DBM
      arm64: Replace hard-coded values in the pmd/pud_bad() macros
      arm64: Ensure pmd_present() returns false after pmd_mknotpresent()

Colin Ian King (1):
      arm64: do not enforce strict 16 byte alignment to stack pointer

David Daney (2):
      of, numa: Add NUMA of binding implementation.
      arm64: Move unflatten_device_tree() call earlier.

Ezequiel Garcia (1):
      arm64: kconfig: drop CONFIG_RTC_LIB dependency

Ganapatrao Kulkarni (3):
      Documentation, dt, numa: dt bindings for NUMA.
      arm64, numa: Add NUMA support for arm64 platforms.
      arm64, mm, numa: Add NUMA balancing support for arm64.

Geoff Levand (4):
      arm64: Fold proc-macros.S into assembler.h
      arm64: Cleanup SCTLR flags
      arm64: hyp/kvm: Make hyp-stub extensible
      arm64: Add new asm macro copy_page

Huang Shijie (1):
      arm64: mm: remove the redundant code

James Morse (11):
      arm64: mm: Add trace_irqflags annotations to do_debug_exception()
      arm64: kvm: Move lr save/restore from do_el2_call into EL1
      arm64: hyp/kvm: Make hyp-stub reject kvm_call_hyp()
      arm64: kernel: Rework finisher callback out of __cpu_suspend_enter()
      arm64: Change cpu_resume() to enable mmu early then access sleep_sp by va
      arm64: kernel: Include _AC definition in page.h
      arm64: Promote KERNEL_START/KERNEL_END definitions to a header file
      PM / Hibernate: Call flush_icache_range() on pages restored in-place
      arm64: kernel: Add support for hibernate/suspend-to-disk
      arm64: hibernate: Refuse to hibernate if the boot cpu is offline
      arm64: kvm: Fix kvm teardown for systems using the extended idmap

Jan Glauber (1):
      arm64: Reduce verbosity on SMP CPU stop

Jisheng Zhang (1):
      arm64: cpuidle: make arm_cpuidle_suspend() a bit more efficient

Julien Grall (1):
      arm64: cpuinfo: Missing NULL terminator in compat_hwcap_str

Kees Cook (1):
      arm64: kernel: Fix incorrect brk randomization

Kefeng Wang (3):
      arm64: cpufeature: append additional id_aa64mmfr2 fields to cpufeature
      arm64: mm: make pr_cont() per line in Virtual kernel memory layout
      arm64: mm: Show bss segment in kernel memory layout

Marc Zyngier (2):
      arm64: Allow a capability to be checked on a single CPU
      irqchip/gic: Restore CPU interface checking

Mark Rutland (2):
      arm64: asm: remove unused push/pop macros
      arm64: make dt_scan_depth1_nodes more readable

Robin Murphy (2):
      arm64/dma-mapping: Extend DMA ops workaround to PCI devices
      arm64/dma-mapping: Remove default domain workaround

Shannon Zhao (1):
      ARM64: ACPI: Check if it runs on Xen to enable or disable ACPI

Suzuki K Poulose (12):
      arm64: Add cpu_panic_kernel helper
      arm64: vhe: Verify CPU Exception Levels
      arm64: hwcaps: Cleanup naming
      arm64: HWCAP: Split COMPAT HWCAP table entries
      arm64: Add helpers for detecting AArch32 support at EL0
      arm64: cpufeature: Check availability of AArch32
      arm64: cpufeature: Track 32bit EL0 support
      arm64: compat: Check for AArch32 state
      arm64: cpufeature: Add scope for capability check
      arm64: Verify CPU errata work arounds on hotplugged CPU
      arm64: Fix behavior of maxcpus=N
      arm64: secondary_start_kernel: Remove unnecessary barrier

Will Deacon (1):
      arm64: make ARCH_SUPPORTS_DEBUG_PAGEALLOC depend on !HIBERNATION

Yang Shi (3):
      arm64: Kconfig: remove redundant HAVE_ARCH_TRANSPARENT_HUGEPAGE definition
      arm64: always use STRICT_MM_TYPECHECKS
      arm64: mm: remove unnecessary EXPORT_SYMBOL_GPL

 Documentation/arm64/booting.txt            |   4 +
 Documentation/devicetree/bindings/numa.txt | 275 ++++++++++++++++
 Documentation/kernel-parameters.txt        |   6 +-
 arch/arm/include/asm/kvm_host.h            |  10 +-
 arch/arm/include/asm/kvm_mmu.h             |   1 +
 arch/arm/kvm/arm.c                         | 119 ++++---
 arch/arm/kvm/mmu.c                         |   5 +
 arch/arm64/Kconfig                         |  45 ++-
 arch/arm64/Kconfig.debug                   |   2 +-
 arch/arm64/include/asm/assembler.h         | 133 +++++++-
 arch/arm64/include/asm/cpufeature.h        |  27 +-
 arch/arm64/include/asm/elf.h               |   3 +-
 arch/arm64/include/asm/kernel-pgtable.h    |  21 +-
 arch/arm64/include/asm/kvm_arm.h           |  11 -
 arch/arm64/include/asm/kvm_asm.h           |   3 +
 arch/arm64/include/asm/kvm_host.h          |  14 +-
 arch/arm64/include/asm/kvm_mmu.h           |   1 +
 arch/arm64/include/asm/memory.h            |  33 +-
 arch/arm64/include/asm/mmu.h               |   1 +
 arch/arm64/include/asm/mmzone.h            |  12 +
 arch/arm64/include/asm/numa.h              |  45 +++
 arch/arm64/include/asm/page.h              |   2 +
 arch/arm64/include/asm/pgtable-hwdef.h     |   1 -
 arch/arm64/include/asm/pgtable-types.h     |  32 --
 arch/arm64/include/asm/pgtable.h           |  62 ++--
 arch/arm64/include/asm/smp.h               |  11 +
 arch/arm64/include/asm/suspend.h           |  32 +-
 arch/arm64/include/asm/sysreg.h            |  24 +-
 arch/arm64/include/asm/topology.h          |  10 +
 arch/arm64/include/asm/virt.h              |  22 ++
 arch/arm64/kernel/Makefile                 |   1 +
 arch/arm64/kernel/acpi.c                   |  33 +-
 arch/arm64/kernel/asm-offsets.c            |  10 +-
 arch/arm64/kernel/cpu_errata.c             |  24 +-
 arch/arm64/kernel/cpufeature.c             | 343 ++++++++++++--------
 arch/arm64/kernel/cpuidle.c                |   9 +-
 arch/arm64/kernel/cpuinfo.c                |  40 +--
 arch/arm64/kernel/debug-monitors.c         |   3 +-
 arch/arm64/kernel/efi-entry.S              |   2 +-
 arch/arm64/kernel/head.S                   | 165 +++++-----
 arch/arm64/kernel/hibernate-asm.S          | 176 +++++++++++
 arch/arm64/kernel/hibernate.c              | 487 +++++++++++++++++++++++++++++
 arch/arm64/kernel/hw_breakpoint.c          |   8 +-
 arch/arm64/kernel/hyp-stub.S               |  45 ++-
 arch/arm64/kernel/image.h                  |   2 +
 arch/arm64/kernel/insn.c                   |   2 +-
 arch/arm64/kernel/kaslr.c                  |   6 +-
 arch/arm64/kernel/pci.c                    |  10 +
 arch/arm64/kernel/process.c                |  18 +-
 arch/arm64/kernel/setup.c                  |  81 +----
 arch/arm64/kernel/sleep.S                  | 157 ++++------
 arch/arm64/kernel/smp.c                    |  78 +++--
 arch/arm64/kernel/suspend.c                | 102 +++---
 arch/arm64/kernel/sys.c                    |  10 +
 arch/arm64/kernel/vdso.c                   |   4 +-
 arch/arm64/kernel/vmlinux.lds.S            |  48 ++-
 arch/arm64/kvm/handle_exit.c               |   7 +
 arch/arm64/kvm/hyp-init.S                  |  48 ++-
 arch/arm64/kvm/hyp.S                       |  11 +-
 arch/arm64/kvm/hyp/entry.S                 |  19 ++
 arch/arm64/kvm/hyp/hyp-entry.S             |  10 +-
 arch/arm64/kvm/reset.c                     |  30 ++
 arch/arm64/mm/Makefile                     |   1 +
 arch/arm64/mm/cache.S                      |   2 -
 arch/arm64/mm/context.c                    |   3 +-
 arch/arm64/mm/dma-mapping.c                |  56 +---
 arch/arm64/mm/dump.c                       |  52 +--
 arch/arm64/mm/fault.c                      |  87 +++++-
 arch/arm64/mm/init.c                       | 112 +++++--
 arch/arm64/mm/mm.h                         |   1 -
 arch/arm64/mm/mmap.c                       |   2 -
 arch/arm64/mm/mmu.c                        |  24 +-
 arch/arm64/mm/numa.c                       | 396 +++++++++++++++++++++++
 arch/arm64/mm/proc-macros.S                |  98 ------
 arch/arm64/mm/proc.S                       |  56 ++--
 arch/nios2/include/asm/io.h                |   1 -
 arch/nios2/include/asm/page.h              |   2 +-
 arch/nios2/include/asm/pgtable.h           |   2 +-
 arch/openrisc/include/asm/page.h           |   2 -
 drivers/firmware/efi/arm-init.c            |   8 +
 drivers/firmware/efi/libstub/arm64-stub.c  |  15 +-
 drivers/firmware/efi/libstub/fdt.c         |  24 +-
 drivers/irqchip/irq-gic.c                  |   5 +-
 drivers/of/Kconfig                         |   3 +
 drivers/of/Makefile                        |   1 +
 drivers/of/of_numa.c                       | 211 +++++++++++++
 include/linux/mm.h                         |   6 +-
 include/linux/of.h                         |   9 +
 kernel/power/swap.c                        |  18 ++
 89 files changed, 3127 insertions(+), 1026 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/numa.txt
 create mode 100644 arch/arm64/include/asm/mmzone.h
 create mode 100644 arch/arm64/include/asm/numa.h
 create mode 100644 arch/arm64/kernel/hibernate-asm.S
 create mode 100644 arch/arm64/kernel/hibernate.c
 create mode 100644 arch/arm64/mm/numa.c
 delete mode 100644 arch/arm64/mm/proc-macros.S
 create mode 100644 drivers/of/of_numa.c
