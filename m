From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 11 May 2015 09:12:58 +0200
Subject: [PATCH 00/10] arm64: relax Image placement rules
Message-ID: <1431328388-3051-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a followup to the "arm64: update/clarify/relax Image and FDT placement
rules" series I sent a while ago:
(http://article.gmane.org/gmane.linux.ports.arm.kernel/407148)

This has now been split in two series: this second series deals with the
physical and virtual placement of the kernel Image. It depends on the first
three patches of the first series:
http://thread.gmane.org/gmane.linux.kernel.efi/5736

This series updates the mapping of the kernel Image and the linear mapping of
system memory to allow more freedom in the choice of placement without affecting
the accessibility of system RAM below the kernel Image, and the mapping
efficiency (i.e., memory can always be mapped in 512 MB or 1 GB blocks).
See below for a page table dump captured on AMD Seattle without and without this
series applied.

Changes since previous version:
- rebased onto v4.1-rc3
- dropped phys_offset_bias in favor of updating memstart_addr with the bias
  temporarily
- bootstrap the linear mapping of the base of RAM in addition to the linear
  mapping of the statically allocated page tables
- fixed a bug in the handling of the mem= kernel command line parameter.

Known issues:
- the mem= command line parameter works correctly now, but removes memory from
  the bottom first before clipping from the top, which may be undesirable since
  it may discard precious memory below the 4 GB boundary.s

Patch #1 drops the statically allocated EFI root pgd in favor of one allocated
dynamically by pgd_alloc(). Since pgd_alloc is initialized itself in a core
initcall, the EFI virtmap init is moved to a postcore_initcall.

Patch #2 removes the requirement that the Image be placed such that it does not
cross a 512 MB/1 GB alignment boundary, by shrinking the ID map to a single
page.

Patch #3 is a cleanup patch related to the ID map.

Patch #4 changes the memblock_reserve logic so that unused page table
reservations are left unreserved in memblock.

Patch #5 refactors early_fixmap_init() so that we can reuse its core for
bootstrapping other memory mappings.

Patch #6 bootstraps the linear mapping explicitly. Up until now, this was done
implicitly due to the fact that the linear mapping starts at the base of the
kernel Image.

Patch #7 moves the mapping of the kernel Image outside of the linear mapping.

Patch #8 changes the attributes of the linear mapping to non-executable since
we don't execute code from it anymore.

Patch #9 allows the kernel to be loaded at any 2 MB aligned offset in physical
memory, by assigning PHYS_OFFSET based on the available memory and not based on
the physical address of the base of the kernel Image.

Patch #10 updates the UEFI stub placement logic to put the kernel at the top of
memory. This patch is merely a proof of concept for the rest of the series, it
is not necessarily a good idea to always load the kernel high.

Ard Biesheuvel (10):
  arm64/efi: use dynamically allocated space for EFI pgd
  arm64: reduce ID map to a single page
  arm64: drop sleep_idmap_phys and clean up cpu_resume()
  arm64: use more granular reservations for static page table
    allocations
  arm64: split off early mapping code from early_fixmap_init()
  arm64: mm: explicitly bootstrap the linear mapping
  arm64: move kernel mapping out of linear region
  arm64: map linear region as non-executable
  arm64: allow kernel Image to be loaded anywhere in physical memory
  arm64/efi: adapt to relaxed kernel Image placement requirements

 Documentation/arm64/booting.txt   |  20 ++--
 arch/arm64/include/asm/boot.h     |   7 ++
 arch/arm64/include/asm/compiler.h |   2 +
 arch/arm64/include/asm/memory.h   |  19 +++-
 arch/arm64/kernel/efi-stub.c      |   5 +-
 arch/arm64/kernel/efi.c           |  10 +-
 arch/arm64/kernel/head.S          |  31 ++++--
 arch/arm64/kernel/sleep.S         |   9 +-
 arch/arm64/kernel/suspend.c       |   3 -
 arch/arm64/kernel/vmlinux.lds.S   |  51 +++++++--
 arch/arm64/mm/init.c              |  51 ++++++++-
 arch/arm64/mm/mmu.c               | 222 ++++++++++++++++++++++++--------------
 arch/arm64/mm/proc.S              |   3 +-
 13 files changed, 302 insertions(+), 131 deletions(-)


Before:
-------
[...]
---[ Fixmap start ]---
0xffffffbffabff000-0xffffffbffac00000           4K     RW NX SHD AF    UXN DEVICE/nGnRE
---[ Fixmap end ]---
---[ PCI I/O start ]---
---[ PCI I/O end ]---
---[ Modules start ]---
---[ Modules end ]---
---[ Kernel Mapping ]---
0xffffffc000000000-0xffffffc000800000           8M     RW x  SHD AF    UXN MEM/NORMAL
0xffffffc000800000-0xffffffc00081b000         108K     RW x  SHD AF    UXN MEM/NORMAL
0xffffffc00081b000-0xffffffc00086e000         332K     RW NX SHD AF    UXN MEM/NORMAL
0xffffffc00086e000-0xffffffc000a00000        1608K     RW x  SHD AF    UXN MEM/NORMAL
0xffffffc000a00000-0xffffffc3ff000000       16358M     RW x  SHD AF    UXN MEM/NORMAL

After:
------
[...]
---[ Fixmap start ]---
0xffffffbff67ff000-0xffffffbff6800000           4K     RW NX SHD AF    UXN DEVICE/nGnRE
0xffffffbff6800000-0xffffffbff6a00000           2M     ro NX SHD AF    UXN MEM/NORMAL
---[ Fixmap end ]---
---[ PCI I/O start ]---
---[ PCI I/O end ]---
---[ Modules start ]---
---[ Modules end ]---
0xffffffbffc000000-0xffffffbffc800000           8M     RW x  SHD AF    MEM/NORMAL
0xffffffbffc800000-0xffffffbffc81d000         116K     RW x  SHD AF    UXN MEM/NORMAL
0xffffffbffc81d000-0xffffffbffc870000         332K     RW NX SHD AF    UXN MEM/NORMAL
0xffffffbffc870000-0xffffffbffca00000        1600K     RW x  SHD AF    UXN MEM/NORMAL
---[ Kernel Mapping ]---
0xffffffc000000000-0xffffffc400000000          16G     RW NX SHD AF    UXN MEM/NORMAL

-- 
1.9.1
