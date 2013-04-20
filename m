From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 20 Apr 2013 15:56:54 +0200
Subject: [RESEND PATCH 12/12] ARM: integrator: get PCI device IRQs from device
 tree
Message-ID: <1366466214-15714-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the interrupt-map property to the PCIv3 DTS file
and makes the bridge obtain mappings from the device tree.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/integratorap.dts | 24 ++++++++++++++++++++++++
 arch/arm/mach-integrator/pci_v3.c  | 23 ++++++++++++++++++++++-
 2 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/integratorap.dts b/arch/arm/boot/dts/integratorap.dts
index 9c78130..03f23b7 100644
--- a/arch/arm/boot/dts/integratorap.dts
+++ b/arch/arm/boot/dts/integratorap.dts
@@ -41,6 +41,7 @@
 
 	pci: pciv3 at 62000000 {
 		compatible = "v3,v360epc-pci";
+		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
 		reg = <0x62000000 0x10000>;
@@ -54,6 +55,29 @@
 			0x40000000 0 0x10000000 /* 256 MiB @ 40000000 */
 			0x42000000 0 0x50000000 /* prefetchable memory */
 			0x50000000 0 0x10000000>; /* 256 MiB @ 50000000 */
+		interrupt-map-mask = <0xf800 0 0 0x7>;
+		interrupt-map = <
+		/* IDSEL 9 */
+		0x4800 0 0 1 &pic 13 /* INT A on slot 9 is irq 13 */
+		0x4800 0 0 2 &pic 14 /* INT B on slot 9 is irq 14 */
+		0x4800 0 0 3 &pic 15 /* INT C on slot 9 is irq 15 */
+		0x4800 0 0 4 &pic 16 /* INT D on slot 9 is irq 16 */
+		/* IDSEL 10 */
+		0x5000 0 0 1 &pic 14 /* INT A on slot 10 is irq 14 */
+		0x5000 0 0 2 &pic 15 /* INT B on slot 10 is irq 15 */
+		0x5000 0 0 3 &pic 16 /* INT C on slot 10 is irq 16 */
+		0x5000 0 0 4 &pic 13 /* INT D on slot 10 is irq 13 */
+		/* IDSEL 11 */
+		0x5800 0 0 1 &pic 15 /* INT A on slot 11 is irq 15 */
+		0x5800 0 0 2 &pic 16 /* INT B on slot 11 is irq 16 */
+		0x5800 0 0 3 &pic 13 /* INT C on slot 11 is irq 13 */
+		0x5800 0 0 4 &pic 14 /* INT D on slot 11 is irq 14 */
+		/* IDSEL 12 */
+		0x6000 0 0 1 &pic 16 /* INT A on slot 12 is irq 16 */
+		0x6000 0 0 2 &pic 13 /* INT B on slot 12 is irq 13 */
+		0x6000 0 0 3 &pic 14 /* INT C on slot 12 is irq 14 */
+		0x6000 0 0 4 &pic 15 /* INT D on slot 12 is irq 15 */
+		>;
 	};
 
 	fpga {
diff --git a/arch/arm/mach-integrator/pci_v3.c b/arch/arm/mach-integrator/pci_v3.c
index 8932eb3..020048a 100644
--- a/arch/arm/mach-integrator/pci_v3.c
+++ b/arch/arm/mach-integrator/pci_v3.c
@@ -30,6 +30,7 @@
 #include <linux/platform_device.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/of_irq.h>
 #include <linux/of_pci.h>
 #include <video/vga.h>
 
@@ -829,9 +830,24 @@ static int __init pci_v3_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 	return irq_tab[intnr];
 }
 
+static int __init pci_v3_map_irq_dt(const struct pci_dev *dev, u8 slot, u8 pin)
+{
+	struct of_irq oirq;
+	int ret;
+
+	ret = of_irq_map_pci(dev, &oirq);
+	if (ret) {
+		dev_err(&dev->dev, "of_irq_map_pci() %d\n", ret);
+		/* Proper return code 0 == NO_IRQ */
+		return 0;
+	}
+
+	return irq_create_of_mapping(oirq.controller, oirq.specifier,
+				     oirq.size);
+}
+
 static struct hw_pci pci_v3 __initdata = {
 	.swizzle		= pci_v3_swizzle,
-	.map_irq		= pci_v3_map_irq,
 	.setup			= pci_v3_setup,
 	.nr_controllers		= 1,
 	.ops			= &pci_v3_ops,
@@ -903,7 +919,10 @@ static int __init pci_v3_dtprobe(struct platform_device *pdev,
 		return -EINVAL;
 	}
 
+	pci_v3.map_irq = pci_v3_map_irq_dt;
+
 	pci_common_init(&pdev->dev, &pci_v3);
+
 	return 0;
 }
 
@@ -958,6 +977,8 @@ static int __init pci_v3_probe(struct platform_device *pdev)
 		PCI_BUS_PREMEM_SIZE - 1;
 	pre_mem.flags = IORESOURCE_MEM | IORESOURCE_PREFETCH;
 
+	pci_v3.map_irq = pci_v3_map_irq;
+
 	pci_common_init_dev(&pdev->dev, &pci_v3);
 
 	return 0;
-- 
1.8.1.4
