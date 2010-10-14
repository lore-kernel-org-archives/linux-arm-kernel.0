From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 Oct 2010 18:10:54 +0200
Subject: [PATCH 4/7] arm/versatile: use correct PCI IRQ swizzling
In-Reply-To: <1287072657-32477-1-git-send-email-arnd@arndb.de>
References: <1287072657-32477-1-git-send-email-arnd@arndb.de>
Message-ID: <1287072657-32477-5-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The interrupts on the versatile platform only worked for
one slot with a single-function device.

This fixes the swizzling and the IRQ assignment to work for
both slots on the base plane including multi-function devices
and bridges.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-versatile/versatile_pb.c            |    1 +
 arch/arm/plat-versatile/include/plat/xilinx-pci.h |    1 +
 arch/arm/plat-versatile/xilinx-pci.c              |   19 +++++++++++--------
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-versatile/versatile_pb.c b/arch/arm/mach-versatile/versatile_pb.c
index 0f39fde..e355057 100644
--- a/arch/arm/mach-versatile/versatile_pb.c
+++ b/arch/arm/mach-versatile/versatile_pb.c
@@ -117,6 +117,7 @@ static struct xilinx_pci_data versatile_pci_io = {
 	.sys_pcictl	= __IO_ADDRESS(VERSATILE_SYS_PCICTL),
 	.core_base	= __IO_ADDRESS(VERSATILE_PCI_CORE_BASE),
 	.base_irq	= 27,
+	.irq_rotate	= 2,
 
 	/* identity map outbound AHB addresses to PCI addresses */
 	.imap		= {
diff --git a/arch/arm/plat-versatile/include/plat/xilinx-pci.h b/arch/arm/plat-versatile/include/plat/xilinx-pci.h
index b0394c5..9156fcb 100644
--- a/arch/arm/plat-versatile/include/plat/xilinx-pci.h
+++ b/arch/arm/plat-versatile/include/plat/xilinx-pci.h
@@ -11,6 +11,7 @@ struct xilinx_pci_data {
 	void __iomem *cfg_base;
 	void __iomem *io_base;
 	int base_irq;
+	int irq_rotate;
 
 	u32 imap[3];
 	u32 smap[3];
diff --git a/arch/arm/plat-versatile/xilinx-pci.c b/arch/arm/plat-versatile/xilinx-pci.c
index 425604a..8da45e7 100644
--- a/arch/arm/plat-versatile/xilinx-pci.c
+++ b/arch/arm/plat-versatile/xilinx-pci.c
@@ -23,6 +23,7 @@
 #include <linux/io.h>
 
 #include <mach/hardware.h>
+#include <mach/platform.h>
 #include <asm/irq.h>
 #include <asm/system.h>
 #include <asm/mach/pci.h>
@@ -323,21 +324,23 @@ static int __init xilinx_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
 	int irq;
 	int devslot = PCI_SLOT(dev->devfn);
 
-	/* slot,  pin,	irq
-	 *  24     1     27
-	 *  25     1     28
-	 *  26     1     29
-	 *  27     1     30
+	/*
+	 * Slot to IRQ mapping for RealView Platform Baseboard 926 Backplane
+	 *	name	slot	IntA	IntB	IntC	IntD
+	 *	A	31	IRQ28	IRQ29	IRQ30	IRQ27
+	 *	B	30	IRQ27	IRQ28	IRQ29	IRQ30
+	 *	C	29	IRQ30	IRQ27	IRQ28	IRQ29
 	 */
-	irq = xilinx_pci->base_irq + ((slot + pin - 1) & 3);
+	irq = xilinx_pci->base_irq +
+		((slot + xilinx_pci->irq_rotate + pin - 1) & 3);
 
-	printk("PCI map irq: slot %d, pin %d, devslot %d, irq: %d\n",slot,pin,devslot,irq);
+	pr_debug("PCI map (slot+3) irq: slot %d, pin %d, devslot %d, irq: %d\n",slot,pin,devslot,irq);
 
 	return irq;
 }
 
 static struct hw_pci xilinx_hw_pci __initdata = {
-	.swizzle		= NULL,
+	.swizzle		= pci_std_swizzle,
 	.map_irq		= xilinx_map_irq,
 	.nr_controllers		= 1,
 	.setup			= pci_xilinx_setup,
-- 
1.7.1
