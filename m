From: toshi.kani@hpe.com (Toshi Kani)
Date: Mon, 30 Apr 2018 11:59:22 -0600
Subject: [PATCH 0/3] fix free pmd/pte page handlings on x86
Message-ID: <20180430175925.2657-1-toshi.kani@hpe.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series fixes x86 ioremap free page handlings when setting up
pud/pmd maps.

Patch 01 is from Chintan's v9 01/04 patch [1], which adds a new arg 'addr'.
This avoids merge conflicts with his series.

Patch 02 adds a TLB purge (INVLPG) to purge page-structure caches that
may be cached by speculation.  See patch 2/2 for the detals.

Patch 03 disables free page handling on x86-PAE to address BUG_ON reported
by Joerg.

[1] https://patchwork.kernel.org/patch/10371015/

---
Chintan Pandya (1):
  1/3 ioremap: Update pgtable free interfaces with addr

Toshi Kani (2):
  2/3 x86/mm: add TLB purge to free pmd/pte page interfaces
  3/3 x86/mm: disable ioremap free page handling on x86-PAE

---
 arch/arm64/mm/mmu.c           |  4 +--
 arch/x86/mm/pgtable.c         | 57 +++++++++++++++++++++++++++++++++++++------
 include/asm-generic/pgtable.h |  8 +++---
 lib/ioremap.c                 |  4 +--
 4 files changed, 57 insertions(+), 16 deletions(-)
