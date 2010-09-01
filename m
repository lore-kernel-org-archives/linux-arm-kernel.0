From: gbean@codeaurora.org (Gregory Bean)
Date: Wed,  1 Sep 2010 16:26:12 -0700
Subject: [PATCH] msm: Featurize gpiomux.
Message-ID: <1283383572-15635-1-git-send-email-gbean@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Featurize gpiomux so that systems like 7x00 which do not wish to use it
do not have to be saddled with the configuration tables.

Signed-off-by: Gregory Bean <gbean@codeaurora.org>
---
 arch/arm/mach-msm/Kconfig   |    5 +++++
 arch/arm/mach-msm/gpiomux.h |   20 ++++++++++++++++++++
 2 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-msm/Kconfig b/arch/arm/mach-msm/Kconfig
index 4e79580..f09ffef 100644
--- a/arch/arm/mach-msm/Kconfig
+++ b/arch/arm/mach-msm/Kconfig
@@ -18,6 +18,7 @@ config ARCH_MSM7X30
 	select MSM_VIC
 	select CPU_V7
 	select MSM_REMOTE_SPINLOCK_DEKKERS
+	select MSM_GPIOMUX
 
 config ARCH_QSD8X50
 	bool "QSD8X50"
@@ -26,6 +27,7 @@ config ARCH_QSD8X50
 	select MSM_VIC
 	select CPU_V7
 	select MSM_REMOTE_SPINLOCK_LDREX
+	select MSM_GPIOMUX
 endchoice
 
 config MSM_SOC_REV_A
@@ -106,6 +108,9 @@ config MSM_SMD_PKG3
 config MSM_SMD
 	bool
 
+config MSM_GPIOMUX
+	bool
+
 config MSM_V2_TLMM
 	bool
 endif
diff --git a/arch/arm/mach-msm/gpiomux.h b/arch/arm/mach-msm/gpiomux.h
index bb0acf0..b178d9c 100644
--- a/arch/arm/mach-msm/gpiomux.h
+++ b/arch/arm/mach-msm/gpiomux.h
@@ -18,6 +18,7 @@
 #define __ARCH_ARM_MACH_MSM_GPIOMUX_H
 
 #include <linux/bitops.h>
+#include <linux/errno.h>
 
 #if defined(CONFIG_MSM_V2_TLMM)
 #include "gpiomux-v2.h"
@@ -60,6 +61,8 @@ enum {
 	GPIOMUX_CTL_MASK = GPIOMUX_VALID,
 };
 
+#ifdef CONFIG_MSM_GPIOMUX
+
 /* Each architecture must provide its own instance of this table.
  * To avoid having gpiomux manage any given gpio, one or both of
  * the entries can avoid setting GPIOMUX_VALID - the absence
@@ -90,5 +93,22 @@ int msm_gpiomux_write(unsigned gpio,
  * should use msm_gpiomux_write.
  */
 void __msm_gpiomux_write(unsigned gpio, gpiomux_config_t val);
+#else
+static inline int __must_check msm_gpiomux_get(unsigned gpio)
+{
+	return -ENOSYS;
+}
 
+static inline int msm_gpiomux_put(unsigned gpio)
+{
+	return -ENOSYS;
+}
+
+static inline int msm_gpiomux_write(unsigned gpio,
+				    gpiomux_config_t active,
+				    gpiomux_config_t suspended)
+{
+	return -ENOSYS;
+}
+#endif
 #endif
-- 
1.7.0.4

--
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
