From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 10 Sep 2010 09:23:21 +0200
Subject: [PATCH 4/6] ARM: S5PV210: Enable USB HSOTG gadget build
In-Reply-To: <1284103403-10696-1-git-send-email-m.szyprowski@samsung.com>
References: <1284103403-10696-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1284103403-10696-5-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the necessary definitions and mapping information to enable the
s3c-hsotg gadget to build.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv210/cpu.c                   |    5 +++++
 arch/arm/mach-s5pv210/include/mach/map.h      |    6 ++++++
 arch/arm/mach-s5pv210/include/mach/regs-sys.h |   19 +++++++++++++++++++
 3 files changed, 30 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-s5pv210/include/mach/regs-sys.h

diff --git a/arch/arm/mach-s5pv210/cpu.c b/arch/arm/mach-s5pv210/cpu.c
index c551ab1..6183b55 100644
--- a/arch/arm/mach-s5pv210/cpu.c
+++ b/arch/arm/mach-s5pv210/cpu.c
@@ -84,6 +84,11 @@ static struct map_desc s5pv210_iodesc[] __initdata = {
 		.pfn		= __phys_to_pfn(S5PV210_PA_SROMC),
 		.length		= SZ_4K,
 		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)S3C_VA_USB_HSPHY,
+		.pfn		=__phys_to_pfn(S3C_PA_USB_HSPHY),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
 	}
 };
 
diff --git a/arch/arm/mach-s5pv210/include/mach/map.h b/arch/arm/mach-s5pv210/include/mach/map.h
index bd9afd5..724a428 100644
--- a/arch/arm/mach-s5pv210/include/mach/map.h
+++ b/arch/arm/mach-s5pv210/include/mach/map.h
@@ -73,6 +73,9 @@
 
 #define S5PV210_PA_HSMMC(x)	(0xEB000000 + ((x) * 0x100000))
 
+#define S5PV210_PA_HSOTG	(0xEC000000)
+#define S5PV210_PA_HSPHY	(0xEC100000)
+
 #define S5PV210_PA_VIC0		(0xF2000000)
 #define S5PV210_PA_VIC1		(0xF2100000)
 #define S5PV210_PA_VIC2		(0xF2200000)
@@ -111,6 +114,9 @@
 #define S5P_PA_FIMC0		S5PV210_PA_FIMC0
 #define S5P_PA_FIMC1		S5PV210_PA_FIMC1
 #define S5P_PA_FIMC2		S5PV210_PA_FIMC2
+#define S3C_PA_USB_HSOTG	S5PV210_PA_HSOTG
+#define S3C_PA_USB_HSPHY	S5PV210_PA_HSPHY
+#define S3C_VA_USB_HSPHY	S3C_ADDR(0x02000000)
 
 #define SAMSUNG_PA_ADC		S5PV210_PA_ADC
 #define SAMSUNG_PA_CFCON	S5PV210_PA_CFCON
diff --git a/arch/arm/mach-s5pv210/include/mach/regs-sys.h b/arch/arm/mach-s5pv210/include/mach/regs-sys.h
new file mode 100644
index 0000000..26691d3
--- /dev/null
+++ b/arch/arm/mach-s5pv210/include/mach/regs-sys.h
@@ -0,0 +1,19 @@
+/* arch/arm/mach-s5pv210/include/mach/regs-sys.h
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * S5PV210 - System registers definitions
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#define S5PV210_USB_PHY_CON	(S3C_VA_SYS + 0xE80C)
+#define S5PV210_USB_PHY0_EN	(1 << 0)
+#define S5PV210_USB_PHY1_EN	(1 << 1)
+
+/* compatibility defines for s3c-hsotg driver */
+#define S3C64XX_OTHERS		S5PV210_USB_PHY_CON
+#define S3C64XX_OTHERS_USBMASK	S5PV210_USB_PHY0_EN
-- 
1.7.2.2
