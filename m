From: will.deacon@arm.com (Will Deacon)
Date: Wed, 5 Jul 2017 10:30:13 +0100
Subject: [GIT PULL] arm64: updates for 4.13
Message-ID: <20170705093012.GB10112@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull the following arm64 updates for 4.13. The summary is in the tag,
but note that the RAS changes are based on Christoph's uuid-types branch [1]
(which you've already pulled) to avoid conflicts in the ACPI core.

There is a trivial conflict in drivers/acpi/apei/ghes.c, and the correct
resolution is just to add the new ACPI_HEST_NOTIFY_SEA cases to the
three switch statements [2].

Cheers,

Will

[1] http://git.infradead.org/users/hch/uuid.git/shortlog/refs/heads/uuid-types
[2]

diff --cc drivers/acpi/apei/ghes.c
index 0968816,bb83044..0000000
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@@ -718,10 -809,59 +809,59 @@@ static int ghes_notify_hed(struct notif
  	return ret;
  }
  
 -static struct notifier_block ghes_notifier_sci = {
 -	.notifier_call = ghes_notify_sci,
 +static struct notifier_block ghes_notifier_hed = {
 +	.notifier_call = ghes_notify_hed,
  };
  
+ #ifdef CONFIG_ACPI_APEI_SEA
+ static LIST_HEAD(ghes_sea);
+ 
+ /*
+  * Return 0 only if one of the SEA error sources successfully reported an error
+  * record sent from the firmware.
+  */
+ int ghes_notify_sea(void)
+ {
+ 	struct ghes *ghes;
+ 	int ret = -ENOENT;
+ 
+ 	rcu_read_lock();
+ 	list_for_each_entry_rcu(ghes, &ghes_sea, list) {
+ 		if (!ghes_proc(ghes))
+ 			ret = 0;
+ 	}
+ 	rcu_read_unlock();
+ 	return ret;
+ }
+ 
+ static void ghes_sea_add(struct ghes *ghes)
+ {
+ 	mutex_lock(&ghes_list_mutex);
+ 	list_add_rcu(&ghes->list, &ghes_sea);
+ 	mutex_unlock(&ghes_list_mutex);
+ }
+ 
+ static void ghes_sea_remove(struct ghes *ghes)
+ {
+ 	mutex_lock(&ghes_list_mutex);
+ 	list_del_rcu(&ghes->list);
+ 	mutex_unlock(&ghes_list_mutex);
+ 	synchronize_rcu();
+ }
+ #else /* CONFIG_ACPI_APEI_SEA */
+ static inline void ghes_sea_add(struct ghes *ghes)
+ {
+ 	pr_err(GHES_PFX "ID: %d, trying to add SEA notification which is not supported\n",
+ 	       ghes->generic->header.source_id);
+ }
+ 
+ static inline void ghes_sea_remove(struct ghes *ghes)
+ {
+ 	pr_err(GHES_PFX "ID: %d, trying to remove SEA notification which is not supported\n",
+ 	       ghes->generic->header.source_id);
+ }
+ #endif /* CONFIG_ACPI_APEI_SEA */
+ 
  #ifdef CONFIG_HAVE_ACPI_APEI_NMI
  /*
   * printk is not safe in NMI context.  So in NMI handler, we allocate
@@@ -966,10 -1095,15 +1095,17 @@@ static int ghes_probe(struct platform_d
  	case ACPI_HEST_NOTIFY_POLLED:
  	case ACPI_HEST_NOTIFY_EXTERNAL:
  	case ACPI_HEST_NOTIFY_SCI:
 +	case ACPI_HEST_NOTIFY_GSIV:
 +	case ACPI_HEST_NOTIFY_GPIO:
  		break;
- 
+ 	case ACPI_HEST_NOTIFY_SEA:
+ 		if (!IS_ENABLED(CONFIG_ACPI_APEI_SEA)) {
+ 			pr_warn(GHES_PFX "Generic hardware error source: %d notified via SEA is not supported\n",
+ 				generic->header.source_id);
+ 			rc = -ENOTSUPP;
+ 			goto err;
+ 		}
+ 		break;
  	case ACPI_HEST_NOTIFY_NMI:
  		if (!IS_ENABLED(CONFIG_HAVE_ACPI_APEI_NMI)) {
  			pr_warn(GHES_PFX "Generic hardware error source: %d notified via NMI interrupt is not supported!\n",
@@@ -1027,17 -1161,16 +1163,19 @@@
  			goto err_edac_unreg;
  		}
  		break;
 +
  	case ACPI_HEST_NOTIFY_SCI:
 +	case ACPI_HEST_NOTIFY_GSIV:
 +	case ACPI_HEST_NOTIFY_GPIO:
  		mutex_lock(&ghes_list_mutex);
 -		if (list_empty(&ghes_sci))
 -			register_acpi_hed_notifier(&ghes_notifier_sci);
 -		list_add_rcu(&ghes->list, &ghes_sci);
 +		if (list_empty(&ghes_hed))
 +			register_acpi_hed_notifier(&ghes_notifier_hed);
 +		list_add_rcu(&ghes->list, &ghes_hed);
  		mutex_unlock(&ghes_list_mutex);
  		break;
- 
+ 	case ACPI_HEST_NOTIFY_SEA:
+ 		ghes_sea_add(ghes);
+ 		break;
  	case ACPI_HEST_NOTIFY_NMI:
  		ghes_nmi_add(ghes);
  		break;

--->8

The following changes since commit 3c2993b8c6143d8a5793746a54eba8f86f95240f:

  Linux 4.12-rc4 (2017-06-04 16:47:43 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-upstream

for you to fetch changes up to 425e1ed73e6574e4fe186ec82fd37213cbd47df0:

  arm64: fix endianness annotation for 'struct jit_ctx' and friends (2017-06-30 17:11:28 +0100)

----------------------------------------------------------------
arm64 updates for 4.13:

- RAS reporting via GHES/APEI (ACPI)
- Indirect ftrace trampolines for modules
- Improvements to kernel fault reporting
- Page poisoning
- Sigframe cleanups and preparation for SVE context
- Core dump fixes
- Sparse fixes (mainly relating to endianness)
- xgene SoC PMU v3 driver
- Misc cleanups and non-critical fixes

----------------------------------------------------------------
Amir Goldstein (4):
      xfs: use uuid_copy() helper to abstract uuid_t
      md: namespace private helper names
      xfs: use the common helper uuid_is_null()
      tmpfs: generate random sb->s_uuid

Andy Shevchenko (6):
      acpi, nfit: Switch to use new generic UUID API
      ACPI / APEI: Switch to use new generic UUID API
      ACPI / bus: Switch to use new generic UUID API
      ACPI / extlog: Switch to use new generic UUID API
      ACPI: Switch to use generic guid_t in acpi_evaluate_dsm()
      thermal: int340x_thermal: Switch to use new generic UUID API

Ard Biesheuvel (6):
      arm64: kernel: restrict /dev/mem read() calls to linear region
      arm64: ftrace: don't validate branch via PLT in ftrace_make_nop()
      arm64: ftrace: add support for far branches to dynamic ftrace
      drivers/char: kmem: disable on arm64
      fs/proc: kcore: use kcore_list type to check for vmalloc/module address
      arm64: mm: select CONFIG_ARCH_PROC_KCORE_TEXT

Arnd Bergmann (1):
      ras: mark stub functions as 'inline'

Arvind Yadav (2):
      arm: perf: make of_device_ids const
      arm64: cpuinfo: constify attribute_group structures.

Christoph Hellwig (21):
      uuid,afs: move struct uuid_v1 back into afs
      xfs: use uuid_be to implement the uuid_t type
      nfsd: namespace-prefix uuid_parse
      uuid: remove uuid_be defintions from the uapi header
      uuid: rename uuid types
      uuid: don't export guid_index and uuid_index
      uuid: hoist helpers uuid_equal() and uuid_copy() from xfs
      uuid: hoist uuid_is_null() helper from libnvdimm
      S390/sysinfo: use uuid_is_null instead of opencoding it
      xfs: remove uuid_getnodeuniq and xfs_uu_t
      block: remove blk_part_pack_uuid
      ima/policy: switch to use uuid_t
      fs: switch ->s_uuid to uuid_t
      overlayfs: use uuid_t instead of uuid_be
      partitions/ldm: switch to use uuid_t
      sysctl: switch to use uuid_t
      nvme: switch to uuid_t
      scsi_debug: switch to uuid_t
      MAINTAINERS: add uuid entry
      acpi: always include uuid.h
      thermal: int340x_thermal: fix compile after the UUID API switch

Dave Martin (11):
      arm64: signal: split frame link record from sigcontext structure
      arm64: signal: Refactor sigcontext parsing in rt_sigreturn
      arm64: signal: factor frame layout and population into separate passes
      arm64: signal: factor out signal frame record allocation
      arm64: ptrace: Fix VFP register dumping in compat coredumps
      arm64: ptrace: Flush FPSIMD regs back to thread_struct before reading
      arm64: ptrace: Flush user-RW TLS reg to thread_struct before reading
      arm64: signal: Allow expansion of the signal frame
      arm64: ptrace: Avoid setting compat FP[SC]R to garbage if get_user fails
      arm64: ptrace: Remove redundant overrun check from compat_vfp_set()
      arm64: ptrace: Fix incorrect get_user() use in compat_vfp_set()

Dong Bo (1):
      arm64: Preventing READ_IMPLIES_EXEC propagation

Dustin Brown (1):
      arm64: Export save_stack_trace_tsk()

Hoan Tran (3):
      perf: xgene: Parse PMU subnode from the match table
      perf: xgene: Move PMU leaf functions into function pointer structure
      perf: xgene: Add support for SoC PMU version 3

Jonathan (Zhixiong) Zhang (3):
      arm64: hwpoison: add VM_FAULT_HWPOISON[_LARGE] handling
      arm64: kconfig: allow support for memory failure handling
      acpi: apei: panic OS with fatal error status block

Kees Cook (1):
      arm64, vdso: Define vdso_{start,end} as array

Kefeng Wang (3):
      arm64: Call __show_regs directly
      arm64: Add dump_backtrace() in show_regs
      arm64: check return value of of_flat_dt_get_machine_name

Kristina Martsenko (3):
      arm64: mm: print out correct page table entries
      arm64: mm: don't print out page table entries on EL0 faults
      arm64: mm: print file name of faulting vma

Lorenzo Pieralisi (3):
      ARM64/PCI: Set root bus NUMA node on ACPI systems
      ARM64/irqchip: Update ACPI_IORT symbol selection logic
      ACPI/IORT: Remove iort_node_match()

Luc Van Oostenryck (13):
      arm64: pass machine size to sparse
      arm64: pass endianness info to sparse
      arm64: fix endianness annotation for debug-monitors.c
      arm64: fix endianness annotation in call_undef_hook()
      arm64: fix endianness annotation in aarch64_insn_read()
      arm64: fix endianness annotation for aarch64_insn_write()
      arm64: fix endianness annotation for reloc_insn_movw() & reloc_insn_imm()
      arm64: use readq() instead of readl() to read 64bit entry_point
      arm64: fix endianness annotation in acpi_parking_protocol.c
      arm64: add missing conversion to __wsum in ip_fast_csum()
      arm64: fix endianness annotation in get_kaslr_seed()
      arm64: fix endianness annotation for __apply_alternatives()/get_alt_insn()
      arm64: fix endianness annotation for 'struct jit_ctx' and friends

Mark Rutland (3):
      drivers/perf: commonise PERF_EVENTS dependency
      arm64: dump cpu_hwcaps at panic time
      arm64: ftrace: fix !CONFIG_ARM64_MODULE_PLTS kernels

Olav Haugan (1):
      arm64/dma-mapping: Remove extraneous null-pointer checks

Punit Agrawal (2):
      arm64: hugetlb: Fix huge_pte_offset to return poisoned page table entries
      arm64: mm: Update perf accounting to handle poison faults

Shaokun Zhang (1):
      arm64: perf: Extend event config for ARMv8.1

Tobias Klauser (1):
      arm64: mm: explicity include linux/vmalloc.h

Tyler Baicar (11):
      acpi: apei: read ack upon ghes record consumption
      ras: acpi/apei: cper: add support for generic data v3 structure
      cper: add timestamp print to CPER status printing
      efi: parse ARM processor error
      arm64: exception: handle Synchronous External Abort
      acpi: apei: handle SEA notification type for ARMv8
      efi: print unrecognized CPER section
      ras: acpi / apei: generate trace event for unrecognized CPER section
      trace, ras: add ARM processor error trace event
      arm/arm64: KVM: add guest SEA support
      acpi: apei: check for pending errors when probing GHES entries

Will Deacon (8):
      arm64: cpufeature: Don't dump useless backtrace on CPU_OUT_OF_SPEC
      arm64: futex: Fix undefined behaviour with FUTEX_OP_OPARG_SHIFT usage
      arm64: cpufeature: Fix CPU_OUT_OF_SPEC taint for uniform systems
      arm64: fault: Print info about page table structure when dumping pte
      arm64: ftrace: fix building without CONFIG_MODULES
      Merge branch 'uuid-types' of git://git.infradead.org/users/hch/uuid into aarch64/for-next/ras-apei
      Merge branch 'perf/updates' into aarch64/for-next/core
      Merge branch 'aarch64/for-next/ras-apei' into aarch64/for-next/core

 MAINTAINERS                                        |  11 +
 arch/arm/include/asm/kvm_arm.h                     |  10 +
 arch/arm/include/asm/system_misc.h                 |   5 +
 arch/arm/kernel/perf_event_v6.c                    |   2 +-
 arch/arm64/Kconfig                                 |   9 +-
 arch/arm64/Makefile                                |   7 +-
 arch/arm64/include/asm/checksum.h                  |   2 +-
 arch/arm64/include/asm/dma-mapping.h               |   2 -
 arch/arm64/include/asm/elf.h                       |   6 +
 arch/arm64/include/asm/esr.h                       |   1 +
 arch/arm64/include/asm/futex.h                     |   8 +-
 arch/arm64/include/asm/kvm_arm.h                   |  10 +
 arch/arm64/include/asm/module.h                    |   3 +
 arch/arm64/include/asm/pgtable.h                   |   2 +-
 arch/arm64/include/asm/processor.h                 |   3 +
 arch/arm64/include/asm/stacktrace.h                |   1 +
 arch/arm64/include/asm/system_misc.h               |   4 +-
 arch/arm64/include/uapi/asm/sigcontext.h           |  55 ++
 arch/arm64/kernel/Makefile                         |   3 +
 arch/arm64/kernel/acpi_parking_protocol.c          |   6 +-
 arch/arm64/kernel/alternative.c                    |   8 +-
 arch/arm64/kernel/cpufeature.c                     |  25 +-
 arch/arm64/kernel/cpuinfo.c                        |   2 +-
 arch/arm64/kernel/debug-monitors.c                 |  14 +-
 arch/arm64/kernel/ftrace-mod.S                     |  18 +
 arch/arm64/kernel/ftrace.c                         | 103 +++-
 arch/arm64/kernel/insn.c                           |   7 +-
 arch/arm64/kernel/kaslr.c                          |   2 +-
 arch/arm64/kernel/module.c                         |  20 +-
 arch/arm64/kernel/pci.c                            |   3 +
 arch/arm64/kernel/perf_event.c                     |   2 +-
 arch/arm64/kernel/probes/kprobes.c                 |   4 +-
 arch/arm64/kernel/process.c                        |   9 +-
 arch/arm64/kernel/ptrace.c                         |  39 +-
 arch/arm64/kernel/setup.c                          |   3 +
 arch/arm64/kernel/signal.c                         | 413 +++++++++++--
 arch/arm64/kernel/stacktrace.c                     |   1 +
 arch/arm64/kernel/traps.c                          |  18 +-
 arch/arm64/kernel/vdso.c                           |  10 +-
 arch/arm64/mm/dma-mapping.c                        |   9 -
 arch/arm64/mm/fault.c                              | 215 +++++--
 arch/arm64/mm/hugetlbpage.c                        |  29 +-
 arch/arm64/mm/mmap.c                               |  19 +-
 arch/arm64/mm/mmu.c                                |   1 +
 arch/arm64/net/bpf_jit_comp.c                      |   6 +-
 arch/s390/include/asm/sysinfo.h                    |   4 +-
 arch/s390/kernel/sysinfo.c                         |   2 +-
 block/partitions/ldm.c                             |  10 +-
 block/partitions/ldm.h                             |   6 +-
 drivers/acpi/acpi_extlog.c                         |  20 +-
 drivers/acpi/apei/Kconfig                          |  15 +
 drivers/acpi/apei/ghes.c                           | 214 ++++++-
 drivers/acpi/apei/hest.c                           |   7 +-
 drivers/acpi/arm64/iort.c                          |  15 -
 drivers/acpi/bus.c                                 |  29 +-
 drivers/acpi/nfit/core.c                           |  54 +-
 drivers/acpi/nfit/nfit.h                           |   3 +-
 drivers/acpi/utils.c                               |  16 +-
 drivers/char/Kconfig                               |   2 +
 drivers/char/tpm/tpm_crb.c                         |   9 +-
 drivers/char/tpm/tpm_ppi.c                         |  20 +-
 drivers/firmware/efi/cper.c                        | 204 +++++-
 drivers/gpu/drm/i915/intel_acpi.c                  |  14 +-
 drivers/gpu/drm/nouveau/nouveau_acpi.c             |  20 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mxm/base.c     |   9 +-
 drivers/hid/i2c-hid/i2c-hid.c                      |   9 +-
 drivers/iommu/dmar.c                               |  11 +-
 drivers/irqchip/Kconfig                            |   1 -
 drivers/md/md.c                                    |   8 +-
 drivers/mmc/host/sdhci-pci-core.c                  |   9 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c |  15 +-
 drivers/nvdimm/btt_devs.c                          |   9 +-
 drivers/nvme/host/fabrics.c                        |   8 +-
 drivers/nvme/host/fabrics.h                        |   2 +-
 drivers/nvme/host/fc.c                             |   3 +-
 drivers/nvme/target/nvmet.h                        |   1 +
 drivers/pci/pci-acpi.c                             |  13 +-
 drivers/pci/pci-label.c                            |   4 +-
 drivers/perf/Kconfig                               |   9 +-
 drivers/perf/xgene_pmu.c                           | 684 +++++++++++++++++++--
 drivers/ras/ras.c                                  |  16 +-
 drivers/scsi/scsi_debug.c                          |  10 +-
 drivers/thermal/int340x_thermal/int3400_thermal.c  |   8 +-
 drivers/usb/dwc3/dwc3-pci.c                        |  10 +-
 drivers/usb/host/xhci-pci.c                        |   9 +-
 drivers/usb/misc/ucsi.c                            |   6 +-
 drivers/usb/typec/typec_wcove.c                    |   8 +-
 drivers/xen/tmem.c                                 |   6 +-
 fs/afs/cmservice.c                                 |  16 +-
 fs/afs/internal.h                                  |  11 +-
 fs/afs/main.c                                      |   2 +-
 fs/ext4/super.c                                    |   2 +-
 fs/f2fs/super.c                                    |   2 +-
 fs/gfs2/ops_fstype.c                               |   2 +-
 fs/gfs2/sys.c                                      |  22 +-
 fs/nfsd/export.c                                   |   4 +-
 fs/ocfs2/super.c                                   |   2 +-
 fs/overlayfs/copy_up.c                             |   7 +-
 fs/overlayfs/namei.c                               |   2 +-
 fs/overlayfs/overlayfs.h                           |   2 +-
 fs/proc/kcore.c                                    |   2 +-
 fs/xfs/Makefile                                    |   3 +-
 fs/xfs/uuid.c                                      |  63 --
 fs/xfs/uuid.h                                      |  35 --
 fs/xfs/xfs_inode_item.c                            |   8 +-
 fs/xfs/xfs_linux.h                                 |   2 +-
 fs/xfs/xfs_log_recover.c                           |   6 +-
 fs/xfs/xfs_mount.c                                 |  16 +-
 include/acpi/acpi_bus.h                            |  11 +-
 include/acpi/ghes.h                                |  48 +-
 include/linux/acpi.h                               |   4 +-
 include/linux/acpi_iort.h                          |   2 -
 include/linux/cleancache.h                         |   2 +-
 include/linux/cper.h                               |  54 ++
 include/linux/fs.h                                 |   5 +-
 include/linux/genhd.h                              |  11 -
 include/linux/nvme-fc.h                            |   3 +-
 include/linux/nvme.h                               |   3 +-
 include/linux/pci-acpi.h                           |   2 +-
 include/linux/ras.h                                |  17 +
 include/linux/uuid.h                               | 101 ++-
 include/ras/ras_event.h                            |  90 +++
 include/uapi/linux/uuid.h                          |  28 +-
 kernel/sysctl_binary.c                             |   4 +-
 lib/test_uuid.c                                    |  36 +-
 lib/uuid.c                                         |  33 +-
 lib/vsprintf.c                                     |   4 +-
 mm/cleancache.c                                    |   2 +-
 mm/shmem.c                                         |   2 +
 security/integrity/evm/evm_crypto.c                |   2 +-
 security/integrity/ima/ima_policy.c                |  12 +-
 sound/soc/intel/skylake/skl-nhlt.c                 |   7 +-
 tools/testing/nvdimm/test/iomap.c                  |   6 +-
 tools/testing/nvdimm/test/nfit.c                   |   2 +-
 tools/testing/nvdimm/test/nfit_test.h              |   4 +-
 virt/kvm/arm/mmu.c                                 |  36 +-
 136 files changed, 2562 insertions(+), 840 deletions(-)
 create mode 100644 arch/arm64/kernel/ftrace-mod.S
 delete mode 100644 fs/xfs/uuid.c
 delete mode 100644 fs/xfs/uuid.h
