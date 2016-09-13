From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 13 Sep 2016 22:40:53 +0530
Subject: [RFC PATCH] HACK: pci: controller: dra7xx: disable smart idle
In-Reply-To: <1473786653-12759-1-git-send-email-kishon@ti.com>
References: <1473786653-12759-1-git-send-email-kishon@ti.com>
Message-ID: <1473786653-12759-12-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Smart idle prevents RC to access the memory space of this
controller. Set the idle mode to smart idle wakeup. This
should ideally be done in hwmod. Till it's figured out how
to configure it in hwmod, mark this as HACK.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/pci-dra7xx.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pci/controller/pci-dra7xx.c b/drivers/pci/controller/pci-dra7xx.c
index 5b49367..31211e6 100644
--- a/drivers/pci/controller/pci-dra7xx.c
+++ b/drivers/pci/controller/pci-dra7xx.c
@@ -30,6 +30,14 @@
 
 /* PCIe controller wrapper DRA7XX configuration registers */
 
+#define	PCIECTRL_DRA7XX_CONF_SYSCONFIG			0x0010
+#define SIDLE_MASK					3
+#define SIDLE_SHIFT					2
+#define SIDLE_FORCE					0x0
+#define SIDLE_NO					0x1
+#define SIDLE_SMART					0x2
+#define SIDLE_SMART_WKUP				0x3
+
 #define	PCIECTRL_DRA7XX_CONF_IRQSTATUS_MAIN		0x0024
 #define	PCIECTRL_DRA7XX_CONF_IRQENABLE_SET_MAIN		0x0028
 #define	ERR_SYS						BIT(0)
@@ -606,6 +614,10 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 			goto err_gpio;
 		break;
 	case DW_PCIE_EP_TYPE:
+		reg = dra7xx_pcie_readl(dra7xx, PCIECTRL_DRA7XX_CONF_SYSCONFIG);
+		reg &= ~(SIDLE_MASK << SIDLE_SHIFT);
+		reg |= SIDLE_SMART_WKUP << SIDLE_SHIFT;
+		dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_SYSCONFIG, reg);
 		dra7xx_pcie_writel(dra7xx, PCIECTRL_TI_CONF_DEVICE_TYPE,
 				   DEVICE_TYPE_EP);
 		ret = dra7xx_add_pcie_ep(dra7xx, pdev);
-- 
1.7.9.5
