From: dk-arm-linux@gmx.de (Dieter Kiermaier)
Date: Mon, 9 Nov 2009 09:33:46 +0100
Subject: orion/kirkwood pcie issue still open with rc6
Message-ID: <200911090933.46240.dk-arm-linux@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

I've tried your latest kernel from orion.git and there is still a PCIe issue left.
Please see my patch below.
It would be very nice if someone could tell me why this patch helped me
to boot my kernel :)


---
>From 6ce3d877a96186e0dda0c319b9b7eb8df5d10541 Mon Sep 17 00:00:00 2001
From: Dieter Kiermaier <dk-arm-linux@gmx.de>
Date: Mon, 9 Nov 2009 09:15:12 +0100
Subject: [PATCH] Without this patch my kernel hangs during boot up while scanning the pci bus behind
 a marvell 88SB2211 stepping A0 pcie to pci bridge.

Ronan Shitrit from marvell gave me the information to clear bit 2 of physical
address 0xf1020100 to enable bus scanning.
I don't know what this really does but it helped to get my kernel up and running.

Signed-off-by: Dieter Kiermaier <dk-arm-linux@gmx.de>
---
 arch/arm/mach-kirkwood/openrd_base-setup.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-kirkwood/openrd_base-setup.c b/arch/arm/mach-kirkwood/openrd_base-setup.c
index 77617c7..21a1cf7 100644
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
@@ -76,6 +77,19 @@ static void __init openrd_base_init(void)
 
 static int __init openrd_base_pci_init(void)
 {
+	u32 cpu_config_reg;
+	void __iomem *base;
+	
+	base = ioremap(0xf1020100, 4);
+	if (base)
+	{
+		cpu_config_reg = readl(base);
+		cpu_config_reg &= ~(1 << 2);
+		writel(cpu_config_reg, base);
+		printk("register 0x20100: %x\n", readl(base));
+	}
+	iounmap(base);
+	
 	if (machine_is_openrd_base())
 		kirkwood_pcie_init();
 
-- 
1.5.4.3

Dieter
