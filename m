From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon,  1 Jun 2015 13:40:30 +0200
Subject: [PATCH for-v4.2 0/4] arm64: EFI minimal FDT and Image placement fixes
Message-ID: <1433158834-25238-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The EFI stub may place the Image or FDT in a memory location that is
not allowed by the arm64/Linux boot protocol. Instead of fixing the stub,
these patches relax the placement rules for Image and FDT so that the
placement logic employed by the EFI stub is guaranteed to produce correct
values.

These 4 patches have been split off from these series

http://thread.gmane.org/gmane.linux.kernel.efi/5736 (8 patches)
http://thread.gmane.org/gmane.linux.ports.arm.kernel/411718 (10 patches)

so that they may still be considered for inclusion in v4.2.

Changes since previous versions:
- added acks/R-b/T-b from Catalin and Mark Rutland
- improved Documentation text in patch #2

Ard Biesheuvel (4):
  of/fdt: split off FDT self reservation from memreserve processing
  arm64: use fixmap region for permanent FDT mapping
  arm64: reduce ID map to a single page
  arm64: drop sleep_idmap_phys and clean up cpu_resume()

 Documentation/arm64/booting.txt | 10 ++++---
 arch/arm/mm/init.c              |  1 +
 arch/arm64/include/asm/boot.h   | 14 +++++++++
 arch/arm64/include/asm/fixmap.h | 15 ++++++++++
 arch/arm64/include/asm/mmu.h    |  1 +
 arch/arm64/kernel/head.S        | 52 +++++---------------------------
 arch/arm64/kernel/setup.c       | 30 +++++++------------
 arch/arm64/kernel/sleep.S       |  9 +++---
 arch/arm64/kernel/suspend.c     |  3 --
 arch/arm64/kernel/vmlinux.lds.S | 11 ++++++-
 arch/arm64/mm/Makefile          |  2 ++
 arch/arm64/mm/mmu.c             | 66 +++++++++++++++++++++++++++++++++++++++++
 arch/arm64/mm/proc.S            |  3 +-
 arch/powerpc/kernel/prom.c      |  1 +
 drivers/of/fdt.c                | 19 ++++++++----
 include/linux/of_fdt.h          |  2 ++
 16 files changed, 156 insertions(+), 83 deletions(-)
 create mode 100644 arch/arm64/include/asm/boot.h

-- 
1.9.1
