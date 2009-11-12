From: dk-arm-linux@gmx.de (Dieter Kiermaier)
Date: Thu, 12 Nov 2009 15:19:42 +0100
Subject: [PATCH] [ARM] Kirkwood: Prevent kernel from crashing if PCIe bridge
	is present
Message-ID: <200911121519.42786.dk-arm-linux@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

first: thanks to all for the help while debugging!

Below you can find a first version of the patch which enables PCI on my openrd-base board
together with a PCIe->PCI bridge.
Please let me know if something is wrong with it.

This works together with Maxime Bizon's patch to enable pci bridges:
http://lists.infradead.org/pipermail/linux-arm-kernel/2009-November/003784.html

Regards,
Dieter


>From 25bbc7222100dce9c47a4e3bfc31267f8394a9da Mon Sep 17 00:00:00 2001
From: Dieter Kiermaier <dk-arm-linux@gmx.de>
Date: Thu, 12 Nov 2009 15:12:24 +0100
Subject: [PATCH] [ARM] Kirkwood: Prevent kernel from crashing if PCIe bridge is present

Clear bit 2 of CPU configuration register at offset 0x20100
to disable MBUS-L Error propagation.
If this bit isn't disabled kernel crash during bootup when booted
with current mainline u-boot (version U-Boot 2009.08-00208-g9ef0569)
and a PCIe -> PCI bridge is connected to the system.

Signed-off-by: Dieter Kiermaier <dk-arm-linux@gmx.de>
---
 arch/arm/mach-kirkwood/openrd_base-setup.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-kirkwood/openrd_base-setup.c b/arch/arm/mach-kirkwood/openrd_base-setup.c
index 77617c7..9e57326 100644
--- a/arch/arm/mach-kirkwood/openrd_base-setup.c
+++ b/arch/arm/mach-kirkwood/openrd_base-setup.c
@@ -14,6 +14,7 @@
 #include <linux/mtd/partitions.h>
 #include <linux/ata_platform.h>
 #include <linux/mv643xx_eth.h>
+#include <asm/io.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <mach/kirkwood.h>
@@ -76,9 +77,19 @@ static void __init openrd_base_init(void)
 
 static int __init openrd_base_pci_init(void)
 {
+	u32 cpu_config_reg;
+	void __iomem *base;
+	base = ioremap(0xf1020100, 4);
+	if (base)
+	{
+		cpu_config_reg = readl(base);
+		cpu_config_reg &= ~(1 << 2);
+		writel(cpu_config_reg, base);
+	}
+	iounmap(base);
+
 	if (machine_is_openrd_base())
 		kirkwood_pcie_init();
-
 	return 0;
  }
 subsys_initcall(openrd_base_pci_init);
-- 
1.5.4.3
