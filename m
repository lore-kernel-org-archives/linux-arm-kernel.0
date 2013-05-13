From: shc_work@mail.ru (Alexander Shiyan)
Date: Mon, 13 May 2013 21:07:36 +0400
Subject: [PATCH 14/15] ARM: clps711x: Add support for SYSCON driver
In-Reply-To: <1368464857-5038-1-git-send-email-shc_work@mail.ru>
References: <1368464857-5038-1-git-send-email-shc_work@mail.ru>
Message-ID: <1368464857-5038-17-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for SYSCON driver for CLPS711X targets.
At this time there are no users for this driver, but it is will
be used as start point to use in CLPS711X drivers and remove
<mach/xx> dependencies.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/Kconfig                               |  1 +
 arch/arm/mach-clps711x/devices.c               | 20 ++++++
 arch/arm/mach-clps711x/include/mach/clps711x.h | 88 +-----------------------
 drivers/mfd/syscon.c                           |  3 +
 include/linux/mfd/syscon/clps711x.h            | 94 ++++++++++++++++++++++++++
 5 files changed, 120 insertions(+), 86 deletions(-)
 create mode 100644 include/linux/mfd/syscon/clps711x.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2af27f7..6228676 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -371,6 +371,7 @@ config ARCH_CLPS711X
 	select COMMON_CLK
 	select CPU_ARM720T
 	select GENERIC_CLOCKEVENTS
+	select MFD_SYSCON
 	select MULTI_IRQ_HANDLER
 	select SPARSE_IRQ
 	help
diff --git a/arch/arm/mach-clps711x/devices.c b/arch/arm/mach-clps711x/devices.c
index 21161ed..856b81c 100644
--- a/arch/arm/mach-clps711x/devices.c
+++ b/arch/arm/mach-clps711x/devices.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/platform_device.h>
+#include <linux/sizes.h>
 
 #include <mach/hardware.h>
 
@@ -42,7 +43,26 @@ static void __init clps711x_add_gpio(void)
 	}
 }
 
+const struct resource clps711x_syscon_res[] __initconst = {
+	/* SYSCON1, SYSFLG1 */
+	DEFINE_RES_MEM(CLPS711X_PHYS_BASE + SYSCON1, SZ_128),
+	/* SYSCON2, SYSFLG2 */
+	DEFINE_RES_MEM(CLPS711X_PHYS_BASE + SYSCON2, SZ_128),
+	/* SYSCON3 */
+	DEFINE_RES_MEM(CLPS711X_PHYS_BASE + SYSCON3, SZ_64),
+};
+
+static void __init clps711x_add_syscon(void)
+{
+	unsigned i;
+
+	for (i = 0; i < ARRAY_SIZE(clps711x_syscon_res); i++)
+		platform_device_register_simple("clps711x-syscon", i + 1,
+						&clps711x_syscon_res[i], 1);
+}
+
 void __init clps711x_devices_init(void)
 {
 	clps711x_add_gpio();
+	clps711x_add_syscon();
 }
diff --git a/arch/arm/mach-clps711x/include/mach/clps711x.h b/arch/arm/mach-clps711x/include/mach/clps711x.h
index 01d1b95..0286f4b 100644
--- a/arch/arm/mach-clps711x/include/mach/clps711x.h
+++ b/arch/arm/mach-clps711x/include/mach/clps711x.h
@@ -21,6 +21,8 @@
 #ifndef __MACH_CLPS711X_H
 #define __MACH_CLPS711X_H
 
+#include <linux/mfd/syscon/clps711x.h>
+
 #define CLPS711X_PHYS_BASE	(0x80000000)
 
 #define PADR		(0x0000)
@@ -96,83 +98,9 @@
 #define RANDID2		(0x2708)
 #define RANDID3		(0x270c)
 
-/* common bits: SYSCON1 / SYSCON2 */
-#define SYSCON_UARTEN		(1 << 8)
-
-#define SYSCON1_KBDSCAN(x)	((x) & 15)
-#define SYSCON1_KBDSCANMASK	(15)
-#define SYSCON1_TC1M		(1 << 4)
-#define SYSCON1_TC1S		(1 << 5)
-#define SYSCON1_TC2M		(1 << 6)
-#define SYSCON1_TC2S		(1 << 7)
-#define SYSCON1_UART1EN		SYSCON_UARTEN
-#define SYSCON1_BZTOG		(1 << 9)
-#define SYSCON1_BZMOD		(1 << 10)
-#define SYSCON1_DBGEN		(1 << 11)
-#define SYSCON1_LCDEN		(1 << 12)
-#define SYSCON1_CDENTX		(1 << 13)
-#define SYSCON1_CDENRX		(1 << 14)
-#define SYSCON1_SIREN		(1 << 15)
-#define SYSCON1_ADCKSEL(x)	(((x) & 3) << 16)
-#define SYSCON1_ADCKSEL_MASK	(3 << 16)
-#define SYSCON1_EXCKEN		(1 << 18)
-#define SYSCON1_WAKEDIS		(1 << 19)
-#define SYSCON1_IRTXM		(1 << 20)
-
-/* common bits: SYSFLG1 / SYSFLG2 */
-#define SYSFLG_UBUSY		(1 << 11)
-#define SYSFLG_URXFE		(1 << 22)
-#define SYSFLG_UTXFF		(1 << 23)
-
-#define SYSFLG1_MCDR		(1 << 0)
-#define SYSFLG1_DCDET		(1 << 1)
-#define SYSFLG1_WUDR		(1 << 2)
-#define SYSFLG1_WUON		(1 << 3)
-#define SYSFLG1_CTS		(1 << 8)
-#define SYSFLG1_DSR		(1 << 9)
-#define SYSFLG1_DCD		(1 << 10)
-#define SYSFLG1_UBUSY		SYSFLG_UBUSY
-#define SYSFLG1_NBFLG		(1 << 12)
-#define SYSFLG1_RSTFLG		(1 << 13)
-#define SYSFLG1_PFFLG		(1 << 14)
-#define SYSFLG1_CLDFLG		(1 << 15)
-#define SYSFLG1_URXFE		SYSFLG_URXFE
-#define SYSFLG1_UTXFF		SYSFLG_UTXFF
-#define SYSFLG1_CRXFE		(1 << 24)
-#define SYSFLG1_CTXFF		(1 << 25)
-#define SYSFLG1_SSIBUSY		(1 << 26)
-#define SYSFLG1_ID		(1 << 29)
-#define SYSFLG1_VERID(x)	(((x) >> 30) & 3)
-#define SYSFLG1_VERID_MASK	(3 << 30)
-
-#define SYSFLG2_SSRXOF		(1 << 0)
-#define SYSFLG2_RESVAL		(1 << 1)
-#define SYSFLG2_RESFRM		(1 << 2)
-#define SYSFLG2_SS2RXFE		(1 << 3)
-#define SYSFLG2_SS2TXFF		(1 << 4)
-#define SYSFLG2_SS2TXUF		(1 << 5)
-#define SYSFLG2_CKMODE		(1 << 6)
-#define SYSFLG2_UBUSY		SYSFLG_UBUSY
-#define SYSFLG2_URXFE		SYSFLG_URXFE
-#define SYSFLG2_UTXFF		SYSFLG_UTXFF
-
 #define LCDCON_GSEN		(1 << 30)
 #define LCDCON_GSMD		(1 << 31)
 
-#define SYSCON2_SERSEL		(1 << 0)
-#define SYSCON2_KBD6		(1 << 1)
-#define SYSCON2_DRAMZ		(1 << 2)
-#define SYSCON2_KBWEN		(1 << 3)
-#define SYSCON2_SS2TXEN		(1 << 4)
-#define SYSCON2_PCCARD1		(1 << 5)
-#define SYSCON2_PCCARD2		(1 << 6)
-#define SYSCON2_SS2RXEN		(1 << 7)
-#define SYSCON2_UART2EN		SYSCON_UARTEN
-#define SYSCON2_SS2MAEN		(1 << 9)
-#define SYSCON2_OSTB		(1 << 12)
-#define SYSCON2_CLKENSL		(1 << 13)
-#define SYSCON2_BUZFREQ		(1 << 14)
-
 /* common bits: UARTDR1 / UARTDR2 */
 #define UARTDR_FRMERR		(1 << 8)
 #define UARTDR_PARERR		(1 << 9)
@@ -228,18 +156,6 @@
 #define DAI64FS_MCLK256EN	(1 << 3)
 #define DAI64FS_LOOPBACK	(1 << 5)
 
-#define SYSCON3_ADCCON		(1 << 0)
-#define SYSCON3_CLKCTL0		(1 << 1)
-#define SYSCON3_CLKCTL1		(1 << 2)
-#define SYSCON3_DAISEL		(1 << 3)
-#define SYSCON3_ADCCKNSEN	(1 << 4)
-#define SYSCON3_VERSN(x)	(((x) >> 5) & 7)
-#define SYSCON3_VERSN_MASK	(7 << 5)
-#define SYSCON3_FASTWAKE	(1 << 8)
-#define SYSCON3_DAIEN		(1 << 9)
-#define SYSCON3_128FS		SYSCON3_DAIEN
-#define SYSCON3_ENPD67		(1 << 10)
-
 #define SDCONF_ACTIVE		(1 << 10)
 #define SDCONF_CLKCTL		(1 << 9)
 #define SDCONF_WIDTH_4		(0 << 7)
diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index 962a6e1..1a31512 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -159,6 +159,9 @@ static int syscon_probe(struct platform_device *pdev)
 
 static const struct platform_device_id syscon_ids[] = {
 	{ "syscon", },
+#ifdef CONFIG_ARCH_CLPS711X
+	{ "clps711x-syscon", },
+#endif
 	{ }
 };
 
diff --git a/include/linux/mfd/syscon/clps711x.h b/include/linux/mfd/syscon/clps711x.h
new file mode 100644
index 0000000..26355ab
--- /dev/null
+++ b/include/linux/mfd/syscon/clps711x.h
@@ -0,0 +1,94 @@
+/*
+ *  CLPS711X system register bits definitions
+ *
+ *  Copyright (C) 2013 Alexander Shiyan <shc_work@mail.ru>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef _LINUX_MFD_SYSCON_CLPS711X_H_
+#define _LINUX_MFD_SYSCON_CLPS711X_H_
+
+#define SYSCON_OFFSET		(0x00)
+#define SYSFLG_OFFSET		(0x40)
+
+#define SYSCON1_KBDSCAN(x)	((x) & 15)
+#define SYSCON1_KBDSCAN_MASK	(15)
+#define SYSCON1_TC1M		(1 << 4)
+#define SYSCON1_TC1S		(1 << 5)
+#define SYSCON1_TC2M		(1 << 6)
+#define SYSCON1_TC2S		(1 << 7)
+#define SYSCON1_BZTOG		(1 << 9)
+#define SYSCON1_BZMOD		(1 << 10)
+#define SYSCON1_DBGEN		(1 << 11)
+#define SYSCON1_LCDEN		(1 << 12)
+#define SYSCON1_CDENTX		(1 << 13)
+#define SYSCON1_CDENRX		(1 << 14)
+#define SYSCON1_SIREN		(1 << 15)
+#define SYSCON1_ADCKSEL(x)	(((x) & 3) << 16)
+#define SYSCON1_ADCKSEL_MASK	(3 << 16)
+#define SYSCON1_EXCKEN		(1 << 18)
+#define SYSCON1_WAKEDIS		(1 << 19)
+#define SYSCON1_IRTXM		(1 << 20)
+
+#define SYSCON2_SERSEL		(1 << 0)
+#define SYSCON2_KBD6		(1 << 1)
+#define SYSCON2_DRAMZ		(1 << 2)
+#define SYSCON2_KBWEN		(1 << 3)
+#define SYSCON2_SS2TXEN		(1 << 4)
+#define SYSCON2_PCCARD1		(1 << 5)
+#define SYSCON2_PCCARD2		(1 << 6)
+#define SYSCON2_SS2RXEN		(1 << 7)
+#define SYSCON2_SS2MAEN		(1 << 9)
+#define SYSCON2_OSTB		(1 << 12)
+#define SYSCON2_CLKENSL		(1 << 13)
+#define SYSCON2_BUZFREQ		(1 << 14)
+
+#define SYSCON3_ADCCON		(1 << 0)
+#define SYSCON3_CLKCTL0		(1 << 1)
+#define SYSCON3_CLKCTL1		(1 << 2)
+#define SYSCON3_DAISEL		(1 << 3)
+#define SYSCON3_ADCCKNSEN	(1 << 4)
+#define SYSCON3_VERSN(x)	(((x) >> 5) & 7)
+#define SYSCON3_VERSN_MASK	(7 << 5)
+#define SYSCON3_FASTWAKE	(1 << 8)
+#define SYSCON3_DAIEN		(1 << 9)
+#define SYSCON3_128FS		SYSCON3_DAIEN
+#define SYSCON3_ENPD67		(1 << 10)
+
+#define SYSCON_UARTEN		(1 << 8)
+
+#define SYSFLG1_MCDR		(1 << 0)
+#define SYSFLG1_DCDET		(1 << 1)
+#define SYSFLG1_WUDR		(1 << 2)
+#define SYSFLG1_WUON		(1 << 3)
+#define SYSFLG1_CTS		(1 << 8)
+#define SYSFLG1_DSR		(1 << 9)
+#define SYSFLG1_DCD		(1 << 10)
+#define SYSFLG1_NBFLG		(1 << 12)
+#define SYSFLG1_RSTFLG		(1 << 13)
+#define SYSFLG1_PFFLG		(1 << 14)
+#define SYSFLG1_CLDFLG		(1 << 15)
+#define SYSFLG1_CRXFE		(1 << 24)
+#define SYSFLG1_CTXFF		(1 << 25)
+#define SYSFLG1_SSIBUSY		(1 << 26)
+#define SYSFLG1_ID		(1 << 29)
+#define SYSFLG1_VERID(x)	(((x) >> 30) & 3)
+#define SYSFLG1_VERID_MASK	(3 << 30)
+
+#define SYSFLG2_SSRXOF		(1 << 0)
+#define SYSFLG2_RESVAL		(1 << 1)
+#define SYSFLG2_RESFRM		(1 << 2)
+#define SYSFLG2_SS2RXFE		(1 << 3)
+#define SYSFLG2_SS2TXFF		(1 << 4)
+#define SYSFLG2_SS2TXUF		(1 << 5)
+#define SYSFLG2_CKMODE		(1 << 6)
+
+#define SYSFLG_UBUSY		(1 << 11)
+#define SYSFLG_URXFE		(1 << 22)
+#define SYSFLG_UTXFF		(1 << 23)
+
+#endif
-- 
1.8.1.5
