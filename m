From: tony.lin@freescale.com (Tony Lin)
Date: Wed, 27 Jul 2011 13:29:29 +0800
Subject: [PATCH v3 1/6] ARM: mxs: ehci: consolidate definitions and structures
	to share among platforms
In-Reply-To: <1311744574-3610-1-git-send-email-tony.lin@freescale.com>
References: <1311744574-3610-1-git-send-email-tony.lin@freescale.com>
Message-ID: <1311744574-3610-2-git-send-email-tony.lin@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

move common definitions and data structures used for mxs and mxc
platforms to fsl_device.h from mxc_ehci.h
so that these definitions and structures could be shared without
duplicated copies.

Signed-off-by: Tony Lin <tony.lin@freescale.com>
---
 arch/arm/plat-mxc/include/mach/mxc_ehci.h |   19 -------------------
 drivers/usb/host/ehci-mxc.c               |    4 +---
 include/linux/fsl_devices.h               |   19 +++++++++++++++++++
 3 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/mxc_ehci.h b/arch/arm/plat-mxc/include/mach/mxc_ehci.h
index 2c159dc..8775807 100644
--- a/arch/arm/plat-mxc/include/mach/mxc_ehci.h
+++ b/arch/arm/plat-mxc/include/mach/mxc_ehci.h
@@ -1,17 +1,6 @@
 #ifndef __INCLUDE_ASM_ARCH_MXC_EHCI_H
 #define __INCLUDE_ASM_ARCH_MXC_EHCI_H
 
-/* values for portsc field */
-#define MXC_EHCI_PHY_LOW_POWER_SUSPEND	(1 << 23)
-#define MXC_EHCI_FORCE_FS		(1 << 24)
-#define MXC_EHCI_UTMI_8BIT		(0 << 28)
-#define MXC_EHCI_UTMI_16BIT		(1 << 28)
-#define MXC_EHCI_SERIAL			(1 << 29)
-#define MXC_EHCI_MODE_UTMI		(0 << 30)
-#define MXC_EHCI_MODE_PHILIPS		(1 << 30)
-#define MXC_EHCI_MODE_ULPI		(2 << 30)
-#define MXC_EHCI_MODE_SERIAL		(3 << 30)
-
 /* values for flags field */
 #define MXC_EHCI_INTERFACE_DIFF_UNI	(0 << 0)
 #define MXC_EHCI_INTERFACE_DIFF_BI	(1 << 0)
@@ -39,14 +28,6 @@
 #define MX5_USB_UTMI_PHYCTRL1_PLLDIV_MASK		0x3
 #define MX5_USB_UTMI_PHYCTRL1_PLLDIV_SHIFT		0
 
-struct mxc_usbh_platform_data {
-	int (*init)(struct platform_device *pdev);
-	int (*exit)(struct platform_device *pdev);
-
-	unsigned int		 portsc;
-	struct otg_transceiver	*otg;
-};
-
 int mx51_initialize_usb_hw(int port, unsigned int flags);
 int mx25_initialize_usb_hw(int port, unsigned int flags);
 int mx31_initialize_usb_hw(int port, unsigned int flags);
diff --git a/drivers/usb/host/ehci-mxc.c b/drivers/usb/host/ehci-mxc.c
index 0c058be..cbf60a6 100644
--- a/drivers/usb/host/ehci-mxc.c
+++ b/drivers/usb/host/ehci-mxc.c
@@ -23,9 +23,7 @@
 #include <linux/usb/otg.h>
 #include <linux/usb/ulpi.h>
 #include <linux/slab.h>
-
-#include <mach/mxc_ehci.h>
-
+#include <linux/fsl_devices.h>
 #include <asm/mach-types.h>
 
 #define ULPI_VIEWPORT_OFFSET	0x170
diff --git a/include/linux/fsl_devices.h b/include/linux/fsl_devices.h
index fffdf00..cb19260 100644
--- a/include/linux/fsl_devices.h
+++ b/include/linux/fsl_devices.h
@@ -103,6 +103,25 @@ struct fsl_usb2_platform_data {
 
 #define FLS_USB2_WORKAROUND_ENGCM09152	(1 << 0)
 
+/* values for portsc field */
+#define MXC_EHCI_PHY_LOW_POWER_SUSPEND	(1 << 23)
+#define MXC_EHCI_FORCE_FS		(1 << 24)
+#define MXC_EHCI_UTMI_8BIT		(0 << 28)
+#define MXC_EHCI_UTMI_16BIT		(1 << 28)
+#define MXC_EHCI_SERIAL			(1 << 29)
+#define MXC_EHCI_MODE_UTMI		(0 << 30)
+#define MXC_EHCI_MODE_PHILIPS		(1 << 30)
+#define MXC_EHCI_MODE_ULPI		(2 << 30)
+#define MXC_EHCI_MODE_SERIAL		(3 << 30)
+
+struct mxc_usbh_platform_data {
+	int (*init)(struct platform_device *pdev);
+	int (*exit)(struct platform_device *pdev);
+
+	unsigned int		portsc;
+	struct otg_transceiver	*otg;
+};
+
 struct spi_device;
 
 struct fsl_spi_platform_data {
-- 
1.7.0.4
