From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Thu, 10 Jul 2014 10:04:01 +0800
Subject: [PATCH v10 02/11] ARM: mcpm: support 4 clusters
In-Reply-To: <1404957850-13340-1-git-send-email-haojian.zhuang@linaro.org>
References: <1404957850-13340-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1404957850-13340-3-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the CONFIG_MCPM_QUAD_CLUSTER configuration to enlarge cluster number
from 2 to 4.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
Reviewed-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/Kconfig            | 9 +++++++++
 arch/arm/include/asm/mcpm.h | 5 +++++
 2 files changed, 14 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 87b63fd..10cc6ec 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1490,6 +1490,15 @@ config MCPM
 	  for (multi-)cluster based systems, such as big.LITTLE based
 	  systems.
 
+config MCPM_QUAD_CLUSTER
+	bool
+	depends on MCPM
+	help
+	  To avoid wasting resources unnecessarily, MCPM only supports up
+	  to 2 clusters by default.
+	  Platforms with 3 or 4 clusters that use MCPM must select this
+	  option to allow the additional clusters to be managed.
+
 config BIG_LITTLE
 	bool "big.LITTLE support (Experimental)"
 	depends on CPU_V7 && SMP
diff --git a/arch/arm/include/asm/mcpm.h b/arch/arm/include/asm/mcpm.h
index d9702eb..a4fbacc 100644
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
1.9.1
