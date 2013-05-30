From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 30 May 2013 17:52:30 +0900
Subject: [PATCH 04/05] ARM: shmobile: r8a73a4 SMP CA7 prototype (+ CA7 x 4)
In-Reply-To: <20130530085152.24374.64208.sendpatchset@w520>
References: <20130530085152.24374.64208.sendpatchset@w520>
Message-ID: <20130530085230.24374.41041.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Prototype code to enable 4 x CA7 found in r8a73a4.

To test on APE6EVM boot with maxcpus=4 and use CPU Hotplug
for boot and shut down. Not ready for merge.

Not-yet-Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/boot/dts/r8a73a4.dtsi       |   28 ++++++++++++++++++++++++++
 arch/arm/mach-shmobile/smp-r8a73a4.c |   36 +++++++++++++++++++++++++++++-----
 2 files changed, 59 insertions(+), 5 deletions(-)

--- 0002/arch/arm/boot/dts/r8a73a4.dtsi
+++ work/arch/arm/boot/dts/r8a73a4.dtsi	2013-05-30 16:13:11.000000000 +0900
@@ -46,6 +46,34 @@
 			reg = <3>;
 			clock-frequency = <1500000000>;
 		};
+
+		cpu4: cpu at 4 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x100>;
+			clock-frequency = <1000000000>; 
+		};
+
+		cpu5: cpu at 5 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x101>;
+			clock-frequency = <1000000000>; 
+		};
+
+		cpu6: cpu at 6 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x102>;
+			clock-frequency = <1000000000>; 
+		};
+
+		cpu7: cpu at 7 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x103>;
+			clock-frequency = <1000000000>; 
+		};
 	};
 
 	gic: interrupt-controller at f1001000 {
--- 0004/arch/arm/mach-shmobile/smp-r8a73a4.c
+++ work/arch/arm/mach-shmobile/smp-r8a73a4.c	2013-05-30 16:18:40.000000000 +0900
@@ -31,17 +31,22 @@
 #include <asm/smp_plat.h>
 
 #define SYSC	0xe6180000
+#define CA7BAR	0x4020
 #define CA15BAR	0x6020
 #define RESCNT	0x801c
 
 #define APMU	0xe6150000
+#define CA7WUPCR 0x1010
 #define CA15WUPCR 0x2010
+#define CA7PSTR	0x1040
 #define CA15PSTR 0x2040
+#define CA7CPUNCR(n) (0x1100 + (0x10 * (n))) 
 #define CA15CPUNCR(n) (0x2100 + (0x10 * (n))) 
 
 #define MERAM	0xe8080000
 #define CCI_BASE	0xf0190000
 #define CCI_SLAVE3	0x4000
+#define CCI_SLAVE4	0x5000
 #define CCI_SNOOP	0x0000
 #define CCI_STATUS	0x000c
 
@@ -75,13 +80,16 @@ static void __init r8a73a4_smp_prepare_c
 	p = ioremap_nocache(SYSC, 0x9000);
 	bar = (MERAM >> 8) & 0xfffffc00;
 	__raw_writel(bar, p + CA15BAR);
+	__raw_writel(bar, p + CA7BAR);
 	__raw_writel(bar | 0x10, p + CA15BAR);
+	__raw_writel(bar | 0x10, p + CA7BAR);
 	__raw_writel(__raw_readl(p + RESCNT) & ~(1 << 10), p + RESCNT);
 	iounmap(p);
 
 	/* enable snoop and DVM */
 	p = ioremap_nocache(CCI_BASE, 0x8000);
 	__raw_writel(3, p + CCI_SLAVE3 + CCI_SNOOP);	/* ca15 */
+	__raw_writel(3, p + CCI_SLAVE4 + CCI_SNOOP);	/* ca7 */
 	while (__raw_readl(p + CCI_STATUS))
 		/* wait for pending bit low */;
 	iounmap(p);
@@ -92,10 +100,14 @@ static void __init r8a73a4_smp_prepare_c
 static int __cpuinit r8a73a4_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	void __iomem *p;
+	int cluster_cpu = cpu_logical_map(cpu) & 3;
 
 	/* wake up CPU core */
 	p = ioremap_nocache(APMU, 0x3000);
-	__raw_writel(1 << (cpu_logical_map(cpu) & 3), p + CA15WUPCR);
+	if (cpu_logical_map(cpu) < 4) 
+		__raw_writel(1 << cluster_cpu, p + CA15WUPCR);
+	else
+		__raw_writel(1 << cluster_cpu, p + CA7WUPCR);
 	iounmap(p);
 
 	return 0;
@@ -112,6 +124,7 @@ static void __cpuinit r8a73a4_secondary_
 static int r8a73a4_cpu_kill(unsigned int cpu)
 {
 	void __iomem *p;
+	int offs;
 	int ret = 0;
 	int k;
 
@@ -120,9 +133,18 @@ static int r8a73a4_cpu_kill(unsigned int
 	 */
 	p = ioremap_nocache(APMU, 0x3000);
 	for (k = 0; k < 1000; k++) {
-		if (((__raw_readl(p + CA15PSTR) >> (cpu * 4)) & 0x03) == 3) {
-			ret = 1;
-			break;
+		if (cpu < 4) { /* CA15 Core Standby */
+			offs = cpu * 4;
+			if (((__raw_readl(p + CA15PSTR) >> offs) & 0x03) == 3) {
+				ret = 1;
+				break;
+			}
+		} else { /* CA7 Core Standby */
+			offs = (cpu - 4) * 4;
+			if (((__raw_readl(p + CA7PSTR) >> offs) & 0x03) == 3) {
+				ret = 1;
+				break;
+			}
 		}
 
 		mdelay(1);
@@ -176,7 +198,11 @@ static void r8a73a4_cpu_die(unsigned int
 
 	/* select CPU shutdown mode */
 	p = ioremap_nocache(APMU, 0x3000);
-	__raw_writel(3, p + CA15CPUNCR(cpu)); /* CA15 Core Standby */
+	if (cpu < 4)
+		__raw_writel(3, p + CA15CPUNCR(cpu)); /* CA15 Core Standby */
+	else
+		__raw_writel(3, p + CA7CPUNCR(cpu - 4)); /* CA7 Core Standby */
+
 	iounmap(p);
 
 	cpu_enter_lowpower_a15();
