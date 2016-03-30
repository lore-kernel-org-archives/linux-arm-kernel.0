From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 30 Mar 2016 14:25:45 +0200
Subject: [PATCH v2 0/3] arm64: memstart_addr alignment and vmemmap offset fixes
Message-ID: <1459340748-14975-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series wraps up some loose ends regarding the v4.6 changes in arm64 to
allow the kernel to reside at any [appropriately aligned] physical address.

Patch #1 fixes a bug where we fail to update memstart_addr after clipping
memory from the bottom if so required by the size of the linear region and
the placement of the kernel Image.

Patch #2 updates the constant ARM64_MEMSTART_ALIGN, which defines the minimum
alignment of memstart_addr, to account for the section alignment my sparsemem
vmemmap if that is enabled. This is a prerequisite for patch #3

Patch #3 reverts commit 36e5cd6b897e ("arm64: account for sparsemem section
alignment  when choosing vmemmap offset"), which was included as a bugfix in
v4.5-late, but is no longer required now that we can freely choose
memstart_addr, allowing us to take this minimum alignment into account. This
makes the rounding in the definition of vmemmap redundant.

Ard Biesheuvel (3):
  arm64/mm: ensure memstart_addr remains sufficiently aligned
  arm64: choose memstart_addr based on minimum sparsemem section
    alignment
  Revert "arm64: account for sparsemem section alignment when choosing
    vmemmap offset"

 arch/arm64/include/asm/kernel-pgtable.h | 21 +++++++++++++++++---
 arch/arm64/include/asm/pgtable.h        |  5 ++---
 arch/arm64/mm/init.c                    |  8 ++++++--
 3 files changed, 26 insertions(+), 8 deletions(-)

-- 
2.5.0
