From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sat, 13 Apr 2013 16:56:44 +0200
Subject: [PATCHv3 09/10] arm: kirkwood: convert db-88f6281 to the Device Tree
In-Reply-To: <1365865005-26653-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1365865005-26653-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1365865005-26653-10-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit converts the Marvell DB-88F6281/DB-88F6282 board to the
Device Tree. In fact, the code was supporting two different boards:
one with the 6281 SoC variant, and one with the 6282 SoC variant. The
difference between the two being that the 6281 has one PCIe interface,
and the 6282 has two PCIe interfaces.

In order to handle that with the Device Tree, we create a
'kirkwood-db.dtsi' file that contains the definitions common to both
boards, and 'kirkwood-db-88f6281.dts' and 'kirkwood-db-88f6282.dts'
for the definitions specific to each board. This is similar to what is
done for the QNAP TS219 Kirkwood platform.

We have kept one single Kconfig option, just like it was before.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/Makefile                  |    5 +-
 arch/arm/boot/dts/kirkwood-db-88f6281.dts   |   30 ++++++++
 arch/arm/boot/dts/kirkwood-db-88f6282.dts   |   34 +++++++++
 arch/arm/boot/dts/kirkwood-db.dtsi          |   89 ++++++++++++++++++++++
 arch/arm/mach-kirkwood/Kconfig              |   13 ++--
 arch/arm/mach-kirkwood/Makefile             |    2 +-
 arch/arm/mach-kirkwood/board-db88f6281-bp.c |   26 +++++++
 arch/arm/mach-kirkwood/board-dt.c           |    2 +
 arch/arm/mach-kirkwood/common.h             |    6 ++
 arch/arm/mach-kirkwood/db88f6281-bp-setup.c |  108 ---------------------------
 10 files changed, 199 insertions(+), 116 deletions(-)
 create mode 100644 arch/arm/boot/dts/kirkwood-db-88f6281.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-db-88f6282.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-db.dtsi
 create mode 100644 arch/arm/mach-kirkwood/board-db88f6281-bp.c
 delete mode 100644 arch/arm/mach-kirkwood/db88f6281-bp-setup.c

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 9c62558..f28a23e 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -51,7 +51,10 @@ dtb-$(CONFIG_ARCH_HIGHBANK) += highbank.dtb \
 dtb-$(CONFIG_ARCH_INTEGRATOR) += integratorap.dtb \
 	integratorcp.dtb
 dtb-$(CONFIG_ARCH_LPC32XX) += ea3250.dtb phy3250.dtb
-dtb-$(CONFIG_ARCH_KIRKWOOD) += kirkwood-dns320.dtb \
+dtb-$(CONFIG_ARCH_KIRKWOOD) += \
+	kirkwood-db-88f6281.dtb \
+	kirkwood-db-88f6282.dtb \
+	kirkwood-dns320.dtb \
 	kirkwood-dns325.dtb \
 	kirkwood-dockstar.dtb \
 	kirkwood-dreamplug.dtb \
diff --git a/arch/arm/boot/dts/kirkwood-db-88f6281.dts b/arch/arm/boot/dts/kirkwood-db-88f6281.dts
new file mode 100644
index 0000000..9d777ed
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-db-88f6281.dts
@@ -0,0 +1,30 @@
+/*
+ * Marvell DB-88F6281-BP Development Board Setup
+ *
+ * Saeed Bishara <saeed@marvell.com>
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/dts-v1/;
+
+/include/ "kirkwood-db.dtsi"
+/include/ "kirkwood-6281.dtsi"
+
+/ {
+	model = "Marvell DB-88F6281-BP Development Board";
+	compatible = "marvell,db-88f6281-bp", "marvell,kirkwood-88f6281", "marvell,kirkwood";
+
+	ocp at f1000000 {
+		pcie-controller {
+			status = "okay";
+
+			pcie at 1,0 {
+				status = "okay";
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/kirkwood-db-88f6282.dts b/arch/arm/boot/dts/kirkwood-db-88f6282.dts
new file mode 100644
index 0000000..f4c8528
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-db-88f6282.dts
@@ -0,0 +1,34 @@
+/*
+ * Marvell DB-88F6282-BP Development Board Setup
+ *
+ * Saeed Bishara <saeed@marvell.com>
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/dts-v1/;
+
+/include/ "kirkwood-db.dtsi"
+/include/ "kirkwood-6282.dtsi"
+
+/ {
+	model = "Marvell DB-88F6282-BP Development Board";
+	compatible = "marvell,db-88f6282-bp", "marvell,kirkwood-88f6282", "marvell,kirkwood";
+
+	ocp at f1000000 {
+		pcie-controller {
+			status = "okay";
+
+			pcie at 1,0 {
+				status = "okay";
+			};
+
+			pcie at 2,0 {
+				status = "okay";
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/kirkwood-db.dtsi b/arch/arm/boot/dts/kirkwood-db.dtsi
new file mode 100644
index 0000000..c87cfb8
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-db.dtsi
@@ -0,0 +1,89 @@
+/*
+ * Marvell DB-{88F6281,88F6282}-BP Development Board Setup
+ *
+ * Saeed Bishara <saeed@marvell.com>
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ *
+ * This file contains the definitions that are common between the 6281
+ * and 6282 variants of the Marvell Kirkwood Development Board.
+ */
+
+/include/ "kirkwood.dtsi"
+
+/ {
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x20000000>; /* 512 MB */
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200n8 earlyprintk";
+	};
+
+	ocp at f1000000 {
+		pinctrl at 10000 {
+			pmx_sdio_gpios: pmx-sdio-gpios {
+				marvell,pins = "mpp37", "mpp38";
+				marvell,function = "gpio";
+			};
+		};
+
+		serial at 12000 {
+			pinctrl-0 = <&pmx_uart0>;
+			pinctrl-names = "default";
+			clock-frequency = <200000000>;
+			status = "ok";
+		};
+
+		nand at 3000000 {
+			pinctrl-0 = <&pmx_nand>;
+			pinctrl-names = "default";
+			chip-delay = <25>;
+			status = "okay";
+
+			partition at 0 {
+				label = "uboot";
+				reg = <0x0 0x100000>;
+			};
+
+			partition at 100000 {
+				label = "uImage";
+				reg = <0x100000 0x400000>;
+			};
+
+			partition at 500000 {
+				label = "root";
+				reg = <0x500000 0x1fb00000>;
+			};
+		};
+
+		sata at 80000 {
+			nr-ports = <2>;
+			status = "okay";
+		};
+
+		ehci at 50000 {
+			status = "okay";
+		};
+
+		mvsdio at 90000 {
+			pinctrl-0 = <&pmx_sdio_gpios>;
+			pinctrl-names = "default";
+			wp-gpios = <&gpio1 5 0>;
+			cd-gpios = <&gpio1 6 0>;
+			status = "okay";
+		};
+
+		pcie-controller {
+			status = "okay";
+
+			pcie at 1,0 {
+				status = "okay";
+			};
+		};
+	};
+};
diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
index 1fe5f2f..b09afca 100644
--- a/arch/arm/mach-kirkwood/Kconfig
+++ b/arch/arm/mach-kirkwood/Kconfig
@@ -2,12 +2,6 @@ if ARCH_KIRKWOOD
 
 menu "Marvell Kirkwood Implementations"
 
-config MACH_DB88F6281_BP
-	bool "Marvell DB-88F6281-BP Development Board"
-	help
-	  Say 'Y' here if you want your kernel to support the
-	  Marvell DB-88F6281-BP Development Board.
-
 config MACH_RD88F6192_NAS
 	bool "Marvell RD-88F6192-NAS Reference Board"
 	help
@@ -58,6 +52,13 @@ config ARCH_KIRKWOOD_DT
 	  Say 'Y' here if you want your kernel to support the
 	  Marvell Kirkwood using flattened device tree.
 
+config MACH_DB88F6281_BP_DT
+	bool "Marvell DB-88F6281-BP Development Board (Flattened Device Tree)"
+	help
+	  Say 'Y' here if you want your kernel to support the Marvell
+	  DB-88F6281-BP and DB-88F6282-BP Development Board (Flattened
+	  Device Tree).
+
 config MACH_GURUPLUG_DT
 	bool "Marvell GuruPlug Reference Board (Flattened Device Tree)"
 	select ARCH_KIRKWOOD_DT
diff --git a/arch/arm/mach-kirkwood/Makefile b/arch/arm/mach-kirkwood/Makefile
index 0e5ccad..e6a88ab 100644
--- a/arch/arm/mach-kirkwood/Makefile
+++ b/arch/arm/mach-kirkwood/Makefile
@@ -1,6 +1,5 @@
 obj-y				+= common.o irq.o pcie.o mpp.o
 
-obj-$(CONFIG_MACH_DB88F6281_BP)		+= db88f6281-bp-setup.o
 obj-$(CONFIG_MACH_RD88F6192_NAS)	+= rd88f6192-nas-setup.o
 obj-$(CONFIG_MACH_RD88F6281)		+= rd88f6281-setup.o
 obj-$(CONFIG_MACH_MV88F6281GTW_GE)	+= mv88f6281gtw_ge-setup.o
@@ -20,6 +19,7 @@ obj-$(CONFIG_MACH_NET5BIG_V2)		+= netxbig_v2-setup.o lacie_v2-common.o
 obj-$(CONFIG_MACH_T5325)		+= t5325-setup.o
 
 obj-$(CONFIG_ARCH_KIRKWOOD_DT)		+= board-dt.o
+obj-$(CONFIG_MACH_DB88F6281_BP_DT)	+= board-db88f6281-bp.o
 obj-$(CONFIG_MACH_DREAMPLUG_DT)		+= board-dreamplug.o
 obj-$(CONFIG_MACH_GURUPLUG_DT)		+= board-guruplug.o
 obj-$(CONFIG_MACH_ICONNECT_DT)		+= board-iconnect.o
diff --git a/arch/arm/mach-kirkwood/board-db88f6281-bp.c b/arch/arm/mach-kirkwood/board-db88f6281-bp.c
new file mode 100644
index 0000000..bffd160
--- /dev/null
+++ b/arch/arm/mach-kirkwood/board-db88f6281-bp.c
@@ -0,0 +1,26 @@
+/*
+ * arch/arm/mach-kirkwood/db88f6281-bp-setup.c
+ *
+ * Saeed Bishara <saeed@marvell.com>
+ *
+ * Marvell DB-88F6281-BP Development Board Setup
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/of.h>
+#include <linux/mv643xx_eth.h>
+#include "common.h"
+
+static struct mv643xx_eth_platform_data db88f6281_ge00_data = {
+	.phy_addr	= MV643XX_ETH_PHY_ADDR(8),
+};
+
+void __init db88f6281_init(void)
+{
+	kirkwood_ge00_init(&db88f6281_ge00_data);
+}
diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index ea49476..b6cb807 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -165,6 +165,8 @@ static const char * const kirkwood_dt_board_compat[] = {
 	"lacie,netspace_v2",
 	"lacie,netspace_lite_v2",
 	"lacie,netspace_mini_v2",
+	"marvell,db-88f6281-bp",
+	"marvell,db-88f6282-bp",
 	"mpl,cec4",
 	"plathome,openblocks-a6",
 	"usi,topkick",
diff --git a/arch/arm/mach-kirkwood/common.h b/arch/arm/mach-kirkwood/common.h
index e24f743..d174ab5 100644
--- a/arch/arm/mach-kirkwood/common.h
+++ b/arch/arm/mach-kirkwood/common.h
@@ -119,6 +119,12 @@ void km_kirkwood_init(void);
 static inline void km_kirkwood_init(void) {};
 #endif
 
+#ifdef CONFIG_MACH_DB88F6281_BP_DT
+void db88f6281_init(void);
+#else
+static inline void db88f6281_init(void) {};
+#endif
+
 #ifdef CONFIG_MACH_MPLCEC4_DT
 void mplcec4_init(void);
 #else
diff --git a/arch/arm/mach-kirkwood/db88f6281-bp-setup.c b/arch/arm/mach-kirkwood/db88f6281-bp-setup.c
deleted file mode 100644
index 5a369fe..0000000
--- a/arch/arm/mach-kirkwood/db88f6281-bp-setup.c
+++ /dev/null
@@ -1,108 +0,0 @@
-/*
- * arch/arm/mach-kirkwood/db88f6281-bp-setup.c
- *
- * Marvell DB-88F6281-BP Development Board Setup
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/sizes.h>
-#include <linux/platform_device.h>
-#include <linux/mtd/partitions.h>
-#include <linux/ata_platform.h>
-#include <linux/mv643xx_eth.h>
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-#include <mach/kirkwood.h>
-#include <linux/platform_data/mmc-mvsdio.h>
-#include "common.h"
-#include "mpp.h"
-
-static struct mtd_partition db88f6281_nand_parts[] = {
-	{
-		.name = "u-boot",
-		.offset = 0,
-		.size = SZ_1M
-	}, {
-		.name = "uImage",
-		.offset = MTDPART_OFS_NXTBLK,
-		.size = SZ_4M
-	}, {
-		.name = "root",
-		.offset = MTDPART_OFS_NXTBLK,
-		.size = MTDPART_SIZ_FULL
-	},
-};
-
-static struct mv643xx_eth_platform_data db88f6281_ge00_data = {
-	.phy_addr	= MV643XX_ETH_PHY_ADDR(8),
-};
-
-static struct mv_sata_platform_data db88f6281_sata_data = {
-	.n_ports	= 2,
-};
-
-static struct mvsdio_platform_data db88f6281_mvsdio_data = {
-	.gpio_write_protect	= 37,
-	.gpio_card_detect	= 38,
-};
-
-static unsigned int db88f6281_mpp_config[] __initdata = {
-	MPP0_NF_IO2,
-	MPP1_NF_IO3,
-	MPP2_NF_IO4,
-	MPP3_NF_IO5,
-	MPP4_NF_IO6,
-	MPP5_NF_IO7,
-	MPP18_NF_IO0,
-	MPP19_NF_IO1,
-	MPP37_GPIO,
-	MPP38_GPIO,
-	0
-};
-
-static void __init db88f6281_init(void)
-{
-	/*
-	 * Basic setup. Needs to be called early.
-	 */
-	kirkwood_init();
-	kirkwood_mpp_conf(db88f6281_mpp_config);
-
-	kirkwood_nand_init(ARRAY_AND_SIZE(db88f6281_nand_parts), 25);
-	kirkwood_ehci_init();
-	kirkwood_ge00_init(&db88f6281_ge00_data);
-	kirkwood_sata_init(&db88f6281_sata_data);
-	kirkwood_uart0_init();
-	kirkwood_sdio_init(&db88f6281_mvsdio_data);
-}
-
-static int __init db88f6281_pci_init(void)
-{
-	if (machine_is_db88f6281_bp()) {
-		u32 dev, rev;
-
-		kirkwood_pcie_id(&dev, &rev);
-		if (dev == MV88F6282_DEV_ID)
-			kirkwood_pcie_init(KW_PCIE1 | KW_PCIE0);
-		else
-			kirkwood_pcie_init(KW_PCIE0);
-	}
-	return 0;
-}
-subsys_initcall(db88f6281_pci_init);
-
-MACHINE_START(DB88F6281_BP, "Marvell DB-88F6281-BP Development Board")
-	/* Maintainer: Saeed Bishara <saeed@marvell.com> */
-	.atag_offset	= 0x100,
-	.init_machine	= db88f6281_init,
-	.map_io		= kirkwood_map_io,
-	.init_early	= kirkwood_init_early,
-	.init_irq	= kirkwood_init_irq,
-	.init_time	= kirkwood_timer_init,
-	.restart	= kirkwood_restart,
-MACHINE_END
-- 
1.7.9.5
