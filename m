From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 08 Mar 2012 03:51:25 -0700
Subject: [PATCH 01/15] ARM: OMAP2+: clockdomains: make {prm,cm}_clkdm common
In-Reply-To: <20120308104918.14753.69281.stgit@dusk>
References: <20120308104918.14753.69281.stgit@dusk>
Message-ID: <20120308105123.14753.65790.stgit@dusk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PRM and CM implicit clockdomains will soon be used by OMAP44xx.
So, make them common to OMAP2+ and modify the OMAP4 clockdomains code
so use of these clockdomains doesn't crash the system.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/Makefile                     |    8 +++++--
 arch/arm/mach-omap2/clockdomain44xx.c            |    6 ++++++
 arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c |   10 ---------
 arch/arm/mach-omap2/clockdomains44xx_data.c      |    2 ++
 arch/arm/mach-omap2/clockdomains_common_data.c   |   24 ++++++++++++++++++++++
 5 files changed, 37 insertions(+), 13 deletions(-)
 create mode 100644 arch/arm/mach-omap2/clockdomains_common_data.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index bd76394..9b2f406 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -117,16 +117,18 @@ obj-$(CONFIG_ARCH_OMAP4)		+= $(powerdomain-common) \
 					   powerdomains44xx_data.o
 
 # PRCM clockdomain control
-obj-$(CONFIG_ARCH_OMAP2)		+= clockdomain.o \
+clockdomain-common			+= clockdomain.o \
+					   clockdomains_common_data.o
+obj-$(CONFIG_ARCH_OMAP2)		+= $(clockdomain-common) \
 					   clockdomain2xxx_3xxx.o \
 					   clockdomains2xxx_3xxx_data.o
 obj-$(CONFIG_SOC_OMAP2420)		+= clockdomains2420_data.o
 obj-$(CONFIG_SOC_OMAP2430)		+= clockdomains2430_data.o
-obj-$(CONFIG_ARCH_OMAP3)		+= clockdomain.o \
+obj-$(CONFIG_ARCH_OMAP3)		+= $(clockdomain-common) \
 					   clockdomain2xxx_3xxx.o \
 					   clockdomains2xxx_3xxx_data.o \
 					   clockdomains3xxx_data.o
-obj-$(CONFIG_ARCH_OMAP4)		+= clockdomain.o \
+obj-$(CONFIG_ARCH_OMAP4)		+= $(clockdomain-common) \
 					   clockdomain44xx.o \
 					   clockdomains44xx_data.o
 
diff --git a/arch/arm/mach-omap2/clockdomain44xx.c b/arch/arm/mach-omap2/clockdomain44xx.c
index 935c7f0..4f04dd1 100644
--- a/arch/arm/mach-omap2/clockdomain44xx.c
+++ b/arch/arm/mach-omap2/clockdomain44xx.c
@@ -51,6 +51,9 @@ static int omap4_clkdm_clear_all_wkup_sleep_deps(struct clockdomain *clkdm)
 	struct clkdm_dep *cd;
 	u32 mask = 0;
 
+	if (!clkdm->prcm_partition)
+		return 0;
+
 	for (cd = clkdm->wkdep_srcs; cd && cd->clkdm_name; cd++) {
 		if (!cd->clkdm)
 			continue; /* only happens if data is erroneous */
@@ -103,6 +106,9 @@ static int omap4_clkdm_clk_disable(struct clockdomain *clkdm)
 {
 	bool hwsup = false;
 
+	if (!clkdm->prcm_partition)
+		return 0;
+
 	hwsup = omap4_cminst_is_clkdm_in_hwsup(clkdm->prcm_partition,
 					clkdm->cm_inst, clkdm->clkdm_offs);
 
diff --git a/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c b/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c
index 0a6a048..839145e 100644
--- a/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c
+++ b/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c
@@ -89,13 +89,3 @@ struct clockdomain wkup_common_clkdm = {
 	.pwrdm		= { .name = "wkup_pwrdm" },
 	.dep_bit	= OMAP_EN_WKUP_SHIFT,
 };
-
-struct clockdomain prm_common_clkdm = {
-	.name		= "prm_clkdm",
-	.pwrdm		= { .name = "wkup_pwrdm" },
-};
-
-struct clockdomain cm_common_clkdm = {
-	.name		= "cm_clkdm",
-	.pwrdm		= { .name = "core_pwrdm" },
-};
diff --git a/arch/arm/mach-omap2/clockdomains44xx_data.c b/arch/arm/mach-omap2/clockdomains44xx_data.c
index 9299ac2..dc42cd6 100644
--- a/arch/arm/mach-omap2/clockdomains44xx_data.c
+++ b/arch/arm/mach-omap2/clockdomains44xx_data.c
@@ -430,6 +430,8 @@ static struct clockdomain *clockdomains_omap44xx[] __initdata = {
 	&l4_wkup_44xx_clkdm,
 	&emu_sys_44xx_clkdm,
 	&l3_dma_44xx_clkdm,
+	&prm_common_clkdm,
+	&cm_common_clkdm,
 	NULL
 };
 
diff --git a/arch/arm/mach-omap2/clockdomains_common_data.c b/arch/arm/mach-omap2/clockdomains_common_data.c
new file mode 100644
index 0000000..615b1f0
--- /dev/null
+++ b/arch/arm/mach-omap2/clockdomains_common_data.c
@@ -0,0 +1,24 @@
+/*
+ * OMAP2+-common clockdomain data
+ *
+ * Copyright (C) 2008-2012 Texas Instruments, Inc.
+ * Copyright (C) 2008-2010 Nokia Corporation
+ *
+ * Paul Walmsley, Jouni H?gander
+ */
+
+#include <linux/kernel.h>
+#include <linux/io.h>
+
+#include "clockdomain.h"
+
+/* These are implicit clockdomains - they are never defined as such in TRM */
+struct clockdomain prm_common_clkdm = {
+	.name		= "prm_clkdm",
+	.pwrdm		= { .name = "wkup_pwrdm" },
+};
+
+struct clockdomain cm_common_clkdm = {
+	.name		= "cm_clkdm",
+	.pwrdm		= { .name = "core_pwrdm" },
+};
