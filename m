From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 28 Dec 2012 13:47:24 +0100
Subject: [PATCH] cpuidle: kirkwood: Move out of mach directory, add DT.
Message-ID: <1356698844-4220-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the Kirkwood cpuidle driver out of arch/arm/mach-kirkwood and
into drivers/cpuidle. Convert the driver into a platform driver and
add a device tree binding. Add a DT node to instantiate the driver for
boards converted to DT, and a platform data for old style boards.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 .../devicetree/bindings/power/qnap-poweroff.txt    |   14 +++
 arch/arm/boot/dts/kirkwood.dtsi                    |    5 +
 arch/arm/configs/kirkwood_defconfig                |    1 +
 arch/arm/mach-kirkwood/Makefile                    |    1 -
 arch/arm/mach-kirkwood/common.c                    |   23 ++++
 arch/arm/mach-kirkwood/cpuidle.c                   |   73 -------------
 arch/arm/mach-kirkwood/include/mach/kirkwood.h     |    3 +-
 drivers/cpuidle/Kconfig                            |    6 ++
 drivers/cpuidle/Makefile                           |    1 +
 drivers/cpuidle/cpuidle-kirkwood.c                 |  114 ++++++++++++++++++++
 10 files changed, 166 insertions(+), 75 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/qnap-poweroff.txt
 delete mode 100644 arch/arm/mach-kirkwood/cpuidle.c
 create mode 100644 drivers/cpuidle/cpuidle-kirkwood.c

diff --git a/Documentation/devicetree/bindings/power/qnap-poweroff.txt b/Documentation/devicetree/bindings/power/qnap-poweroff.txt
new file mode 100644
index 0000000..e15a334
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/qnap-poweroff.txt
@@ -0,0 +1,14 @@
+* QNAP Power Off
+
+QNAP NAS devices have a microcontroller controlling the main power
+supply. This microcontroller is connected to UART1 of the Kirkwood and
+Orion5x SoCs. Sending the charactor 'A', at 19200 baud, tells the
+microcontroller to turn the power off. This driver adds a handler to
+pm_power_off which is called to turn the power off.
+
+Required Properties:
+- compatibile: Should be "qnap,power-off"
+
+- reg: Address and length of the register set for UART1
+- clocks: tclk clock
+
diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index 7735cee..ca99aa2 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -23,6 +23,11 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 
+		cpuidle at 1418 {
+			compatible = "marvell,kirkwood-cpuidle";
+			reg = <0x1418 0x4>;
+		};
+
 		core_clk: core-clocks at 10030 {
 			compatible = "marvell,kirkwood-core-clock";
 			reg = <0x10030 0x4>;
diff --git a/arch/arm/configs/kirkwood_defconfig b/arch/arm/configs/kirkwood_defconfig
index 93f3794..13482ea 100644
--- a/arch/arm/configs/kirkwood_defconfig
+++ b/arch/arm/configs/kirkwood_defconfig
@@ -56,6 +56,7 @@ CONFIG_AEABI=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CPU_IDLE=y
+CONFIG_CPU_IDLE_KIRKWOOD=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
diff --git a/arch/arm/mach-kirkwood/Makefile b/arch/arm/mach-kirkwood/Makefile
index 8d2e5a9..d665309 100644
--- a/arch/arm/mach-kirkwood/Makefile
+++ b/arch/arm/mach-kirkwood/Makefile
@@ -19,7 +19,6 @@ obj-$(CONFIG_MACH_NET2BIG_V2)		+= netxbig_v2-setup.o lacie_v2-common.o
 obj-$(CONFIG_MACH_NET5BIG_V2)		+= netxbig_v2-setup.o lacie_v2-common.o
 obj-$(CONFIG_MACH_T5325)		+= t5325-setup.o
 
-obj-$(CONFIG_CPU_IDLE)			+= cpuidle.o
 obj-$(CONFIG_ARCH_KIRKWOOD_DT)		+= board-dt.o
 obj-$(CONFIG_MACH_DREAMPLUG_DT)		+= board-dreamplug.o
 obj-$(CONFIG_MACH_ICONNECT_DT)		+= board-iconnect.o
diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
index bac21a5..e8a2978 100644
--- a/arch/arm/mach-kirkwood/common.c
+++ b/arch/arm/mach-kirkwood/common.c
@@ -499,6 +499,28 @@ void __init kirkwood_wdt_init(void)
 	orion_wdt_init();
 }
 
+/*****************************************************************************
+ * CPU idle
+ ****************************************************************************/
+static struct resource kirkwood_cpuidle_resource[] = {
+	{
+		.flags	= IORESOURCE_MEM,
+		.start	= DDR_OPERATION_BASE,
+		.end	= 3,
+	},
+};
+
+static struct platform_device kirkwood_cpuidle = {
+	.name		= "kirkwood_cpuidle",
+	.id		= -1,
+	.resource	= kirkwood_cpuidle_resource,
+	.num_resources	= 1,
+};
+
+static void __init kirkwood_cpuidle_init(void)
+{
+	platform_device_register(&kirkwood_cpuidle);
+}
 
 /*****************************************************************************
  * Time handling
@@ -671,6 +693,7 @@ void __init kirkwood_init(void)
 	kirkwood_xor1_init();
 	kirkwood_crypto_init();
 
+	kirkwood_cpuidle_init();
 #ifdef CONFIG_KEXEC
 	kexec_reinit = kirkwood_enable_pcie;
 #endif
diff --git a/arch/arm/mach-kirkwood/cpuidle.c b/arch/arm/mach-kirkwood/cpuidle.c
deleted file mode 100644
index f730467..0000000
--- a/arch/arm/mach-kirkwood/cpuidle.c
+++ /dev/null
@@ -1,73 +0,0 @@
-/*
- * arch/arm/mach-kirkwood/cpuidle.c
- *
- * CPU idle Marvell Kirkwood SoCs
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- *
- * The cpu idle uses wait-for-interrupt and DDR self refresh in order
- * to implement two idle states -
- * #1 wait-for-interrupt
- * #2 wait-for-interrupt and DDR self refresh
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/cpuidle.h>
-#include <linux/io.h>
-#include <linux/export.h>
-#include <asm/proc-fns.h>
-#include <asm/cpuidle.h>
-#include <mach/kirkwood.h>
-
-#define KIRKWOOD_MAX_STATES	2
-
-/* Actual code that puts the SoC in different idle states */
-static int kirkwood_enter_idle(struct cpuidle_device *dev,
-				struct cpuidle_driver *drv,
-			       int index)
-{
-	writel(0x7, DDR_OPERATION_BASE);
-	cpu_do_idle();
-
-	return index;
-}
-
-static struct cpuidle_driver kirkwood_idle_driver = {
-	.name			= "kirkwood_idle",
-	.owner			= THIS_MODULE,
-	.en_core_tk_irqen	= 1,
-	.states[0]		= ARM_CPUIDLE_WFI_STATE,
-	.states[1]		= {
-		.enter			= kirkwood_enter_idle,
-		.exit_latency		= 10,
-		.target_residency	= 100000,
-		.flags			= CPUIDLE_FLAG_TIME_VALID,
-		.name			= "DDR SR",
-		.desc			= "WFI and DDR Self Refresh",
-	},
-	.state_count = KIRKWOOD_MAX_STATES,
-};
-
-static DEFINE_PER_CPU(struct cpuidle_device, kirkwood_cpuidle_device);
-
-/* Initialize CPU idle by registering the idle states */
-static int kirkwood_init_cpuidle(void)
-{
-	struct cpuidle_device *device;
-
-	device = &per_cpu(kirkwood_cpuidle_device, smp_processor_id());
-	device->state_count = KIRKWOOD_MAX_STATES;
-
-	cpuidle_register_driver(&kirkwood_idle_driver);
-	if (cpuidle_register_device(device)) {
-		pr_err("kirkwood_init_cpuidle: Failed registering\n");
-		return -EIO;
-	}
-	return 0;
-}
-
-device_initcall(kirkwood_init_cpuidle);
diff --git a/arch/arm/mach-kirkwood/include/mach/kirkwood.h b/arch/arm/mach-kirkwood/include/mach/kirkwood.h
index 041653a..a05563a 100644
--- a/arch/arm/mach-kirkwood/include/mach/kirkwood.h
+++ b/arch/arm/mach-kirkwood/include/mach/kirkwood.h
@@ -60,8 +60,9 @@
  * Register Map
  */
 #define DDR_VIRT_BASE		(KIRKWOOD_REGS_VIRT_BASE + 0x00000)
+#define DDR_PHYS_BASE		(KIRKWOOD_REGS_PHYS_BASE + 0x00000)
 #define  DDR_WINDOW_CPU_BASE	(DDR_VIRT_BASE + 0x1500)
-#define DDR_OPERATION_BASE	(DDR_VIRT_BASE + 0x1418)
+#define DDR_OPERATION_BASE	(DDR_PHYS_BASE + 0x1418)
 
 #define DEV_BUS_PHYS_BASE	(KIRKWOOD_REGS_PHYS_BASE + 0x10000)
 #define DEV_BUS_VIRT_BASE	(KIRKWOOD_REGS_VIRT_BASE + 0x10000)
diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
index c4cc27e..071e2c3 100644
--- a/drivers/cpuidle/Kconfig
+++ b/drivers/cpuidle/Kconfig
@@ -39,4 +39,10 @@ config CPU_IDLE_CALXEDA
 	help
 	  Select this to enable cpuidle on Calxeda processors.
 
+config CPU_IDLE_KIRKWOOD
+	bool "CPU Idle Driver for Kirkwood processors"
+	depends on ARCH_KIRKWOOD
+	help
+	  Select this to enable cpuidle on Kirkwood processors.
+
 endif
diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
index 03ee874..24c6e7d 100644
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@ -6,3 +6,4 @@ obj-y += cpuidle.o driver.o governor.o sysfs.o governors/
 obj-$(CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED) += coupled.o
 
 obj-$(CONFIG_CPU_IDLE_CALXEDA) += cpuidle-calxeda.o
+obj-$(CONFIG_CPU_IDLE_KIRKWOOD) += cpuidle-kirkwood.o
diff --git a/drivers/cpuidle/cpuidle-kirkwood.c b/drivers/cpuidle/cpuidle-kirkwood.c
new file mode 100644
index 0000000..2d9d5b3
--- /dev/null
+++ b/drivers/cpuidle/cpuidle-kirkwood.c
@@ -0,0 +1,114 @@
+/*
+ * arch/arm/mach-kirkwood/cpuidle.c
+ *
+ * CPU idle Marvell Kirkwood SoCs
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ *
+ * The cpu idle uses wait-for-interrupt and DDR self refresh in order
+ * to implement two idle states -
+ * #1 wait-for-interrupt
+ * #2 wait-for-interrupt and DDR self refresh
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/cpuidle.h>
+#include <linux/io.h>
+#include <linux/export.h>
+#include <linux/of.h>
+#include <asm/proc-fns.h>
+#include <asm/cpuidle.h>
+
+#define KIRKWOOD_MAX_STATES	2
+
+static void __iomem *ddr_operation_base;
+
+/* Actual code that puts the SoC in different idle states */
+static int kirkwood_enter_idle(struct cpuidle_device *dev,
+			       struct cpuidle_driver *drv,
+			       int index)
+{
+	writel(0x7, ddr_operation_base);
+	cpu_do_idle();
+
+	return index;
+}
+
+static struct cpuidle_driver kirkwood_idle_driver = {
+	.name			= "kirkwood_idle",
+	.owner			= THIS_MODULE,
+	.en_core_tk_irqen	= 1,
+	.states[0]		= ARM_CPUIDLE_WFI_STATE,
+	.states[1]		= {
+		.enter			= kirkwood_enter_idle,
+		.exit_latency		= 10,
+		.target_residency	= 100000,
+		.flags			= CPUIDLE_FLAG_TIME_VALID,
+		.name			= "DDR SR",
+		.desc			= "WFI and DDR Self Refresh",
+	},
+	.state_count = KIRKWOOD_MAX_STATES,
+};
+static struct cpuidle_device *device;
+
+static DEFINE_PER_CPU(struct cpuidle_device, kirkwood_cpuidle_device);
+
+/* Initialize CPU idle by registering the idle states */
+static int kirkwood_cpuidle_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res == NULL)
+		return -EINVAL;
+
+	ddr_operation_base = devm_ioremap(&pdev->dev, res->start,
+					  resource_size(res));
+	if (ddr_operation_base == NULL)
+		return -EINVAL;
+
+	device = &per_cpu(kirkwood_cpuidle_device, smp_processor_id());
+	device->state_count = KIRKWOOD_MAX_STATES;
+
+	cpuidle_register_driver(&kirkwood_idle_driver);
+	if (cpuidle_register_device(device)) {
+		pr_err("kirkwood_init_cpuidle: Failed registering\n");
+		return -EIO;
+	}
+	return 0;
+}
+
+int kirkwood_cpuidle_remove(struct platform_device *pdev)
+{
+	cpuidle_unregister_device(device);
+	cpuidle_unregister_driver(&kirkwood_idle_driver);
+
+	return 0;
+}
+
+static const struct of_device_id of_kirkwood_cpuidle_match[] = {
+	{ .compatible = "marvell,kirkwood-cpuidle", },
+	{},
+};
+
+static struct platform_driver kirkwood_cpuidle_driver = {
+	.probe = kirkwood_cpuidle_probe,
+	.remove = __devexit_p(kirkwood_cpuidle_remove),
+	.driver = {
+		   .name = "kirkwood_cpuidle",
+		   .owner = THIS_MODULE,
+		   .of_match_table = of_kirkwood_cpuidle_match,
+		   },
+};
+
+module_platform_driver(kirkwood_cpuidle_driver);
+
+MODULE_AUTHOR("Andrew Lunn <andrew@lunn.ch>");
+MODULE_DESCRIPTION("Kirkwood cpu idle driver");
+MODULE_LICENSE("GPLv2");
+MODULE_ALIAS("platform:kirkwood-cpuidle");
-- 
1.7.10.4
