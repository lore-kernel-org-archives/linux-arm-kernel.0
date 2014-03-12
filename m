From: steve.capper@linaro.org (Steve Capper)
Date: Wed, 12 Mar 2014 13:40:22 +0000
Subject: [RFC PATCH V3 5/6] arm64: mm: Enable HAVE_RCU_TABLE_FREE logic
In-Reply-To: <1394631623-17883-1-git-send-email-steve.capper@linaro.org>
References: <1394631623-17883-1-git-send-email-steve.capper@linaro.org>
Message-ID: <1394631623-17883-6-git-send-email-steve.capper@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to implement fast_get_user_pages we need to ensure that the
page table walker is protected from page table pages being freed from
under it.

This patch enables HAVE_RCU_TABLE_FREE, any page table pages belonging
to address spaces with multiple users will be call_rcu_sched freed.
Meaning that disabling interrupts will block the free and protect the
fast gup page walker.

Signed-off-by: Steve Capper <steve.capper@linaro.org>
---
 arch/arm64/Kconfig           | 1 +
 arch/arm64/include/asm/tlb.h | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 27bbcfc..6185f95 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -38,6 +38,7 @@ config ARM64
 	select HAVE_MEMBLOCK
 	select HAVE_PATA_PLATFORM
 	select HAVE_PERF_EVENTS
+	select HAVE_RCU_TABLE_FREE
 	select IRQ_DOMAIN
 	select MODULES_USE_ELF_RELA
 	select NO_BOOTMEM
diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
index 72cadf5..58a8b78 100644
--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@ -22,6 +22,14 @@
 
 #include <asm-generic/tlb.h>
 
+#include <linux/pagemap.h>
+#include <linux/swap.h>
+
+static inline void __tlb_remove_table(void *_table)
+{
+	free_page_and_swap_cache((struct page *)_table);
+}
+
 /*
  * There's three ways the TLB shootdown code is used:
  *  1. Unmapping a range of vmas.  See zap_page_range(), unmap_region().
-- 
1.8.1.4
