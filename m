From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 25 Jan 2013 11:24:05 +0900
Subject: [PATCH 29/80] sh: Add PFC platform device registration helper function
In-Reply-To: <1359080696-31489-1-git-send-email-horms+renesas@verge.net.au>
References: <1359080696-31489-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1359080696-31489-30-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The sh_pfc_register() function can be called by boards or SoC setup code
to register the PFC platform device.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/sh/include/cpu-common/cpu/pfc.h |   30 +++++++++++++++++++++++
 arch/sh/kernel/cpu/Makefile          |    2 +-
 arch/sh/kernel/cpu/pfc.c             |   44 ++++++++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+), 1 deletion(-)
 create mode 100644 arch/sh/include/cpu-common/cpu/pfc.h
 create mode 100644 arch/sh/kernel/cpu/pfc.c

diff --git a/arch/sh/include/cpu-common/cpu/pfc.h b/arch/sh/include/cpu-common/cpu/pfc.h
new file mode 100644
index 0000000..40e8643
--- /dev/null
+++ b/arch/sh/include/cpu-common/cpu/pfc.h
@@ -0,0 +1,30 @@
+/*
+ * SH Pin Function Control Initialization
+ *
+ * Copyright (C) 2012  Renesas Solutions Corp.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __ARCH_SH_CPU_PFC_H__
+#define __ARCH_SH_CPU_PFC_H__
+
+#include <linux/types.h>
+
+struct pinmux_info;
+struct resource;
+
+int sh_pfc_register(const char *name,
+		    struct resource *resource, u32 num_resources);
+int sh_pfc_register_info(const char *name,
+			 struct resource *resource, u32 num_resources,
+			 struct pinmux_info *pdata);
+
+#endif /* __ARCH_SH_CPU_PFC_H__ */
diff --git a/arch/sh/kernel/cpu/Makefile b/arch/sh/kernel/cpu/Makefile
index fa58bfd..accc7ca 100644
--- a/arch/sh/kernel/cpu/Makefile
+++ b/arch/sh/kernel/cpu/Makefile
@@ -18,4 +18,4 @@ obj-$(CONFIG_ARCH_SHMOBILE)	+= shmobile/
 obj-$(CONFIG_SH_ADC)		+= adc.o
 obj-$(CONFIG_SH_CLK_CPG_LEGACY)	+= clock-cpg.o
 
-obj-y	+= irq/ init.o clock.o fpu.o proc.o
+obj-y	+= irq/ init.o clock.o fpu.o pfc.o proc.o
diff --git a/arch/sh/kernel/cpu/pfc.c b/arch/sh/kernel/cpu/pfc.c
new file mode 100644
index 0000000..d045d75
--- /dev/null
+++ b/arch/sh/kernel/cpu/pfc.c
@@ -0,0 +1,44 @@
+/*
+ * SH Pin Function Control Initialization
+ *
+ * Copyright (C) 2012  Renesas Solutions Corp.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/init.h>
+#include <linux/platform_device.h>
+
+#include <cpu/pfc.h>
+
+static struct platform_device sh_pfc_device = {
+	.name		= "sh-pfc",
+	.id		= -1,
+};
+
+int __init sh_pfc_register(const char *name,
+			   struct resource *resource, u32 num_resources)
+{
+	if (name)
+		sh_pfc_device.name = name;
+	sh_pfc_device.num_resources = num_resources;
+	sh_pfc_device.resource = resource;
+
+	return platform_device_register(&sh_pfc_device);
+}
+
+int __init sh_pfc_register_info(const char *name,
+				struct resource *resource, u32 num_resources,
+				struct pinmux_info *pdata)
+{
+	sh_pfc_device.dev.platform_data = pdata;
+
+	return sh_pfc_register(name, resource, num_resources);
+}
-- 
1.7.10.4
