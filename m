From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Wed,  7 May 2014 22:44:36 +0800
Subject: [PATCH v5 02/14] ARM: add V7_NONLPAE && V7_LPAE sub config
In-Reply-To: <1399473888-12947-1-git-send-email-haojian.zhuang@linaro.org>
References: <1399473888-12947-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1399473888-12947-3-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since CONFIG_ARM_LPAE could be set in ARM V7, add new two configurations
CONFIG_ARCH_MULTI_V7_NONLPAE & CONFIG_ARCH_MULTI_V7_LPAE.

If we want to enable CONFIG_ARM_LPAE configuration, we should enable
CONFIG_ARCH_MULTI_V7 & disable both CONFIG_ARCH_MULTI_V6 and
CONFIG_ARCH_MULTI_V7_NONLPAE.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 arch/arm/Kconfig    | 13 ++++++++++++-
 arch/arm/mm/Kconfig |  2 +-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index ab438cb..0e52a2c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -918,12 +918,23 @@ config ARCH_MULTI_V6
 	select CPU_V6K
 
 config ARCH_MULTI_V7
-	bool "ARMv7 based platforms (Cortex-A, PJ4, Scorpion, Krait)"
+	bool "ARMv7 based platforms"
 	default y
 	select ARCH_MULTI_V6_V7
 	select CPU_V7
 	select HAVE_SMP
 
+config ARCH_MULTI_V7_NONLPAE
+	bool "ARMv7 non-LPAE based platforms (Cortex-A5/A8/A9, PJ4, PJ4B, Scorpion)"
+	depends on ARCH_MULTI_V7
+	default y
+
+config ARCH_MULTI_V7_LPAE
+	bool "ARMv7 LPAE based platforms (Cortex-A7/A12/A15/A17, Brahma-B15, PJ4B-MP, Krait)"
+	depends on ARCH_MULTI_V7
+	default y
+	select ARM_LPAE if !(ARCH_MULTI_V6 || ARCH_MULTI_V7_NONLPAE)
+
 config ARCH_MULTI_V6_V7
 	bool
 	select MIGHT_HAVE_CACHE_L2X0
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index f5ad9ee..1c1576c 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -615,7 +615,7 @@ comment "Processor Features"
 config ARM_LPAE
 	bool "Support for the Large Physical Address Extension"
 	depends on MMU && CPU_32v7 && !CPU_32v6 && !CPU_32v5 && \
-		!CPU_32v4 && !CPU_32v3
+		!CPU_32v4 && !CPU_32v3 && !ARCH_MULTI_V7_NONLPAE
 	help
 	  Say Y if you have an ARMv7 processor supporting the LPAE page
 	  table format and you would like to access memory beyond the
-- 
1.9.1
