From: fan.chen@mediatek.com (Fan Chen)
Date: Fri, 18 Dec 2015 10:42:28 +0800
Subject: [PATCH 1/4] soc: Mediatek: Create Mediatek SIP call
In-Reply-To: <1450406551-1741-1-git-send-email-fan.chen@mediatek.com>
References: <1450406551-1741-1-git-send-email-fan.chen@mediatek.com>
Message-ID: <1450406551-1741-2-git-send-email-fan.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Create a generic interface for issuing SIP Service calls
which are specified in ARM SMC CALLING CONVENTION.

Signed-off-by: Fan Chen <fan.chen@mediatek.com>
---
 drivers/soc/mediatek/Kconfig         |    8 ++++++++
 drivers/soc/mediatek/Makefile        |    1 +
 drivers/soc/mediatek/mtk-sip.c       |   28 ++++++++++++++++++++++++++++
 include/linux/soc/mediatek/mtk-sip.h |   17 +++++++++++++++++
 4 files changed, 54 insertions(+)
 create mode 100644 drivers/soc/mediatek/mtk-sip.c
 create mode 100644 include/linux/soc/mediatek/mtk-sip.h

diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
index 9d50682..65c1323 100644
--- a/drivers/soc/mediatek/Kconfig
+++ b/drivers/soc/mediatek/Kconfig
@@ -29,3 +29,11 @@ config MTK_SCPSYS
 	help
 	  Say yes here to add support for the MediaTek SCPSYS power domain
 	  driver.
+
+config MTK_SIP
+        bool "Mediatek SIP Support"
+	depends on ARCH_MEDIATEK || COMPILE_TEST
+	depends on HAVE_SMCCC
+	help
+	Say yes here to add support for the MediaTek SIP call.
+
diff --git a/drivers/soc/mediatek/Makefile b/drivers/soc/mediatek/Makefile
index 12998b0..67077dc 100644
--- a/drivers/soc/mediatek/Makefile
+++ b/drivers/soc/mediatek/Makefile
@@ -1,3 +1,4 @@
 obj-$(CONFIG_MTK_INFRACFG) += mtk-infracfg.o
 obj-$(CONFIG_MTK_PMIC_WRAP) += mtk-pmic-wrap.o
 obj-$(CONFIG_MTK_SCPSYS) += mtk-scpsys.o
+obj-$(CONFIG_MTK_SIP) += mtk-sip.o
diff --git a/drivers/soc/mediatek/mtk-sip.c b/drivers/soc/mediatek/mtk-sip.c
new file mode 100644
index 0000000..882617f
--- /dev/null
+++ b/drivers/soc/mediatek/mtk-sip.c
@@ -0,0 +1,28 @@
+/*
+ * Copyright (c) 2015 MediaTek Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/arm-smccc.h>
+#include <linux/soc/mediatek/mtk-sip.h>
+
+int mtk_sip_simple_call(unsigned long func_id,
+			unsigned long a1,
+			unsigned long a2,
+			unsigned long a3)
+{
+	struct smccc_res res;
+
+	smccc_smc(func_id, a1, a2, a3, 0, 0, 0, 0, &res);
+
+	return res.a0;
+}
+
diff --git a/include/linux/soc/mediatek/mtk-sip.h b/include/linux/soc/mediatek/mtk-sip.h
new file mode 100644
index 0000000..dce1818
--- /dev/null
+++ b/include/linux/soc/mediatek/mtk-sip.h
@@ -0,0 +1,17 @@
+#ifndef __SOC_MEDIATEK_MTKSIP_H
+#define __SOC_MEDIATEK_MTKSIP_H
+
+#ifdef CONFIG_MTK_SIP
+int mtk_sip_simple_call(unsigned long func_id,
+			unsigned long a1,
+			unsigned long a2,
+			unsigned long a3);
+#else
+static inline int mtk_sip_simple_call(unsigned long func_id,
+				      unsigned long a1,
+				      unsigned long a2,
+				      unsigned long a3)
+{       return -EOPNOTSUPP; }
+#endif
+
+#endif /*__SOC_MEDIATEK_MTKSIP_H*/
-- 
1.7.9.5
