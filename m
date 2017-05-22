From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Mon, 22 May 2017 09:25:33 +0900
Subject: [PATCH v35 00/14] arm64: add kdump support
In-Reply-To: <20170403022139.12383-1-takahiro.akashi@linaro.org>
References: <20170403022139.12383-1-takahiro.akashi@linaro.org>
Message-ID: <20170522002532.GB6544@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 03, 2017 at 11:21:39AM +0900, AKASHI Takahiro wrote:
> This patch series adds kdump support on arm64.
> 
> To load a crash-dump kernel to the systems, a series of patches to
> kexec-tools[1] are also needed. Please use the latest one, v6 [2].
> For your convinience, you can pick them up from:
>    https://git.linaro.org/people/takahiro.akashi/linux-aarch64.git arm64/kdump
>    https://git.linaro.org/people/takahiro.akashi/kexec-tools.git arm64/kdump

Please note that I updated kexec-tools to v7:
  http://lists.infradead.org/pipermail/kexec/2017-May/018770.html

The repo above now has it.

Thanks,
-Takahiro AKASHI

> To examine vmcore (/proc/vmcore) on a crash-dump kernel, you can use
>   - crash utility (v7.1.8 or later) [3]
> 
> I tested this patchset on fast model and hikey.
> 
> The previous versions were also:
> Tested-by: Pratyush Anand <panand@redhat.com> (v33, mustang and seattle)
> Tested-by: James Morse <james.morse@arm.com> (v27/v32?, Juno)
> Tested-by: Sameer Goel (v33, QDT2400)
> 
> Changes for v35 (Apr 3, 2017)
>   o rebased to arm64/for-next/core, solving conflicts on mmu.c (patch#6)
> 
> Changes for v34 (Mar 28, 2017)
>   o add and use set_memory_valid() instead of create_pgd_mapping()
>     (patch #5,6)
>   o rename functions from kexec_* to crash_* (patch #7)
>   o supress WARN_ON() message if successfully shutting down secondary cpus
>     (patch #8)
> 
> Changes for v33 (Mar 15, 2017)
>   o rebased to v4.11-rc2+
>   o arch_kexec_(un)protect_crashkres() now protects loaded data segments
>     only along with moving copying of control_code_page back to machine_kexec()
>     (patch #6)
>   o reduce the size of hibernation image when kdump and hibernation are
>     comfigured at the same time (patch #7)
>   o clearify that "linux,usable-memory-range" and "linux,elfcorehdr"
>     have values of the size of root node's "#address-cells" and "#size-cells"
>     (patch #13)
>   o add "efi/libstub/arm*: Set default address and size cells values for
>     an empty dtb" from Sameer Goel (patch #14)
>     (I didn't test the case though.)
> 
> Changes for v32 (Feb 7, 2017)
>   o isolate crash dump kernel memory as well as kernel text/data by using
>     MEMBLOCK_MAP attribute to and then specifically map them in map_mem()
>     (patch #1,6)
>   o delete remove_pgd_mapping() and instead modify create_pgd_mapping() to
>     allowing for unmapping a kernel mapping (patch #5)
>   o correct a commit message as well as a comment in the source (patch#10)
>   o other trivial changes after Mark's comments (patch#3,4)
> 
> Changes for v31 (Feb 1, 2017)
>   o add/use remove_pgd_mapping() instead of modifying (__)create_pgd_mapping()
>     to protect crash dump kernel memory (patch #4,5)
>   o fix an issue at the isolation of crash dump kernel memory in
>     map_mem()/__map_memblock(), adding map_crashkernel() (patch#5)
>   o preserve the contents of crash dump kernel memory around hibernation
>     (patch#6)
> 
> Changes for v30 (Jan 24, 2017)
>   o rebased to Linux-v4.10-rc5
>   o remove "linux,crashkernel-base/size" from exported device tree
>   o protect memory region for crash-dump kernel (adding patch#4,5)
>   o remove "in_crash_kexec" variable
>   o and other trivial changes
> 
> Changes for v29 (Dec 28, 2016)
>   o rebased to Linux-v4.10-rc1
>   o change asm constraints in crash_setup_regs() per Catalin
> 
> Changes for v28 (Nov 22, 2016)
>   o rebased to Linux-v4.9-rc6
>   o revamp patch #1 and merge memblock_cap_memory_range() with
>     memblock_mem_limit_remove_map()
> 
> Changes for v27 (Nov 1, 2016)
>   o rebased to Linux-v4.9-rc3
>   o revert v26 change, i.e. revive "linux,usable-memory-range" property
>     (patch #2/#3, updating patch #9)
>   o minor fixes per review comments (patch #3/#4/#6/#8)
>   o re-order patches and improve commit messages for readability
> 
> Changes for v26 (Sep 7, 2016):
>   o Use /reserved-memory instead of "linux,usable-memory-range" property
>     (dropping v25's patch#2 and #3, updating ex-patch#9.)
> 
> Changes for v25 (Aug 29, 2016):
>   o Rebase to Linux-4.8-rc4
>   o Use memremap() instead of ioremap_cache() [patch#5]
> 
> Changes for v24 (Aug 9, 2016):
>   o Rebase to Linux-4.8-rc1
>   o Update descriptions about newly added DT proerties
> 
> Changes for v23 (July 26, 2016):
> 
>   o Move memblock_reserve() to a single place in reserve_crashkernel()
>   o Use  cpu_park_loop() in ipi_cpu_crash_stop()
>   o Always enforce ARCH_LOW_ADDRESS_LIMIT to the memory range of crash kernel
>   o Re-implement fdt_enforce_memory_region() to remove non-reserve regions
>     (for ACPI) from usable memory at crash kernel
> 
> Changes for v22 (July 12, 2016):
> 
>   o Export "crashkernel-base" and "crashkernel-size" via device-tree,
>     and add some descriptions about them in chosen.txt
>   o Rename "usable-memory" to "usable-memory-range" to avoid inconsistency
>     with powerpc's "usable-memory"
>   o Make cosmetic changes regarding "ifdef" usage
>   o Correct some wordings in kdump.txt
> 
> Changes for v21 (July 6, 2016):
> 
>   o Remove kexec patches.
>   o Rebase to arm64's for-next/core (Linux-4.7-rc4 based).
>   o Clarify the description about kvm in kdump.txt.
> 
> See the link [4] for older changes.
> 
> 
> [1] https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git
> [2] http://lists.infradead.org/pipermail/kexec/2017-March/018356.html
> [3] https://github.com/crash-utility/crash.git
> [4] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-June/438780.html
> 
> AKASHI Takahiro (11):
>   memblock: add memblock_clear_nomap()
>   memblock: add memblock_cap_memory_range()
>   arm64: limit memory regions based on DT property, usable-memory-range
>   arm64: kdump: reserve memory for crash dump kernel
>   arm64: mm: add set_memory_valid()
>   arm64: hibernate: preserve kdump image around hibernation
>   arm64: kdump: implement machine_crash_shutdown()
>   arm64: kdump: add VMCOREINFO's for user-space tools
>   arm64: kdump: provide /proc/vmcore file
>   arm64: kdump: enable kdump in defconfig
>   Documentation: kdump: describe arm64 port
> 
> James Morse (1):
>   Documentation: dt: chosen properties for arm64 kdump
> 
> Sameer Goel (1):
>   efi/libstub/arm*: Set default address and size cells values for an
>     empty dtb
> 
> Takahiro Akashi (1):
>   arm64: kdump: protect crash dump kernel memory
> 
>  Documentation/devicetree/bindings/chosen.txt |  45 +++++++
>  Documentation/kdump/kdump.txt                |  16 ++-
>  arch/arm64/Kconfig                           |  11 ++
>  arch/arm64/configs/defconfig                 |   1 +
>  arch/arm64/include/asm/cacheflush.h          |   1 +
>  arch/arm64/include/asm/hardirq.h             |   2 +-
>  arch/arm64/include/asm/kexec.h               |  52 +++++++-
>  arch/arm64/include/asm/smp.h                 |   3 +
>  arch/arm64/kernel/Makefile                   |   1 +
>  arch/arm64/kernel/crash_dump.c               |  71 +++++++++++
>  arch/arm64/kernel/hibernate.c                |  10 +-
>  arch/arm64/kernel/machine_kexec.c            | 170 +++++++++++++++++++++++--
>  arch/arm64/kernel/setup.c                    |   7 +-
>  arch/arm64/kernel/smp.c                      |  68 ++++++++++
>  arch/arm64/mm/init.c                         | 181 +++++++++++++++++++++++++++
>  arch/arm64/mm/mmu.c                          | 103 +++++++--------
>  arch/arm64/mm/pageattr.c                     |  15 ++-
>  drivers/firmware/efi/libstub/fdt.c           |  28 ++++-
>  include/linux/memblock.h                     |   2 +
>  mm/memblock.c                                |  56 ++++++---
>  20 files changed, 757 insertions(+), 86 deletions(-)
>  create mode 100644 arch/arm64/kernel/crash_dump.c
> 
> -- 
> 2.11.1
> 
