From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 17 Mar 2016 18:26:54 +0000
Subject: [GIT PULL] arm64 updates for 4.6
Message-ID: <20160317182651.GA32292@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Here are the main arm64 updates for 4.6. There are some relatively
intrusive changes to support KASLR, the reworking of the kernel virtual
memory layout and initial page table creation. These would conflict with
some of the arm64 KVM changes merged via the KVM tree (adding support
for the "Virtualisation Host Extensions" ARMv8.1 feature). The prior
merge resolution in linux-next should be fine but I also included the
output of "git show --cc" on a local merge I did against last night's
mainline tree (at the end of this email). If there are any issues please
let me know.

Thanks.


The following changes since commit 18558cae0272f8fd9647e69d3fec1565a7949865:

  Linux 4.5-rc4 (2016-02-14 13:05:20 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-upstream

for you to fetch changes up to 2776e0e8ef683a42fe3e9a5facf576b73579700e:

  arm64: kasan: Fix zero shadow mapping overriding kernel image shadow (2016-03-11 11:03:35 +0000)

----------------------------------------------------------------
arm64 updates for 4.6:

- Initial page table creation reworked to avoid breaking large block
  mappings (huge pages) into smaller ones. The ARM architecture requires
  break-before-make in such cases to avoid TLB conflicts but that's not
  always possible on live page tables

- Kernel virtual memory layout: the kernel image is no longer linked to
  the bottom of the linear mapping (PAGE_OFFSET) but at the bottom of
  the vmalloc space, allowing the kernel to be loaded (nearly) anywhere
  in physical RAM

- Kernel ASLR: position independent kernel Image and modules being
  randomly mapped in the vmalloc space with the randomness is provided
  by UEFI (efi_get_random_bytes() patches merged via the arm64 tree,
  acked by Matt Fleming)

- Implement relative exception tables for arm64, required by KASLR
  (initial code for ARCH_HAS_RELATIVE_EXTABLE added to lib/extable.c but
  actual x86 conversion to deferred to 4.7 because of the merge
  dependencies)

- Support for the User Access Override feature of ARMv8.2: this allows
  uaccess functions (get_user etc.) to be implemented using LDTR/STTR
  instructions. Such instructions, when run by the kernel, perform
  unprivileged accesses adding an extra level of protection. The
  set_fs() macro is used to "upgrade" such instruction to privileged
  accesses via the UAO bit

- Half-precision floating point support (part of ARMv8.2)

- Optimisations for CPUs with or without a hardware prefetcher (using
  run-time code patching)

- copy_page performance improvement to deal with 128 bytes at a time

- Sanity checks on the CPU capabilities (via CPUID) to prevent
  incompatible secondary CPUs from being brought up (e.g. weird
  big.LITTLE configurations)

- valid_user_regs() reworked for better sanity check of the sigcontext
  information (restored pstate information)

- ACPI parking protocol implementation

- CONFIG_DEBUG_RODATA enabled by default

- VDSO code marked as read-only

- DEBUG_PAGEALLOC support

- ARCH_HAS_UBSAN_SANITIZE_ALL enabled

- Erratum workaround Cavium ThunderX SoC

- set_pte_at() fix for PROT_NONE mappings

- Code clean-ups

----------------------------------------------------------------
Adam Buchbinder (1):
      arm64: Fix misspellings in comments.

Andrew Pinski (2):
      arm64: lib: patch in prfm for copy_page if requested
      arm64: Add workaround for Cavium erratum 27456

Ard Biesheuvel (35):
      arm64: use local label prefixes for __reg_num symbols
      of/fdt: make memblock minimum physical address arch configurable
      of/fdt: factor out assignment of initrd_start/initrd_end
      arm64: prevent potential circular header dependencies in asm/bug.h
      arm64: add support for ioremap() block mappings
      arm64: introduce KIMAGE_VADDR as the virtual base of the kernel region
      arm64: pgtable: implement static [pte|pmd|pud]_offset variants
      arm64: decouple early fixmap init from linear mapping
      arm64: kvm: deal with kernel symbols outside of linear mapping
      arm64: move kernel image to base of vmalloc area
      arm64: defer __va translation of initrd_start and initrd_end
      arm64: allow kernel Image to be loaded anywhere in physical memory
      arm64: mm: only perform memstart_addr sanity check if DEBUG_VM
      arm64: mm: use bit ops rather than arithmetic in pa/va translations
      arm64: move brk immediate argument definitions to separate header
      arm64: add support for module PLTs
      arm64: avoid R_AARCH64_ABS64 relocations for Image header fields
      arm64: avoid dynamic relocations in early boot code
      arm64: make asm/elf.h available to asm files
      scripts/sortextable: add support for ET_DYN binaries
      extable: add support for relative extables to search and sort routines
      arm64: switch to relative exception tables
      arm64: add support for building vmlinux as a relocatable PIE binary
      arm64: add support for kernel ASLR
      arm64: kaslr: randomize the linear region
      efi: stub: implement efi_get_random_bytes() based on EFI_RNG_PROTOCOL
      efi: stub: add implementation of efi_random_alloc()
      efi: stub: use high allocation for converted command line
      arm64: efi: invoke EFI_RNG_PROTOCOL to supply KASLR randomness
      arm64: lse: deal with clobbered IP registers after branch via PLT
      arm64: mm: list kernel sections in order
      arm64: mm: treat memstart_addr as a signed quantity
      arm64: mm: check at build time that PAGE_OFFSET divides the VA space evenly
      arm64: enable CONFIG_DEBUG_RODATA by default
      arm64: efi: add missing frame pointer assignment

Catalin Marinas (6):
      arm64: Remove the get_thread_info() function
      arm64: User die() instead of panic() in do_page_fault()
      arm64: Fix building error with 16KB pages and 36-bit VA
      arm64: Update PTE_RDONLY in set_pte_at() for PROT_NONE permission
      arm64: kasan: Use actual memory node when populating the kernel image shadow
      arm64: kasan: Fix zero shadow mapping overriding kernel image shadow

David Brown (1):
      arm64: vdso: Mark vDSO code as read-only

James Morse (5):
      arm64: cpufeature: Change read_cpuid() to use sysreg's mrs_s macro
      arm64: add ARMv8.2 id_aa64mmfr2 boiler plate
      arm64: kernel: Add support for User Access Override
      arm64: cpufeature: Test 'matches' pointer to find the end of the list
      arm64: kernel: Don't toggle PAN on systems with UAO

Jeremy Linton (1):
      arm64: mm: Mark .rodata as RO

Kefeng Wang (1):
      arm64: mm: dump: Use VA_START directly instead of private LOWEST_ADDR

Laura Abbott (3):
      arm64: Drop alloc function from create_mapping
      arm64: Add support for ARCH_SUPPORTS_DEBUG_PAGEALLOC
      arm64: ptdump: Indicate whether memory should be faulting

Lorenzo Pieralisi (2):
      arm64: kernel: implement ACPI parking protocol
      arm64: kernel: acpi: fix ioremap in ACPI parking protocol cpu_postboot

Marc Zyngier (1):
      arm64: KVM: Move kvm_call_hyp back to its original localtion

Mark Rutland (21):
      asm-generic: Fix local variable shadow in __set_fixmap_offset
      arm64: mm: specialise pagetable allocators
      arm64: mm: place empty_zero_page in bss
      arm64: unify idmap removal
      arm64: unmap idmap earlier
      arm64: add function to install the idmap
      arm64: mm: add code to safely replace TTBR1_EL1
      arm64: kasan: avoid TLB conflicts
      arm64: mm: move pte_* macros
      arm64: mm: add functions to walk page tables by PA
      arm64: mm: avoid redundant __pa(__va(x))
      arm64: mm: add __{pud,pgd}_populate
      arm64: mm: add functions to walk tables in fixmap
      arm64: mm: use fixmap when creating page tables
      arm64: mm: allocate pagetables anywhere
      arm64: mm: allow passing a pgdir to alloc_init_*
      arm64: ensure _stext and _etext are page-aligned
      arm64: mm: create new fine-grained mappings at boot
      arm64: Remove fixmap include fragility
      arm64: Rework valid_user_regs
      arm64: make mrs_s prefixing implicit in read_cpuid

Miles Chen (1):
      arm64/mm: remove unnecessary boundary check

Suzuki K Poulose (12):
      arm64: Add a helper for parking CPUs in a loop
      arm64: Introduce cpu_die_early
      arm64: Move cpu_die_early to smp.c
      arm64: Handle early CPU boot failures
      arm64: Enable CPU capability verification unconditionally
      arm64: Add helper for extracting ASIDBits
      arm64: Ensure the secondary CPUs have safe ASIDBits size
      arm64: cpufeature: Correct feature register tables
      arm64: cpufeature: Fix the sign of feature bits
      arm64: capabilities: Handle sign of the feature bit
      arm64: Rename cpuid_feature field extract routines
      arm64: Add support for Half precision floating point

Will Deacon (5):
      arm64: prefetch: don't provide spin_lock_prefetch with LSE
      arm64: prefetch: add alternative pattern for CPUs without a prefetcher
      arm64: lib: improve copy_page to deal with 128 bytes at a time
      arm64: prefetch: add missing #include for spin_lock_prefetch
      arm64: kconfig: add submenu for 8.2 architectural features

Yang Shi (2):
      arm64: replace read_lock to rcu lock in call_step_hook
      arm64: ubsan: select ARCH_HAS_UBSAN_SANITIZE_ALL

 Documentation/arm64/booting.txt                    |  20 +-
 Documentation/arm64/silicon-errata.txt             |   1 +
 .../features/vm/huge-vmap/arch-support.txt         |   2 +-
 arch/arm/include/asm/kvm_asm.h                     |   2 +
 arch/arm/kvm/arm.c                                 |   8 +-
 arch/arm64/Kconfig                                 | 104 ++++
 arch/arm64/Kconfig.debug                           |   6 +-
 arch/arm64/Makefile                                |  10 +-
 arch/arm64/boot/dts/nvidia/tegra132.dtsi           |   2 +-
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           |   2 +-
 arch/arm64/include/asm/acpi.h                      |  19 +-
 arch/arm64/include/asm/alternative.h               |  63 +++
 arch/arm64/include/asm/assembler.h                 |  26 +-
 arch/arm64/include/asm/atomic_lse.h                |  38 +-
 arch/arm64/include/asm/boot.h                      |   6 +
 arch/arm64/include/asm/brk-imm.h                   |  25 +
 arch/arm64/include/asm/bug.h                       |   2 +-
 arch/arm64/include/asm/cpu.h                       |   1 +
 arch/arm64/include/asm/cpufeature.h                |  41 +-
 arch/arm64/include/asm/cputype.h                   |  31 +-
 arch/arm64/include/asm/debug-monitors.h            |  14 +-
 arch/arm64/include/asm/elf.h                       |  24 +-
 arch/arm64/include/asm/fixmap.h                    |  11 +
 arch/arm64/include/asm/ftrace.h                    |   2 +-
 arch/arm64/include/asm/futex.h                     |  12 +-
 arch/arm64/include/asm/hardirq.h                   |   2 +-
 arch/arm64/include/asm/kasan.h                     |   5 +-
 arch/arm64/include/asm/kernel-pgtable.h            |  12 +
 arch/arm64/include/asm/kvm_arm.h                   |   2 +-
 arch/arm64/include/asm/kvm_asm.h                   |   2 +
 arch/arm64/include/asm/kvm_host.h                  |  12 +-
 arch/arm64/include/asm/kvm_mmu.h                   |   2 +-
 arch/arm64/include/asm/lse.h                       |   1 +
 arch/arm64/include/asm/memory.h                    |  65 ++-
 arch/arm64/include/asm/mmu_context.h               |  64 ++-
 arch/arm64/include/asm/module.h                    |  17 +
 arch/arm64/include/asm/pgalloc.h                   |  26 +-
 arch/arm64/include/asm/pgtable-prot.h              |  92 ++++
 arch/arm64/include/asm/pgtable.h                   | 178 ++++---
 arch/arm64/include/asm/processor.h                 |   9 +-
 arch/arm64/include/asm/ptrace.h                    |  33 +-
 arch/arm64/include/asm/smp.h                       |  46 ++
 arch/arm64/include/asm/sysreg.h                    |  23 +-
 arch/arm64/include/asm/uaccess.h                   |  82 ++--
 arch/arm64/include/asm/word-at-a-time.h            |   7 +-
 arch/arm64/include/uapi/asm/hwcap.h                |   2 +
 arch/arm64/include/uapi/asm/ptrace.h               |   1 +
 arch/arm64/kernel/Makefile                         |   3 +
 arch/arm64/kernel/acpi_parking_protocol.c          | 141 ++++++
 arch/arm64/kernel/armv8_deprecated.c               |   7 +-
 arch/arm64/kernel/asm-offsets.c                    |   2 +
 arch/arm64/kernel/cpu_errata.c                     |  27 +-
 arch/arm64/kernel/cpu_ops.c                        |  27 +-
 arch/arm64/kernel/cpufeature.c                     | 270 ++++++-----
 arch/arm64/kernel/cpuinfo.c                        |   3 +
 arch/arm64/kernel/debug-monitors.c                 |  23 +-
 arch/arm64/kernel/efi-entry.S                      |   3 +-
 arch/arm64/kernel/fpsimd.c                         |   2 +-
 arch/arm64/kernel/head.S                           | 167 ++++++-
 arch/arm64/kernel/image.h                          |  45 +-
 arch/arm64/kernel/kaslr.c                          | 177 +++++++
 arch/arm64/kernel/kgdb.c                           |   4 +-
 arch/arm64/kernel/module-plts.c                    | 201 ++++++++
 arch/arm64/kernel/module.c                         |  25 +-
 arch/arm64/kernel/module.lds                       |   3 +
 arch/arm64/kernel/process.c                        |  16 +
 arch/arm64/kernel/ptrace.c                         |  80 +++-
 arch/arm64/kernel/setup.c                          |  36 ++
 arch/arm64/kernel/signal.c                         |   4 +-
 arch/arm64/kernel/signal32.c                       |   4 +-
 arch/arm64/kernel/smp.c                            |  99 +++-
 arch/arm64/kernel/suspend.c                        |  20 +-
 arch/arm64/kernel/vdso/vdso.S                      |   3 +-
 arch/arm64/kernel/vmlinux.lds.S                    |  30 +-
 arch/arm64/kvm/hyp.S                               |   6 +-
 arch/arm64/kvm/hyp/debug-sr.c                      |   1 +
 arch/arm64/kvm/sys_regs.c                          |   2 +-
 arch/arm64/lib/Makefile                            |  13 +-
 arch/arm64/lib/clear_user.S                        |  12 +-
 arch/arm64/lib/copy_from_user.S                    |  12 +-
 arch/arm64/lib/copy_in_user.S                      |  20 +-
 arch/arm64/lib/copy_page.S                         |  63 ++-
 arch/arm64/lib/copy_to_user.S                      |  12 +-
 arch/arm64/lib/memcmp.S                            |   2 +-
 arch/arm64/mm/context.c                            |  54 ++-
 arch/arm64/mm/dump.c                               |  21 +-
 arch/arm64/mm/extable.c                            |   2 +-
 arch/arm64/mm/fault.c                              |  34 +-
 arch/arm64/mm/init.c                               | 130 ++++-
 arch/arm64/mm/kasan_init.c                         |  70 ++-
 arch/arm64/mm/mmu.c                                | 526 +++++++++++++--------
 arch/arm64/mm/pageattr.c                           |  46 +-
 arch/arm64/mm/proc.S                               |  40 ++
 arch/x86/include/asm/efi.h                         |   2 +
 drivers/firmware/efi/libstub/Makefile              |   2 +-
 drivers/firmware/efi/libstub/arm-stub.c            |  40 +-
 drivers/firmware/efi/libstub/arm64-stub.c          |  78 ++-
 drivers/firmware/efi/libstub/efi-stub-helper.c     |   7 +-
 drivers/firmware/efi/libstub/efistub.h             |   7 +
 drivers/firmware/efi/libstub/fdt.c                 |  14 +
 drivers/firmware/efi/libstub/random.c              | 135 ++++++
 drivers/of/fdt.c                                   |  19 +-
 include/asm-generic/fixmap.h                       |  12 +-
 include/linux/efi.h                                |   6 +-
 lib/extable.c                                      |  50 +-
 scripts/sortextable.c                              |  10 +-
 106 files changed, 3128 insertions(+), 897 deletions(-)
 create mode 100644 arch/arm64/include/asm/brk-imm.h
 create mode 100644 arch/arm64/include/asm/pgtable-prot.h
 create mode 100644 arch/arm64/kernel/acpi_parking_protocol.c
 create mode 100644 arch/arm64/kernel/kaslr.c
 create mode 100644 arch/arm64/kernel/module-plts.c
 create mode 100644 arch/arm64/kernel/module.lds
 create mode 100644 drivers/firmware/efi/libstub/random.c

----------------------------------------------------------------

    Merge branch 'for-next/core' into HEAD

    * for-next/core: (99 commits)
      ...

    Conflicts:
    	arch/arm/kvm/arm.c
    	arch/arm64/include/asm/cpufeature.h
    	arch/arm64/kernel/cpufeature.c
    	arch/arm64/kvm/hyp.S
    	arch/arm64/mm/init.c

diff --cc arch/arm/kvm/arm.c
index 76552b51c7ae,975da6cfbf59..3e0fb66d8e05
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@@ -1051,10 -982,9 +1051,10 @@@ static void cpu_init_hyp_mode(void *dum
  	pgd_ptr = kvm_mmu_get_httbr();
  	stack_page = __this_cpu_read(kvm_arm_hyp_stack_page);
  	hyp_stack_ptr = stack_page + PAGE_SIZE;
- 	vector_ptr = (unsigned long)__kvm_hyp_vector;
+ 	vector_ptr = (unsigned long)kvm_ksym_ref(__kvm_hyp_vector);
  
  	__cpu_init_hyp_mode(boot_pgd_ptr, pgd_ptr, hyp_stack_ptr, vector_ptr);
 +	__cpu_init_stage2();
  
  	kvm_arm_init_debug();
  }
@@@ -1220,16 -1074,18 +1220,18 @@@ static int init_hyp_mode(void
  	/*
  	 * Map the Hyp-code called directly from the host
  	 */
- 	err = create_hyp_mappings(__hyp_text_start, __hyp_text_end);
 -	err = create_hyp_mappings(kvm_ksym_ref(__kvm_hyp_code_start),
 -				  kvm_ksym_ref(__kvm_hyp_code_end));
++	err = create_hyp_mappings(kvm_ksym_ref(__hyp_text_start),
++				  kvm_ksym_ref(__hyp_text_end));
  	if (err) {
  		kvm_err("Cannot map world-switch code\n");
 -		goto out_free_mappings;
 +		goto out_err;
  	}
  
- 	err = create_hyp_mappings(__start_rodata, __end_rodata);
+ 	err = create_hyp_mappings(kvm_ksym_ref(__start_rodata),
+ 				  kvm_ksym_ref(__end_rodata));
  	if (err) {
  		kvm_err("Cannot map rodata section\n");
 -		goto out_free_mappings;
 +		goto out_err;
  	}
  
  	/*
diff --cc arch/arm64/Kconfig
index b3f2522d266d,dbd47bb9caf2..4f436220384f
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@@ -748,21 -767,86 +765,99 @@@ config ARM64_LSE_ATOMIC
  	  not support these instructions and requires the kernel to be
  	  built with binutils >= 2.25.
  
 +config ARM64_VHE
 +	bool "Enable support for Virtualization Host Extensions (VHE)"
 +	default y
 +	help
 +	  Virtualization Host Extensions (VHE) allow the kernel to run
 +	  directly at EL2 (instead of EL1) on processors that support
 +	  it. This leads to better performance for KVM, as they reduce
 +	  the cost of the world switch.
 +
 +	  Selecting this option allows the VHE feature to be detected
 +	  at runtime, and does not affect processors that do not
 +	  implement this feature.
 +
  endmenu
  
+ menu "ARMv8.2 architectural features"
+ 
+ config ARM64_UAO
+ 	bool "Enable support for User Access Override (UAO)"
+ 	default y
+ 	help
+ 	  User Access Override (UAO; part of the ARMv8.2 Extensions)
+ 	  causes the 'unprivileged' variant of the load/store instructions to
+ 	  be overriden to be privileged.
+ 
+ 	  This option changes get_user() and friends to use the 'unprivileged'
+ 	  variant of the load/store instructions. This ensures that user-space
+ 	  really did have access to the supplied memory. When addr_limit is
+ 	  set to kernel memory the UAO bit will be set, allowing privileged
+ 	  access to kernel memory.
+ 
+ 	  Choosing this option will cause copy_to_user() et al to use user-space
+ 	  memory permissions.
+ 
+ 	  The feature is detected at runtime, the kernel will use the
+ 	  regular load/store instructions if the cpu does not implement the
+ 	  feature.
+ 
+ endmenu
+ 
+ config ARM64_MODULE_CMODEL_LARGE
+ 	bool
+ 
+ config ARM64_MODULE_PLTS
+ 	bool
+ 	select ARM64_MODULE_CMODEL_LARGE
+ 	select HAVE_MOD_ARCH_SPECIFIC
+ 
+ config RELOCATABLE
+ 	bool
+ 	help
+ 	  This builds the kernel as a Position Independent Executable (PIE),
+ 	  which retains all relocation metadata required to relocate the
+ 	  kernel binary at runtime to a different virtual address than the
+ 	  address it was linked at.
+ 	  Since AArch64 uses the RELA relocation format, this requires a
+ 	  relocation pass at runtime even if the kernel is loaded at the
+ 	  same address it was linked at.
+ 
+ config RANDOMIZE_BASE
+ 	bool "Randomize the address of the kernel image"
+ 	select ARM64_MODULE_PLTS
+ 	select RELOCATABLE
+ 	help
+ 	  Randomizes the virtual address at which the kernel image is
+ 	  loaded, as a security feature that deters exploit attempts
+ 	  relying on knowledge of the location of kernel internals.
+ 
+ 	  It is the bootloader's job to provide entropy, by passing a
+ 	  random u64 value in /chosen/kaslr-seed at kernel entry.
+ 
+ 	  When booting via the UEFI stub, it will invoke the firmware's
+ 	  EFI_RNG_PROTOCOL implementation (if available) to supply entropy
+ 	  to the kernel proper. In addition, it will randomise the physical
+ 	  location of the kernel Image as well.
+ 
+ 	  If unsure, say N.
+ 
+ config RANDOMIZE_MODULE_REGION_FULL
+ 	bool "Randomize the module region independently from the core kernel"
+ 	depends on RANDOMIZE_BASE
+ 	default y
+ 	help
+ 	  Randomizes the location of the module region without considering the
+ 	  location of the core kernel. This way, it is impossible for modules
+ 	  to leak information about the location of core kernel data structures
+ 	  but it does imply that function calls between modules and the core
+ 	  kernel will need to be resolved via veneers in the module PLT.
+ 
+ 	  When this option is not set, the module region will be randomized over
+ 	  a limited range that contains the [_stext, _etext] interval of the
+ 	  core kernel, so branch relocations are always in range.
+ 
  endmenu
  
  menu "Boot options"
diff --cc arch/arm64/include/asm/cpufeature.h
index a5c769b1c65b,f6f7423e51d0..b9b649422fca
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@@ -30,12 -30,12 +30,13 @@@
  #define ARM64_HAS_LSE_ATOMICS			5
  #define ARM64_WORKAROUND_CAVIUM_23154		6
  #define ARM64_WORKAROUND_834220			7
- /* #define ARM64_HAS_NO_HW_PREFETCH		8 */
- /* #define ARM64_HAS_UAO			9 */
- /* #define ARM64_ALT_PAN_NOT_UAO		10 */
+ #define ARM64_HAS_NO_HW_PREFETCH		8
+ #define ARM64_HAS_UAO				9
+ #define ARM64_ALT_PAN_NOT_UAO			10
 +#define ARM64_HAS_VIRT_HOST_EXTN		11
+ #define ARM64_WORKAROUND_CAVIUM_27456		12
  
- #define ARM64_NCAPS				12
+ #define ARM64_NCAPS				13
  
  #ifndef __ASSEMBLY__
  
diff --cc arch/arm64/include/asm/pgtable.h
index 819aff5d593f,e308807105e2..989fef16d461
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@@ -34,26 -26,18 +26,20 @@@
  /*
   * VMALLOC and SPARSEMEM_VMEMMAP ranges.
   *
 - * VMEMAP_SIZE: allows the whole VA space to be covered by a struct page array
 + * VMEMAP_SIZE: allows the whole linear region to be covered by a struct page array
   *	(rounded up to PUD_SIZE).
-  * VMALLOC_START: beginning of the kernel VA space
+  * VMALLOC_START: beginning of the kernel vmalloc space
   * VMALLOC_END: extends to the available space below vmmemmap, PCI I/O space,
   *	fixed mappings and modules
   */
  #define VMEMMAP_SIZE		ALIGN((1UL << (VA_BITS - PAGE_SHIFT)) * sizeof(struct page), PUD_SIZE)
  
- #ifndef CONFIG_KASAN
- #define VMALLOC_START		(VA_START)
- #else
- #include <asm/kasan.h>
- #define VMALLOC_START		(KASAN_SHADOW_END + SZ_64K)
- #endif
- 
+ #define VMALLOC_START		(MODULES_END)
  #define VMALLOC_END		(PAGE_OFFSET - PUD_SIZE - VMEMMAP_SIZE - SZ_64K)
  
 -#define vmemmap			((struct page *)(VMALLOC_END + SZ_64K))
 +#define VMEMMAP_START		(VMALLOC_END + SZ_64K)
 +#define vmemmap			((struct page *)VMEMMAP_START - \
 +				 SECTION_ALIGN_DOWN(memstart_addr >> PAGE_SHIFT))
  
  #define FIRST_USER_ADDRESS	0UL
  
diff --cc arch/arm64/kernel/cpufeature.c
index ba745199297e,392c67eb9fa6..c2c42534c7fa
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@@ -24,9 -24,9 +24,10 @@@
  #include <asm/cpu.h>
  #include <asm/cpufeature.h>
  #include <asm/cpu_ops.h>
+ #include <asm/mmu_context.h>
  #include <asm/processor.h>
  #include <asm/sysreg.h>
 +#include <asm/virt.h>
  
  unsigned long elf_hwcap __read_mostly;
  EXPORT_SYMBOL_GPL(elf_hwcap);
@@@ -622,11 -647,18 +648,23 @@@ static bool has_useable_gicv3_cpuif(con
  	return has_sre;
  }
  
 +static bool runs_at_el2(const struct arm64_cpu_capabilities *entry)
 +{
 +	return is_kernel_in_hyp_mode();
 +}
 +
+ static bool has_no_hw_prefetch(const struct arm64_cpu_capabilities *entry)
+ {
+ 	u32 midr = read_cpuid_id();
+ 	u32 rv_min, rv_max;
+ 
+ 	/* Cavium ThunderX pass 1.x and 2.x */
+ 	rv_min = 0;
+ 	rv_max = (1 << MIDR_VARIANT_SHIFT) | MIDR_REVISION_MASK;
+ 
+ 	return MIDR_IS_CPU_MODEL_RANGE(midr, MIDR_THUNDERX, rv_min, rv_max);
+ }
+ 
  static const struct arm64_cpu_capabilities arm64_features[] = {
  	{
  		.desc = "GIC system register CPU interface",
@@@ -658,10 -693,27 +699,32 @@@
  	},
  #endif /* CONFIG_AS_LSE && CONFIG_ARM64_LSE_ATOMICS */
  	{
 +		.desc = "Virtualization Host Extensions",
 +		.capability = ARM64_HAS_VIRT_HOST_EXTN,
 +		.matches = runs_at_el2,
 +	},
++	{
+ 		.desc = "Software prefetching using PRFM",
+ 		.capability = ARM64_HAS_NO_HW_PREFETCH,
+ 		.matches = has_no_hw_prefetch,
+ 	},
+ #ifdef CONFIG_ARM64_UAO
+ 	{
+ 		.desc = "User Access Override",
+ 		.capability = ARM64_HAS_UAO,
+ 		.matches = has_cpuid_feature,
+ 		.sys_reg = SYS_ID_AA64MMFR2_EL1,
+ 		.field_pos = ID_AA64MMFR2_UAO_SHIFT,
+ 		.min_field_value = 1,
+ 		.enable = cpu_enable_uao,
+ 	},
+ #endif /* CONFIG_ARM64_UAO */
+ #ifdef CONFIG_ARM64_PAN
+ 	{
+ 		.capability = ARM64_ALT_PAN_NOT_UAO,
+ 		.matches = cpufeature_pan_not_uao,
+ 	},
+ #endif /* CONFIG_ARM64_PAN */
  	{},
  };
  
diff --cc arch/arm64/kernel/head.S
index 6f2f37743d3b,50c2134a4aaf..6ebd204da16a
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@@ -29,8 -29,8 +29,9 @@@
  #include <asm/asm-offsets.h>
  #include <asm/cache.h>
  #include <asm/cputype.h>
+ #include <asm/elf.h>
  #include <asm/kernel-pgtable.h>
 +#include <asm/kvm_arm.h>
  #include <asm/memory.h>
  #include <asm/pgtable-hwdef.h>
  #include <asm/pgtable.h>
diff --cc arch/arm64/kvm/hyp.S
index 0689a74e6ba0,870578f84b1c..48f19a37b3df
--- a/arch/arm64/kvm/hyp.S
+++ b/arch/arm64/kvm/hyp.S
@@@ -17,12 -17,10 +17,12 @@@
  
  #include <linux/linkage.h>
  
 +#include <asm/alternative.h>
  #include <asm/assembler.h>
 +#include <asm/cpufeature.h>
  
  /*
-  * u64 kvm_call_hyp(void *hypfn, ...);
+  * u64 __kvm_call_hyp(void *hypfn, ...);
   *
   * This is not really a variadic function in the classic C-way and care must
   * be taken when calling this to ensure parameters are passed in registers
@@@ -39,12 -37,7 +39,12 @@@
   * used to implement __hyp_get_vectors in the same way as in
   * arch/arm64/kernel/hyp_stub.S.
   */
- ENTRY(kvm_call_hyp)
+ ENTRY(__kvm_call_hyp)
 +alternative_if_not ARM64_HAS_VIRT_HOST_EXTN	
  	hvc	#0
  	ret
 +alternative_else
 +	b	__vhe_hyp_call
 +	nop
 +alternative_endif
- ENDPROC(kvm_call_hyp)
+ ENDPROC(__kvm_call_hyp)
diff --cc arch/arm64/kvm/hyp/debug-sr.c
index 053cf8b057c1,2f8bca8af295..33342a776ec7
--- a/arch/arm64/kvm/hyp/debug-sr.c
+++ b/arch/arm64/kvm/hyp/debug-sr.c
@@@ -18,8 -18,11 +18,9 @@@
  #include <linux/compiler.h>
  #include <linux/kvm_host.h>
  
+ #include <asm/debug-monitors.h>
  #include <asm/kvm_asm.h>
 -#include <asm/kvm_mmu.h>
 -
 -#include "hyp.h"
 +#include <asm/kvm_hyp.h>
  
  #define read_debug(r,n)		read_sysreg(r##n##_el1)
  #define write_debug(v,r,n)	write_sysreg(v, r##n##_el1)
diff --cc arch/arm64/mm/init.c
index 7802f216a67a,8c3d7dd91c25..61a38eaf0895
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@@ -317,11 -382,16 +382,16 @@@ void __init mem_init(void
  #ifdef CONFIG_KASAN
  		  MLG(KASAN_SHADOW_START, KASAN_SHADOW_END),
  #endif
+ 		  MLM(MODULES_VADDR, MODULES_END),
  		  MLG(VMALLOC_START, VMALLOC_END),
+ 		  MLK_ROUNDUP(_text, __start_rodata),
+ 		  MLK_ROUNDUP(__start_rodata, _etext),
+ 		  MLK_ROUNDUP(__init_begin, __init_end),
+ 		  MLK_ROUNDUP(_sdata, _edata),
  #ifdef CONFIG_SPARSEMEM_VMEMMAP
 -		  MLG((unsigned long)vmemmap,
 -		      (unsigned long)vmemmap + VMEMMAP_SIZE),
 +		  MLG(VMEMMAP_START,
 +		      VMEMMAP_START + VMEMMAP_SIZE),
- 		  MLM((unsigned long)virt_to_page(PAGE_OFFSET),
+ 		  MLM((unsigned long)phys_to_page(memblock_start_of_DRAM()),
  		      (unsigned long)virt_to_page(high_memory)),
  #endif
  		  MLK(FIXADDR_START, FIXADDR_TOP),
diff --cc scripts/sortextable.c
index 7b29fb14f870,19d83647846c..62a1822e0f41
--- a/scripts/sortextable.c
+++ b/scripts/sortextable.c
@@@ -310,10 -281,8 +310,11 @@@ do_file(char const *const fname
  		break;
  	case EM_386:
  	case EM_X86_64:
 +		custom_sort = x86_sort_relative_table;
 +		break;
 +
  	case EM_S390:
+ 	case EM_AARCH64:
  		custom_sort = sort_relative_table;
  		break;
  	case EM_ARCOMPACT:
