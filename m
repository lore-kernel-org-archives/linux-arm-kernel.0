From: andy@warmcat.com (Andy Green)
Date: Tue, 29 Dec 2009 14:40:23 +0000
Subject: [PATCH 1/4] s3c64xx-introduce-srom-registers.patch
In-Reply-To: <20091229143756.15524.25160.stgit@hit-nxdomain.opendns.com>
References: <20091229143756.15524.25160.stgit@hit-nxdomain.opendns.com>
Message-ID: <20091229144023.15524.41915.stgit@hit-nxdomain.opendns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This introduces a platform file for s3c64xx that defines
the SROM unit registers that control chip select
characteristics.

Signed-off-by: Andy Green <andy@warmcat.com>
---

 arch/arm/mach-s3c6400/include/mach/map.h       |   12 +++++
 arch/arm/plat-s3c64xx/include/plat/regs-srom.h |   59 ++++++++++++++++++++++++
 2 files changed, 71 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-s3c64xx/include/plat/regs-srom.h

diff --git a/arch/arm/mach-s3c6400/include/mach/map.h b/arch/arm/mach-s3c6400/include/mach/map.h
index f3b48f8..b0fb5c5 100644
--- a/arch/arm/mach-s3c6400/include/mach/map.h
+++ b/arch/arm/mach-s3c6400/include/mach/map.h
@@ -17,6 +17,18 @@
 
 #include <plat/map-base.h>
 
+/*
+ * Post-mux Chip Select Regions Xm0CSn_
+ * These may be used by SROM, NAND or CF depending on settings
+ */
+
+#define S3C64XX_PA_XM0CSN0 (0x10000000)
+#define S3C64XX_PA_XM0CSN1 (0x18000000)
+#define S3C64XX_PA_XM0CSN2 (0x20000000)
+#define S3C64XX_PA_XM0CSN3 (0x28000000)
+#define S3C64XX_PA_XM0CSN4 (0x30000000)
+#define S3C64XX_PA_XM0CSN5 (0x38000000)
+
 /* HSMMC units */
 #define S3C64XX_PA_HSMMC(x)	(0x7C200000 + ((x) * 0x100000))
 #define S3C64XX_PA_HSMMC0	S3C64XX_PA_HSMMC(0)
diff --git a/arch/arm/plat-s3c64xx/include/plat/regs-srom.h b/arch/arm/plat-s3c64xx/include/plat/regs-srom.h
new file mode 100644
index 0000000..756731b
--- /dev/null
+++ b/arch/arm/plat-s3c64xx/include/plat/regs-srom.h
@@ -0,0 +1,59 @@
+/* arch/arm/plat-s3c64xx/include/plat/regs-srom.h
+ *
+ * Copyright 2009 Andy Green <andy@warmcat.com>
+ *
+ * S3C64XX SROM definitions
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __PLAT_REGS_SROM_H
+#define __PLAT_REGS_SROM_H __FILE__
+
+#define S3C64XX_SROMREG(x)	(S3C_VA_MEM + (x))
+
+#define S3C64XX_SROM_BW		S3C64XX_SROMREG(0)
+#define S3C64XX_SROM_BC0	S3C64XX_SROMREG(4)
+#define S3C64XX_SROM_BC1	S3C64XX_SROMREG(8)
+#define S3C64XX_SROM_BC2	S3C64XX_SROMREG(0xc)
+#define S3C64XX_SROM_BC3	S3C64XX_SROMREG(0x10)
+#define S3C64XX_SROM_BC4	S3C64XX_SROMREG(0x14)
+#define S3C64XX_SROM_BC5	S3C64XX_SROMREG(0x18)
+
+/*
+ * one register BW holds 5 x 4-bit packed settings for NCS0 - NCS4
+ */
+
+#define S3C64XX_SROM_BW__DATAWIDTH__SHIFT	0
+#define S3C64XX_SROM_BW__WAITENABLE__SHIFT	2
+#define S3C64XX_SROM_BW__BYTEENABLE__SHIFT	3
+#define S3C64XX_SROM_BW__CS_MASK 0xf
+
+#define S3C64XX_SROM_BW__NCS0__SHIFT	0
+#define S3C64XX_SROM_BW__NCS1__SHIFT	4
+#define S3C64XX_SROM_BW__NCS2__SHIFT	8
+#define S3C64XX_SROM_BW__NCS3__SHIFT	0xc
+#define S3C64XX_SROM_BW__NCS4__SHIFT	0x10
+
+/*
+ * applies to same to BCS0 - BCS4
+ */
+
+#define S3C64XX_SROM_BCX__PMC__SHIFT	0
+#define S3C64XX_SROM_BCX__PMC__MASK	3
+#define S3C64XX_SROM_BCX__TACP__SHIFT	4
+#define S3C64XX_SROM_BCX__TACP__MASK	0xf
+#define S3C64XX_SROM_BCX__TCAH__SHIFT	8
+#define S3C64XX_SROM_BCX__TCAH__MASK	0xf
+#define S3C64XX_SROM_BCX__TCOH__SHIFT	12
+#define S3C64XX_SROM_BCX__TCOH__MASK	0xf
+#define S3C64XX_SROM_BCX__TACC__SHIFT	16
+#define S3C64XX_SROM_BCX__TACC__MASK	0x1f
+#define S3C64XX_SROM_BCX__TCOS__SHIFT	24
+#define S3C64XX_SROM_BCX__TCOS__MASK	0xf
+#define S3C64XX_SROM_BCX__TACS__SHIFT	28
+#define S3C64XX_SROM_BCX__TACS__MASK	0xf
+
+#endif /* _PLAT_REGS_SROM_H */
