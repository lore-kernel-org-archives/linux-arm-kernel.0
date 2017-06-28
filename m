From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Wed, 28 Jun 2017 10:16:57 +0100
Subject: [PATCH 1/2] drivers: dma-mapping: allow dma_common_mmap() for NOMMU
In-Reply-To: <1498641418-3554-1-git-send-email-vladimir.murzin@arm.com>
References: <1498641418-3554-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1498641418-3554-2-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, internals of dma_common_mmap() is compiled out if build is
done for either NOMMU or target which explicitly says it does not
have/want coherent DMA mmap. It turned out that dma_common_mmap() can
be handy in NOMMU setup (at least for ARM).

This patch converts exitent NOMMU targets to use ARCH_NO_COHERENT_DMA_MMAP,
thus when CONFIG_MMU is gone from dma_common_mmap() their behaviour stays
unchanged.

ARM is not converted to ARCH_NO_COHERENT_DMA_MMAP because it 1)
already has mmap callback which can handle (at some extent) NOMMU 2)
already defines dummy pgprot_noncached() for NOMMU build.

c6x and frv stay untouched since they already have ARCH_NO_COHERENT_DMA_MMAP.

Cc: Steven Miao <realmz6@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Michal Simek <monstr@monstr.eu>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/blackfin/Kconfig      | 1 +
 arch/m32r/Kconfig          | 1 +
 arch/m68k/Kconfig          | 1 +
 arch/microblaze/Kconfig    | 1 +
 arch/sh/Kconfig            | 1 +
 arch/xtensa/Kconfig        | 1 +
 drivers/base/dma-mapping.c | 4 ++--
 7 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/blackfin/Kconfig b/arch/blackfin/Kconfig
index 3c1bd64..89bdb82 100644
--- a/arch/blackfin/Kconfig
+++ b/arch/blackfin/Kconfig
@@ -41,6 +41,7 @@ config BLACKFIN
 	select MODULES_USE_ELF_RELA
 	select HAVE_DEBUG_STACKOVERFLOW
 	select HAVE_NMI
+	select ARCH_NO_COHERENT_DMA_MMAP
 
 config GENERIC_CSUM
 	def_bool y
diff --git a/arch/m32r/Kconfig b/arch/m32r/Kconfig
index 9547446..87cde1e 100644
--- a/arch/m32r/Kconfig
+++ b/arch/m32r/Kconfig
@@ -19,6 +19,7 @@ config M32R
 	select HAVE_DEBUG_STACKOVERFLOW
 	select CPU_NO_EFFICIENT_FFS
 	select DMA_NOOP_OPS
+	select ARCH_NO_COHERENT_DMA_MMAP if !MMU
 
 config SBUS
 	bool
diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index d140206..5abb548 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -2,6 +2,7 @@ config M68K
 	bool
 	default y
 	select ARCH_MIGHT_HAVE_PC_PARPORT if ISA
+	select ARCH_NO_COHERENT_DMA_MMAP if !MMU
 	select HAVE_IDE
 	select HAVE_AOUT if MMU
 	select HAVE_DEBUG_BUGVERBOSE
diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index 85885a5..8ba7b7c 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -2,6 +2,7 @@ config MICROBLAZE
 	def_bool y
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_MIGHT_HAVE_PC_PARPORT
+	select ARCH_NO_COHERENT_DMA_MMAP if !MMU
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select BUILDTIME_EXTABLE_SORT
 	select CLKSRC_OF
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index ee08695..640a859 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -2,6 +2,7 @@ config SUPERH
 	def_bool y
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_MIGHT_HAVE_PC_PARPORT
+	select ARCH_NO_COHERENT_DMA_MMAP if !MMU
 	select HAVE_PATA_PLATFORM
 	select CLKDEV_LOOKUP
 	select HAVE_IDE if HAS_IOPORT_MAP
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index f4126cf..7ad6d77 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -3,6 +3,7 @@ config ZONE_DMA
 
 config XTENSA
 	def_bool y
+	select ARCH_NO_COHERENT_DMA_MMAP if !MMU
 	select ARCH_WANT_FRAME_POINTERS
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select BUILDTIME_EXTABLE_SORT
diff --git a/drivers/base/dma-mapping.c b/drivers/base/dma-mapping.c
index 10e7c02..ce1e02b 100644
--- a/drivers/base/dma-mapping.c
+++ b/drivers/base/dma-mapping.c
@@ -227,7 +227,7 @@ int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
 		    void *cpu_addr, dma_addr_t dma_addr, size_t size)
 {
 	int ret = -ENXIO;
-#if defined(CONFIG_MMU) && !defined(CONFIG_ARCH_NO_COHERENT_DMA_MMAP)
+#ifndef CONFIG_ARCH_NO_COHERENT_DMA_MMAP
 	unsigned long user_count = vma_pages(vma);
 	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	unsigned long pfn = page_to_pfn(virt_to_page(cpu_addr));
@@ -244,7 +244,7 @@ int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
 				      user_count << PAGE_SHIFT,
 				      vma->vm_page_prot);
 	}
-#endif	/* CONFIG_MMU && !CONFIG_ARCH_NO_COHERENT_DMA_MMAP */
+#endif	/* !CONFIG_ARCH_NO_COHERENT_DMA_MMAP */
 
 	return ret;
 }
-- 
2.0.0
