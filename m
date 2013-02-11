From: dinguyen@altera.com (dinguyen at altera.com)
Date: Mon, 11 Feb 2013 17:30:33 -0600
Subject: [PATCHv5 for soc 4/4] arm: socfpga: Add SMP support for actual
 socfpga harware
In-Reply-To: <1360625433-28067-1-git-send-email-dinguyen@altera.com>
References: <1360625433-28067-1-git-send-email-dinguyen@altera.com>
Message-ID: <1360625433-28067-5-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

Because the CPU1 start address is different for socfpga-vt and
socfpga-cyclone5, we add code to use the correct CPU1 start addr.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
Signed-off-by: Pavel Machek <pavel@denx.de>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
---
 .../bindings/arm/altera/socfpga-system.txt         |    2 ++
 arch/arm/boot/dts/socfpga_cyclone5.dts             |    4 ++++
 arch/arm/boot/dts/socfpga_vt.dts                   |    4 ++++
 arch/arm/mach-socfpga/core.h                       |    4 +++-
 arch/arm/mach-socfpga/headsmp.S                    |   16 ++++++++++++----
 arch/arm/mach-socfpga/platsmp.c                    |   17 ++++++++++-------
 arch/arm/mach-socfpga/socfpga.c                    |    6 ++++++
 7 files changed, 41 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/altera/socfpga-system.txt b/Documentation/devicetree/bindings/arm/altera/socfpga-system.txt
index 07c65e3..f4d04a0 100644
--- a/Documentation/devicetree/bindings/arm/altera/socfpga-system.txt
+++ b/Documentation/devicetree/bindings/arm/altera/socfpga-system.txt
@@ -3,9 +3,11 @@ Altera SOCFPGA System Manager
 Required properties:
 - compatible : "altr,sys-mgr"
 - reg : Should contain 1 register ranges(address and length)
+- cpu1-start-addr : CPU1 start address in hex.
 
 Example:
 	 sysmgr at ffd08000 {
 		compatible = "altr,sys-mgr";
 		reg = <0xffd08000 0x1000>;
+		cpu1-start-addr = <0xffd080c4>;
 	};
diff --git a/arch/arm/boot/dts/socfpga_cyclone5.dts b/arch/arm/boot/dts/socfpga_cyclone5.dts
index 7ad3cc6..3ae8a83 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5.dts
@@ -56,5 +56,9 @@
 		serial1 at ffc03000 {
 			clock-frequency = <100000000>;
 		};
+
+		sysmgr at ffd08000 {
+			cpu1-start-addr = <0xffd080c4>;
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/socfpga_vt.dts b/arch/arm/boot/dts/socfpga_vt.dts
index a0c6c65..1036eba 100644
--- a/arch/arm/boot/dts/socfpga_vt.dts
+++ b/arch/arm/boot/dts/socfpga_vt.dts
@@ -56,5 +56,9 @@
 		serial1 at ffc03000 {
 			clock-frequency = <7372800>;
 		};
+
+		sysmgr at ffd08000 {
+			cpu1-start-addr = <0xffd08010>;
+		};
 	};
 };
diff --git a/arch/arm/mach-socfpga/core.h b/arch/arm/mach-socfpga/core.h
index 9941caa..315edff 100644
--- a/arch/arm/mach-socfpga/core.h
+++ b/arch/arm/mach-socfpga/core.h
@@ -20,7 +20,7 @@
 #ifndef __MACH_CORE_H
 #define __MACH_CORE_H
 
-extern void secondary_startup(void);
+extern void socfpga_secondary_startup(void);
 extern void __iomem *socfpga_scu_base_addr;
 
 extern void socfpga_init_clocks(void);
@@ -29,6 +29,8 @@ extern void socfpga_sysmgr_init(void);
 extern struct smp_operations socfpga_smp_ops;
 extern char secondary_trampoline, secondary_trampoline_end;
 
+extern unsigned long cpu1start_addr;
+
 #define SOCFPGA_SCU_VIRT_BASE   0xfffec000
 
 #endif
diff --git a/arch/arm/mach-socfpga/headsmp.S b/arch/arm/mach-socfpga/headsmp.S
index f09b128..9004bfb 100644
--- a/arch/arm/mach-socfpga/headsmp.S
+++ b/arch/arm/mach-socfpga/headsmp.S
@@ -13,13 +13,21 @@
 	__CPUINIT
 	.arch	armv7-a
 
-#define CPU1_START_ADDR 	        0xffd08010
-
 ENTRY(secondary_trampoline)
-	movw	r0, #:lower16:CPU1_START_ADDR
-	movt  r0, #:upper16:CPU1_START_ADDR
+	movw	r2, #:lower16:cpu1start_addr
+	movt  r2, #:upper16:cpu1start_addr
+
+	/* The socfpga VT cannot handle a 0xC0000000 page offset when loading
+		the cpu1start_addr, we bit clear it. Tested on HW and VT. */
+	bic	r2, r2, #0x40000000
 
+	ldr	r0, [r2]
 	ldr	r1, [r0]
 	bx	r1
 
 ENTRY(secondary_trampoline_end)
+
+ENTRY(socfpga_secondary_startup)
+       bl      v7_invalidate_l1
+       b       secondary_startup
+ENDPROC(socfpga_secondary_startup)
diff --git a/arch/arm/mach-socfpga/platsmp.c b/arch/arm/mach-socfpga/platsmp.c
index 68dd1b6..2481968 100644
--- a/arch/arm/mach-socfpga/platsmp.c
+++ b/arch/arm/mach-socfpga/platsmp.c
@@ -47,16 +47,19 @@ static int __cpuinit socfpga_boot_secondary(unsigned int cpu, struct task_struct
 {
 	int trampoline_size = &secondary_trampoline_end - &secondary_trampoline;
 
-	memcpy(phys_to_virt(0), &secondary_trampoline, trampoline_size);
+	if (cpu1start_addr) {
+		memcpy(phys_to_virt(0), &secondary_trampoline, trampoline_size);
 
-	__raw_writel(virt_to_phys(secondary_startup), (sys_manager_base_addr+0x10));
+		__raw_writel(virt_to_phys(socfpga_secondary_startup),
+			(sys_manager_base_addr + (cpu1start_addr & 0x000000ff)));
 
-	flush_cache_all();
-	smp_wmb();
-	outer_clean_range(0, trampoline_size);
+		flush_cache_all();
+		smp_wmb();
+		outer_clean_range(0, trampoline_size);
 
-	/* This will release CPU #1 out of reset.*/
-	__raw_writel(0, rst_manager_base_addr + 0x10);
+		/* This will release CPU #1 out of reset.*/
+		__raw_writel(0, rst_manager_base_addr + 0x10);
+	}
 
 	return 0;
 }
diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-socfpga/socfpga.c
index 94aa6ad..cec1266 100644
--- a/arch/arm/mach-socfpga/socfpga.c
+++ b/arch/arm/mach-socfpga/socfpga.c
@@ -29,6 +29,7 @@
 void __iomem *socfpga_scu_base_addr = ((void __iomem *)(SOCFPGA_SCU_VIRT_BASE));
 void __iomem *sys_manager_base_addr;
 void __iomem *rst_manager_base_addr;
+unsigned long cpu1start_addr;
 
 static struct map_desc scu_io_desc __initdata = {
 	.virtual	= SOCFPGA_SCU_VIRT_BASE,
@@ -72,6 +73,11 @@ void __init socfpga_sysmgr_init(void)
 	struct device_node *np;
 
 	np = of_find_compatible_node(NULL, NULL, "altr,sys-mgr");
+
+	if (of_property_read_u32(np, "cpu1-start-addr",
+			(u32 *) &cpu1start_addr))
+		pr_err("SMP: Need cpu1-start-addr in device tree.\n");
+
 	sys_manager_base_addr = of_iomap(np, 0);
 
 	np = of_find_compatible_node(NULL, NULL, "altr,rst-mgr");
-- 
1.7.9.5
