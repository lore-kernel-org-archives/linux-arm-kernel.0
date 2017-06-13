From: al.cooper@broadcom.com (Al Cooper)
Date: Tue, 13 Jun 2017 10:55:20 -0400
Subject: [PATCH v2 3/4] phy: usb: phy-brcm-usb: Add Broadcom STB USB phy driver
In-Reply-To: <1497365721-31188-1-git-send-email-al.cooper@broadcom.com>
References: <1497365721-31188-1-git-send-email-al.cooper@broadcom.com>
Message-ID: <1497365721-31188-4-git-send-email-al.cooper@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Al Cooper <alcooperx@gmail.com>

Add a new USB Phy driver for Broadcom STB SoCs. This driver
supports Broadcom STB ARM and MIPS SoCs. This driver in
combination with the Broadcom STB ohci, ehci and xhci
drivers will enable USB1.1, USB2.0 and USB3.0 support.
This Phy driver also supports the Broadcom UDC gadget
driver.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 MAINTAINERS                              |    7 +
 drivers/phy/broadcom/Kconfig             |   12 +
 drivers/phy/broadcom/Makefile            |    3 +
 drivers/phy/broadcom/phy-brcm-usb-init.c | 1125 ++++++++++++++++++++++++++++++
 drivers/phy/broadcom/phy-brcm-usb-init.h |   95 +++
 drivers/phy/broadcom/phy-brcm-usb.c      |  359 ++++++++++
 6 files changed, 1601 insertions(+)
 create mode 100644 drivers/phy/broadcom/phy-brcm-usb-init.c
 create mode 100644 drivers/phy/broadcom/phy-brcm-usb-init.h
 create mode 100644 drivers/phy/broadcom/phy-brcm-usb.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d711d53..63b6f41 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2774,6 +2774,13 @@ L:	linux-pm at vger.kernel.org
 S:	Maintained
 F:	drivers/cpufreq/bmips-cpufreq.c
 
+BROADCOM BRCMSTB USB2 and USB3 PHY DRIVER
+M:	Al Cooper <alcooperx@gmail.com>
+L:	linux-kernel at vger.kernel.org
+L:	bcm-kernel-feedback-list at broadcom.com
+S:	Maintained
+F:	drivers/phy/broadcom/phy-brcm-usb*
+
 BROADCOM TG3 GIGABIT ETHERNET DRIVER
 M:	Siva Reddy Kallam <siva.kallam@broadcom.com>
 M:	Prashant Sreedharan <prashant@broadcom.com>
diff --git a/drivers/phy/broadcom/Kconfig b/drivers/phy/broadcom/Kconfig
index c4b632e..136338a 100644
--- a/drivers/phy/broadcom/Kconfig
+++ b/drivers/phy/broadcom/Kconfig
@@ -66,3 +66,15 @@ config PHY_BRCM_SATA
 	help
 	  Enable this to support the Broadcom SATA PHY.
 	  If unsure, say N.
+
+config PHY_BRCM_USB
+	tristate "Broadcom STB USB PHY driver"
+	depends on ARCH_BRCMSTB || BMIPS_GENERIC || COMPILE_TEST
+	depends on OF
+	select GENERIC_PHY
+	default ARCH_BRCMSTB || BMIPS_GENERIC
+	help
+	  Enable this to support the Broadcom STB USB PHY.
+	  This driver is required by the USB XHCI, EHCI and OHCI
+	  drivers.
+	  If unsure, say N.
diff --git a/drivers/phy/broadcom/Makefile b/drivers/phy/broadcom/Makefile
index 4eb82ec..7c37ba6 100644
--- a/drivers/phy/broadcom/Makefile
+++ b/drivers/phy/broadcom/Makefile
@@ -5,3 +5,6 @@ obj-$(CONFIG_PHY_BCM_NS_USB3)		+= phy-bcm-ns-usb3.o
 obj-$(CONFIG_PHY_NS2_PCIE)		+= phy-bcm-ns2-pcie.o
 obj-$(CONFIG_PHY_NS2_USB_DRD)		+= phy-bcm-ns2-usbdrd.o
 obj-$(CONFIG_PHY_BRCM_SATA)		+= phy-brcm-sata.o
+obj-$(CONFIG_PHY_BRCM_USB)		+= phy-brcm-usb-dvr.o
+
+phy-brcm-usb-dvr-objs := phy-brcm-usb.o phy-brcm-usb-init.o
diff --git a/drivers/phy/broadcom/phy-brcm-usb-init.c b/drivers/phy/broadcom/phy-brcm-usb-init.c
new file mode 100644
index 0000000..5d83355
--- /dev/null
+++ b/drivers/phy/broadcom/phy-brcm-usb-init.c
@@ -0,0 +1,1125 @@
+/*
+ * phy-brcm-usb-init.c - Broadcom USB Phy chip specific init functions
+ *
+ * Copyright (C) 2014-2017 Broadcom
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+/*
+ * This module contains USB PHY initialization for power up and S3 resume
+ */
+
+#include <linux/delay.h>
+#include <linux/io.h>
+
+#include <linux/soc/brcmstb/brcmstb.h>
+#include "phy-brcm-usb-init.h"
+
+#define PHY_PORTS 2
+#define PHY_PORT_SELECT_0 0
+#define PHY_PORT_SELECT_1 0x1000
+
+/* Register definitions for the USB CTRL block */
+#define USB_CTRL_SETUP			0x00
+#define   USB_CTRL_SETUP_IOC_MASK			0x00000010
+#define   USB_CTRL_SETUP_IPP_MASK			0x00000020
+#define   USB_CTRL_SETUP_BABO_MASK			0x00000001
+#define   USB_CTRL_SETUP_FNHW_MASK			0x00000002
+#define   USB_CTRL_SETUP_FNBO_MASK			0x00000004
+#define   USB_CTRL_SETUP_WABO_MASK			0x00000008
+#define   USB_CTRL_SETUP_SCB_CLIENT_SWAP_MASK		0x00002000 /* option */
+#define   USB_CTRL_SETUP_SCB1_EN_MASK			0x00004000 /* option */
+#define   USB_CTRL_SETUP_SCB2_EN_MASK			0x00008000 /* option */
+#define   USB_CTRL_SETUP_SS_EHCI64BIT_EN_MASK		0X00020000 /* option */
+#define   USB_CTRL_SETUP_SS_EHCI64BIT_EN_VAR_MASK	0x00010000 /* option */
+#define   USB_CTRL_SETUP_STRAP_IPP_SEL_MASK		0x02000000 /* option */
+#define   USB_CTRL_SETUP_CC_DRD_MODE_ENABLE_MASK	0x04000000 /* option */
+#define   USB_CTRL_SETUP_STRAP_CC_DRD_MODE_ENABLE_SEL_MASK 0x08000000 /* opt */
+#define   USB_CTRL_SETUP_OC3_DISABLE_MASK		0xc0000000 /* option */
+#define USB_CTRL_PLL_CTL		0x04
+#define   USB_CTRL_PLL_CTL_PLL_SUSPEND_EN_MASK		0x08000000
+#define   USB_CTRL_PLL_CTL_PLL_RESETB_MASK		0x40000000
+#define   USB_CTRL_PLL_CTL_PLL_IDDQ_PWRDN_MASK		0x80000000 /* option */
+#define USB_CTRL_EBRIDGE		0x0c
+#define   USB_CTRL_EBRIDGE_ESTOP_SCB_REQ_MASK		0x00020000 /* option */
+#define USB_CTRL_MDIO			0x14
+#define USB_CTRL_MDIO2			0x18
+#define USB_CTRL_UTMI_CTL_1		0x2c
+#define   USB_CTRL_UTMI_CTL_1_POWER_UP_FSM_EN_MASK	0x00000800
+#define   USB_CTRL_UTMI_CTL_1_POWER_UP_FSM_EN_P1_MASK	0x08000000
+#define USB_CTRL_USB_PM			0x34
+#define   USB_CTRL_USB_PM_BDC_SOFT_RESETB_MASK		0x00800000 /* option */
+#define   USB_CTRL_USB_PM_XHC_SOFT_RESETB_MASK		0x00400000 /* option */
+#define   USB_CTRL_USB_PM_XHC_SOFT_RESETB_VAR_MASK	0x40000000 /* option */
+#define   USB_CTRL_USB_PM_USB_PWRDN_MASK		0x80000000 /* option */
+#define   USB_CTRL_USB_PM_SOFT_RESET_MASK		0x40000000 /* option */
+#define   USB_CTRL_USB_PM_USB20_HC_RESETB_MASK		0x30000000 /* option */
+#define   USB_CTRL_USB_PM_USB20_HC_RESETB_VAR_MASK	0x00300000 /* option */
+#define USB_CTRL_USB30_CTL1		0x60
+#define   USB_CTRL_USB30_CTL1_PHY3_PLL_SEQ_START_MASK	0x00000010
+#define   USB_CTRL_USB30_CTL1_PHY3_RESETB_MASK		0x00010000
+#define   USB_CTRL_USB30_CTL1_XHC_SOFT_RESETB_MASK	0x00020000 /* option */
+#define   USB_CTRL_USB30_CTL1_USB3_IOC_MASK		0x10000000 /* option */
+#define   USB_CTRL_USB30_CTL1_USB3_IPP_MASK		0x20000000 /* option */
+#define USB_CTRL_USB30_PCTL		0x70
+#define   USB_CTRL_USB30_PCTL_PHY3_SOFT_RESETB_MASK	0x00000002
+#define   USB_CTRL_USB30_PCTL_PHY3_SOFT_RESETB_P1_MASK	0x00020000
+#define USB_CTRL_USB_DEVICE_CTL1	0x90
+#define   USB_CTRL_USB_DEVICE_CTL1_PORT_MODE_MASK	0x00000003 /* option */
+
+/* Register definitions for the XHCI EC block */
+#define USB_XHCI_EC_IRAADR 0x658
+#define USB_XHCI_EC_IRADAT 0x65c
+
+enum brcm_family_type {
+	BRCM_FAMILY_3390A0,
+	BRCM_FAMILY_7250B0,
+	BRCM_FAMILY_7271A0,
+	BRCM_FAMILY_7364A0,
+	BRCM_FAMILY_7366C0,
+	BRCM_FAMILY_74371A0,
+	BRCM_FAMILY_7439B0,
+	BRCM_FAMILY_7445D0,
+	BRCM_FAMILY_7260A0,
+	BRCM_FAMILY_7278A0,
+	BRCM_FAMILY_7425B0,
+	BRCM_FAMILY_MIPS_GENERIC,
+	BRCM_FAMILY_COUNT,
+};
+
+#define USB_BRCM_FAMILY(chip) \
+	[BRCM_FAMILY_##chip] = __stringify(chip)
+
+static const char *family_names[BRCM_FAMILY_COUNT] = {
+	USB_BRCM_FAMILY(3390A0),
+	USB_BRCM_FAMILY(7250B0),
+	USB_BRCM_FAMILY(7271A0),
+	USB_BRCM_FAMILY(7364A0),
+	USB_BRCM_FAMILY(7366C0),
+	USB_BRCM_FAMILY(74371A0),
+	USB_BRCM_FAMILY(7439B0),
+	USB_BRCM_FAMILY(7445D0),
+	USB_BRCM_FAMILY(7260A0),
+	USB_BRCM_FAMILY(7278A0),
+	USB_BRCM_FAMILY(7425B0),
+	USB_BRCM_FAMILY(MIPS_GENERIC),
+};
+
+enum {
+	USB_CTRL_SETUP_SCB1_EN_SELECTOR,
+	USB_CTRL_SETUP_SCB2_EN_SELECTOR,
+	USB_CTRL_SETUP_SS_EHCI64BIT_EN_SELECTOR,
+	USB_CTRL_SETUP_STRAP_IPP_SEL_SELECTOR,
+	USB_CTRL_SETUP_OC3_DISABLE_SELECTOR,
+	USB_CTRL_PLL_CTL_PLL_IDDQ_PWRDN_SELECTOR,
+	USB_CTRL_EBRIDGE_ESTOP_SCB_REQ_SELECTOR,
+	USB_CTRL_USB_PM_BDC_SOFT_RESETB_SELECTOR,
+	USB_CTRL_USB_PM_XHC_SOFT_RESETB_SELECTOR,
+	USB_CTRL_USB_PM_USB_PWRDN_SELECTOR,
+	USB_CTRL_USB30_CTL1_XHC_SOFT_RESETB_SELECTOR,
+	USB_CTRL_USB30_CTL1_USB3_IOC_SELECTOR,
+	USB_CTRL_USB30_CTL1_USB3_IPP_SELECTOR,
+	USB_CTRL_USB_DEVICE_CTL1_PORT_MODE_SELECTOR,
+	USB_CTRL_USB_PM_SOFT_RESET_SELECTOR,
+	USB_CTRL_SETUP_CC_DRD_MODE_ENABLE_SELECTOR,
+	USB_CTRL_SETUP_STRAP_CC_DRD_MODE_ENABLE_SEL_SELECTOR,
+	USB_CTRL_USB_PM_USB20_HC_RESETB_SELECTOR,
+	USB_CTRL_SETUP_ENDIAN_SELECTOR,
+	USB_CTRL_SELECTOR_COUNT,
+};
+
+#define USB_CTRL_REG(base, reg)	((void *)base + USB_CTRL_##reg)
+#define USB_XHCI_EC_REG(base, reg) ((void *)base + USB_XHCI_EC_##reg)
+#define USB_CTRL_MASK(reg, field) \
+	USB_CTRL_##reg##_##field##_MASK
+#define USB_CTRL_MASK_FAMILY(params, reg, field)			\
+	(params->usb_reg_bits_map[USB_CTRL_##reg##_##field##_SELECTOR])
+
+#define USB_CTRL_SET_FAMILY(params, reg, field)	\
+	usb_ctrl_set_family(params, USB_CTRL_##reg,	\
+			USB_CTRL_##reg##_##field##_SELECTOR)
+#define USB_CTRL_UNSET_FAMILY(params, reg, field)	\
+	usb_ctrl_unset_family(params, USB_CTRL_##reg,	\
+		USB_CTRL_##reg##_##field##_SELECTOR)
+
+#define USB_CTRL_SET(base, reg, field)	\
+	brcmusb_writel(brcmusb_readl(USB_CTRL_REG(base, reg)) |		\
+		USB_CTRL_##reg##_##field##_MASK, USB_CTRL_REG(base, reg))
+#define USB_CTRL_UNSET(base, reg, field)	\
+	brcmusb_writel(brcmusb_readl(USB_CTRL_REG(base, reg)) &		\
+		~USB_CTRL_##reg##_##field##_MASK, USB_CTRL_REG(base, reg))
+
+
+#define MDIO_USB2	0
+#define MDIO_USB3	(1 << 31)
+
+#define USB_CTRL_SETUP_ENDIAN_BITS (	\
+		USB_CTRL_MASK(SETUP, BABO) |	\
+		USB_CTRL_MASK(SETUP, FNHW) |	\
+		USB_CTRL_MASK(SETUP, FNBO) |	\
+		USB_CTRL_MASK(SETUP, WABO))
+
+#ifdef __LITTLE_ENDIAN
+#define ENDIAN_SETTINGS (			\
+		USB_CTRL_MASK(SETUP, BABO) |	\
+		USB_CTRL_MASK(SETUP, FNHW))
+#else
+#define ENDIAN_SETTINGS (			\
+		USB_CTRL_MASK(SETUP, FNHW) |	\
+		USB_CTRL_MASK(SETUP, FNBO) |	\
+		USB_CTRL_MASK(SETUP, WABO))
+#endif
+
+struct id_to_type {
+	u32 id;
+	int type;
+};
+
+static const struct id_to_type id_to_type_table_arm[] = {
+	{ 0x33900000, BRCM_FAMILY_3390A0 },
+	{ 0x72500010, BRCM_FAMILY_7250B0 },
+	{ 0x72600000, BRCM_FAMILY_7260A0 },
+	{ 0x72680000, BRCM_FAMILY_7271A0 },
+	{ 0x72710000, BRCM_FAMILY_7271A0 },
+	{ 0x73640000, BRCM_FAMILY_7364A0 },
+	{ 0x73660020, BRCM_FAMILY_7366C0 },
+	{ 0x07437100, BRCM_FAMILY_74371A0 },
+	{ 0x74390010, BRCM_FAMILY_7439B0 },
+	{ 0x74450030, BRCM_FAMILY_7445D0 },
+	{ 0x72780000, BRCM_FAMILY_7278A0 },
+	{ 0, BRCM_FAMILY_7271A0 }, /* default */
+};
+
+static const struct id_to_type id_to_type_table_mips[] = {
+	{ 0x74250010, BRCM_FAMILY_7425B0 },
+	{ 0x74350010, BRCM_FAMILY_7425B0 },
+	{ 0, BRCM_FAMILY_MIPS_GENERIC },
+};
+
+static const u32
+usb_reg_bits_map_table[BRCM_FAMILY_COUNT][USB_CTRL_SELECTOR_COUNT] = {
+	/* 3390B0 */
+	[BRCM_FAMILY_3390A0] = {
+		USB_CTRL_SETUP_SCB1_EN_MASK,
+		USB_CTRL_SETUP_SCB2_EN_MASK,
+		USB_CTRL_SETUP_SS_EHCI64BIT_EN_MASK,
+		USB_CTRL_SETUP_STRAP_IPP_SEL_MASK,
+		USB_CTRL_SETUP_OC3_DISABLE_MASK,
+		0, /* USB_CTRL_PLL_CTL_PLL_IDDQ_PWRDN_MASK */
+		USB_CTRL_EBRIDGE_ESTOP_SCB_REQ_MASK,
+		0, /* USB_CTRL_USB_PM_BDC_SOFT_RESETB_MASK */
+		USB_CTRL_USB_PM_XHC_SOFT_RESETB_MASK,
+		USB_CTRL_USB_PM_USB_PWRDN_MASK,
+		0, /* USB_CTRL_USB30_CTL1_XHC_SOFT_RESETB_MASK */
+		0, /* USB_CTRL_USB30_CTL1_USB3_IOC_MASK */
+		0, /* USB_CTRL_USB30_CTL1_USB3_IPP_MASK */
+		USB_CTRL_USB_DEVICE_CTL1_PORT_MODE_MASK,
+		0, /* USB_CTRL_USB_PM_SOFT_RESET_MASK */
+		0, /* USB_CTRL_SETUP_CC_DRD_MODE_ENABLE_MASK */
+		0, /* USB_CTRL_SETUP_STRAP_CC_DRD_MODE_ENABLE_SEL_MASK */
+		USB_CTRL_USB_PM_USB20_HC_RESETB_VAR_MASK,
+		ENDIAN_SETTINGS, /* USB_CTRL_SETUP ENDIAN bits */
+	},
+	/* 7250b0 */
+	[BRCM_FAMILY_7250B0] = {
+		USB_CTRL_SETUP_SCB1_EN_MASK,
+		USB_CTRL_SETUP_SCB2_EN_MASK,
+		USB_CTRL_SETUP_SS_EHCI64BIT_EN_MASK,
+		0, /* USB_CTRL_SETUP_STRAP_IPP_SEL_MASK */
+		USB_CTRL_SETUP_OC3_DISABLE_MASK,
+		USB_CTRL_PLL_CTL_PLL_IDDQ_PWRDN_MASK,
+		USB_CTRL_EBRIDGE_ESTOP_SCB_REQ_MASK,
+		0, /* USB_CTRL_USB_PM_BDC_SOFT_RESETB_MASK */
+		USB_CTRL_USB_PM_XHC_SOFT_RESETB_VAR_MASK,
+		0, /* USB_CTRL_USB_PM_USB_PWRDN_MASK */
+		0, /* USB_CTRL_USB30_CTL1_XHC_SOFT_RESETB_MASK */
+		0, /* USB_CTRL_USB30_CTL1_USB3_IOC_MASK */
+		0, /* USB_CTRL_USB30_CTL1_USB3_IPP_MASK */
+		0, /* USB_CTRL_USB_DEVICE_CTL1_PORT_MODE_MASK */
+		0, /* USB_CTRL_USB_PM_SOFT_RESET_MASK */
+		0, /* USB_CTRL_SETUP_CC_DRD_MODE_ENABLE_MASK */
+		0, /* USB_CTRL_SETUP_STRAP_CC_DRD_MODE_ENABLE_SEL_MASK */
+		USB_CTRL_USB_PM_USB20_HC_RESETB_MASK,
+		ENDIAN_SETTINGS, /* USB_CTRL_SETUP ENDIAN bits */
+	},
+	/* 7271a0 */
+	[BRCM_FAMILY_7271A0] = {
+		0, /* USB_CTRL_SETUP_SCB1_EN_MASK */
+		0, /* USB_CTRL_SETUP_SCB2_EN_MASK */
+		USB_CTRL_SETUP_SS_EHCI64BIT_EN_MASK,
+		USB_CTRL_SETUP_STRAP_IPP_SEL_MASK,
+		USB_CTRL_SETUP_OC3_DISABLE_MASK,
+		0, /* USB_CTRL_PLL_CTL_PLL_IDDQ_PWRDN_MASK */
+		USB_CTRL_EBRIDGE_ESTOP_SCB_REQ_MASK,
+		USB_CTRL_USB_PM_BDC_SOFT_RESETB_MASK,
+		USB_CTRL_USB_PM_XHC_SOFT_RESETB_MASK,
+		USB_CTRL_USB_PM_USB_PWRDN_MASK,
+		0, /* USB_CTRL_USB30_CTL1_XHC_SOFT_RESETB_MASK */
+		0, /* USB_CTRL_USB30_CTL1_USB3_IOC_MASK */
+		0, /* USB_CTRL_USB30_CTL1_USB3_IPP_MASK */
+		USB_CTRL_USB_DEVICE_CTL1_PORT_MODE_MASK,
+		USB_CTRL_USB_PM_SOFT_RESET_MASK,
+		USB_CTRL_SETUP_CC_DRD_MODE_ENABLE_MASK,
+		USB_CTRL_SETUP_STRAP_CC_DRD_MODE_ENABLE_SEL_MASK,
+		USB_CTRL_USB_PM_USB20_HC_RESETB_VAR_MASK,
+		ENDIAN_SETTINGS, /* USB_CTRL_SETUP ENDIAN bits */
+	},
+	/* 7364a0 */
+	[BRCM_FAMILY_7364A0] = {
+		USB_CTRL_SETUP_SCB1_EN_MASK,
+		USB_CTRL_SETUP_SCB2_EN_MASK,
+		USB_CTRL_SETUP_SS_EHCI64BIT_EN_MASK,
+		0, /* USB_CTRL_SETUP_STRAP_IPP_SEL_MASK */
+		USB_CTRL_SETUP_OC3_DISABLE_MASK,
+		USB_CTRL_PLL_CTL_PLL_IDDQ_PWRDN_MASK,
+		USB_CTRL_EBRIDGE_ESTOP_SCB_REQ_MASK,
+		0, /* USB_CTRL_USB_PM_BDC_SOFT_RESETB_MASK */
+		USB_CTRL_USB_PM_XHC_SOFT_RESETB_VAR_MASK,
+		0, /* USB_CTRL_USB_PM_USB_PWRDN_MASK */
+		0, /* USB_CTRL_USB30_CTL1_XHC_SOFT_RESETB_MASK */
+		0, /* USB_CTRL_USB30_CTL1_USB3_IOC_MASK */
+		0, /* USB_CTRL_USB30_CTL1_USB3_IPP_MASK */
+		0, /* USB_CTRL_USB_DEVICE_CTL1_PORT_MODE_MASK */
+		0, /* USB_CTRL_USB_PM_SOFT_RESET_MASK */
+		0, /* USB_CTRL_SETUP_CC_DRD_MODE_ENABLE_MASK */
+		0, /* USB_CTRL_SETUP_STRAP_CC_DRD_MODE_ENABLE_SEL_MASK */
+		USB_CTRL_USB_PM_USB20_HC_RESETB_MASK,
+		ENDIAN_SETTINGS, /* USB_CTRL_SETUP ENDIAN bits */
+	},
+	/* 7366c0 */
+	[BRCM_FAMILY_7366C0] = {
+		USB_CTRL_SETUP_SCB1_EN_MASK,
+		USB_CTRL_SETUP_SCB2_EN_MASK,
+		USB_CTRL_SETUP_SS_EHCI64BIT_EN_MASK,
+		0, /* USB_CTRL_SETUP_STRAP_IPP_SEL_MASK */
+		USB_CTRL_SETUP_OC3_DISABLE_MASK,
+		0, /* USB_CTRL_PLL_CTL_PLL_IDDQ_PWRDN_MASK */
+		USB_CTRL_EBRIDGE_ESTOP_SCB_REQ_MASK,
+		0, /* USB_CTRL_USB_PM_BDC_SOFT_RESETB_MASK */
+		USB_CTRL_USB_PM_XHC_SOFT_RESETB_VAR_MASK,
+		USB_CTRL_USB_PM_USB_PWRDN_MASK,
+		0, /* USB_CTRL_USB30_CTL1_XHC_SOFT_RESETB_MASK */
+		0, /* USB_CTRL_USB30_CTL1_USB3_IOC_MASK */
+		0, /* USB_CTRL_USB30_CTL1_USB3_IPP_MASK */
+		0, /* USB_CTRL_USB_DEVICE_CTL1_PORT_MODE_MASK */
+		0, /* USB_CTRL_USB_PM_SOFT_RESET_MASK */
+		0, /* USB_CTRL_SETUP_CC_DRD_MODE_ENABLE_MASK */
+		0, /* USB_CTRL_SETUP_STRAP_CC_DRD_MODE_ENABLE_SEL_MASK */
+		USB_CTRL_USB_PM_USB20_HC_RESETB_MASK,
+		ENDIAN_SETTINGS, /* USB_CTRL_SETUP ENDIAN bits */
+	},
+	/* 74371A0 */
+	[BRCM_FAMILY_74371A0] = {
+		USB_CTRL_SETUP_SCB1_EN_MASK,
+		USB_CTRL_SETUP_SCB2_EN_MASK,
+		USB_CTRL_SETUP_SS_EHCI64BIT_EN_VAR_MASK,
+		0, /* USB_CTRL_SETUP_STRAP_IPP_SEL_MASK */
+		0, /* USB_CTRL_SETUP_OC3_DISABLE_MASK */
+		USB_CTRL_PLL_CTL_PLL_IDDQ_PWRDN_MASK,
+		0, /* USB_CTRL_EBRIDGE_ESTOP_SCB_REQ_MASK */
+		0, /* USB_CTRL_USB_PM_BDC_SOFT_RESETB_MASK */
+		0, /* USB_CTRL_USB_PM_XHC_SOFT_RESETB_MASK */
+		0, /* USB_CTRL_USB_PM_USB_PWRDN_MASK */
+		USB_CTRL_USB30_CTL1_XHC_SOFT_RESETB_MASK,
+		USB_CTRL_USB30_CTL1_USB3_IOC_MASK,
+		USB_CTRL_USB30_CTL1_USB3_IPP_MASK,
+		0, /* USB_CTRL_USB_DEVICE_CTL1_PORT_MODE_MASK */
+		0, /* USB_CTRL_USB_PM_SOFT_RESET_MASK */
+		0, /* USB_CTRL_SETUP_CC_DRD_MODE_ENABLE_MASK */
+		0, /* USB_CTRL_SETUP_STRAP_CC_DRD_MODE_ENABLE_SEL_MASK */
+		0, /* USB_CTRL_USB_PM_USB20_HC_RESETB_MASK */
+		ENDIAN_SETTINGS, /* USB_CTRL_SETUP ENDIAN bits */
+	},
+	/* 7439B0 */
+	[BRCM_FAMILY_7439B0] = {
+		USB_CTRL_SETUP_SCB1_EN_MASK,
+		USB_CTRL_SETUP_SCB2_EN_MASK,
+		USB_CTRL_SETUP_SS_EHCI64BIT_EN_MASK,
+		USB_CTRL_SETUP_STRAP_IPP_SEL_MASK,
+		USB_CTRL_SETUP_OC3_DISABLE_MASK,
+		0, /* USB_CTRL_PLL_CTL_PLL_IDDQ_PWRDN_MASK */
+		0, /* USB_CTRL_EBRIDGE_ESTOP_SCB_REQ_MASK */
+		USB_CTRL_USB_PM_BDC_SOFT_RESETB_MASK,
+		USB_CTRL_USB_PM_XHC_SOFT_RESETB_MASK,
+		USB_CTRL_USB_PM_USB_PWRDN_MASK,
+		0, /* USB_CTRL_USB30_CTL1_XHC_SOFT_RESETB_MASK */
+		0, /* USB_CTRL_USB30_CTL1_USB3_IOC_MASK */
+		0, /* USB_CTRL_USB30_CTL1_USB3_IPP_MASK */
+		USB_CTRL_USB_DEVICE_CTL1_PORT_MODE_MASK,
+		0, /* USB_CTRL_USB_PM_SOFT_RESET_MASK */
+		0, /* USB_CTRL_SETUP_CC_DRD_MODE_ENABLE_MASK */
+		0, /* USB_CTRL_SETUP_STRAP_CC_DRD_MODE_ENABLE_SEL_MASK */
+		USB_CTRL_USB_PM_USB20_HC_RESETB_VAR_MASK,
+		ENDIAN_SETTINGS, /* USB_CTRL_SETUP ENDIAN bits */
+	},
+	/* 7445d0 */
+	[BRCM_FAMILY_7445D0] = {
+		USB_CTRL_SETUP_SCB1_EN_MASK,
+		USB_CTRL_SETUP_SCB2_EN_MASK,
+		USB_CTRL_SETUP_SS_EHCI64BIT_EN_VAR_MASK,
+		0, /* USB_CTRL_SETUP_STRAP_IPP_SEL_MASK */
+		USB_CTRL_SETUP_OC3_DISABLE_MASK,
+		USB_CTRL_PLL_CTL_PLL_IDDQ_PWRDN_MASK,
+		0, /* USB_CTRL_EBRIDGE_ESTOP_SCB_REQ_MASK */
+		0, /* USB_CTRL_USB_PM_BDC_SOFT_RESETB_MASK */
+		0, /* USB_CTRL_USB_PM_XHC_SOFT_RESETB_MASK */
+		0, /* USB_CTRL_USB_PM_USB_PWRDN_MASK */
+		USB_CTRL_USB30_CTL1_XHC_SOFT_RESETB_MASK,
+		0, /* USB_CTRL_USB30_CTL1_USB3_IOC_MASK */
+		0, /* USB_CTRL_USB30_CTL1_USB3_IPP_MASK */
+		0, /* USB_CTRL_USB_DEVICE_CTL1_PORT_MODE_MASK */
+		0, /* USB_CTRL_USB_PM_SOFT_RESET_MASK */
+		0, /* USB_CTRL_SETUP_CC_DRD_MODE_ENABLE_MASK */
+		0, /* USB_CTRL_SETUP_STRAP_CC_DRD_MODE_ENABLE_SEL_MASK */
+		USB_CTRL_USB_PM_USB20_HC_RESETB_VAR_MASK,
+		ENDIAN_SETTINGS, /* USB_CTRL_SETUP ENDIAN bits */
+	},
+	/* 7260a0 */
+	[BRCM_FAMILY_7260A0] = {
+		0, /* USB_CTRL_SETUP_SCB1_EN_MASK */
+		0, /* USB_CTRL_SETUP_SCB2_EN_MASK */
+		USB_CTRL_SETUP_SS_EHCI64BIT_EN_MASK,
+		USB_CTRL_SETUP_STRAP_IPP_SEL_MASK,
+		USB_CTRL_SETUP_OC3_DISABLE_MASK,
+		0, /* USB_CTRL_PLL_CTL_PLL_IDDQ_PWRDN_MASK */
+		USB_CTRL_EBRIDGE_ESTOP_SCB_REQ_MASK,
+		USB_CTRL_USB_PM_BDC_SOFT_RESETB_MASK,
+		USB_CTRL_USB_PM_XHC_SOFT_RESETB_MASK,
+		USB_CTRL_USB_PM_USB_PWRDN_MASK,
+		0, /* USB_CTRL_USB30_CTL1_XHC_SOFT_RESETB_MASK */
+		0, /* USB_CTRL_USB30_CTL1_USB3_IOC_MASK */
+		0, /* USB_CTRL_USB30_CTL1_USB3_IPP_MASK */
+		USB_CTRL_USB_DEVICE_CTL1_PORT_MODE_MASK,
+		USB_CTRL_USB_PM_SOFT_RESET_MASK,
+		USB_CTRL_SETUP_CC_DRD_MODE_ENABLE_MASK,
+		USB_CTRL_SETUP_STRAP_CC_DRD_MODE_ENABLE_SEL_MASK,
+		USB_CTRL_USB_PM_USB20_HC_RESETB_VAR_MASK,
+		ENDIAN_SETTINGS, /* USB_CTRL_SETUP ENDIAN bits */
+	},
+	/* 7278a0 */
+	[BRCM_FAMILY_7278A0] = {
+		0, /* USB_CTRL_SETUP_SCB1_EN_MASK */
+		0, /* USB_CTRL_SETUP_SCB2_EN_MASK */
+		0, /*USB_CTRL_SETUP_SS_EHCI64BIT_EN_MASK */
+		USB_CTRL_SETUP_STRAP_IPP_SEL_MASK,
+		USB_CTRL_SETUP_OC3_DISABLE_MASK,
+		0, /* USB_CTRL_PLL_CTL_PLL_IDDQ_PWRDN_MASK */
+		USB_CTRL_EBRIDGE_ESTOP_SCB_REQ_MASK,
+		USB_CTRL_USB_PM_BDC_SOFT_RESETB_MASK,
+		USB_CTRL_USB_PM_XHC_SOFT_RESETB_MASK,
+		USB_CTRL_USB_PM_USB_PWRDN_MASK,
+		0, /* USB_CTRL_USB30_CTL1_XHC_SOFT_RESETB_MASK */
+		0, /* USB_CTRL_USB30_CTL1_USB3_IOC_MASK */
+		0, /* USB_CTRL_USB30_CTL1_USB3_IPP_MASK */
+		USB_CTRL_USB_DEVICE_CTL1_PORT_MODE_MASK,
+		USB_CTRL_USB_PM_SOFT_RESET_MASK,
+		0, /* USB_CTRL_SETUP_CC_DRD_MODE_ENABLE_MASK */
+		0, /* USB_CTRL_SETUP_STRAP_CC_DRD_MODE_ENABLE_SEL_MASK */
+		0, /* USB_CTRL_USB_PM_USB20_HC_RESETB_MASK */
+		0, /* USB_CTRL_SETUP ENDIAN bits */
+	},
+	/* 7425b0 */
+	[BRCM_FAMILY_7425B0] = {
+		0, /* USB_CTRL_SETUP_SCB1_EN_MASK */
+		0, /* USB_CTRL_SETUP_SCB2_EN_MASK */
+		0, /* USB_CTRL_SETUP_SS_EHCI64BIT_EN_MASK */
+		0, /* USB_CTRL_SETUP_STRAP_IPP_SEL_MASK */
+		0, /* USB_CTRL_SETUP_OC3_DISABLE_MASK */
+		0, /* USB_CTRL_PLL_CTL_PLL_IDDQ_PWRDN_MASK */
+		0, /* USB_CTRL_EBRIDGE_ESTOP_SCB_REQ_MASK */
+		0, /* USB_CTRL_USB_PM_BDC_SOFT_RESETB_MASK */
+		0, /* USB_CTRL_USB_PM_XHC_SOFT_RESETB_MASK */
+		0, /* USB_CTRL_USB_PM_USB_PWRDN_MASK */
+		0, /* USB_CTRL_USB30_CTL1_XHC_SOFT_RESETB_MASK */
+		0, /* USB_CTRL_USB30_CTL1_USB3_IOC_MASK */
+		0, /* USB_CTRL_USB30_CTL1_USB3_IPP_MASK */
+		0, /* USB_CTRL_USB_DEVICE_CTL1_PORT_MODE_MASK */
+		0, /* USB_CTRL_USB_PM_SOFT_RESET_MASK */
+		0, /* USB_CTRL_SETUP_CC_DRD_MODE_ENABLE_MASK */
+		0, /* USB_CTRL_SETUP_STRAP_CC_DRD_MODE_ENABLE_SEL_MASK */
+		0, /* USB_CTRL_USB_PM_USB20_HC_RESETB_MASK */
+		ENDIAN_SETTINGS, /* USB_CTRL_SETUP ENDIAN bits */
+	},
+	[BRCM_FAMILY_MIPS_GENERIC] = {
+		0, /* USB_CTRL_SETUP_SCB1_EN_MASK */
+		0, /* USB_CTRL_SETUP_SCB2_EN_MASK */
+		0, /* USB_CTRL_SETUP_SS_EHCI64BIT_EN_MASK */
+		0, /* USB_CTRL_SETUP_STRAP_IPP_SEL_MASK */
+		0, /* USB_CTRL_SETUP_OC3_DISABLE_MASK */
+		0, /* USB_CTRL_PLL_CTL_PLL_IDDQ_PWRDN_MASK */
+		0, /* USB_CTRL_EBRIDGE_ESTOP_SCB_REQ_MASK */
+		0, /* USB_CTRL_USB_PM_BDC_SOFT_RESETB_MASK */
+		0, /* USB_CTRL_USB_PM_XHC_SOFT_RESETB_MASK */
+		0, /* USB_CTRL_USB_PM_USB_PWRDN_MASK */
+		0, /* USB_CTRL_USB30_CTL1_XHC_SOFT_RESETB_MASK */
+		0, /* USB_CTRL_USB30_CTL1_USB3_IOC_MASK */
+		0, /* USB_CTRL_USB30_CTL1_USB3_IPP_MASK */
+		0, /* USB_CTRL_USB_DEVICE_CTL1_PORT_MODE_MASK */
+		0, /* USB_CTRL_USB_PM_SOFT_RESET_MASK */
+		0, /* USB_CTRL_SETUP_CC_DRD_MODE_ENABLE_MASK */
+		0, /* USB_CTRL_SETUP_STRAP_CC_DRD_MODE_ENABLE_SEL_MASK */
+		0, /* USB_CTRL_USB_PM_USB20_HC_RESETB_MASK */
+		ENDIAN_SETTINGS, /* USB_CTRL_SETUP ENDIAN bits */
+	},
+};
+
+static inline u32 brcmusb_readl(void __iomem *addr)
+{
+	/*
+	 * MIPS endianness is configured by boot strap, which also reverses all
+	 * bus endianness (i.e., big-endian CPU + big endian bus ==> native
+	 * endian I/O).
+	 *
+	 * Other architectures (e.g., ARM) either do not support big endian, or
+	 * else leave I/O in little endian mode.
+	 */
+	if (IS_ENABLED(CONFIG_MIPS) && IS_ENABLED(__BIG_ENDIAN))
+		return __raw_readl(addr);
+	else
+		return readl_relaxed(addr);
+}
+
+static inline void brcmusb_writel(u32 val, void __iomem *addr)
+{
+	/* See brcmnand_readl() comments */
+	if (IS_ENABLED(CONFIG_MIPS) && IS_ENABLED(__BIG_ENDIAN))
+		__raw_writel(val, addr);
+	else
+		writel_relaxed(val, addr);
+}
+
+static inline
+void usb_ctrl_unset_family(struct brcm_usb_init_params *params,
+			u32 reg_offset, u32 field)
+{
+	u32 mask;
+	void *reg;
+
+	mask = params->usb_reg_bits_map[field];
+	reg = params->ctrl_regs + reg_offset;
+	brcmusb_writel(brcmusb_readl(reg) & ~mask, reg);
+};
+
+static inline
+void usb_ctrl_set_family(struct brcm_usb_init_params *params,
+			u32 reg_offset, u32 field)
+{
+	u32 mask;
+	void *reg;
+
+	mask = params->usb_reg_bits_map[field];
+	reg = params->ctrl_regs + reg_offset;
+	brcmusb_writel(brcmusb_readl(reg) | mask, reg);
+};
+
+
+static u32 brcmusb_usb_mdio_read(void __iomem *ctrl_base, u32 reg, int mode)
+{
+	u32 data;
+
+	data = (reg << 16) | mode;
+	brcmusb_writel(data, USB_CTRL_REG(ctrl_base, MDIO));
+	data |= (1 << 24);
+	brcmusb_writel(data, USB_CTRL_REG(ctrl_base, MDIO));
+	data &= ~(1 << 24);
+	/* wait for the 60MHz parallel to serial shifter */
+	udelay(10);
+	brcmusb_writel(data, USB_CTRL_REG(ctrl_base, MDIO));
+	/* wait for the 60MHz parallel to serial shifter */
+	udelay(10);
+
+	return brcmusb_readl(USB_CTRL_REG(ctrl_base, MDIO2)) & 0xffff;
+}
+
+static void brcmusb_usb_mdio_write(void __iomem *ctrl_base, u32 reg,
+				u32 val, int mode)
+{
+	u32 data;
+
+	data = (reg << 16) | val | mode;
+	brcmusb_writel(data, USB_CTRL_REG(ctrl_base, MDIO));
+	data |= (1 << 25);
+	brcmusb_writel(data, USB_CTRL_REG(ctrl_base, MDIO));
+	data &= ~(1 << 25);
+
+	/* wait for the 60MHz parallel to serial shifter */
+	udelay(10);
+	brcmusb_writel(data, USB_CTRL_REG(ctrl_base, MDIO));
+	/* wait for the 60MHz parallel to serial shifter */
+	udelay(10);
+}
+
+
+static void brcmusb_usb_phy_ldo_fix(void __iomem *ctrl_base)
+{
+	/* first disable FSM but also leave it that way */
+	/* to allow normal suspend/resume */
+	USB_CTRL_UNSET(ctrl_base, UTMI_CTL_1, POWER_UP_FSM_EN);
+	USB_CTRL_UNSET(ctrl_base, UTMI_CTL_1, POWER_UP_FSM_EN_P1);
+
+	/* reset USB 2.0 PLL */
+	USB_CTRL_UNSET(ctrl_base, PLL_CTL, PLL_RESETB);
+	/* PLL reset period */
+	udelay(1);
+	USB_CTRL_SET(ctrl_base, PLL_CTL, PLL_RESETB);
+	/* Give PLL enough time to lock */
+	msleep(1);
+}
+
+
+static void brcmusb_usb2_eye_fix(void __iomem *ctrl_base)
+{
+	/* Increase USB 2.0 TX level to meet spec requirement */
+	brcmusb_usb_mdio_write(ctrl_base, 0x1f, 0x80a0, MDIO_USB2);
+	brcmusb_usb_mdio_write(ctrl_base, 0x0a, 0xc6a0, MDIO_USB2);
+}
+
+
+static void brcmusb_usb3_pll_fix(void __iomem *ctrl_base)
+{
+	/* Set correct window for PLL lock detect */
+	brcmusb_usb_mdio_write(ctrl_base, 0x1f, 0x8000, MDIO_USB3);
+	brcmusb_usb_mdio_write(ctrl_base, 0x07, 0x1503, MDIO_USB3);
+}
+
+
+static void brcmusb_usb3_enable_pipe_reset(void __iomem *ctrl_base)
+{
+	u32 val;
+
+	/* Re-enable USB 3.0 pipe reset */
+	brcmusb_usb_mdio_write(ctrl_base, 0x1f, 0x8000, MDIO_USB3);
+	val = brcmusb_usb_mdio_read(ctrl_base, 0x0f, MDIO_USB3) | 0x200;
+	brcmusb_usb_mdio_write(ctrl_base, 0x0f, val, MDIO_USB3);
+}
+
+
+static void brcmusb_usb3_enable_sigdet(void __iomem *ctrl_base)
+{
+	u32 val, ofs;
+	int ii;
+
+	ofs = 0;
+	for (ii = 0; ii < PHY_PORTS; ++ii) {
+		/* Set correct default for sigdet */
+		brcmusb_usb_mdio_write(ctrl_base, 0x1f, (0x8080 + ofs),
+				MDIO_USB3);
+		val = brcmusb_usb_mdio_read(ctrl_base, 0x05, MDIO_USB3);
+		val = (val & ~0x800f) | 0x800d;
+		brcmusb_usb_mdio_write(ctrl_base, 0x05, val, MDIO_USB3);
+		ofs = PHY_PORT_SELECT_1;
+	}
+}
+
+
+static void brcmusb_usb3_enable_skip_align(void __iomem *ctrl_base)
+{
+	u32 val, ofs;
+	int ii;
+
+	ofs = 0;
+	for (ii = 0; ii < PHY_PORTS; ++ii) {
+		/* Set correct default for SKIP align */
+		brcmusb_usb_mdio_write(ctrl_base, 0x1f, (0x8060 + ofs),
+				MDIO_USB3);
+		val = brcmusb_usb_mdio_read(ctrl_base, 0x01, MDIO_USB3) | 0x200;
+		brcmusb_usb_mdio_write(ctrl_base, 0x01, val, MDIO_USB3);
+		ofs = PHY_PORT_SELECT_1;
+	}
+}
+
+
+static void brcmusb_usb3_unfreeze_aeq(void __iomem *ctrl_base)
+{
+	u32 val, ofs;
+	int ii;
+
+	ofs = 0;
+	for (ii = 0; ii < PHY_PORTS; ++ii) {
+		/* Let EQ freeze after TSEQ */
+		brcmusb_usb_mdio_write(ctrl_base, 0x1f, (0x80e0 + ofs),
+				MDIO_USB3);
+		val = brcmusb_usb_mdio_read(ctrl_base, 0x01, MDIO_USB3);
+		val &= ~0x0008;
+		brcmusb_usb_mdio_write(ctrl_base, 0x01, val, MDIO_USB3);
+		ofs = PHY_PORT_SELECT_1;
+	}
+}
+
+
+static void brcmusb_usb3_pll_54Mhz(struct brcm_usb_init_params *params)
+{
+	u32 ofs;
+	int ii;
+	void __iomem *ctrl_base = params->ctrl_regs;
+
+	/*
+	 * On newer B53 based SoC's, the reference clock for the
+	 * 3.0 PLL has been changed from 50MHz to 54MHz so the
+	 * PLL needs to be reprogrammed.
+	 * See SWLINUX-4006.
+	 *
+	 * On the 7364C0, the reference clock for the
+	 * 3.0 PLL has been changed from 50MHz to 54MHz to
+	 * work around a MOCA issue.
+	 * See SWLINUX-4169.
+	 */
+	switch (params->selected_family) {
+	case BRCM_FAMILY_3390A0:
+	case BRCM_FAMILY_7250B0:
+	case BRCM_FAMILY_7366C0:
+	case BRCM_FAMILY_74371A0:
+	case BRCM_FAMILY_7439B0:
+	case BRCM_FAMILY_7445D0:
+	case BRCM_FAMILY_7260A0:
+		return;
+	case BRCM_FAMILY_7364A0:
+		if (BRCM_REV(params->family_id) < 0x20)
+			return;
+		break;
+	}
+
+	/* set USB 3.0 PLL to accept 54Mhz reference clock */
+	USB_CTRL_UNSET(ctrl_base, USB30_CTL1, PHY3_PLL_SEQ_START);
+
+	brcmusb_usb_mdio_write(ctrl_base, 0x1f, 0x8000, MDIO_USB3);
+	brcmusb_usb_mdio_write(ctrl_base, 0x10, 0x5784, MDIO_USB3);
+	brcmusb_usb_mdio_write(ctrl_base, 0x11, 0x01d0, MDIO_USB3);
+	brcmusb_usb_mdio_write(ctrl_base, 0x12, 0x1DE8, MDIO_USB3);
+	brcmusb_usb_mdio_write(ctrl_base, 0x13, 0xAA80, MDIO_USB3);
+	brcmusb_usb_mdio_write(ctrl_base, 0x14, 0x8826, MDIO_USB3);
+	brcmusb_usb_mdio_write(ctrl_base, 0x15, 0x0044, MDIO_USB3);
+	brcmusb_usb_mdio_write(ctrl_base, 0x16, 0x8000, MDIO_USB3);
+	brcmusb_usb_mdio_write(ctrl_base, 0x17, 0x0851, MDIO_USB3);
+	brcmusb_usb_mdio_write(ctrl_base, 0x18, 0x0000, MDIO_USB3);
+
+	/* both ports */
+	ofs = 0;
+	for (ii = 0; ii < PHY_PORTS; ++ii) {
+		brcmusb_usb_mdio_write(ctrl_base, 0x1f, (0x8040 + ofs),
+				MDIO_USB3);
+		brcmusb_usb_mdio_write(ctrl_base, 0x03, 0x0090, MDIO_USB3);
+		brcmusb_usb_mdio_write(ctrl_base, 0x04, 0x0134, MDIO_USB3);
+		brcmusb_usb_mdio_write(ctrl_base, 0x1f, (0x8020 + ofs),
+				MDIO_USB3);
+		brcmusb_usb_mdio_write(ctrl_base, 0x01, 0x00e2, MDIO_USB3);
+		ofs = PHY_PORT_SELECT_1;
+	}
+
+	/* restart PLL sequence */
+	USB_CTRL_SET(ctrl_base, USB30_CTL1, PHY3_PLL_SEQ_START);
+	/* Give PLL enough time to lock */
+	msleep(1);
+}
+
+
+static void brcmusb_usb3_ssc_enable(void __iomem *ctrl_base)
+{
+	u32 val;
+
+	/* Enable USB 3.0 TX spread spectrum */
+	brcmusb_usb_mdio_write(ctrl_base, 0x1f, 0x8040, MDIO_USB3);
+	val = brcmusb_usb_mdio_read(ctrl_base, 0x01, MDIO_USB3) | 0xf;
+	brcmusb_usb_mdio_write(ctrl_base, 0x01, val, MDIO_USB3);
+
+	/* Currently, USB 3.0 SSC is enabled via port 0 MDIO registers,
+	 * which should have been adequate. However, due to a bug in the
+	 * USB 3.0 PHY, it must be enabled via both ports (HWUSB3DVT-26).
+	 */
+	brcmusb_usb_mdio_write(ctrl_base, 0x1f, 0x9040, MDIO_USB3);
+	val = brcmusb_usb_mdio_read(ctrl_base, 0x01, MDIO_USB3) | 0xf;
+	brcmusb_usb_mdio_write(ctrl_base, 0x01, val, MDIO_USB3);
+}
+
+
+static void brcmusb_usb3_phy_workarounds(struct brcm_usb_init_params *params)
+{
+	void __iomem *ctrl_base = params->ctrl_regs;
+
+	brcmusb_usb3_pll_fix(ctrl_base);
+	brcmusb_usb3_pll_54Mhz(params);
+	brcmusb_usb3_ssc_enable(ctrl_base);
+	brcmusb_usb3_enable_pipe_reset(ctrl_base);
+	brcmusb_usb3_enable_sigdet(ctrl_base);
+	brcmusb_usb3_enable_skip_align(ctrl_base);
+	brcmusb_usb3_unfreeze_aeq(ctrl_base);
+}
+
+
+static void brcmusb_memc_fix(struct brcm_usb_init_params *params)
+{
+	u32 prid;
+
+	if (params->selected_family != BRCM_FAMILY_7445D0)
+		return;
+	/*
+	 * This is a workaround for HW7445-1869 where a DMA write ends up
+	 * doing a read pre-fetch after the end of the DMA buffer. This
+	 * causes a problem when the DMA buffer is at the end of physical
+	 * memory, causing the pre-fetch read to access non-existent memory,
+	 * and the chip bondout has MEMC2 disabled. When the pre-fetch read
+	 * tries to use the disabled MEMC2, it hangs the bus. The workaround
+	 * is to disable MEMC2 access in the usb controller which avoids
+	 * the hang.
+	 */
+
+	prid = params->product_id & 0xfffff000;
+	switch (prid) {
+	case 0x72520000:
+	case 0x74480000:
+	case 0x74490000:
+	case 0x07252000:
+	case 0x07448000:
+	case 0x07449000:
+		USB_CTRL_UNSET_FAMILY(params, SETUP, SCB2_EN);
+	}
+}
+
+static void brcmusb_usb3_otp_fix(struct brcm_usb_init_params *params)
+{
+	void __iomem *xhci_ec_base = params->xhci_ec_regs;
+	u32 val;
+
+	if ((params->family_id != 0x74371000) || (xhci_ec_base == 0))
+		return;
+	brcmusb_writel(0xa20c, USB_XHCI_EC_REG(xhci_ec_base, IRAADR));
+	val = brcmusb_readl(USB_XHCI_EC_REG(xhci_ec_base, IRADAT));
+
+	/* set cfg_pick_ss_lock */
+	val |= (1 << 27);
+	brcmusb_writel(val, USB_XHCI_EC_REG(xhci_ec_base, IRADAT));
+
+	/* Reset USB 3.0 PHY for workaround to take effect */
+	USB_CTRL_UNSET(params->ctrl_regs, USB30_CTL1, PHY3_RESETB);
+	USB_CTRL_SET(params->ctrl_regs,	USB30_CTL1, PHY3_RESETB);
+}
+
+
+static void brcmusb_xhci_soft_reset(struct brcm_usb_init_params *params,
+				int on_off)
+{
+	/* Assert reset */
+	if (on_off) {
+		if (USB_CTRL_MASK_FAMILY(params, USB_PM, XHC_SOFT_RESETB))
+			USB_CTRL_UNSET_FAMILY(params, USB_PM, XHC_SOFT_RESETB);
+		else
+			USB_CTRL_UNSET_FAMILY(params,
+					USB30_CTL1, XHC_SOFT_RESETB);
+	}
+	/* De-assert reset */
+	else {
+		if (USB_CTRL_MASK_FAMILY(params, USB_PM, XHC_SOFT_RESETB))
+			USB_CTRL_SET_FAMILY(params, USB_PM, XHC_SOFT_RESETB);
+		else
+			USB_CTRL_SET_FAMILY(params, USB30_CTL1,
+					XHC_SOFT_RESETB);
+	}
+}
+
+/*
+ * Return the best map table family. The order is:
+ *   - exact match of chip and major rev
+ *   - exact match of chip and closest older major rev
+ *   - default chip/rev.
+ * NOTE: The minor rev is always ignored.
+ */
+static enum brcm_family_type brcmusb_get_family_type(
+	struct brcm_usb_init_params *params,
+	struct id_to_type const *table)
+{
+	int last_type = -1;
+	u32 last_family = 0;
+	u32 family_no_major;
+	unsigned int x;
+	u32 family;
+
+	family = params->family_id & 0xfffffff0;
+	family_no_major = params->family_id & 0xffffff00;
+	for (x = 0; table[x].id; x++) {
+		if (family == table[x].id)
+			return table[x].type;
+		if (family_no_major == (table[x].id & 0xffffff00))
+			if ((family > table[x].id) &&
+				(last_family < table[x].id)) {
+				last_family = table[x].id;
+				last_type = table[x].type;
+			}
+	}
+
+	/* If no match, return the default family */
+	if (last_type == -1)
+		return table[x].type;
+	return last_type;
+}
+
+static void brcmusb_usb_init_ipp(struct brcm_usb_init_params *params)
+{
+	void __iomem *ctrl = params->ctrl_regs;
+	u32 reg;
+	u32 orig_reg;
+
+	/* Starting with the 7445d0, there are no longer separate 3.0
+	 * versions of IOC and IPP.
+	 */
+	if (USB_CTRL_MASK_FAMILY(params, USB30_CTL1, USB3_IOC)) {
+		if (params->ioc)
+			USB_CTRL_SET_FAMILY(params, USB30_CTL1, USB3_IOC);
+		if (params->ipp == 1)
+			USB_CTRL_SET_FAMILY(params, USB30_CTL1, USB3_IPP);
+	}
+
+	orig_reg = reg = brcmusb_readl(USB_CTRL_REG(ctrl, SETUP));
+	if (USB_CTRL_MASK_FAMILY(params, SETUP, STRAP_CC_DRD_MODE_ENABLE_SEL))
+		/* Never use the strap, it's going away. */
+		reg &= ~(USB_CTRL_MASK_FAMILY(params,
+						SETUP,
+						STRAP_CC_DRD_MODE_ENABLE_SEL));
+	if (USB_CTRL_MASK_FAMILY(params, SETUP, STRAP_IPP_SEL))
+		if (params->ipp != 2)
+			/* override ipp strap pin (if it exits) */
+			reg &= ~(USB_CTRL_MASK_FAMILY(params, SETUP,
+							STRAP_IPP_SEL));
+
+	/* Override the default OC and PP polarity */
+	reg &= ~(USB_CTRL_MASK(SETUP, IPP) | USB_CTRL_MASK(SETUP, IOC));
+	if (params->ioc)
+		reg |= USB_CTRL_MASK(SETUP, IOC);
+	if ((params->ipp == 1) && ((reg & USB_CTRL_MASK(SETUP, IPP)) == 0))
+		reg |= USB_CTRL_MASK(SETUP, IPP);
+	brcmusb_writel(reg, USB_CTRL_REG(ctrl, SETUP));
+
+	/*
+	 * If we're changing IPP, make sure power is off long enough
+	 * to turn off any connected devices.
+	 */
+	if (reg != orig_reg)
+		msleep(50);
+}
+
+int brcm_usb_init_get_dual_select(struct brcm_usb_init_params *params)
+{
+	void __iomem *ctrl = params->ctrl_regs;
+	u32 reg = 0;
+
+	if (USB_CTRL_MASK_FAMILY(params, USB_DEVICE_CTL1, PORT_MODE)) {
+		reg = brcmusb_readl(USB_CTRL_REG(ctrl, USB_DEVICE_CTL1));
+		reg &= USB_CTRL_MASK_FAMILY(params, USB_DEVICE_CTL1,
+					PORT_MODE);
+	}
+	return reg;
+}
+
+void brcm_usb_init_set_dual_select(struct brcm_usb_init_params *params,
+				int mode)
+{
+	void __iomem *ctrl = params->ctrl_regs;
+	u32 reg;
+
+	if (USB_CTRL_MASK_FAMILY(params, USB_DEVICE_CTL1, PORT_MODE)) {
+		reg = brcmusb_readl(USB_CTRL_REG(ctrl, USB_DEVICE_CTL1));
+		reg &= ~USB_CTRL_MASK_FAMILY(params, USB_DEVICE_CTL1,
+					PORT_MODE);
+		reg |= mode;
+		brcmusb_writel(reg, USB_CTRL_REG(ctrl, USB_DEVICE_CTL1));
+	}
+}
+
+static void brcmusb_init_common(struct brcm_usb_init_params *params)
+{
+	u32 reg;
+	void __iomem *ctrl = params->ctrl_regs;
+
+	/* Take USB out of power down */
+	if (USB_CTRL_MASK_FAMILY(params, PLL_CTL, PLL_IDDQ_PWRDN)) {
+		USB_CTRL_UNSET_FAMILY(params, PLL_CTL, PLL_IDDQ_PWRDN);
+		/* 1 millisecond - for USB clocks to settle down */
+		msleep(1);
+	}
+
+	if (USB_CTRL_MASK_FAMILY(params, USB_PM, USB_PWRDN)) {
+		USB_CTRL_UNSET_FAMILY(params, USB_PM, USB_PWRDN);
+		/* 1 millisecond - for USB clocks to settle down */
+		msleep(1);
+	}
+
+	if ((params->selected_family != BRCM_FAMILY_74371A0) &&
+		(BRCM_ID(params->family_id) != 0x7364))
+		/*
+		 * HW7439-637: 7439a0 and its derivatives do not have large
+		 * enough descriptor storage for this.
+		 */
+		USB_CTRL_SET_FAMILY(params, SETUP, SS_EHCI64BIT_EN);
+
+	/* Block auto PLL suspend by USB2 PHY (Sasi) */
+	USB_CTRL_SET(ctrl, PLL_CTL, PLL_SUSPEND_EN);
+
+	reg = brcmusb_readl(USB_CTRL_REG(ctrl, SETUP));
+	if (params->selected_family == BRCM_FAMILY_7364A0)
+		/* Suppress overcurrent indication from USB30 ports for A0 */
+		reg |= USB_CTRL_MASK_FAMILY(params, SETUP, OC3_DISABLE);
+
+	brcmusb_usb_phy_ldo_fix(ctrl);
+	brcmusb_usb2_eye_fix(ctrl);
+
+	/*
+	 * Make sure the the second and third memory controller
+	 * interfaces are enabled if they exist.
+	 */
+	if (USB_CTRL_MASK_FAMILY(params, SETUP, SCB1_EN))
+		reg |= USB_CTRL_MASK_FAMILY(params, SETUP, SCB1_EN);
+	if (USB_CTRL_MASK_FAMILY(params, SETUP, SCB2_EN))
+		reg |= USB_CTRL_MASK_FAMILY(params, SETUP, SCB2_EN);
+	brcmusb_writel(reg, USB_CTRL_REG(ctrl, SETUP));
+
+	brcmusb_memc_fix(params);
+
+	if (USB_CTRL_MASK_FAMILY(params, USB_DEVICE_CTL1, PORT_MODE)) {
+		reg = brcmusb_readl(USB_CTRL_REG(ctrl, USB_DEVICE_CTL1));
+		reg &= ~USB_CTRL_MASK_FAMILY(params, USB_DEVICE_CTL1,
+					PORT_MODE);
+		reg |= params->mode;
+		brcmusb_writel(reg, USB_CTRL_REG(ctrl, USB_DEVICE_CTL1));
+	}
+	if (USB_CTRL_MASK_FAMILY(params, USB_PM, BDC_SOFT_RESETB)) {
+		switch (params->mode) {
+		case USB_CTLR_MODE_HOST:
+			USB_CTRL_UNSET_FAMILY(params, USB_PM, BDC_SOFT_RESETB);
+			break;
+		default:
+			USB_CTRL_SET_FAMILY(params, USB_PM, BDC_SOFT_RESETB);
+		break;
+		}
+	}
+	if (USB_CTRL_MASK_FAMILY(params, SETUP, CC_DRD_MODE_ENABLE)) {
+		if (params->mode == USB_CTLR_MODE_TYPEC_PD)
+			USB_CTRL_SET_FAMILY(params, SETUP, CC_DRD_MODE_ENABLE);
+		else
+			USB_CTRL_UNSET_FAMILY(params, SETUP,
+					CC_DRD_MODE_ENABLE);
+	}
+}
+
+static void brcmusb_init_eohci(struct brcm_usb_init_params *params)
+{
+	u32 reg;
+	void __iomem *ctrl = params->ctrl_regs;
+
+	if (USB_CTRL_MASK_FAMILY(params, USB_PM, USB20_HC_RESETB))
+		USB_CTRL_SET_FAMILY(params, USB_PM, USB20_HC_RESETB);
+
+	if (params->selected_family == BRCM_FAMILY_7366C0)
+		/*
+		 * Don't enable this so the memory controller doesn't read
+		 * into memory holes. NOTE: This bit is low true on 7366C0.
+		 */
+		USB_CTRL_SET_FAMILY(params, EBRIDGE, ESTOP_SCB_REQ);
+
+	/* Setup the endian bits */
+	reg = brcmusb_readl(USB_CTRL_REG(ctrl, SETUP));
+	reg &= ~USB_CTRL_SETUP_ENDIAN_BITS;
+	reg |= USB_CTRL_MASK_FAMILY(params, SETUP, ENDIAN);
+	brcmusb_writel(reg, USB_CTRL_REG(ctrl, SETUP));
+
+}
+
+static void brcmusb_init_xhci(struct brcm_usb_init_params *params)
+{
+	void __iomem *ctrl = params->ctrl_regs;
+
+	if (BRCM_ID(params->family_id) == 0x7366) {
+		/*
+		 * The PHY3_SOFT_RESETB bits default to the wrong state.
+		 */
+		USB_CTRL_SET(ctrl, USB30_PCTL, PHY3_SOFT_RESETB);
+		USB_CTRL_SET(ctrl, USB30_PCTL, PHY3_SOFT_RESETB_P1);
+	}
+
+	/*
+	 * Kick start USB3 PHY
+	 * Make sure it's low to insure a rising edge.
+	 */
+	USB_CTRL_UNSET(ctrl, USB30_CTL1, PHY3_PLL_SEQ_START);
+	USB_CTRL_SET(ctrl, USB30_CTL1, PHY3_PLL_SEQ_START);
+
+	brcmusb_usb3_phy_workarounds(params);
+	brcmusb_xhci_soft_reset(params, 0);
+	brcmusb_usb3_otp_fix(params);
+}
+
+static void brcmusb_uninit_common(struct brcm_usb_init_params *params)
+{
+	if (USB_CTRL_MASK_FAMILY(params, USB_PM, USB_PWRDN))
+		USB_CTRL_SET_FAMILY(params, USB_PM, USB_PWRDN);
+
+	if (USB_CTRL_MASK_FAMILY(params, PLL_CTL, PLL_IDDQ_PWRDN))
+		USB_CTRL_SET_FAMILY(params, PLL_CTL, PLL_IDDQ_PWRDN);
+}
+
+static void brcmusb_uninit_eohci(struct brcm_usb_init_params *params)
+{
+
+	if (USB_CTRL_MASK_FAMILY(params, USB_PM, USB20_HC_RESETB))
+		USB_CTRL_UNSET_FAMILY(params, USB_PM, USB20_HC_RESETB);
+}
+
+static void usb_uninit_xhci(struct brcm_usb_init_params *params)
+{
+	brcmusb_xhci_soft_reset(params, 1);
+}
+
+static const struct brcm_usb_init_ops arm_ops = {
+	.init_ipp = brcmusb_usb_init_ipp,
+	.init_common = brcmusb_init_common,
+	.init_eohci = brcmusb_init_eohci,
+	.init_xhci = brcmusb_init_xhci,
+	.uninit_common = brcmusb_uninit_common,
+	.uninit_eohci = brcmusb_uninit_eohci,
+	.uninit_xhci = usb_uninit_xhci,
+};
+
+static void brcmusb_init_common_mips(struct brcm_usb_init_params *params)
+{
+	u32 reg;
+	void __iomem *ctrl = params->ctrl_regs;
+
+	reg = brcmusb_readl(USB_CTRL_REG(ctrl, SETUP));
+	reg &= ~USB_CTRL_SETUP_ENDIAN_BITS;
+	reg |= USB_CTRL_MASK_FAMILY(params, SETUP, ENDIAN);
+	brcmusb_writel(reg, USB_CTRL_REG(ctrl, SETUP));
+	USB_CTRL_SET(ctrl, PLL_CTL, PLL_SUSPEND_EN);
+	if (params->selected_family == BRCM_FAMILY_7425B0)
+		USB_CTRL_SET(ctrl, SETUP, SCB_CLIENT_SWAP);
+}
+
+static const struct brcm_usb_init_ops bmips_ops = {
+	.init_ipp = brcmusb_usb_init_ipp,
+	.init_common = brcmusb_init_common_mips,
+};
+
+void brcm_usb_set_family_map(struct brcm_usb_init_params *params)
+{
+	struct id_to_type const *table;
+	int fam;
+
+	if (IS_ENABLED(CONFIG_MIPS)) {
+		params->ops = &bmips_ops;
+		table = id_to_type_table_mips;
+	} else {
+		params->ops = &arm_ops;
+		table = id_to_type_table_arm;
+	}
+	fam = brcmusb_get_family_type(params, table);
+	params->selected_family = fam;
+	params->usb_reg_bits_map =
+		&usb_reg_bits_map_table[fam][0];
+	params->family_name = family_names[fam];
+}
+
diff --git a/drivers/phy/broadcom/phy-brcm-usb-init.h b/drivers/phy/broadcom/phy-brcm-usb-init.h
new file mode 100644
index 0000000..2c5f10a
--- /dev/null
+++ b/drivers/phy/broadcom/phy-brcm-usb-init.h
@@ -0,0 +1,95 @@
+/*
+ * Copyright (C) 2014-2017 Broadcom
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _USB_BRCM_COMMON_INIT_H
+#define _USB_BRCM_COMMON_INIT_H
+
+#define USB_CTLR_MODE_HOST 0
+#define USB_CTLR_MODE_DEVICE 1
+#define USB_CTLR_MODE_DRD 2
+#define USB_CTLR_MODE_TYPEC_PD 3
+
+struct  brcm_usb_init_params;
+
+struct brcm_usb_init_ops {
+	void (*init_ipp)(struct brcm_usb_init_params *params);
+	void (*init_common)(struct brcm_usb_init_params *params);
+	void (*init_eohci)(struct brcm_usb_init_params *params);
+	void (*init_xhci)(struct brcm_usb_init_params *params);
+	void (*uninit_common)(struct brcm_usb_init_params *params);
+	void (*uninit_eohci)(struct brcm_usb_init_params *params);
+	void (*uninit_xhci)(struct brcm_usb_init_params *params);
+};
+
+struct  brcm_usb_init_params {
+	void __iomem *ctrl_regs;
+	void __iomem *xhci_ec_regs;
+	int ioc;
+	int ipp;
+	int mode;
+	u32 family_id;
+	u32 product_id;
+	int selected_family;
+	const char *family_name;
+	const u32 *usb_reg_bits_map;
+	const struct brcm_usb_init_ops *ops;
+};
+
+void brcm_usb_set_family_map(struct brcm_usb_init_params *params);
+int brcm_usb_init_get_dual_select(struct brcm_usb_init_params *params);
+void brcm_usb_init_set_dual_select(struct brcm_usb_init_params *params,
+				int mode);
+
+static inline void brcm_usb_init_ipp(struct brcm_usb_init_params *ini)
+{
+	if (ini->ops->init_ipp)
+		ini->ops->init_ipp(ini);
+}
+
+static inline void brcm_usb_init_common(struct brcm_usb_init_params *ini)
+{
+	if (ini->ops->init_common)
+		ini->ops->init_common(ini);
+}
+
+static inline void brcm_usb_init_eohci(struct brcm_usb_init_params *ini)
+{
+	if (ini->ops->init_eohci)
+		ini->ops->init_eohci(ini);
+}
+
+static inline void brcm_usb_init_xhci(struct brcm_usb_init_params *ini)
+{
+	if (ini->ops->init_xhci)
+		ini->ops->init_xhci(ini);
+}
+
+static inline void brcm_usb_uninit_common(struct brcm_usb_init_params *ini)
+{
+	if (ini->ops->uninit_common)
+		ini->ops->uninit_common(ini);
+}
+
+static inline void brcm_usb_uninit_eohci(struct brcm_usb_init_params *ini)
+{
+	if (ini->ops->uninit_eohci)
+		ini->ops->uninit_eohci(ini);
+}
+
+static inline void brcm_usb_uninit_xhci(struct brcm_usb_init_params *ini)
+{
+	if (ini->ops->uninit_xhci)
+		ini->ops->uninit_xhci(ini);
+}
+
+#endif /* _USB_BRCM_COMMON_INIT_H */
diff --git a/drivers/phy/broadcom/phy-brcm-usb.c b/drivers/phy/broadcom/phy-brcm-usb.c
new file mode 100644
index 0000000..cd18616
--- /dev/null
+++ b/drivers/phy/broadcom/phy-brcm-usb.c
@@ -0,0 +1,359 @@
+/*
+ * phy-brcm-usb.c - Broadcom USB Phy Driver
+ *
+ * Copyright (C) 2015-2017 Broadcom
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/interrupt.h>
+#include <linux/soc/brcmstb/brcmstb.h>
+#include <dt-bindings/phy/phy.h>
+
+#include "phy-brcm-usb-init.h"
+
+enum brcm_usb_phy_id {
+	BRCM_USB_PHY_2_0 = 0,
+	BRCM_USB_PHY_3_0,
+	BRCM_USB_PHY_ID_MAX
+};
+
+struct value_to_name_map {
+	int value;
+	const char *name;
+};
+
+static struct value_to_name_map brcm_dr_mode_to_name[] = {
+	{ USB_CTLR_MODE_HOST, "host" },
+	{ USB_CTLR_MODE_DEVICE, "peripheral" },
+	{ USB_CTLR_MODE_DRD, "drd" },
+	{ USB_CTLR_MODE_TYPEC_PD, "typec-pd" }
+};
+
+struct brcm_usb_phy {
+	struct phy *phy;
+	unsigned int id;
+	bool inited;
+};
+
+struct brcm_usb_phy_data {
+	struct  brcm_usb_init_params ini;
+	bool			has_eohci;
+	bool			has_xhci;
+	struct clk		*usb_20_clk;
+	struct clk		*usb_30_clk;
+	struct mutex		mutex;
+	int			init_count;
+	struct brcm_usb_phy	phys[BRCM_USB_PHY_ID_MAX];
+};
+
+#define to_brcm_usb_phy_data(phy) \
+	container_of((phy), struct brcm_usb_phy_data, phys[(phy)->id])
+
+static int brcm_usb_phy_init(struct phy *gphy)
+{
+	struct brcm_usb_phy *phy = phy_get_drvdata(gphy);
+	struct brcm_usb_phy_data *priv = to_brcm_usb_phy_data(phy);
+
+	/*
+	 * Use a lock to make sure a second caller waits until
+	 * the base phy is inited before using it.
+	 */
+	mutex_lock(&priv->mutex);
+	if (priv->init_count++ == 0) {
+		clk_enable(priv->usb_20_clk);
+		clk_enable(priv->usb_30_clk);
+		brcm_usb_init_common(&priv->ini);
+	}
+	mutex_unlock(&priv->mutex);
+	if (phy->id == BRCM_USB_PHY_2_0)
+		brcm_usb_init_eohci(&priv->ini);
+	else if (phy->id == BRCM_USB_PHY_3_0)
+		brcm_usb_init_xhci(&priv->ini);
+	phy->inited = true;
+	dev_dbg(&gphy->dev, "INIT, id: %d, total: %d\n", phy->id,
+		priv->init_count);
+
+	return 0;
+}
+
+static int brcm_usb_phy_exit(struct phy *gphy)
+{
+	struct brcm_usb_phy *phy = phy_get_drvdata(gphy);
+	struct brcm_usb_phy_data *priv = to_brcm_usb_phy_data(phy);
+
+	dev_dbg(&gphy->dev, "EXIT\n");
+	if (phy->id == BRCM_USB_PHY_2_0)
+		brcm_usb_uninit_eohci(&priv->ini);
+	if (phy->id == BRCM_USB_PHY_3_0)
+		brcm_usb_uninit_xhci(&priv->ini);
+
+	/* If both xhci and eohci are gone, reset everything else */
+	mutex_lock(&priv->mutex);
+	if (--priv->init_count == 0) {
+		brcm_usb_uninit_common(&priv->ini);
+		clk_disable(priv->usb_20_clk);
+		clk_disable(priv->usb_30_clk);
+	}
+	mutex_unlock(&priv->mutex);
+	phy->inited = false;
+	return 0;
+}
+
+static struct phy_ops brcm_usb_phy_ops = {
+	.init		= brcm_usb_phy_init,
+	.exit		= brcm_usb_phy_exit,
+	.owner		= THIS_MODULE,
+};
+
+static struct phy *brcm_usb_phy_xlate(struct device *dev,
+				struct of_phandle_args *args)
+{
+	struct brcm_usb_phy_data *data = dev_get_drvdata(dev);
+
+	/*
+	 * values 0 and 1 are for backward compatibility with
+	 * device tree nodes from older bootloaders.
+	 */
+	switch (args->args[0]) {
+	case 0:
+	case PHY_TYPE_USB2:
+		return data->phys[BRCM_USB_PHY_2_0].phy;
+	case 1:
+	case PHY_TYPE_USB3:
+		return data->phys[BRCM_USB_PHY_3_0].phy;
+	}
+	return ERR_PTR(-ENODEV);
+}
+
+static int name_to_value(struct value_to_name_map *table, int count,
+			const char *name, int *value)
+{
+	int x;
+
+	*value = 0;
+	for (x = 0; x < count; x++) {
+		if (sysfs_streq(name, table[x].name)) {
+			*value = x;
+			return 0;
+		}
+	}
+	return -EINVAL;
+}
+
+static int brcm_usb_phy_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	struct device *dev = &pdev->dev;
+	struct brcm_usb_phy_data *priv;
+	struct phy *gphy;
+	struct phy_provider *phy_provider;
+	struct device_node *dn = pdev->dev.of_node;
+	int err;
+	const char *mode;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+	platform_set_drvdata(pdev, priv);
+
+	priv->ini.family_id = brcmstb_get_family_id();
+	priv->ini.product_id = brcmstb_get_product_id();
+	brcm_usb_set_family_map(&priv->ini);
+	dev_dbg(&pdev->dev, "Best mapping table is for %s\n",
+		priv->ini.family_name);
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res == NULL) {
+		dev_err(&pdev->dev, "can't get USB_CTRL base address\n");
+		return -EINVAL;
+	}
+	priv->ini.ctrl_regs = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(priv->ini.ctrl_regs)) {
+		dev_err(dev, "can't map CTRL register space\n");
+		return -EINVAL;
+	}
+
+	/* The XHCI EC registers are optional */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (res != NULL) {
+		priv->ini.xhci_ec_regs =
+			devm_ioremap_resource(&pdev->dev, res);
+		if (IS_ERR(priv->ini.xhci_ec_regs)) {
+			dev_err(dev, "can't map XHCI EC register space\n");
+			return -EINVAL;
+		}
+	}
+
+	of_property_read_u32(dn, "brcm,ipp", &priv->ini.ipp);
+	of_property_read_u32(dn, "brcm,ioc", &priv->ini.ioc);
+
+	priv->ini.mode = USB_CTLR_MODE_HOST;
+	err = of_property_read_string(dn, "dr_mode", &mode);
+	if (err == 0) {
+		name_to_value(&brcm_dr_mode_to_name[0],
+			ARRAY_SIZE(brcm_dr_mode_to_name),
+			mode, &priv->ini.mode);
+	}
+
+	if (of_property_read_bool(dn, "has_xhci_only")) {
+		priv->has_xhci = true;
+	} else {
+		priv->has_eohci = true;
+		if (of_property_read_bool(dn, "has_xhci"))
+			priv->has_xhci = true;
+	}
+	if (priv->has_eohci) {
+		gphy = devm_phy_create(dev, NULL, &brcm_usb_phy_ops);
+		if (IS_ERR(gphy)) {
+			dev_err(dev, "failed to create EHCI/OHCI PHY\n");
+			return PTR_ERR(gphy);
+		}
+		priv->phys[BRCM_USB_PHY_2_0].phy = gphy;
+		priv->phys[BRCM_USB_PHY_2_0].id = BRCM_USB_PHY_2_0;
+		phy_set_drvdata(gphy, &priv->phys[BRCM_USB_PHY_2_0]);
+	}
+	if (priv->has_xhci) {
+		gphy = devm_phy_create(dev, NULL, &brcm_usb_phy_ops);
+		if (IS_ERR(gphy)) {
+			dev_err(dev, "failed to create XHCI PHY\n");
+			return PTR_ERR(gphy);
+		}
+		priv->phys[BRCM_USB_PHY_3_0].phy = gphy;
+		priv->phys[BRCM_USB_PHY_3_0].id = BRCM_USB_PHY_3_0;
+		phy_set_drvdata(gphy, &priv->phys[BRCM_USB_PHY_3_0]);
+	}
+	mutex_init(&priv->mutex);
+	priv->usb_20_clk = of_clk_get_by_name(dn, "sw_usb");
+	if (IS_ERR(priv->usb_20_clk)) {
+		dev_info(&pdev->dev, "Clock not found in Device Tree\n");
+		priv->usb_20_clk = NULL;
+	}
+	err = clk_prepare_enable(priv->usb_20_clk);
+	if (err)
+		return err;
+
+	/* Get the USB3.0 clocks if we have XHCI */
+	if (priv->has_xhci) {
+		priv->usb_30_clk = of_clk_get_by_name(dn, "sw_usb3");
+		if (IS_ERR(priv->usb_30_clk)) {
+			dev_info(&pdev->dev,
+				"USB3.0 clock not found in Device Tree\n");
+			priv->usb_30_clk = NULL;
+		}
+		err = clk_prepare_enable(priv->usb_30_clk);
+		if (err)
+			return err;
+	}
+
+	brcm_usb_init_ipp(&priv->ini);
+
+	/* start with everything off */
+	if (priv->has_xhci)
+		brcm_usb_uninit_xhci(&priv->ini);
+	if (priv->has_eohci)
+		brcm_usb_uninit_eohci(&priv->ini);
+	brcm_usb_uninit_common(&priv->ini);
+	clk_disable(priv->usb_20_clk);
+	clk_disable(priv->usb_30_clk);
+
+	phy_provider = devm_of_phy_provider_register(dev, brcm_usb_phy_xlate);
+	if (IS_ERR(phy_provider))
+		return PTR_ERR(phy_provider);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int brcm_usb_phy_suspend(struct device *dev)
+{
+	struct brcm_usb_phy_data *priv = dev_get_drvdata(dev);
+
+	if (priv->init_count) {
+		clk_disable(priv->usb_20_clk);
+		clk_disable(priv->usb_30_clk);
+	}
+	return 0;
+}
+
+static int brcm_usb_phy_resume(struct device *dev)
+{
+	struct brcm_usb_phy_data *priv = dev_get_drvdata(dev);
+
+	clk_enable(priv->usb_20_clk);
+	clk_enable(priv->usb_30_clk);
+	brcm_usb_init_ipp(&priv->ini);
+
+	/*
+	 * Initialize anything that was previously initialized.
+	 * Uninitialize anything that wasn't previously initialized.
+	 */
+	if (priv->init_count) {
+		brcm_usb_init_common(&priv->ini);
+		if (priv->phys[BRCM_USB_PHY_2_0].inited) {
+			brcm_usb_init_eohci(&priv->ini);
+		} else if (priv->has_eohci) {
+			brcm_usb_uninit_eohci(&priv->ini);
+			clk_disable(priv->usb_20_clk);
+		}
+		if (priv->phys[BRCM_USB_PHY_3_0].inited) {
+			brcm_usb_init_xhci(&priv->ini);
+		} else if (priv->has_xhci) {
+			brcm_usb_uninit_xhci(&priv->ini);
+			clk_disable(priv->usb_30_clk);
+		}
+	} else {
+		if (priv->has_xhci)
+			brcm_usb_uninit_xhci(&priv->ini);
+		if (priv->has_eohci)
+			brcm_usb_uninit_eohci(&priv->ini);
+		brcm_usb_uninit_common(&priv->ini);
+		clk_disable(priv->usb_20_clk);
+		clk_disable(priv->usb_30_clk);
+	}
+
+	return 0;
+}
+#endif /* CONFIG_PM_SLEEP */
+
+static const struct dev_pm_ops brcm_usb_phy_pm_ops = {
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(brcm_usb_phy_suspend, brcm_usb_phy_resume)
+};
+
+static const struct of_device_id brcm_usb_dt_ids[] = {
+	{ .compatible = "brcm,brcmstb-usb-phy" },
+	{ /* sentinel */ }
+};
+
+MODULE_DEVICE_TABLE(of, brcm_usb_dt_ids);
+
+static struct platform_driver brcm_usb_driver = {
+	.probe		= brcm_usb_phy_probe,
+	.driver		= {
+		.name	= "brcmstb-usb-phy",
+		.owner	= THIS_MODULE,
+		.pm = &brcm_usb_phy_pm_ops,
+		.of_match_table = brcm_usb_dt_ids,
+	},
+};
+
+module_platform_driver(brcm_usb_driver);
+
+MODULE_ALIAS("platform:brcmstb-usb-phy");
+MODULE_AUTHOR("Al Cooper <acooper@broadcom.com>");
+MODULE_DESCRIPTION("BRCM USB PHY driver");
+MODULE_LICENSE("GPL v2");
-- 
1.9.0.138.g2de3478
