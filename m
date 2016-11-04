From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri, 4 Nov 2016 12:00:26 +0900
Subject: [PATCH v27 0/9] arm64: add kdump support
In-Reply-To: <20161102044959.11954-1-takahiro.akashi@linaro.org>
References: <20161102044959.11954-1-takahiro.akashi@linaro.org>
Message-ID: <20161104030025.GC381@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For easier testing, I pushed my patches to:
https://git.linaro.org/people/takahiro.akashi/linux-aarch64.git arm64/kdump
https://git.linaro.org/people/takahiro.akashi/kexec-tools.git arm64/kdump

If anybody tries my patches, please let me know the result.
(Pratyush, thank you for your test.)

Thanks,
-Takahiro AKASHI

On Wed, Nov 02, 2016 at 01:49:59PM +0900, AKASHI Takahiro wrote:
>     v27-specific note: In this version, the change made in v26 was reverted
>     because I've got a comment that /reserved-memory DT property should
>     not be used on UEFI/ACPI systems, even though it is workable under
>     the current implementation. I've also confirmed that Rob doesn't argue
>     any more against using "linux,usable-memory-range".
>     So v27 is essentially the same as v25.
> 
> This patch series adds kdump support on arm64.
> 
> To load a crash-dump kernel to the systems, a series of patches to
> kexec-tools[1] are also needed. Please use the latest one, v4 [2].
> 
> To examine vmcore (/proc/vmcore) on a crash-dump kernel, you can use
>   - crash utility (v7.1.6 or later) [3]
> 
> 
> [1] https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git
> [1] http://lists.infradead.org/pipermail/kexec/2016-November/017555.html
> [2] https://github.com/crash-utility/crash.git
> 
> Changes for v27 (Nov 2, 2016)
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
> See the following link [3] for older changes:
> [3]  http://lists.infradead.org/pipermail/linux-arm-kernel/2016-June/438780.html
> 
> AKASHI Takahiro (8):
>   memblock: add memblock_cap_memory_range()
>   arm64: limit memory regions based on DT property, usable-memory-range
>   arm64: kdump: reserve memory for crash dump kernel
>   arm64: kdump: implement machine_crash_shutdown()
>   arm64: kdump: add VMCOREINFO's for user-space tools
>   arm64: kdump: provide /proc/vmcore file
>   arm64: kdump: enable kdump in defconfig
>   Documentation: kdump: describe arm64 port
> 
> James Morse (1):
>   Documentation: dt: chosen properties for arm64 kdump
> 
>  Documentation/devicetree/bindings/chosen.txt |  50 +++++++
>  Documentation/kdump/kdump.txt                |  16 ++-
>  arch/arm64/Kconfig                           |  11 ++
>  arch/arm64/configs/defconfig                 |   1 +
>  arch/arm64/include/asm/hardirq.h             |   2 +-
>  arch/arm64/include/asm/kexec.h               |  42 +++++-
>  arch/arm64/include/asm/smp.h                 |   2 +
>  arch/arm64/kernel/Makefile                   |   1 +
>  arch/arm64/kernel/crash_dump.c               |  71 ++++++++++
>  arch/arm64/kernel/machine_kexec.c            |  67 ++++++++-
>  arch/arm64/kernel/setup.c                    |   7 +-
>  arch/arm64/kernel/smp.c                      |  63 +++++++++
>  arch/arm64/mm/init.c                         | 199 +++++++++++++++++++++++++++
>  include/linux/memblock.h                     |   1 +
>  mm/memblock.c                                |  28 ++++
>  15 files changed, 554 insertions(+), 7 deletions(-)
>  create mode 100644 arch/arm64/kernel/crash_dump.c
> 
> -- 
> 2.10.0
> 
