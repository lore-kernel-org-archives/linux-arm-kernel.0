From: chris.packham@alliedtelesis.co.nz (Chris Packham)
Date: Fri, 13 Jan 2017 22:12:15 +1300
Subject: [PATCHv4 0/5] Support for Marvell switches with integrated CPUs
Message-ID: <20170113091222.7132-1-chris.packham@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 98DX3236, 98DX3336 and 98DX4251 are a set of switch ASICs with
integrated CPUs. They CPU block is common within these product lines and
(as far as I can tell/have been told) is based on the Armada XP. There
are a few differences due to the fact they have to squeeze the CPU into
the same package as the switch.

This series is starting to settle down now. The only major change is in
"arm: mvebu: support for SMP on 98DX3336 SoC" the other changes are
generally cosmetic or collecting acks.

Chris Packham (4):
  clk: mvebu: support for 98DX3236 SoC
    Changes in v2:
    - Update devicetree binding documentation for new compatible string
    Changes in v3:
    - Add 98dx3236 support to mvebu/clk-corediv.c rather than creating a new
      driver.
    - Document mv98dx3236-corediv-clock binding
    Changes in v4:
    - None
  arm: mvebu: support for SMP on 98DX3336 SoC
    Changes in v2:
    - Document new enable-method value
    - Correct some references from 98DX4521 to 98DX3236
    Changes in v3:
    - Simplify mv98dx3236_resume_init by using of_io_request_and_map()
    Changes in v4:
    - integrate changes into platsmp.c instead of new init call
    - avoid duplicated code.
    - fix error return
    - Collect ack from Rob
  arm: mvebu: Add device tree for 98DX3236 SoCs
    Changes in v2:
    - Update devicetree binding documentation to reflect that 98DX3336 and
      984251 are supersets of 98DX3236.
    - disable crypto block
    - disable sdio for 98DX3236, enable for 98DX4251
    Changes in v3:
    - fix typo 4521 -> 4251
    - document prestera bindings
    - rework corediv-clock binding
    - add label to packet processor node
    - add new compatible string for DFX server
    Changes in v4:
    - Collect ack from Rob
  arm: mvebu: Add device tree for db-dxbc2 and db-xc3-24g4xg boards

Kalyan Kinthada (1):
  pinctrl: mvebu: pinctrl driver for 98DX3236 SoC
    Changes in v2:
    - include sdio support for the 98DX4251
    Changes in v3:
    - None
    Changes in v4:
    - Correct some discrepencies between binding and driver.
    - Collect acks from Rob and Sebastian
    
 Documentation/devicetree/bindings/arm/cpus.txt     |   1 +
 .../bindings/arm/marvell/98dx3236-resume-ctrl.txt  |  18 ++
 .../devicetree/bindings/arm/marvell/98dx3236.txt   |  23 ++
 .../bindings/clock/mvebu-corediv-clock.txt         |   1 +
 .../devicetree/bindings/clock/mvebu-cpu-clock.txt  |   1 +
 .../devicetree/bindings/net/marvell,prestera.txt   |  50 ++++
 .../pinctrl/marvell,armada-98dx3236-pinctrl.txt    |  46 ++++
 arch/arm/boot/dts/armada-xp-98dx3236.dtsi          | 254 +++++++++++++++++++++
 arch/arm/boot/dts/armada-xp-98dx3336.dtsi          |  76 ++++++
 arch/arm/boot/dts/armada-xp-98dx4251.dtsi          |  90 ++++++++
 arch/arm/boot/dts/db-dxbc2.dts                     | 159 +++++++++++++
 arch/arm/boot/dts/db-xc3-24g4xg.dts                | 155 +++++++++++++
 arch/arm/mach-mvebu/platsmp.c                      |  86 +++++++
 drivers/clk/mvebu/armada-xp.c                      |  42 ++++
 drivers/clk/mvebu/clk-corediv.c                    |  23 ++
 drivers/clk/mvebu/clk-cpu.c                        |  31 ++-
 drivers/pinctrl/mvebu/pinctrl-armada-xp.c          | 156 +++++++++++++
 17 files changed, 1210 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/marvell/98dx3236-resume-ctrl.txt
 create mode 100644 Documentation/devicetree/bindings/arm/marvell/98dx3236.txt
 create mode 100644 Documentation/devicetree/bindings/net/marvell,prestera.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/marvell,armada-98dx3236-pinctrl.txt
 create mode 100644 arch/arm/boot/dts/armada-xp-98dx3236.dtsi
 create mode 100644 arch/arm/boot/dts/armada-xp-98dx3336.dtsi
 create mode 100644 arch/arm/boot/dts/armada-xp-98dx4251.dtsi
 create mode 100644 arch/arm/boot/dts/db-dxbc2.dts
 create mode 100644 arch/arm/boot/dts/db-xc3-24g4xg.dts

inter-diff to v3:

diff --git a/Documentation/devicetree/bindings/pinctrl/marvell,armada-98dx3236-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/marvell,armada-98dx3236-pinctrl.txt
index d4e6ecdfc853..b5bd23992fdf 100644
--- a/Documentation/devicetree/bindings/pinctrl/marvell,armada-98dx3236-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/marvell,armada-98dx3236-pinctrl.txt
@@ -28,10 +28,10 @@ mpp13         13       gpio, intr(out), dev(ad15)
 mpp14         14       gpio, i2c0(sck)
 mpp15         15       gpio, i2c0(sda)
 mpp16         16       gpio, dev(oe)
-mpp17         17       gpio, dev(clk)
+mpp17         17       gpio, dev(clkout)
 mpp18         18       gpio, uart1(txd)
 mpp19         19       gpio, uart1(rxd), dev(rb)
-mpp20         20       gpio, dev(we)
+mpp20         20       gpio, dev(we0)
 mpp21         21       gpio, dev(ad0)
 mpp22         22       gpio, dev(ad1)
 mpp23         23       gpio, dev(ad2)
diff --git a/arch/arm/mach-mvebu/Makefile b/arch/arm/mach-mvebu/Makefile
index 2a2dd8324fb8..6c6497e80a7b 100644
--- a/arch/arm/mach-mvebu/Makefile
+++ b/arch/arm/mach-mvebu/Makefile
@@ -7,7 +7,6 @@ obj-$(CONFIG_MACH_MVEBU_ANY)	 += system-controller.o mvebu-soc-id.o
 
 ifeq ($(CONFIG_MACH_MVEBU_V7),y)
 obj-y				 += cpu-reset.o board-v7.o coherency.o coherency_ll.o pmsu.o pmsu_ll.o
-obj-y				 += pmsu-98dx3236.o
 
 obj-$(CONFIG_PM)		 += pm.o pm-board.o
 obj-$(CONFIG_SMP)		 += platsmp.o headsmp.o platsmp-a9.o headsmp-a9.o
diff --git a/arch/arm/mach-mvebu/common.h b/arch/arm/mach-mvebu/common.h
index 099dabf23461..6b775492cfad 100644
--- a/arch/arm/mach-mvebu/common.h
+++ b/arch/arm/mach-mvebu/common.h
@@ -27,5 +27,4 @@ void __iomem *mvebu_get_scu_base(void);
 
 int mvebu_pm_suspend_init(void (*board_pm_enter)(void __iomem *sdram_reg,
 							u32 srcmd));
-void mv98dx3236_resume_set_cpu_boot_addr(int hw_cpu, void *boot_addr);
 #endif
diff --git a/arch/arm/mach-mvebu/platsmp.c b/arch/arm/mach-mvebu/platsmp.c
index 3c9ab9a008ad..59be3ca0464f 100644
--- a/arch/arm/mach-mvebu/platsmp.c
+++ b/arch/arm/mach-mvebu/platsmp.c
@@ -182,12 +182,57 @@ const struct smp_operations armada_xp_smp_ops __initconst = {
 #endif
 };
 
+CPU_METHOD_OF_DECLARE(armada_xp_smp, "marvell,armada-xp-smp",
+		      &armada_xp_smp_ops);
+
+struct resume_controller {
+	u32 resume_control;
+	u32 resume_boot_addr;
+};
+
+static const struct resume_controller mv98dx3336_resume_controller = {
+	.resume_control = 0x08,
+	.resume_boot_addr = 0x04,
+};
+
+static const struct of_device_id of_mv98dx3236_resume_table[] = {
+	{
+		.compatible = "marvell,98dx3336-resume-ctrl",
+		.data = (void *)&mv98dx3336_resume_controller,
+	},
+	{ /* end of list */ },
+};
+
+static int mv98dx3236_resume_set_cpu_boot_addr(int hw_cpu, void *boot_addr)
+{
+	const struct of_device_id *match;
+	struct device_node *np;
+	void __iomem *base;
+	struct resume_controller *rc;
+
+	WARN_ON(hw_cpu != 1);
+
+	np = of_find_matching_node_and_match(NULL, of_mv98dx3236_resume_table,
+					     &match);
+	if (!np)
+		return -ENODEV;
+
+	base = of_io_request_and_map(np, 0, of_node_full_name(np));
+	rc = (struct resume_controller *)match->data;
+	of_node_put(np);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	writel(0, base + rc->resume_control);
+	writel(virt_to_phys(boot_addr), base + rc->resume_boot_addr);
+
+	return 0;
+}
+
 static int mv98dx3236_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	int ret, hw_cpu;
 
-	pr_info("Booting CPU %d\n", cpu);
-
 	hw_cpu = cpu_logical_map(cpu);
 	set_secondary_cpu_clock(hw_cpu);
 	mv98dx3236_resume_set_cpu_boot_addr(hw_cpu,
@@ -212,7 +257,7 @@ static int mv98dx3236_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	return 0;
 }
 
-struct smp_operations mv98dx3236_smp_ops __initdata = {
+static const struct smp_operations mv98dx3236_smp_ops __initconst = {
 	.smp_init_cpus		= armada_xp_smp_init_cpus,
 	.smp_prepare_cpus	= armada_xp_smp_prepare_cpus,
 	.smp_boot_secondary	= mv98dx3236_boot_secondary,
@@ -223,7 +268,5 @@ struct smp_operations mv98dx3236_smp_ops __initdata = {
 #endif
 };
 
-CPU_METHOD_OF_DECLARE(armada_xp_smp, "marvell,armada-xp-smp",
-		      &armada_xp_smp_ops);
 CPU_METHOD_OF_DECLARE(mv98dx3236_smp, "marvell,98dx3236-smp",
 		      &mv98dx3236_smp_ops);
diff --git a/arch/arm/mach-mvebu/pmsu-98dx3236.c b/arch/arm/mach-mvebu/pmsu-98dx3236.c
deleted file mode 100644
index 1052674dd439..000000000000
--- a/arch/arm/mach-mvebu/pmsu-98dx3236.c
+++ /dev/null
@@ -1,52 +0,0 @@
-/**
- * CPU resume support for 98DX3236 internal CPU (a.k.a. MSYS).
- */
-
-#define pr_fmt(fmt) "mv98dx3236-resume: " fmt
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/of_address.h>
-#include <linux/io.h>
-#include "common.h"
-
-static void __iomem *mv98dx3236_resume_base;
-#define MV98DX3236_CPU_RESUME_CTRL_OFFSET	0x08
-#define MV98DX3236_CPU_RESUME_ADDR_OFFSET	0x04
-
-static const struct of_device_id of_mv98dx3236_resume_table[] = {
-	{.compatible = "marvell,98dx3336-resume-ctrl",},
-	{ /* end of list */ },
-};
-
-void mv98dx3236_resume_set_cpu_boot_addr(int hw_cpu, void *boot_addr)
-{
-	WARN_ON(hw_cpu != 1);
-
-	writel(0, mv98dx3236_resume_base + MV98DX3236_CPU_RESUME_CTRL_OFFSET);
-	writel(virt_to_phys(boot_addr), mv98dx3236_resume_base +
-	       MV98DX3236_CPU_RESUME_ADDR_OFFSET);
-}
-
-static int __init mv98dx3236_resume_init(void)
-{
-	struct device_node *np;
-	void __iomem *base;
-
-	np = of_find_matching_node(NULL, of_mv98dx3236_resume_table);
-	if (!np)
-		return 0;
-
-	base = of_io_request_and_map(np, 0, of_node_full_name(np));
-	if (IS_ERR(base)) {
-		pr_err("unable to map registers\n");
-		of_node_put(np);
-		return PTR_ERR(mv98dx3236_resume_base);
-	}
-
-	mv98dx3236_resume_base = base;
-	of_node_put(np);
-	return 0;
-}
-
-early_initcall(mv98dx3236_resume_init);
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-xp.c b/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
index 554eeae8cd21..9601d662c7f5 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
@@ -374,8 +374,8 @@ static struct mvebu_mpp_mode mv98dx3236_mpp_modes[] = {
 		 MPP_VAR_FUNCTION(0x2, "spi0", "miso",       V_98DX3236_PLUS),
 		 MPP_VAR_FUNCTION(0x4, "dev", "ad9",         V_98DX3236_PLUS)),
 	MPP_MODE(2,
-		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,         V_98DX3236_PLUS),
-		 MPP_VAR_FUNCTION(0x2, "spi0", "csk",        V_98DX3236_PLUS),
+		 MPP_VAR_FUNCTION(0x0, "gpo", NULL,          V_98DX3236_PLUS),
+		 MPP_VAR_FUNCTION(0x2, "spi0", "sck",        V_98DX3236_PLUS),
 		 MPP_VAR_FUNCTION(0x4, "dev", "ad10",        V_98DX3236_PLUS)),
 	MPP_MODE(3,
 		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,         V_98DX3236_PLUS),
@@ -390,7 +390,7 @@ static struct mvebu_mpp_mode mv98dx3236_mpp_modes[] = {
 		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,         V_98DX3236_PLUS),
 		 MPP_VAR_FUNCTION(0x1, "pex", "rsto",        V_98DX3236_PLUS),
 		 MPP_VAR_FUNCTION(0x2, "sd0", "cmd",         V_98DX4251),
-		 MPP_VAR_FUNCTION(0x4, "dev", "bootcs0",     V_98DX3236_PLUS)),
+		 MPP_VAR_FUNCTION(0x4, "dev", "bootcs",      V_98DX3236_PLUS)),
 	MPP_MODE(6,
 		 MPP_VAR_FUNCTION(0x0, "gpo", NULL,          V_98DX3236_PLUS),
 		 MPP_VAR_FUNCTION(0x2, "sd0", "clk",         V_98DX4251),
@@ -442,7 +442,8 @@ static struct mvebu_mpp_mode mv98dx3236_mpp_modes[] = {
 		 MPP_VAR_FUNCTION(0x3, "uart1", "txd",       V_98DX3236_PLUS)),
 	MPP_MODE(19,
 		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,         V_98DX3236_PLUS),
-		 MPP_VAR_FUNCTION(0x3, "uart1", "rxd",       V_98DX3236_PLUS)),
+		 MPP_VAR_FUNCTION(0x3, "uart1", "rxd",       V_98DX3236_PLUS),
+		 MPP_VAR_FUNCTION(0x4, "dev", "rb",          V_98DX3236_PLUS)),
 	MPP_MODE(20,
 		 MPP_VAR_FUNCTION(0x0, "gpo", NULL,          V_98DX3236_PLUS),
 		 MPP_VAR_FUNCTION(0x4, "dev", "we0",         V_98DX3236_PLUS)),
@@ -548,7 +549,7 @@ static struct mvebu_mpp_ctrl mv98dx3236_mpp_controls[] = {
 };
 
 static struct pinctrl_gpio_range mv98dx3236_mpp_gpio_ranges[] = {
-	MPP_GPIO_RANGE(0,   0,  0, 32),
+	MPP_GPIO_RANGE(0, 0, 0, 32),
 };
 
 static int armada_xp_pinctrl_suspend(struct platform_device *pdev,
-- 
2.11.0.24.ge6920cf
