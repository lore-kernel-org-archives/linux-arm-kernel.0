From: daniel@caiaq.de (Daniel Mack)
Date: Sat, 21 Nov 2009 17:19:24 +0100
Subject: [PATCH] ARM: MX3: fix CPU revision number detection
Message-ID: <1258820364-32693-1-git-send-email-daniel@caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The macro mx31_revision() used to take the global variable system_rev to
determine the CPU revision number. However, this number is expected to
be set by the bootloader and is usually zero (at least on my MX31 based
boards here). More than that, it is usually taken to identify the
board's revision, not the CPU's.

Fix that by reading the the CPU's SREV register instead.

Right now, mx31_read_cpu_rev() is called from mx31_clocks_init() which
is admittedly not a good place for it. However, we need to enable the
IIM clock first, and the clock code also has conditional code that
depends on mx31_revision() returning the right thing.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
---
 arch/arm/mach-mx3/Makefile            |    2 +-
 arch/arm/mach-mx3/clock.c             |    2 +
 arch/arm/mach-mx3/cpu.c               |   57 +++++++++++++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/mx3x.h |    5 ++-
 4 files changed, 63 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/mach-mx3/cpu.c

diff --git a/arch/arm/mach-mx3/Makefile b/arch/arm/mach-mx3/Makefile
index d47a674..47e9358 100644
--- a/arch/arm/mach-mx3/Makefile
+++ b/arch/arm/mach-mx3/Makefile
@@ -4,7 +4,7 @@
 
 # Object file lists.
 
-obj-y				:= mm.o devices.o
+obj-y				:= mm.o devices.o cpu.o
 obj-$(CONFIG_MX3_SDMA)		+= sdma/
 obj-$(CONFIG_ARCH_MX31)		+= clock.o iomux.o
 obj-$(CONFIG_ARCH_MX35)		+= clock-imx35.o
diff --git a/arch/arm/mach-mx3/clock.c b/arch/arm/mach-mx3/clock.c
index e147084..23866fc 100644
--- a/arch/arm/mach-mx3/clock.c
+++ b/arch/arm/mach-mx3/clock.c
@@ -616,6 +616,8 @@ int __init mx31_clocks_init(unsigned long fref)
 
 	clk_enable(&serial_pll_clk);
 
+	mx31_read_cpu_rev();
+
 	if (mx31_revision() >= CHIP_REV_2_0) {
 		reg = __raw_readl(MXC_CCM_PMCR1);
 		/* No PLL restart on DVFS switch; enable auto EMI handshake */
diff --git a/arch/arm/mach-mx3/cpu.c b/arch/arm/mach-mx3/cpu.c
new file mode 100644
index 0000000..b09f338
--- /dev/null
+++ b/arch/arm/mach-mx3/cpu.c
@@ -0,0 +1,57 @@
+/*
+ * MX3 CPU type detection
+ *
+ * Copyright (c) 2009 Daniel Mack <daniel@caiaq.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/module.h>
+#include <mach/hardware.h>
+#include <mach/iim.h>
+#include <asm/io.h>
+
+unsigned int mx31_cpu_rev;
+EXPORT_SYMBOL(mx31_cpu_rev);
+
+struct mx3_cpu_type {
+	u8 srev;
+	const char *name;
+	const char *v;
+	unsigned int rev;
+};
+
+static struct mx3_cpu_type mx31_cpu_type[] __initdata = {
+	{ .srev = 0x00, .name = "i.MX31(L)", .v = "1.0",  .rev = CHIP_REV_1_0	},
+	{ .srev = 0x10, .name = "i.MX31",    .v = "1.1",  .rev = CHIP_REV_1_1	},
+	{ .srev = 0x11, .name = "i.MX31L",   .v = "1.1",  .rev = CHIP_REV_1_1	},
+	{ .srev = 0x12, .name = "i.MX31",    .v = "1.15", .rev = CHIP_REV_1_1	},
+	{ .srev = 0x13, .name = "i.MX31L",   .v = "1.15", .rev = CHIP_REV_1_1	},
+	{ .srev = 0x14, .name = "i.MX31",    .v = "1.2",  .rev = CHIP_REV_1_2	},
+	{ .srev = 0x15, .name = "i.MX31L",   .v = "1.2",  .rev = CHIP_REV_1_2	},
+	{ .srev = 0x28, .name = "i.MX31",    .v = "2.0",  .rev = CHIP_REV_2_0	},
+	{ .srev = 0x29, .name = "i.MX31L",   .v = "2.0",  .rev = CHIP_REV_2_0	},
+};
+
+void __init mx31_read_cpu_rev(void)
+{
+	u32 i, srev;
+
+	/* read SREV register from IIM module */
+	srev = __raw_readl(IO_ADDRESS(IIM_BASE_ADDR) + MXC_IIMSREV);
+
+	for (i = 0; i < ARRAY_SIZE(mx31_cpu_type); i++)
+		if (srev == mx31_cpu_type[i].srev) {
+			printk(KERN_INFO
+				"CPU identified as %s, silicon rev %s\n",
+				mx31_cpu_type[i].name, mx31_cpu_type[i].v);
+
+			mx31_cpu_rev = mx31_cpu_type[i].rev;
+			return;
+		}
+
+	printk(KERN_WARNING "Unknown CPU identifier. srev = %02x\n", srev);
+}
diff --git a/arch/arm/plat-mxc/include/mach/mx3x.h b/arch/arm/plat-mxc/include/mach/mx3x.h
index 009f444..d9613d6 100644
--- a/arch/arm/plat-mxc/include/mach/mx3x.h
+++ b/arch/arm/plat-mxc/include/mach/mx3x.h
@@ -263,11 +263,12 @@
 
 #if !defined(__ASSEMBLY__) && !defined(__MXC_BOOT_UNCOMPRESS)
 
-extern unsigned int system_rev;
+extern unsigned int mx31_cpu_rev;
+extern void mx31_read_cpu_rev(void);
 
 static inline int mx31_revision(void)
 {
-	return system_rev;
+	return mx31_cpu_rev;
 }
 #endif
 
-- 
1.6.5.2
