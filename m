From: jays.lee@samsung.com (Jungseok Lee)
Date: Mon, 14 Apr 2014 16:40:51 +0900
Subject: [PATCH 4/8] arm64: Introduce a kernel configuration option for VA_BITS
Message-ID: <000201cf57b4$dbe63260$93b29720$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a kernel configuration for VA_BITS.

It helps to prevent unnecessary #ifdef statements insertions
for VA_BITS when implementing different page sizes and level of
translation tables.

Signed-off-by: Jungseok Lee <jays.lee@samsung.com>
Reviewed-by: Sungjinn Chung <sungjinn.chung@samsung.com>
---
 arch/arm64/Kconfig              |    8 ++++++++
 arch/arm64/include/asm/memory.h |    6 +-----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1a2faf9..431acbc 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -186,6 +186,14 @@ config ARM64_3_LEVELS
 
 endchoice
 
+config ARM64_VA_BITS
+	int "Virtual address space size"
+	range 39 39 if ARM64_4K_PAGES && ARM64_3_LEVELS
+	range 42 42 if ARM64_64K_PAGES && ARM64_2_LEVELS
+	help
+	  This feature is determined by a combination of page size and
+	  level of translation tables.
+
 config CPU_BIG_ENDIAN
        bool "Build big-endian kernel"
        help
diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index e94f945..f6e7480 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -41,11 +41,7 @@
  * The module space lives between the addresses given by TASK_SIZE
  * and PAGE_OFFSET - it must be within 128MB of the kernel text.
  */
-#ifdef CONFIG_ARM64_64K_PAGES
-#define VA_BITS			(42)
-#else
-#define VA_BITS			(39)
-#endif
+#define VA_BITS			(CONFIG_ARM64_VA_BITS)
 #define PAGE_OFFSET		(UL(0xffffffffffffffff) << (VA_BITS - 1))
 #define MODULES_END		(PAGE_OFFSET)
 #define MODULES_VADDR		(MODULES_END - SZ_64M)
-- 
1.7.10.4
