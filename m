From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 11 Feb 2016 17:48:02 +0100
Subject: [PATCH v2 3/3] arm64: prevent __va() translations before
 memstart_addr is assigned
In-Reply-To: <1455209282-9596-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1455209282-9596-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1455209282-9596-4-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just a hack to check whether all early __va() calls are gone.
---
 arch/arm64/include/asm/memory.h | 10 +++++++++-
 arch/arm64/mm/init.c            |  2 +-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 083361531a61..0d4d1b3b9695 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -90,7 +90,9 @@
 	__x >= PAGE_OFFSET ? (__x - PAGE_OFFSET + PHYS_OFFSET) :	\
 			     (__x - kimage_voffset); })
 
-#define __phys_to_virt(x)	((unsigned long)((x) - PHYS_OFFSET + PAGE_OFFSET))
+#define __phys_to_virt(x) ({						\
+	assert_memstart_addr_assigned();				\
+	(unsigned long)((x) - PHYS_OFFSET + PAGE_OFFSET); })
 #define __phys_to_kimg(x)	((unsigned long)((x) + kimage_voffset))
 
 /*
@@ -133,6 +135,12 @@ extern u64			kimage_vaddr;
 /* the offset between the kernel virtual and physical mappings */
 extern u64			kimage_voffset;
 
+static inline void assert_memstart_addr_assigned(void)
+{
+	if (unlikely(memstart_addr == (phys_addr_t)-1))
+		asm("brk #%0" :: "I"(0x800));
+}
+
 /*
  * Allow all memory at the discovery stage. We will clip it later.
  */
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index eff4751f8761..e88db8acd181 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -48,7 +48,7 @@
 
 #include "mm.h"
 
-phys_addr_t memstart_addr __read_mostly = 0;
+phys_addr_t memstart_addr __read_mostly = (phys_addr_t)-1;
 phys_addr_t arm64_dma_phys_limit __read_mostly;
 
 #ifdef CONFIG_BLK_DEV_INITRD
-- 
2.5.0
