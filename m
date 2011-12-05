From: boojin.kim@samsung.com (Boojin Kim)
Date: Mon,  5 Dec 2011 10:28:59 +0900
Subject: [PATCH] ARM: MM: Configure the number of banks
Message-ID: <1323048539-9573-1-git-send-email-boojin.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch configures NR_BANKS by machine specific configuration.
NR_BANKS should be increased to support bigger than 2GB memory.

Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
---
 arch/arm/include/asm/setup.h               |    6 ++----
 arch/arm/mach-ep93xx/include/mach/memory.h |    4 ++++
 arch/arm/mach-exynos/include/mach/memory.h |    4 ++++
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/setup.h b/arch/arm/include/asm/setup.h
index 915696d..b91ec39 100644
--- a/arch/arm/include/asm/setup.h
+++ b/arch/arm/include/asm/setup.h
@@ -192,10 +192,8 @@ static const struct tagtable __tagtable_##fn __tag = { tag, fn }
 /*
  * Memory map description
  */
-#ifdef CONFIG_ARCH_EP93XX
-# define NR_BANKS 16
-#else
-# define NR_BANKS 8
+#ifndef NR_BANKS
+#define NR_BANKS 8
 #endif
 
 struct membank {
diff --git a/arch/arm/mach-ep93xx/include/mach/memory.h b/arch/arm/mach-ep93xx/include/mach/memory.h
index c9400cf..2c0462e 100644
--- a/arch/arm/mach-ep93xx/include/mach/memory.h
+++ b/arch/arm/mach-ep93xx/include/mach/memory.h
@@ -19,4 +19,8 @@
 #error "Kconfig bug: No EP93xx PHYS_OFFSET set"
 #endif
 
+#if defined(CONFIG_ARCH_EP93XX)
+#define NR_BANKS		16
+#endif
+
 #endif
diff --git a/arch/arm/mach-exynos/include/mach/memory.h b/arch/arm/mach-exynos/include/mach/memory.h
index 374ef2c..b7e146c 100644
--- a/arch/arm/mach-exynos/include/mach/memory.h
+++ b/arch/arm/mach-exynos/include/mach/memory.h
@@ -15,6 +15,10 @@
 
 #define PLAT_PHYS_OFFSET		UL(0x40000000)
 
+#if defined(CONFIG_MACH_SMDKV310)
+#define NR_BANKS		16
+#endif
+
 /* Maximum of 256MiB in one bank */
 #define MAX_PHYSMEM_BITS	32
 #define SECTION_SIZE_BITS	28
-- 
1.7.1
