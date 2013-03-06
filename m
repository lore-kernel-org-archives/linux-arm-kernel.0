From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed,  6 Mar 2013 18:00:03 +0100
Subject: [PATCH 08/10] arm: mach-orion5x: convert to use mvebu-mbus driver
In-Reply-To: <1362589205-4726-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1362589205-4726-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1362589205-4726-9-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit migrates the mach-orion5x platforms to use the mvebu-mbus
driver and therefore removes the Orion5x-specific addr-map code.

In order to do this, we have to do a number of things:

 * introduce a separate dove_dt_init_early() function. It continues to
   be quite similar to dove_init_early(), except that it does a
   DT-based initialization of the mvebu-mbus driver. On the other
   hand, the dove_init_early() function does a legacy initialization
   of the mvebu-mbus driver (which will be removed once all boards
   have been migrated to the Device Tree).

 * introduce a orion5x-88f5182.dtsi file, which is used as an
   intermediate dtsi include between the board .dts (currently only
   orion5x-lacie-ethernet-disk-mini-v2.dts) and the common
   orion5x.dtsi. This is needed because the Orion5x SoCs have many
   things in common (described in orion5x.dtsi), but they are still
   some differences between 5182, 5281, etc, especially when it comes
   to address decoding windows. We therefore need to use a different
   compatible string for the different SoCs in the mbus DT node.

 * convert a number of orion5x_setup_xyz_win() calls to the
   appropriate mvebu_mbus_add_window() calls, as each board was doing
   its own setup for the NOR window or other devices. Ultimately,
   those devices will be probed from the DT.

 * the common address decoding windows are now registered in the
   orion5x_setup_wins() function. It is worth noting that the four
   PCIe address decoding windows will ultimately no longer have to be
   registered here: it will be done automatically by the PCIe driver
   once Dove has been migrated to use the upcoming mvebu PCIe driver.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/Kconfig                                   |    1 +
 arch/arm/boot/dts/orion5x-88f5182.dtsi             |   19 +++
 .../dts/orion5x-lacie-ethernet-disk-mini-v2.dts    |    2 +-
 arch/arm/mach-orion5x/Makefile                     |    2 +-
 arch/arm/mach-orion5x/addr-map.c                   |  155 --------------------
 arch/arm/mach-orion5x/board-dt.c                   |   24 ++-
 arch/arm/mach-orion5x/common.c                     |   49 ++++++-
 arch/arm/mach-orion5x/common.h                     |   13 +-
 arch/arm/mach-orion5x/d2net-setup.c                |    4 +-
 arch/arm/mach-orion5x/db88f5281-setup.c            |   13 +-
 arch/arm/mach-orion5x/dns323-setup.c               |    3 +-
 arch/arm/mach-orion5x/edmini_v2-setup.c            |    4 +-
 arch/arm/mach-orion5x/include/mach/orion5x.h       |    6 +-
 arch/arm/mach-orion5x/kurobox_pro-setup.c          |    8 +-
 arch/arm/mach-orion5x/ls-chl-setup.c               |    4 +-
 arch/arm/mach-orion5x/ls_hgl-setup.c               |    4 +-
 arch/arm/mach-orion5x/lsmini-setup.c               |    4 +-
 arch/arm/mach-orion5x/mss2-setup.c                 |    3 +-
 arch/arm/mach-orion5x/mv2120-setup.c               |    3 +-
 arch/arm/mach-orion5x/net2big-setup.c              |    4 +-
 arch/arm/mach-orion5x/pci.c                        |    7 +-
 arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c       |    4 +-
 arch/arm/mach-orion5x/rd88f5181l-ge-setup.c        |    4 +-
 arch/arm/mach-orion5x/rd88f5182-setup.c            |    7 +-
 arch/arm/mach-orion5x/terastation_pro2-setup.c     |    4 +-
 arch/arm/mach-orion5x/ts209-setup.c                |    4 +-
 arch/arm/mach-orion5x/ts409-setup.c                |    4 +-
 arch/arm/mach-orion5x/wnr854t-setup.c              |    4 +-
 arch/arm/mach-orion5x/wrt350n-v2-setup.c           |    4 +-
 arch/arm/plat-orion/Makefile                       |    1 -
 30 files changed, 149 insertions(+), 219 deletions(-)
 create mode 100644 arch/arm/boot/dts/orion5x-88f5182.dtsi
 delete mode 100644 arch/arm/mach-orion5x/addr-map.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index d18a141..e8caf60 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -602,6 +602,7 @@ config ARCH_ORION5X
 	select GENERIC_CLOCKEVENTS
 	select PCI
 	select PLAT_ORION_LEGACY
+	select MVEBU_MBUS
 	help
 	  Support for the following Marvell Orion 5x series SoCs:
 	  Orion-1 (5181), Orion-VoIP (5181L), Orion-NAS (5182),
diff --git a/arch/arm/boot/dts/orion5x-88f5182.dtsi b/arch/arm/boot/dts/orion5x-88f5182.dtsi
new file mode 100644
index 0000000..cae20e7
--- /dev/null
+++ b/arch/arm/boot/dts/orion5x-88f5182.dtsi
@@ -0,0 +1,19 @@
+/*
+ * Copyright (C) 2012 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/dts-v1/;
+/include/ "orion5x.dtsi"
+
+/ {
+	compatible = "marvell,orion5x-88f5182", "marvell,orion5x";
+
+	ocp at f1000000 {
+		compatible = "marvell,orion5x-88f5182-mbus", "simple-bus";
+		regs = <0xf1020000 0x100>, <0xf1001500 0x10>;
+	};
+};
\ No newline at end of file
diff --git a/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts b/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
index 0077fc8..cc0dc45 100644
--- a/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
+++ b/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
@@ -7,7 +7,7 @@
  */
 
 /dts-v1/;
-/include/ "orion5x.dtsi"
+/include/ "orion5x-88f5182.dtsi"
 
 / {
 	model = "LaCie Ethernet Disk mini V2";
diff --git a/arch/arm/mach-orion5x/Makefile b/arch/arm/mach-orion5x/Makefile
index 9e809a7..45da805 100644
--- a/arch/arm/mach-orion5x/Makefile
+++ b/arch/arm/mach-orion5x/Makefile
@@ -1,4 +1,4 @@
-obj-y				+= common.o addr-map.o pci.o irq.o mpp.o
+obj-y				+= common.o pci.o irq.o mpp.o
 obj-$(CONFIG_MACH_DB88F5281)	+= db88f5281-setup.o
 obj-$(CONFIG_MACH_RD88F5182)	+= rd88f5182-setup.o
 obj-$(CONFIG_MACH_KUROBOX_PRO)	+= kurobox_pro-setup.o
diff --git a/arch/arm/mach-orion5x/addr-map.c b/arch/arm/mach-orion5x/addr-map.c
deleted file mode 100644
index b5efc0f..0000000
--- a/arch/arm/mach-orion5x/addr-map.c
+++ /dev/null
@@ -1,155 +0,0 @@
-/*
- * arch/arm/mach-orion5x/addr-map.c
- *
- * Address map functions for Marvell Orion 5x SoCs
- *
- * Maintainer: Tzachi Perelstein <tzachi@marvell.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/mbus.h>
-#include <linux/io.h>
-#include <mach/hardware.h>
-#include <plat/addr-map.h>
-#include "common.h"
-
-/*
- * The Orion has fully programmable address map. There's a separate address
- * map for each of the device _master_ interfaces, e.g. CPU, PCI, PCIe, USB,
- * Gigabit Ethernet, DMA/XOR engines, etc. Each interface has its own
- * address decode windows that allow it to access any of the Orion resources.
- *
- * CPU address decoding --
- * Linux assumes that it is the boot loader that already setup the access to
- * DDR and internal registers.
- * Setup access to PCI and PCIe IO/MEM space is issued by this file.
- * Setup access to various devices located on the device bus interface (e.g.
- * flashes, RTC, etc) should be issued by machine-setup.c according to
- * specific board population (by using orion5x_setup_*_win()).
- *
- * Non-CPU Masters address decoding --
- * Unlike the CPU, we setup the access from Orion's master interfaces to DDR
- * banks only (the typical use case).
- * Setup access for each master to DDR is issued by platform device setup.
- */
-
-/*
- * Generic Address Decode Windows bit settings
- */
-#define TARGET_DEV_BUS		1
-#define TARGET_PCI		3
-#define TARGET_PCIE		4
-#define TARGET_SRAM		9
-#define ATTR_PCIE_MEM		0x59
-#define ATTR_PCIE_IO		0x51
-#define ATTR_PCIE_WA		0x79
-#define ATTR_PCI_MEM		0x59
-#define ATTR_PCI_IO		0x51
-#define ATTR_DEV_CS0		0x1e
-#define ATTR_DEV_CS1		0x1d
-#define ATTR_DEV_CS2		0x1b
-#define ATTR_DEV_BOOT		0xf
-#define ATTR_SRAM		0x0
-
-static int __initdata win_alloc_count;
-
-static int __init cpu_win_can_remap(const struct orion_addr_map_cfg *cfg,
-		  const int win)
-{
-	u32 dev, rev;
-
-	orion5x_pcie_id(&dev, &rev);
-	if ((dev == MV88F5281_DEV_ID && win < 4)
-	    || (dev == MV88F5182_DEV_ID && win < 2)
-	    || (dev == MV88F5181_DEV_ID && win < 2)
-	    || (dev == MV88F6183_DEV_ID && win < 4))
-		return 1;
-
-	return 0;
-}
-
-/*
- * Description of the windows needed by the platform code
- */
-static struct orion_addr_map_cfg addr_map_cfg __initdata = {
-	.num_wins = 8,
-	.cpu_win_can_remap = cpu_win_can_remap,
-	.bridge_virt_base = ORION5X_BRIDGE_VIRT_BASE,
-};
-
-static const struct __initdata orion_addr_map_info addr_map_info[] = {
-	/*
-	 * Setup windows for PCI+PCIe IO+MEM space.
-	 */
-	{ 0, ORION5X_PCIE_IO_PHYS_BASE, ORION5X_PCIE_IO_SIZE,
-	  TARGET_PCIE, ATTR_PCIE_IO, ORION5X_PCIE_IO_BUS_BASE
-	},
-	{ 1, ORION5X_PCI_IO_PHYS_BASE, ORION5X_PCI_IO_SIZE,
-	  TARGET_PCI, ATTR_PCI_IO, ORION5X_PCI_IO_BUS_BASE
-	},
-	{ 2, ORION5X_PCIE_MEM_PHYS_BASE, ORION5X_PCIE_MEM_SIZE,
-	  TARGET_PCIE, ATTR_PCIE_MEM, -1
-	},
-	{ 3, ORION5X_PCI_MEM_PHYS_BASE, ORION5X_PCI_MEM_SIZE,
-	  TARGET_PCI, ATTR_PCI_MEM, -1
-	},
-	/* End marker */
-	{ -1, 0, 0, 0, 0, 0 }
-};
-
-void __init orion5x_setup_cpu_mbus_bridge(void)
-{
-	/*
-	 * Disable, clear and configure windows.
-	 */
-	orion_config_wins(&addr_map_cfg, addr_map_info);
-	win_alloc_count = 4;
-
-	/*
-	 * Setup MBUS dram target info.
-	 */
-	orion_setup_cpu_mbus_target(&addr_map_cfg,
-				    (void __iomem *) ORION5X_DDR_WINDOW_CPU_BASE);
-}
-
-void __init orion5x_setup_dev_boot_win(u32 base, u32 size)
-{
-	orion_setup_cpu_win(&addr_map_cfg, win_alloc_count++, base, size,
-			    TARGET_DEV_BUS, ATTR_DEV_BOOT, -1);
-}
-
-void __init orion5x_setup_dev0_win(u32 base, u32 size)
-{
-	orion_setup_cpu_win(&addr_map_cfg, win_alloc_count++, base, size,
-			    TARGET_DEV_BUS, ATTR_DEV_CS0, -1);
-}
-
-void __init orion5x_setup_dev1_win(u32 base, u32 size)
-{
-	orion_setup_cpu_win(&addr_map_cfg, win_alloc_count++, base, size,
-			    TARGET_DEV_BUS, ATTR_DEV_CS1, -1);
-}
-
-void __init orion5x_setup_dev2_win(u32 base, u32 size)
-{
-	orion_setup_cpu_win(&addr_map_cfg, win_alloc_count++, base, size,
-			    TARGET_DEV_BUS, ATTR_DEV_CS2, -1);
-}
-
-void __init orion5x_setup_pcie_wa_win(u32 base, u32 size)
-{
-	orion_setup_cpu_win(&addr_map_cfg, win_alloc_count++, base, size,
-			    TARGET_PCIE, ATTR_PCIE_WA, -1);
-}
-
-void __init orion5x_setup_sram_win(void)
-{
-	orion_setup_cpu_win(&addr_map_cfg, win_alloc_count++,
-			    ORION5X_SRAM_PHYS_BASE, ORION5X_SRAM_SIZE,
-			    TARGET_SRAM, ATTR_SRAM, -1);
-}
diff --git a/arch/arm/mach-orion5x/board-dt.c b/arch/arm/mach-orion5x/board-dt.c
index 35a8014..eff2070 100644
--- a/arch/arm/mach-orion5x/board-dt.c
+++ b/arch/arm/mach-orion5x/board-dt.c
@@ -14,10 +14,15 @@
 #include <linux/init.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
+#include <linux/dma-mapping.h>
+#include <linux/mbus.h>
 #include <asm/system_misc.h>
 #include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+#include <mach/bridge-regs.h>
 #include <mach/orion5x.h>
 #include <plat/irq.h>
+#include <plat/time.h>
 #include "common.h"
 
 struct of_dev_auxdata orion5x_auxdata_lookup[] __initdata = {
@@ -30,6 +35,21 @@ struct of_dev_auxdata orion5x_auxdata_lookup[] __initdata = {
 	{},
 };
 
+void __init orion5x_dt_init_early(void)
+{
+	orion_time_set_base(TIMER_VIRT_BASE);
+
+	/*
+	 * Some Orion5x devices allocate their coherent buffers from atomic
+	 * context. Increase size of atomic coherent pool to make sure such
+	 * the allocations won't fail.
+	 */
+	init_dma_coherent_pool_size(SZ_1M);
+
+	/* Initialize the MBUS driver */
+	mvebu_mbus_dt_init();
+}
+
 static void __init orion5x_dt_init(void)
 {
 	char *dev_name;
@@ -41,7 +61,7 @@ static void __init orion5x_dt_init(void)
 	/*
 	 * Setup Orion address map
 	 */
-	orion5x_setup_cpu_mbus_bridge();
+	orion5x_setup_wins();
 
 	/* Setup root of clk tree */
 	clk_init();
@@ -70,7 +90,7 @@ static const char *orion5x_dt_compat[] = {
 DT_MACHINE_START(ORION5X_DT, "Marvell Orion5x (Flattened Device Tree)")
 	/* Maintainer: Thomas Petazzoni <thomas.petazzoni@free-electrons.com> */
 	.map_io		= orion5x_map_io,
-	.init_early	= orion5x_init_early,
+	.init_early	= orion5x_dt_init_early,
 	.init_irq	= orion_dt_init_irq,
 	.init_time	= orion5x_timer_init,
 	.init_machine	= orion5x_dt_init,
diff --git a/arch/arm/mach-orion5x/common.c b/arch/arm/mach-orion5x/common.c
index d068f14..718012d 100644
--- a/arch/arm/mach-orion5x/common.c
+++ b/arch/arm/mach-orion5x/common.c
@@ -34,7 +34,6 @@
 #include <linux/platform_data/usb-ehci-orion.h>
 #include <plat/time.h>
 #include <plat/common.h>
-#include <plat/addr-map.h>
 #include "common.h"
 
 /*****************************************************************************
@@ -174,7 +173,8 @@ void __init orion5x_xor_init(void)
  ****************************************************************************/
 static void __init orion5x_crypto_init(void)
 {
-	orion5x_setup_sram_win();
+	mvebu_mbus_add_window("sram", ORION5X_SRAM_PHYS_BASE,
+			      ORION5X_SRAM_SIZE);
 	orion_crypto_init(ORION5X_CRYPTO_PHYS_BASE, ORION5X_SRAM_PHYS_BASE,
 			  SZ_8K, IRQ_ORION5X_CESA);
 }
@@ -193,6 +193,9 @@ void __init orion5x_wdt_init(void)
  ****************************************************************************/
 void __init orion5x_init_early(void)
 {
+	u32 rev, dev;
+	const char *soc;
+
 	orion_time_set_base(TIMER_VIRT_BASE);
 
 	/*
@@ -201,6 +204,46 @@ void __init orion5x_init_early(void)
 	 * the allocations won't fail.
 	 */
 	init_dma_coherent_pool_size(SZ_1M);
+
+	/* Initialize the MBUS driver */
+	orion5x_pcie_id(&dev, &rev);
+	if (dev == MV88F5281_DEV_ID)
+		soc = "marvell,orion5x-88f5281-mbus";
+	else if (dev == MV88F5182_DEV_ID)
+		soc = "marvell,orion5x-88f5182-mbus";
+	else if (dev == MV88F5181_DEV_ID)
+		soc = "marvell,orion5x-88f5181-mbus";
+	else if (dev == MV88F6183_DEV_ID)
+		soc = "marvell,orion5x-88f6183-mbus";
+	else
+		soc = NULL;
+	mvebu_mbus_init(soc, ORION5X_BRIDGE_WINS_BASE,
+			ORION5X_BRIDGE_WINS_SZ,
+			ORION5X_DDR_WINS_BASE, ORION5X_DDR_WINS_SZ);
+}
+
+void orion5x_setup_wins(void)
+{
+	/*
+	 * The PCIe windows will no longer be statically allocated
+	 * here once Orion5x is migrated to the pci-mvebu driver.
+	 */
+	mvebu_mbus_add_window_remap_flags("pcie0.0", ORION5X_PCIE_IO_PHYS_BASE,
+					  ORION5X_PCIE_IO_SIZE,
+					  ORION5X_PCIE_IO_BUS_BASE,
+					  MVEBU_MBUS_PCI_IO);
+	mvebu_mbus_add_window_remap_flags("pcie0.0", ORION5X_PCIE_MEM_PHYS_BASE,
+					  ORION5X_PCIE_MEM_SIZE,
+					  MVEBU_MBUS_NO_REMAP,
+					  MVEBU_MBUS_PCI_MEM);
+	mvebu_mbus_add_window_remap_flags("pci0.0", ORION5X_PCI_IO_PHYS_BASE,
+					  ORION5X_PCI_IO_SIZE,
+					  ORION5X_PCI_IO_BUS_BASE,
+					  MVEBU_MBUS_PCI_IO);
+	mvebu_mbus_add_window_remap_flags("pci0.0", ORION5X_PCI_MEM_PHYS_BASE,
+					  ORION5X_PCI_MEM_SIZE,
+					  MVEBU_MBUS_NO_REMAP,
+					  MVEBU_MBUS_PCI_MEM);
 }
 
 int orion5x_tclk;
@@ -282,7 +325,7 @@ void __init orion5x_init(void)
 	/*
 	 * Setup Orion address map
 	 */
-	orion5x_setup_cpu_mbus_bridge();
+	orion5x_setup_wins();
 
 	/* Setup root of clk tree */
 	clk_init();
diff --git a/arch/arm/mach-orion5x/common.h b/arch/arm/mach-orion5x/common.h
index e603457..cdaa01f 100644
--- a/arch/arm/mach-orion5x/common.h
+++ b/arch/arm/mach-orion5x/common.h
@@ -17,18 +17,7 @@ void clk_init(void);
 extern int orion5x_tclk;
 extern void orion5x_timer_init(void);
 
-/*
- * Enumerations and functions for Orion windows mapping. Used by Orion core
- * functions to map its interfaces and by the machine-setup to map its on-
- * board devices. Details in /mach-orion/addr-map.c
- */
-void orion5x_setup_cpu_mbus_bridge(void);
-void orion5x_setup_dev_boot_win(u32 base, u32 size);
-void orion5x_setup_dev0_win(u32 base, u32 size);
-void orion5x_setup_dev1_win(u32 base, u32 size);
-void orion5x_setup_dev2_win(u32 base, u32 size);
-void orion5x_setup_pcie_wa_win(u32 base, u32 size);
-void orion5x_setup_sram_win(void);
+void orion5x_setup_wins(void);
 
 void orion5x_ehci0_init(void);
 void orion5x_ehci1_init(void);
diff --git a/arch/arm/mach-orion5x/d2net-setup.c b/arch/arm/mach-orion5x/d2net-setup.c
index 57d0af7..16c88bb 100644
--- a/arch/arm/mach-orion5x/d2net-setup.c
+++ b/arch/arm/mach-orion5x/d2net-setup.c
@@ -317,8 +317,8 @@ static void __init d2net_init(void)
 	d2net_sata_power_init();
 	orion5x_sata_init(&d2net_sata_data);
 
-	orion5x_setup_dev_boot_win(D2NET_NOR_BOOT_BASE,
-				D2NET_NOR_BOOT_SIZE);
+	mvebu_mbus_add_window("devbus-boot", D2NET_NOR_BOOT_BASE,
+			      D2NET_NOR_BOOT_SIZE);
 	platform_device_register(&d2net_nor_flash);
 
 	platform_device_register(&d2net_gpio_buttons);
diff --git a/arch/arm/mach-orion5x/db88f5281-setup.c b/arch/arm/mach-orion5x/db88f5281-setup.c
index 7666564..4e1263d 100644
--- a/arch/arm/mach-orion5x/db88f5281-setup.c
+++ b/arch/arm/mach-orion5x/db88f5281-setup.c
@@ -340,16 +340,19 @@ static void __init db88f5281_init(void)
 	orion5x_uart0_init();
 	orion5x_uart1_init();
 
-	orion5x_setup_dev_boot_win(DB88F5281_NOR_BOOT_BASE,
-				DB88F5281_NOR_BOOT_SIZE);
+	mvebu_mbus_add_window("devbus-boot", DB88F5281_NOR_BOOT_BASE,
+			      DB88F5281_NOR_BOOT_SIZE);
 	platform_device_register(&db88f5281_boot_flash);
 
-	orion5x_setup_dev0_win(DB88F5281_7SEG_BASE, DB88F5281_7SEG_SIZE);
+	mvebu_mbus_add_window("devbus-cs0", DB88F5281_7SEG_BASE,
+			      DB88F5281_7SEG_SIZE);
 
-	orion5x_setup_dev1_win(DB88F5281_NOR_BASE, DB88F5281_NOR_SIZE);
+	mvebu_mbus_add_window("devbus-cs1", DB88F5281_NOR_BASE,
+			      DB88F5281_NOR_SIZE);
 	platform_device_register(&db88f5281_nor_flash);
 
-	orion5x_setup_dev2_win(DB88F5281_NAND_BASE, DB88F5281_NAND_SIZE);
+	mvebu_mbus_add_window("devbus-cs2", DB88F5281_NAND_BASE,
+			      DB88F5281_NAND_SIZE);
 	platform_device_register(&db88f5281_nand_flash);
 
 	i2c_register_board_info(0, &db88f5281_i2c_rtc, 1);
diff --git a/arch/arm/mach-orion5x/dns323-setup.c b/arch/arm/mach-orion5x/dns323-setup.c
index 6eb1732..9e6baf5 100644
--- a/arch/arm/mach-orion5x/dns323-setup.c
+++ b/arch/arm/mach-orion5x/dns323-setup.c
@@ -611,7 +611,8 @@ static void __init dns323_init(void)
 	/* setup flash mapping
 	 * CS3 holds a 8 MB Spansion S29GL064M90TFIR4
 	 */
-	orion5x_setup_dev_boot_win(DNS323_NOR_BOOT_BASE, DNS323_NOR_BOOT_SIZE);
+	mvebu_mbus_add_window("devbus-boot", DNS323_NOR_BOOT_BASE,
+			      DNS323_NOR_BOOT_SIZE);
 	platform_device_register(&dns323_nor_flash);
 
 	/* Sort out LEDs, Buttons and i2c devices */
diff --git a/arch/arm/mach-orion5x/edmini_v2-setup.c b/arch/arm/mach-orion5x/edmini_v2-setup.c
index d675e72..1476155 100644
--- a/arch/arm/mach-orion5x/edmini_v2-setup.c
+++ b/arch/arm/mach-orion5x/edmini_v2-setup.c
@@ -154,8 +154,8 @@ void __init edmini_v2_init(void)
 	orion5x_ehci0_init();
 	orion5x_eth_init(&edmini_v2_eth_data);
 
-	orion5x_setup_dev_boot_win(EDMINI_V2_NOR_BOOT_BASE,
-				EDMINI_V2_NOR_BOOT_SIZE);
+	mvebu_mbus_add_window("devbus-boot", EDMINI_V2_NOR_BOOT_BASE,
+			      EDMINI_V2_NOR_BOOT_SIZE);
 	platform_device_register(&edmini_v2_nor_flash);
 
 	pr_notice("edmini_v2: USB device port, flash write and power-off "
diff --git a/arch/arm/mach-orion5x/include/mach/orion5x.h b/arch/arm/mach-orion5x/include/mach/orion5x.h
index d265f54..b78ff32 100644
--- a/arch/arm/mach-orion5x/include/mach/orion5x.h
+++ b/arch/arm/mach-orion5x/include/mach/orion5x.h
@@ -66,8 +66,10 @@
  * Orion Registers Map
  ******************************************************************************/
 
+#define ORION5X_DDR_PHYS_BASE           (ORION5X_REGS_PHYS_BASE + 0x00000)
+#define  ORION5X_DDR_WINS_BASE          (ORION5X_DDR_PHYS_BASE + 0x1500)
+#define  ORION5X_DDR_WINS_SZ            (0x10)
 #define ORION5X_DDR_VIRT_BASE		(ORION5X_REGS_VIRT_BASE + 0x00000)
-#define  ORION5X_DDR_WINDOW_CPU_BASE    (ORION5X_DDR_VIRT_BASE + 0x1500)
 #define ORION5X_DEV_BUS_PHYS_BASE	(ORION5X_REGS_PHYS_BASE + 0x10000)
 #define ORION5X_DEV_BUS_VIRT_BASE	(ORION5X_REGS_VIRT_BASE + 0x10000)
 #define ORION5X_DEV_BUS_REG(x)		(ORION5X_DEV_BUS_VIRT_BASE + (x))
@@ -81,6 +83,8 @@
 
 #define ORION5X_BRIDGE_VIRT_BASE	(ORION5X_REGS_VIRT_BASE + 0x20000)
 #define ORION5X_BRIDGE_PHYS_BASE	(ORION5X_REGS_PHYS_BASE + 0x20000)
+#define  ORION5X_BRIDGE_WINS_BASE       (ORION5X_BRIDGE_PHYS_BASE)
+#define  ORION5X_BRIDGE_WINS_SZ         (0x80)
 
 #define ORION5X_PCI_VIRT_BASE		(ORION5X_REGS_VIRT_BASE + 0x30000)
 
diff --git a/arch/arm/mach-orion5x/kurobox_pro-setup.c b/arch/arm/mach-orion5x/kurobox_pro-setup.c
index b984035..aae10e4 100644
--- a/arch/arm/mach-orion5x/kurobox_pro-setup.c
+++ b/arch/arm/mach-orion5x/kurobox_pro-setup.c
@@ -359,13 +359,13 @@ static void __init kurobox_pro_init(void)
 	orion5x_uart1_init();
 	orion5x_xor_init();
 
-	orion5x_setup_dev_boot_win(KUROBOX_PRO_NOR_BOOT_BASE,
-				   KUROBOX_PRO_NOR_BOOT_SIZE);
+	mvebu_mbus_add_window("devbus-boot", KUROBOX_PRO_NOR_BOOT_BASE,
+			      KUROBOX_PRO_NOR_BOOT_SIZE);
 	platform_device_register(&kurobox_pro_nor_flash);
 
 	if (machine_is_kurobox_pro()) {
-		orion5x_setup_dev0_win(KUROBOX_PRO_NAND_BASE,
-				       KUROBOX_PRO_NAND_SIZE);
+		mvebu_mbus_add_window("devbus-cs0", KUROBOX_PRO_NAND_BASE,
+				      KUROBOX_PRO_NAND_SIZE);
 		platform_device_register(&kurobox_pro_nand_flash);
 	}
 
diff --git a/arch/arm/mach-orion5x/ls-chl-setup.c b/arch/arm/mach-orion5x/ls-chl-setup.c
index 044da5b..24f4e14 100644
--- a/arch/arm/mach-orion5x/ls-chl-setup.c
+++ b/arch/arm/mach-orion5x/ls-chl-setup.c
@@ -294,8 +294,8 @@ static void __init lschl_init(void)
 	orion5x_uart0_init();
 	orion5x_xor_init();
 
-	orion5x_setup_dev_boot_win(LSCHL_NOR_BOOT_BASE,
-				   LSCHL_NOR_BOOT_SIZE);
+	mvebu_mbus_add_window("devbus-boot", LSCHL_NOR_BOOT_BASE,
+			      LSCHL_NOR_BOOT_SIZE);
 	platform_device_register(&lschl_nor_flash);
 
 	platform_device_register(&lschl_leds);
diff --git a/arch/arm/mach-orion5x/ls_hgl-setup.c b/arch/arm/mach-orion5x/ls_hgl-setup.c
index d49f934..fc653bb 100644
--- a/arch/arm/mach-orion5x/ls_hgl-setup.c
+++ b/arch/arm/mach-orion5x/ls_hgl-setup.c
@@ -243,8 +243,8 @@ static void __init ls_hgl_init(void)
 	orion5x_uart0_init();
 	orion5x_xor_init();
 
-	orion5x_setup_dev_boot_win(LS_HGL_NOR_BOOT_BASE,
-				   LS_HGL_NOR_BOOT_SIZE);
+	mvebu_mbus_add_window("devbus-boot", LS_HGL_NOR_BOOT_BASE,
+			      LS_HGL_NOR_BOOT_SIZE);
 	platform_device_register(&ls_hgl_nor_flash);
 
 	platform_device_register(&ls_hgl_button_device);
diff --git a/arch/arm/mach-orion5x/lsmini-setup.c b/arch/arm/mach-orion5x/lsmini-setup.c
index 8e3965c..18e66e6 100644
--- a/arch/arm/mach-orion5x/lsmini-setup.c
+++ b/arch/arm/mach-orion5x/lsmini-setup.c
@@ -244,8 +244,8 @@ static void __init lsmini_init(void)
 	orion5x_uart0_init();
 	orion5x_xor_init();
 
-	orion5x_setup_dev_boot_win(LSMINI_NOR_BOOT_BASE,
-				   LSMINI_NOR_BOOT_SIZE);
+	mvebu_mbus_add_window("devbus-boot", LSMINI_NOR_BOOT_BASE,
+			      LSMINI_NOR_BOOT_SIZE);
 	platform_device_register(&lsmini_nor_flash);
 
 	platform_device_register(&lsmini_button_device);
diff --git a/arch/arm/mach-orion5x/mss2-setup.c b/arch/arm/mach-orion5x/mss2-setup.c
index 0ec94a1..827acba 100644
--- a/arch/arm/mach-orion5x/mss2-setup.c
+++ b/arch/arm/mach-orion5x/mss2-setup.c
@@ -241,7 +241,8 @@ static void __init mss2_init(void)
 	orion5x_uart0_init();
 	orion5x_xor_init();
 
-	orion5x_setup_dev_boot_win(MSS2_NOR_BOOT_BASE, MSS2_NOR_BOOT_SIZE);
+	mvebu_mbus_add_window("devbus-boot", MSS2_NOR_BOOT_BASE,
+			      MSS2_NOR_BOOT_SIZE);
 	platform_device_register(&mss2_nor_flash);
 
 	platform_device_register(&mss2_button_device);
diff --git a/arch/arm/mach-orion5x/mv2120-setup.c b/arch/arm/mach-orion5x/mv2120-setup.c
index 18143f2..92600ae 100644
--- a/arch/arm/mach-orion5x/mv2120-setup.c
+++ b/arch/arm/mach-orion5x/mv2120-setup.c
@@ -204,7 +204,8 @@ static void __init mv2120_init(void)
 	orion5x_uart0_init();
 	orion5x_xor_init();
 
-	orion5x_setup_dev_boot_win(MV2120_NOR_BOOT_BASE, MV2120_NOR_BOOT_SIZE);
+	mvebu_mbus_add_window("devbus-boot", MV2120_NOR_BOOT_BASE,
+			      MV2120_NOR_BOOT_SIZE);
 	platform_device_register(&mv2120_nor_flash);
 
 	platform_device_register(&mv2120_button_device);
diff --git a/arch/arm/mach-orion5x/net2big-setup.c b/arch/arm/mach-orion5x/net2big-setup.c
index 282e503..dd0641a 100644
--- a/arch/arm/mach-orion5x/net2big-setup.c
+++ b/arch/arm/mach-orion5x/net2big-setup.c
@@ -397,8 +397,8 @@ static void __init net2big_init(void)
 	net2big_sata_power_init();
 	orion5x_sata_init(&net2big_sata_data);
 
-	orion5x_setup_dev_boot_win(NET2BIG_NOR_BOOT_BASE,
-				   NET2BIG_NOR_BOOT_SIZE);
+	mvebu_mbus_add_window("devbus-boot", NET2BIG_NOR_BOOT_BASE,
+			      NET2BIG_NOR_BOOT_SIZE);
 	platform_device_register(&net2big_nor_flash);
 
 	platform_device_register(&net2big_gpio_buttons);
diff --git a/arch/arm/mach-orion5x/pci.c b/arch/arm/mach-orion5x/pci.c
index 973db98..5033680 100644
--- a/arch/arm/mach-orion5x/pci.c
+++ b/arch/arm/mach-orion5x/pci.c
@@ -157,8 +157,11 @@ static int __init pcie_setup(struct pci_sys_data *sys)
 	if (dev == MV88F5181_DEV_ID || dev == MV88F5182_DEV_ID) {
 		printk(KERN_NOTICE "Applying Orion-1/Orion-NAS PCIe config "
 				   "read transaction workaround\n");
-		orion5x_setup_pcie_wa_win(ORION5X_PCIE_WA_PHYS_BASE,
-					  ORION5X_PCIE_WA_SIZE);
+		mvebu_mbus_add_window_remap_flags("pcie0.0",
+						  ORION5X_PCIE_WA_PHYS_BASE,
+						  ORION5X_PCIE_WA_SIZE,
+						  MVEBU_MBUS_NO_REMAP,
+						  MVEBU_MBUS_PCI_WA);
 		pcie_ops.read = pcie_rd_conf_wa;
 	}
 
diff --git a/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c b/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c
index d6e72f6..1c4498b 100644
--- a/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c
+++ b/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c
@@ -123,8 +123,8 @@ static void __init rd88f5181l_fxo_init(void)
 	orion5x_eth_switch_init(&rd88f5181l_fxo_switch_plat_data, NO_IRQ);
 	orion5x_uart0_init();
 
-	orion5x_setup_dev_boot_win(RD88F5181L_FXO_NOR_BOOT_BASE,
-				   RD88F5181L_FXO_NOR_BOOT_SIZE);
+	mvebu_mbus_add_window("devbus-boot", RD88F5181L_FXO_NOR_BOOT_BASE,
+			      RD88F5181L_FXO_NOR_BOOT_SIZE);
 	platform_device_register(&rd88f5181l_fxo_nor_boot_flash);
 }
 
diff --git a/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c b/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c
index c8b7913..adabe34 100644
--- a/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c
+++ b/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c
@@ -130,8 +130,8 @@ static void __init rd88f5181l_ge_init(void)
 	orion5x_i2c_init();
 	orion5x_uart0_init();
 
-	orion5x_setup_dev_boot_win(RD88F5181L_GE_NOR_BOOT_BASE,
-				   RD88F5181L_GE_NOR_BOOT_SIZE);
+	mvebu_mbus_add_window("devbus-boot", RD88F5181L_GE_NOR_BOOT_BASE,
+			      RD88F5181L_GE_NOR_BOOT_SIZE);
 	platform_device_register(&rd88f5181l_ge_nor_boot_flash);
 
 	i2c_register_board_info(0, &rd88f5181l_ge_i2c_rtc, 1);
diff --git a/arch/arm/mach-orion5x/rd88f5182-setup.c b/arch/arm/mach-orion5x/rd88f5182-setup.c
index f9e1567..66e77ec 100644
--- a/arch/arm/mach-orion5x/rd88f5182-setup.c
+++ b/arch/arm/mach-orion5x/rd88f5182-setup.c
@@ -264,10 +264,11 @@ static void __init rd88f5182_init(void)
 	orion5x_uart0_init();
 	orion5x_xor_init();
 
-	orion5x_setup_dev_boot_win(RD88F5182_NOR_BOOT_BASE,
-				   RD88F5182_NOR_BOOT_SIZE);
+	mvebu_mbus_add_window("devbus-boot", RD88F5182_NOR_BOOT_BASE,
+			      RD88F5182_NOR_BOOT_SIZE);
 
-	orion5x_setup_dev1_win(RD88F5182_NOR_BASE, RD88F5182_NOR_SIZE);
+	mvebu_mbus_add_window("devbus-cs1", RD88F5182_NOR_BASE,
+			      RD88F5182_NOR_SIZE);
 	platform_device_register(&rd88f5182_nor_flash);
 	platform_device_register(&rd88f5182_gpio_leds);
 
diff --git a/arch/arm/mach-orion5x/terastation_pro2-setup.c b/arch/arm/mach-orion5x/terastation_pro2-setup.c
index acc0877..a0bfa53 100644
--- a/arch/arm/mach-orion5x/terastation_pro2-setup.c
+++ b/arch/arm/mach-orion5x/terastation_pro2-setup.c
@@ -329,8 +329,8 @@ static void __init tsp2_init(void)
 	/*
 	 * Configure peripherals.
 	 */
-	orion5x_setup_dev_boot_win(TSP2_NOR_BOOT_BASE,
-				   TSP2_NOR_BOOT_SIZE);
+	mvebu_mbus_add_window("devbus-boot", TSP2_NOR_BOOT_BASE,
+			      TSP2_NOR_BOOT_SIZE);
 	platform_device_register(&tsp2_nor_flash);
 
 	orion5x_ehci0_init();
diff --git a/arch/arm/mach-orion5x/ts209-setup.c b/arch/arm/mach-orion5x/ts209-setup.c
index 9c17f0c..80174f0 100644
--- a/arch/arm/mach-orion5x/ts209-setup.c
+++ b/arch/arm/mach-orion5x/ts209-setup.c
@@ -286,8 +286,8 @@ static void __init qnap_ts209_init(void)
 	/*
 	 * Configure peripherals.
 	 */
-	orion5x_setup_dev_boot_win(QNAP_TS209_NOR_BOOT_BASE,
-				   QNAP_TS209_NOR_BOOT_SIZE);
+	mvebu_mbus_add_window("devbus-boot", QNAP_TS209_NOR_BOOT_BASE,
+			      QNAP_TS209_NOR_BOOT_SIZE);
 	platform_device_register(&qnap_ts209_nor_flash);
 
 	orion5x_ehci0_init();
diff --git a/arch/arm/mach-orion5x/ts409-setup.c b/arch/arm/mach-orion5x/ts409-setup.c
index 8cc5ab6..9259279 100644
--- a/arch/arm/mach-orion5x/ts409-setup.c
+++ b/arch/arm/mach-orion5x/ts409-setup.c
@@ -277,8 +277,8 @@ static void __init qnap_ts409_init(void)
 	/*
 	 * Configure peripherals.
 	 */
-	orion5x_setup_dev_boot_win(QNAP_TS409_NOR_BOOT_BASE,
-				   QNAP_TS409_NOR_BOOT_SIZE);
+	mvebu_mbus_add_window("devbus-boot", QNAP_TS409_NOR_BOOT_BASE,
+			      QNAP_TS409_NOR_BOOT_SIZE);
 	platform_device_register(&qnap_ts409_nor_flash);
 
 	orion5x_ehci0_init();
diff --git a/arch/arm/mach-orion5x/wnr854t-setup.c b/arch/arm/mach-orion5x/wnr854t-setup.c
index 66552ca..6b84863 100644
--- a/arch/arm/mach-orion5x/wnr854t-setup.c
+++ b/arch/arm/mach-orion5x/wnr854t-setup.c
@@ -127,8 +127,8 @@ static void __init wnr854t_init(void)
 	orion5x_eth_switch_init(&wnr854t_switch_plat_data, NO_IRQ);
 	orion5x_uart0_init();
 
-	orion5x_setup_dev_boot_win(WNR854T_NOR_BOOT_BASE,
-				   WNR854T_NOR_BOOT_SIZE);
+	mvebu_mbus_add_window("devbus-boot", WNR854T_NOR_BOOT_BASE,
+			      WNR854T_NOR_BOOT_SIZE);
 	platform_device_register(&wnr854t_nor_flash);
 }
 
diff --git a/arch/arm/mach-orion5x/wrt350n-v2-setup.c b/arch/arm/mach-orion5x/wrt350n-v2-setup.c
index 2c5408e..fae684b 100644
--- a/arch/arm/mach-orion5x/wrt350n-v2-setup.c
+++ b/arch/arm/mach-orion5x/wrt350n-v2-setup.c
@@ -213,8 +213,8 @@ static void __init wrt350n_v2_init(void)
 	orion5x_eth_switch_init(&wrt350n_v2_switch_plat_data, NO_IRQ);
 	orion5x_uart0_init();
 
-	orion5x_setup_dev_boot_win(WRT350N_V2_NOR_BOOT_BASE,
-				   WRT350N_V2_NOR_BOOT_SIZE);
+	mvebu_mbus_add_window("devbus-boot", WRT350N_V2_NOR_BOOT_BASE,
+			      WRT350N_V2_NOR_BOOT_SIZE);
 	platform_device_register(&wrt350n_v2_nor_flash);
 	platform_device_register(&wrt350n_v2_leds);
 	platform_device_register(&wrt350n_v2_button_device);
diff --git a/arch/arm/plat-orion/Makefile b/arch/arm/plat-orion/Makefile
index 9fd843e..09711cd 100644
--- a/arch/arm/plat-orion/Makefile
+++ b/arch/arm/plat-orion/Makefile
@@ -3,7 +3,6 @@
 #
 ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include
 
-obj-$(CONFIG_ARCH_ORION5X)        += addr-map.o
 obj-$(CONFIG_ARCH_MV78XX0)        += addr-map.o
 
 orion-gpio-$(CONFIG_GENERIC_GPIO) += gpio.o
-- 
1.7.9.5
