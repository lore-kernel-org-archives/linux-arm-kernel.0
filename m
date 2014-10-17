From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Fri, 17 Oct 2014 15:33:45 -0500
Subject: [PATCHv2 1/4] arm: socfpga: Enable L2 Cache ECC on startup.
In-Reply-To: <1413578029-13205-1-git-send-email-tthayer@opensource.altera.com>
References: <1413578029-13205-1-git-send-email-tthayer@opensource.altera.com>
Message-ID: <1413578029-13205-2-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

This patch enables the ECC for L2 cache on machine
startup.  The ECC has to be enabled before data is
is stored in memory otherwise the ECC will fail on
reads.

Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
---
v2: Split OCRAM initialization into separate patch.
---
 MAINTAINERS                      |    1 +
 arch/arm/mach-socfpga/Makefile   |    1 +
 arch/arm/mach-socfpga/l2_cache.c |   44 ++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-socfpga/l2_cache.h |   28 ++++++++++++++++++++++++
 arch/arm/mach-socfpga/socfpga.c  |    5 ++++-
 5 files changed, 78 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-socfpga/l2_cache.c
 create mode 100644 arch/arm/mach-socfpga/l2_cache.h

diff --git a/MAINTAINERS b/MAINTAINERS
index ee1bc5b..d0c7752 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1407,6 +1407,7 @@ ARM/SOCFPGA EDAC SUPPORT
 M:	Thor Thayer <tthayer@opensource.altera.com>
 S:	Maintained
 F:	drivers/edac/altera_edac.
+F:	arch/arm/mach-socfpga/l2_cache.*
 
 ARM/STI ARCHITECTURE
 M:	Srinivas Kandagatla <srinivas.kandagatla@gmail.com>
diff --git a/arch/arm/mach-socfpga/Makefile b/arch/arm/mach-socfpga/Makefile
index 6dd7a93..142609e 100644
--- a/arch/arm/mach-socfpga/Makefile
+++ b/arch/arm/mach-socfpga/Makefile
@@ -4,3 +4,4 @@
 
 obj-y					:= socfpga.o
 obj-$(CONFIG_SMP)	+= headsmp.o platsmp.o
+obj-$(CONFIG_EDAC_ALTERA_L2C) += l2_cache.o
diff --git a/arch/arm/mach-socfpga/l2_cache.c b/arch/arm/mach-socfpga/l2_cache.c
new file mode 100644
index 0000000..8e109f3
--- /dev/null
+++ b/arch/arm/mach-socfpga/l2_cache.c
@@ -0,0 +1,44 @@
+/*
+ * Copyright Altera Corporation (C) 2014. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#include <linux/clk-provider.h>
+#include <linux/of_platform.h>
+#include <linux/of_address.h>
+
+#include "l2_cache.h"
+
+void socfpga_init_l2_ecc(void)
+{
+	struct device_node *np;
+	void __iomem  *mapped_l2_edac_addr;
+
+	np = of_find_compatible_node(NULL, NULL, "altr,l2-edac");
+	if (!np) {
+		pr_err("SOCFPGA: Unable to find altr,l2-edac in dtb\n");
+		return;
+	}
+
+	mapped_l2_edac_addr = of_iomap(np, 0);
+	if (!mapped_l2_edac_addr) {
+		pr_err("SOCFPGA: Unable to find L2 ECC mapping in dtb\n");
+		return;
+	}
+
+	/* Enable ECC */
+	writel(0x01, mapped_l2_edac_addr);
+
+	pr_debug("SOCFPGA: Success Initializing L2 cache ECC\n");
+}
+
diff --git a/arch/arm/mach-socfpga/l2_cache.h b/arch/arm/mach-socfpga/l2_cache.h
new file mode 100644
index 0000000..58e140d
--- /dev/null
+++ b/arch/arm/mach-socfpga/l2_cache.h
@@ -0,0 +1,28 @@
+/*
+ * Copyright Altera Corporation (C) 2014. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef MACH_SOCFPGA_L2_CACHE_H
+#define MACH_SOCFPGA_L2_CACHE_H
+
+#ifdef CONFIG_EDAC_ALTERA_L2C
+void socfpga_init_l2_ecc(void);
+#else
+inline void socfpga_init_l2_ecc(void)
+{
+}
+#endif
+
+#endif /* #ifndef MACH_SOCFPGA_L2_CACHE_H */
diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-socfpga/socfpga.c
index adbf383..af6413a 100644
--- a/arch/arm/mach-socfpga/socfpga.c
+++ b/arch/arm/mach-socfpga/socfpga.c
@@ -1,5 +1,5 @@
 /*
- *  Copyright (C) 2012 Altera Corporation
+ *  Copyright (C) 2012;2014 Altera Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -25,6 +25,8 @@
 #include <asm/mach/map.h>
 
 #include "core.h"
+#include "l2_cache.h"
+#include "ocram.h"
 
 void __iomem *socfpga_scu_base_addr = ((void __iomem *)(SOCFPGA_SCU_VIRT_BASE));
 void __iomem *sys_manager_base_addr;
@@ -83,6 +85,7 @@ static void __init socfpga_init_irq(void)
 {
 	irqchip_init();
 	socfpga_sysmgr_init();
+	socfpga_init_l2_ecc();
 }
 
 static void socfpga_cyclone5_restart(enum reboot_mode mode, const char *cmd)
-- 
1.7.9.5
