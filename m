From: david@lechnology.com (David Lechner)
Date: Thu, 24 Mar 2016 18:51:27 -0500
Subject: [PATCH v3 02/16] mfd: da8xx-cfgchip: New header file for CFGCHIP
 registers.
In-Reply-To: <1458863503-31121-1-git-send-email-david@lechnology.com>
References: <1458863503-31121-1-git-send-email-david@lechnology.com>
Message-ID: <1458863503-31121-3-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We will be using a generic syscon device for the TI DA8XX SoC CFGCHIPx
retisters. This will be used by a number of planned drivers including a
new USB PHY driver and common clock framework drivers.

The same defines are removed from the platform_data header file since they
are now redundant and they didn't really belong there anyway.

Signed-off-by: David Lechner <david@lechnology.com>
---

v3 changes: This is a new patch. It replaces the previous patch that just added
some missing CFGCHIP2 registers to the platform_data/usb-davinci.h file.
I took David Laight's advice and included all of the possible registers.

Many of these registers will be used for clocks - hopefully in the near future. 


include/linux/mfd/da8xx-cfgchip.h         | 160 ++++++++++++++++++++++++++++++
 include/linux/platform_data/usb-davinci.h |  23 -----
 2 files changed, 160 insertions(+), 23 deletions(-)
 create mode 100644 include/linux/mfd/da8xx-cfgchip.h

diff --git a/include/linux/mfd/da8xx-cfgchip.h b/include/linux/mfd/da8xx-cfgchip.h
new file mode 100644
index 0000000..6940cf9
--- /dev/null
+++ b/include/linux/mfd/da8xx-cfgchip.h
@@ -0,0 +1,160 @@
+/*
+ * TI DaVinci DA8xx CHIPCFGx registers for syscon consumers.
+ *
+ * Copyright (C) 2016 David Lechner <david@lechnology.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __LINUX_MFD_DA8XX_CFGCHIP_H
+#define __LINUX_MFD_DA8XX_CFGCHIP_H
+
+#include <linux/bitops.h>
+
+/* register offsets */
+#define CFGCHIP_REG(n)				(n * 4)
+#define CFGCHIP0_REG				CFGCHIP_REG(0)
+#define CFGCHIP1_REG				CFGCHIP_REG(1)
+#define CFGCHIP2_REG				CFGCHIP_REG(2)
+#define CFGCHIP3_REG				CFGCHIP_REG(3)
+#define CFGCHIP4_REG				CFGCHIP_REG(4)
+
+/* CFGCHIP0 (PLL0/EDMA3_0) register bits */
+#define CFGCHIP0_PLL_MASTER_LOCK		BIT(4)
+#define CFGCHIP0_EDMA30TC1DBS(n)		(n << 2)
+#define CFGCHIP0_EDMA30TC1DBS_MASK		CFGCHIP0_EDMA30TC1DBS(0x3)
+#define CFGCHIP0_EDMA30TC1DBS_16		CFGCHIP0_EDMA30TC1DBS(0x0)
+#define CFGCHIP0_EDMA30TC1DBS_32		CFGCHIP0_EDMA30TC1DBS(0x1)
+#define CFGCHIP0_EDMA30TC1DBS_64		CFGCHIP0_EDMA30TC1DBS(0x2)
+#define CFGCHIP0_EDMA30TC0DBS(n)		(n << 0)
+#define CFGCHIP0_EDMA30TC0DBS_MASK		CFGCHIP0_EDMA30TC0DBS(0x3)
+#define CFGCHIP0_EDMA30TC0DBS_16		CFGCHIP0_EDMA30TC0DBS(0x0)
+#define CFGCHIP0_EDMA30TC0DBS_32		CFGCHIP0_EDMA30TC0DBS(0x1)
+#define CFGCHIP0_EDMA30TC0DBS_64		CFGCHIP0_EDMA30TC0DBS(0x2)
+
+/* CFGCHIP1 (eCAP/HPI/EDMA3_1/eHRPWM TBCLK/McASP0 AMUTEIN) register bits */
+#define CFGCHIP1_CAP2SRC(n)			(n << 27)
+#define CFGCHIP1_CAP2SRC_MASK			CFGCHIP1_CAP2SRC(0x1f)
+#define CFGCHIP1_CAP2SRC_ECAP_PIN		CFGCHIP1_CAP2SRC(0x0)
+#define CFGCHIP1_CAP2SRC_MCASP0_TX		CFGCHIP1_CAP2SRC(0x1)
+#define CFGCHIP1_CAP2SRC_MCASP0_RX		CFGCHIP1_CAP2SRC(0x2)
+#define CFGCHIP1_CAP2SRC_EMAC_C0_RX_THRESHOLD	CFGCHIP1_CAP2SRC(0x7)
+#define CFGCHIP1_CAP2SRC_EMAC_C0_RX		CFGCHIP1_CAP2SRC(0x8)
+#define CFGCHIP1_CAP2SRC_EMAC_C0_TX		CFGCHIP1_CAP2SRC(0x9)
+#define CFGCHIP1_CAP2SRC_EMAC_C0_MISC		CFGCHIP1_CAP2SRC(0xa)
+#define CFGCHIP1_CAP2SRC_EMAC_C1_RX_THRESHOLD	CFGCHIP1_CAP2SRC(0xb)
+#define CFGCHIP1_CAP2SRC_EMAC_C1_RX		CFGCHIP1_CAP2SRC(0xc)
+#define CFGCHIP1_CAP2SRC_EMAC_C1_TX		CFGCHIP1_CAP2SRC(0xd)
+#define CFGCHIP1_CAP2SRC_EMAC_C1_MISC		CFGCHIP1_CAP2SRC(0xe)
+#define CFGCHIP1_CAP2SRC_EMAC_C2_RX_THRESHOLD	CFGCHIP1_CAP2SRC(0xf)
+#define CFGCHIP1_CAP2SRC_EMAC_C2_RX		CFGCHIP1_CAP2SRC(0x10)
+#define CFGCHIP1_CAP2SRC_EMAC_C2_TX		CFGCHIP1_CAP2SRC(0x11)
+#define CFGCHIP1_CAP2SRC_EMAC_C2_MISC		CFGCHIP1_CAP2SRC(0x12)
+#define CFGCHIP1_CAP1SRC(n)			(n << 22)
+#define CFGCHIP1_CAP1SRC_MASK			CFGCHIP1_CAP1SRC(0x1f)
+#define CFGCHIP1_CAP1SRC_ECAP_PIN		CFGCHIP1_CAP1SRC(0x0)
+#define CFGCHIP1_CAP1SRC_MCASP0_TX		CFGCHIP1_CAP1SRC(0x1)
+#define CFGCHIP1_CAP1SRC_MCASP0_RX		CFGCHIP1_CAP1SRC(0x2)
+#define CFGCHIP1_CAP1SRC_EMAC_C0_RX_THRESHOLD	CFGCHIP1_CAP1SRC(0x7)
+#define CFGCHIP1_CAP1SRC_EMAC_C0_RX		CFGCHIP1_CAP1SRC(0x8)
+#define CFGCHIP1_CAP1SRC_EMAC_C0_TX		CFGCHIP1_CAP1SRC(0x9)
+#define CFGCHIP1_CAP1SRC_EMAC_C0_MISC		CFGCHIP1_CAP1SRC(0xa)
+#define CFGCHIP1_CAP1SRC_EMAC_C1_RX_THRESHOLD	CFGCHIP1_CAP1SRC(0xb)
+#define CFGCHIP1_CAP1SRC_EMAC_C1_RX		CFGCHIP1_CAP1SRC(0xc)
+#define CFGCHIP1_CAP1SRC_EMAC_C1_TX		CFGCHIP1_CAP1SRC(0xd)
+#define CFGCHIP1_CAP1SRC_EMAC_C1_MISC		CFGCHIP1_CAP1SRC(0xe)
+#define CFGCHIP1_CAP1SRC_EMAC_C2_RX_THRESHOLD	CFGCHIP1_CAP1SRC(0xf)
+#define CFGCHIP1_CAP1SRC_EMAC_C2_RX		CFGCHIP1_CAP1SRC(0x10)
+#define CFGCHIP1_CAP1SRC_EMAC_C2_TX		CFGCHIP1_CAP1SRC(0x11)
+#define CFGCHIP1_CAP1SRC_EMAC_C2_MISC		CFGCHIP1_CAP1SRC(0x12)
+#define CFGCHIP1_CAP0SRC(n)			(n << 17)
+#define CFGCHIP1_CAP0SRC_MASK			CFGCHIP1_CAP0SRC(0x1f)
+#define CFGCHIP1_CAP0SRC_ECAP_PIN		CFGCHIP1_CAP0SRC(0x0)
+#define CFGCHIP1_CAP0SRC_MCASP0_TX		CFGCHIP1_CAP0SRC(0x1)
+#define CFGCHIP1_CAP0SRC_MCASP0_RX		CFGCHIP1_CAP0SRC(0x2)
+#define CFGCHIP1_CAP0SRC_EMAC_C0_RX_THRESHOLD	CFGCHIP1_CAP0SRC(0x7)
+#define CFGCHIP1_CAP0SRC_EMAC_C0_RX		CFGCHIP1_CAP0SRC(0x8)
+#define CFGCHIP1_CAP0SRC_EMAC_C0_TX		CFGCHIP1_CAP0SRC(0x9)
+#define CFGCHIP1_CAP0SRC_EMAC_C0_MISC		CFGCHIP1_CAP0SRC(0xa)
+#define CFGCHIP1_CAP0SRC_EMAC_C1_RX_THRESHOLD	CFGCHIP1_CAP0SRC(0xb)
+#define CFGCHIP1_CAP0SRC_EMAC_C1_RX		CFGCHIP1_CAP0SRC(0xc)
+#define CFGCHIP1_CAP0SRC_EMAC_C1_TX		CFGCHIP1_CAP0SRC(0xd)
+#define CFGCHIP1_CAP0SRC_EMAC_C1_MISC		CFGCHIP1_CAP0SRC(0xe)
+#define CFGCHIP1_CAP0SRC_EMAC_C2_RX_THRESHOLD	CFGCHIP1_CAP0SRC(0xf)
+#define CFGCHIP1_CAP0SRC_EMAC_C2_RX		CFGCHIP1_CAP0SRC(0x10)
+#define CFGCHIP1_CAP0SRC_EMAC_C2_TX		CFGCHIP1_CAP0SRC(0x11)
+#define CFGCHIP1_CAP0SRC_EMAC_C2_MISC		CFGCHIP1_CAP0SRC(0x12)
+#define CFGCHIP1_HPIBYTEAD			BIT(16)
+#define CFGCHIP1_HPIENA				BIT(15)
+#define CFGCHIP0_EDMA31TC0DBS(n)		(n << 13)
+#define CFGCHIP0_EDMA31TC0DBS_MASK		CFGCHIP0_EDMA31TC0DBS(0x3)
+#define CFGCHIP0_EDMA31TC0DBS_16		CFGCHIP0_EDMA31TC0DBS(0x0)
+#define CFGCHIP0_EDMA31TC0DBS_32		CFGCHIP0_EDMA31TC0DBS(0x1)
+#define CFGCHIP0_EDMA31TC0DBS_64		CFGCHIP0_EDMA31TC0DBS(0x2)
+#define CFGCHIP1_TBCLKSYNC			BIT(12)
+#define CFGCHIP1_AMUTESEL0(n)			(n << 0)
+#define CFGCHIP1_AMUTESEL0_MASK			CFGCHIP1_AMUTESEL0(0xf)
+#define CFGCHIP1_AMUTESEL0_LOW			CFGCHIP1_AMUTESEL0(0x0)
+#define CFGCHIP1_AMUTESEL0_BANK_0		CFGCHIP1_AMUTESEL0(0x1)
+#define CFGCHIP1_AMUTESEL0_BANK_1		CFGCHIP1_AMUTESEL0(0x2)
+#define CFGCHIP1_AMUTESEL0_BANK_2		CFGCHIP1_AMUTESEL0(0x3)
+#define CFGCHIP1_AMUTESEL0_BANK_3		CFGCHIP1_AMUTESEL0(0x4)
+#define CFGCHIP1_AMUTESEL0_BANK_4		CFGCHIP1_AMUTESEL0(0x5)
+#define CFGCHIP1_AMUTESEL0_BANK_5		CFGCHIP1_AMUTESEL0(0x6)
+#define CFGCHIP1_AMUTESEL0_BANK_6		CFGCHIP1_AMUTESEL0(0x7)
+#define CFGCHIP1_AMUTESEL0_BANK_7		CFGCHIP1_AMUTESEL0(0x8)
+
+/* CFGCHIP2 (USB PHY) register bits */
+#define CFGCHIP2_PHYCLKGD			BIT(17)
+#define CFGCHIP2_VBUSSENSE			BIT(16)
+#define CFGCHIP2_RESET				BIT(15)
+#define CFGCHIP2_OTGMODE(n)			(n << 13)
+#define CFGCHIP2_OTGMODE_MASK			CFGCHIP2_OTGMODE(0x3)
+#define CFGCHIP2_OTGMODE_NO_OVERRIDE		CFGCHIP2_OTGMODE(0x0)
+#define CFGCHIP2_OTGMODE_FORCE_HOST		CFGCHIP2_OTGMODE(0x1)
+#define CFGCHIP2_OTGMODE_FORCE_DEVICE		CFGCHIP2_OTGMODE(0x2)
+#define CFGCHIP2_OTGMODE_FORCE_HOST_VBUS_LOW	CFGCHIP2_OTGMODE(0x3)
+#define CFGCHIP2_USB1PHYCLKMUX			BIT(12)
+#define CFGCHIP2_USB2PHYCLKMUX			BIT(11)
+#define CFGCHIP2_PHYPWRDN			BIT(10)
+#define CFGCHIP2_OTGPWRDN			BIT(9)
+#define CFGCHIP2_DATPOL				BIT(8)
+#define CFGCHIP2_USB1SUSPENDM			BIT(7)
+#define CFGCHIP2_PHY_PLLON			BIT(6)
+#define CFGCHIP2_SESENDEN			BIT(5)
+#define CFGCHIP2_VBDTCTEN			BIT(4)
+#define CFGCHIP2_REFFREQ(n)			(n << 0)
+#define CFGCHIP2_REFFREQ_MASK			CFGCHIP2_REFFREQ(0xf)
+#define CFGCHIP2_REFFREQ_12MHZ			CFGCHIP2_REFFREQ(0x1)
+#define CFGCHIP2_REFFREQ_24MHZ			CFGCHIP2_REFFREQ(0x2)
+#define CFGCHIP2_REFFREQ_48MHZ			CFGCHIP2_REFFREQ(0x3)
+#define CFGCHIP2_REFFREQ_19_2MHZ		CFGCHIP2_REFFREQ(0x4)
+#define CFGCHIP2_REFFREQ_38_4MHZ		CFGCHIP2_REFFREQ(0x5)
+#define CFGCHIP2_REFFREQ_13MHZ			CFGCHIP2_REFFREQ(0x6)
+#define CFGCHIP2_REFFREQ_26MHZ			CFGCHIP2_REFFREQ(0x7)
+#define CFGCHIP2_REFFREQ_20MHZ			CFGCHIP2_REFFREQ(0x8)
+#define CFGCHIP2_REFFREQ_40MHZ			CFGCHIP2_REFFREQ(0x9)
+
+/* CFGCHIP3 (EMAC/uPP/PLL1/ASYNC3/PRU/DIV4.5/EMIFA) register bits */
+
+#define CFGCHIP3_RMII_SEL			BIT(8)
+#define CFGCHIP3_UPP_TX_CLKSRC			BIT(6)
+#define CFGCHIP3_PLL1_MASTER_LOCK		BIT(5)
+#define CFGCHIP3_ASYNC3_CLKSRC			BIT(4)
+#define CFGCHIP3_PRUEVTSEL			BIT(3)
+#define CFGCHIP3_DIV45PENA			BIT(2)
+#define CFGCHIP3_EMA_CLKSRC			BIT(1)
+
+/* CFGCHIP4 (McASP0 AMUNTEIN) register bits */
+
+#define CFGCHIP4_AMUTECLR0			BIT(0)
+
+#endif /* __LINUX_MFD_DA8XX_CFGCHIP_H */
diff --git a/include/linux/platform_data/usb-davinci.h b/include/linux/platform_data/usb-davinci.h
index e0bc4ab..7c6ce24 100644
--- a/include/linux/platform_data/usb-davinci.h
+++ b/include/linux/platform_data/usb-davinci.h
@@ -11,28 +11,6 @@
 #ifndef __ASM_ARCH_USB_H
 #define __ASM_ARCH_USB_H
 
-/* DA8xx CFGCHIP2 (USB 2.0 PHY Control) register bits */
-#define CFGCHIP2_PHYCLKGD	(1 << 17)
-#define CFGCHIP2_VBUSSENSE	(1 << 16)
-#define CFGCHIP2_RESET		(1 << 15)
-#define CFGCHIP2_OTGMODE	(3 << 13)
-#define CFGCHIP2_NO_OVERRIDE	(0 << 13)
-#define CFGCHIP2_FORCE_HOST	(1 << 13)
-#define CFGCHIP2_FORCE_DEVICE 	(2 << 13)
-#define CFGCHIP2_FORCE_HOST_VBUS_LOW (3 << 13)
-#define CFGCHIP2_USB1PHYCLKMUX	(1 << 12)
-#define CFGCHIP2_USB2PHYCLKMUX	(1 << 11)
-#define CFGCHIP2_PHYPWRDN	(1 << 10)
-#define CFGCHIP2_OTGPWRDN	(1 << 9)
-#define CFGCHIP2_DATPOL 	(1 << 8)
-#define CFGCHIP2_USB1SUSPENDM	(1 << 7)
-#define CFGCHIP2_PHY_PLLON	(1 << 6)	/* override PLL suspend */
-#define CFGCHIP2_SESENDEN	(1 << 5)	/* Vsess_end comparator */
-#define CFGCHIP2_VBDTCTEN	(1 << 4)	/* Vbus comparator */
-#define CFGCHIP2_REFFREQ	(0xf << 0)
-#define CFGCHIP2_REFFREQ_12MHZ	(1 << 0)
-#define CFGCHIP2_REFFREQ_24MHZ	(2 << 0)
-#define CFGCHIP2_REFFREQ_48MHZ	(3 << 0)
 
 struct	da8xx_ohci_root_hub;
 
@@ -53,7 +31,6 @@ struct	da8xx_ohci_root_hub {
 	/* Time from power on to power good (in 2 ms units) */
 	u8	potpgt;
 };
-
 void davinci_setup_usb(unsigned mA, unsigned potpgt_ms);
 
 #endif	/* ifndef __ASM_ARCH_USB_H */
-- 
1.9.1
