From: tharvey@gateworks.com (Tim Harvey)
Date: Tue, 22 Oct 2013 21:51:28 -0700
Subject: [PATCH 4/4] imx: add PCI fixup for PEX860X on Gateworks board
In-Reply-To: <1382503888-3962-1-git-send-email-tharvey@gateworks.com>
References: <1382503888-3962-1-git-send-email-tharvey@gateworks.com>
Message-ID: <1382503888-3962-5-git-send-email-tharvey@gateworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PEX860X has GPIO's which are used for PCI Reset lines on the
Gateworks Ventana boards.  The GPIO's need to be set as output
level high so as to allow the PCIe devices to come out of reset.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm/mach-imx/mach-imx6q.c |   33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index 0f9f241..eb5747f 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -13,6 +13,7 @@
 #include <linux/clk.h>
 #include <linux/clkdev.h>
 #include <linux/cpu.h>
+#include <linux/delay.h>
 #include <linux/export.h>
 #include <linux/init.h>
 #include <linux/io.h>
@@ -23,6 +24,7 @@
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/opp.h>
+#include <linux/pci.h>
 #include <linux/phy.h>
 #include <linux/reboot.h>
 #include <linux/regmap.h>
@@ -78,6 +80,37 @@ static int ksz9031rn_phy_fixup(struct phy_device *dev)
 	return 0;
 }
 
+/*
+ * fixup for PLX PEX8909 bridge to configure GPIO1-7 as output High
+ * as they are used for slots1-7 PERST#
+ */
+static void mx6_ventana_pciesw_early_fixup(struct pci_dev *dev)
+{
+	u32 dw;
+
+	if (!of_machine_is_compatible("gw,ventana"))
+		return;
+
+	if (dev->devfn != 0)
+		return;
+
+	pci_read_config_dword(dev, 0x62c, &dw);
+	dw |= 0xaaa8; // GPIO1-7 outputs
+	pci_write_config_dword(dev, 0x62c, dw);
+
+	pci_read_config_dword(dev, 0x644, &dw);
+	dw |= 0xfe;   // GPIO1-7 output high
+	pci_write_config_dword(dev, 0x644, dw);
+
+	msleep(100);
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_PLX, 0x8609,
+	mx6_ventana_pciesw_early_fixup);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_PLX, 0x8606,
+	mx6_ventana_pciesw_early_fixup);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_PLX, 0x8604,
+	mx6_ventana_pciesw_early_fixup);
+
 static int ar8031_phy_fixup(struct phy_device *dev)
 {
 	u16 val;
-- 
1.7.9.5
