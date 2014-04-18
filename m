From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Fri, 18 Apr 2014 14:05:49 +0800
Subject: [PATCH v3 06/13] ARM: mcpm: support 4 clusters in HiP04
In-Reply-To: <1397801156-25682-1-git-send-email-haojian.zhuang@linaro.org>
References: <1397801156-25682-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1397801156-25682-7-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since 16 Cortex-A15 cores are used in HiP04 SoC, enlarge the maximum
clusters from 2 to 4 if HiP04 SoC is built without CONFIG_BIG_LITTLE.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 arch/arm/Kconfig            | 8 ++++++++
 arch/arm/include/asm/mcpm.h | 5 +++++
 2 files changed, 13 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9a2214e..f2a25be 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1571,6 +1571,14 @@ config MCPM
 	  for (multi-)cluster based systems, such as big.LITTLE based
 	  systems.
 
+config MCPM_QUAD_CLUSTER
+	bool "Enable Quad clusters in MPCM"
+	depends on MCPM
+	default n
+	help
+	  This option enables quad clusters in MCPM. Quad clusters exist
+	  in HiP04 SoC.
+
 config BIG_LITTLE
 	bool "big.LITTLE support (Experimental)"
 	depends on CPU_V7 && SMP
diff --git a/arch/arm/include/asm/mcpm.h b/arch/arm/include/asm/mcpm.h
index 608516e..fc8d70d 100644
--- a/arch/arm/include/asm/mcpm.h
+++ b/arch/arm/include/asm/mcpm.h
@@ -20,7 +20,12 @@
  * to consider dynamic allocation.
  */
 #define MAX_CPUS_PER_CLUSTER	4
+
+#ifdef CONFIG_MCPM_QUAD_CLUSTER
+#define MAX_NR_CLUSTERS		4
+#else
 #define MAX_NR_CLUSTERS		2
+#endif
 
 #ifndef __ASSEMBLY__
 
-- 
1.8.3.2
