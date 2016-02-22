From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 22 Feb 2016 15:02:06 +0100
Subject: [RFC PATCH 0/2] fix memremap on ARM
Message-ID: <1456149728-16706-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is something I ran into while working on support for the UEFI
memory attributes and ESRT tables. In both cases, these tables are
passed to the kernel in memory which is guaranteed to be below 4 GB,
but may be outside of the kernel direct mapping. (UEFI typically
attempts to allocate from the top down, which means such tables are
highly likely to be in highmem for any system with more than 760 MB
of system RAM)

The recently introduced memremap() is a very useful abstraction for
accessing such tables, because it is generic, and already attempts to
do the right thing with respect to regions that may already have been
mapped directly. However, it falls back to ioremap_cache() for mapping
high memory, which is not allowed on ARM.

So instead, create an arch specific hook 'arch_memremap_wb(), and
implement it for ARM using the same memory attributes used for the
linear mapping.

Note that memremap will only call this hook for regions that are not
already mapped permanently.

Ard Biesheuvel (2):
  memremap: add arch specific hook for MEMREMAP_WB mappings
  ARM: memremap: implement arch_memremap_wb()

 arch/arm/include/asm/io.h |  3 +++
 arch/arm/mm/ioremap.c     | 11 +++++++++--
 kernel/memremap.c         | 11 ++++++++---
 3 files changed, 20 insertions(+), 5 deletions(-)

-- 
2.5.0
