From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu,  3 Mar 2016 14:09:38 +0100
Subject: [PATCH 0/3] arm64: simplify and optimize kernel mapping
Message-ID: <1457010581-4924-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series makes a couple of minor changes that should result in the
kernel being mapped in a more efficient manner.

First of all, it merges the .head.text with the .text section (patch #2)
after moving everything except the kernel and EFI header into the __init
section (patch #1)

Then, it standardizes the segment alignment to 64 KB for all page sizes.
(patch #3). In the example below (4 KB granule, with Jeremy's PTE_CONT
patch applied), we lose 80 KB in total to padding, but the resulting
mappings do look somewhat better.

Before:

0xffff000008082000-0xffff000008090000    56K  ro x  SHD AF         UXN MEM
0xffff000008090000-0xffff000008200000  1472K  ro x  SHD AF CON     UXN MEM
0xffff000008200000-0xffff000008600000     4M  ro x  SHD AF     BLK UXN MEM
0xffff000008600000-0xffff000008660000   384K  ro x  SHD AF CON     UXN MEM
0xffff000008660000-0xffff00000866c000    48K  ro x  SHD AF         UXN MEM
0xffff00000866c000-0xffff000008670000    16K  ro NX SHD AF         UXN MEM
0xffff000008670000-0xffff000008900000  2624K  ro NX SHD AF CON     UXN MEM
0xffff000008900000-0xffff000008909000    36K  ro NX SHD AF         UXN MEM
0xffff000008c39000-0xffff000008c40000    28K  RW NX SHD AF         UXN MEM
0xffff000008c40000-0xffff000008d50000  1088K  RW NX SHD AF CON     UXN MEM
0xffff000008d50000-0xffff000008d57000    28K  RW NX SHD AF         UXN MEM

After:

0xffff000008080000-0xffff000008200000  1536K  ro x  SHD AF CON     UXN MEM
0xffff000008200000-0xffff000008600000     4M  ro x  SHD AF     BLK UXN MEM
0xffff000008600000-0xffff000008670000   448K  ro x  SHD AF CON     UXN MEM
0xffff000008670000-0xffff000008910000  2688K  ro NX SHD AF CON     UXN MEM
0xffff000008c50000-0xffff000008d60000  1088K  RW NX SHD AF CON     UXN MEM
0xffff000008d60000-0xffff000008d6b000    44K  RW NX SHD AF         UXN MEM

I am aware that this clashes with Jeremy's patch to allow CONT_SIZE alignment
when CONFIG_DEBUG_ALIGN_RODATA=y, but the net effect of patch #3 is the same
(only the Kconfig change is not included here)

Ard Biesheuvel (3):
  arm64: move early boot code to the .init segment
  arm64: cover the .head.text section in the .text segment mapping
  arm64: simplify kernel segment mapping granularity

 arch/arm64/kernel/efi-entry.S   |  2 +-
 arch/arm64/kernel/head.S        | 32 +++++++++-----------
 arch/arm64/kernel/image.h       |  4 +++
 arch/arm64/kernel/vmlinux.lds.S | 26 +++++++++-------
 arch/arm64/mm/mmu.c             | 10 +++---
 5 files changed, 40 insertions(+), 34 deletions(-)

-- 
2.5.0
