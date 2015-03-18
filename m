From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 18 Mar 2015 18:05:03 +0100
Subject: [PATCH v3 0/5] arm64: update/clarify/relax Image and FDT placement
 rules
Message-ID: <1426698308-726-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series came about after Mark Rutland brought up the fact that the current
FDT placement logic used by the EFI stub is flawed. But actually, it turned out
that the documentation for both the Image and FDT placement was incorrect as
well, or confusing at the very least.

Patch #1 should preferably get some acks from the ARM and ppc maintainers,
although it is basically a partial revert of Rob's patch d1552ce449eb ("of/fdt:
move memreserve and dtb memory reservations into core") which none of them
acked either.

Patches #2, #4 and #5 need acks as well.

So this series does two things:
- It relaxes the FDT placement requirements, by using a fixmap region mapping
  for the FDT which is disjoint from the virtual mapping of the 512 MB or 1 GB
  region (depending on page size) covering the kernel Image.
- It updates the documentation and EFI stub FDT placement logic accordingly.
- It clarifies the Image placement requirements in the documentation, and brings
  the EFI stub Image placement logic in line with it

Changes since v2:
- added Rob's ack to patch #1

Changes since v1:
- patch #1: split off reservation of the FDT binary itself from the memreserve
  processing, since the former assumes the FDT is accessed via the linear
  mapping, which we are about to change
- patch #2: mention the older, stricter FDT placement rules in booting.txt,
  get rid of early_print,
  use correct format specifier for phys_addr_t,
  use R/O mapping for FDT,
- patches #3 .. #5: add R-b, minor style and grammar tweaks

Ard Biesheuvel (5):
  of/fdt: split off FDT self reservation from memreserve processing
  arm64: use fixmap region for permanent FDT mapping
  arm64: Documentation: clarify Image placement in physical RAM
  arm64/efi: ensure that Image does not cross a 512 MB boundary
  arm64/efi: adapt to relaxed FDT placement requirements

 Documentation/arm64/booting.txt         | 15 ++++---
 arch/arm/mm/init.c                      |  1 +
 arch/arm64/include/asm/efi.h            |  8 ++--
 arch/arm64/include/asm/fixmap.h         |  9 +++++
 arch/arm64/kernel/Makefile              |  1 +
 arch/arm64/kernel/efi-stub.c            | 41 +++++++++++++++----
 arch/arm64/kernel/head.S                | 38 +----------------
 arch/arm64/kernel/setup.c               | 72 ++++++++++++++++++++++++---------
 arch/powerpc/kernel/prom.c              |  1 +
 drivers/firmware/efi/libstub/arm-stub.c |  5 +--
 drivers/firmware/efi/libstub/efistub.h  |  1 -
 drivers/firmware/efi/libstub/fdt.c      | 10 ++---
 drivers/of/fdt.c                        | 19 ++++++---
 include/linux/of_fdt.h                  |  2 +
 14 files changed, 131 insertions(+), 92 deletions(-)

-- 
1.8.3.2
