From: sandeen@redhat.com (Eric Sandeen)
Date: Fri, 13 Nov 2009 00:04:46 -0600
Subject: [PATCH] arm: Iomega ix4-200d support
Message-ID: <4AFCF6FE.1010603@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following is was (lightly) tested under 2.6.30 with a development
board for the Iomega ix4-200d NAS box, which eventually released as:

http://go.iomega.com/en-us/products/network-storage-desktop/storcenter-network-storage-solution/network-hard-drive-ix4-200d/ 

It could probably use some tidying up, but perhaps it's a good starting
place, at least.

Signed-off-by: Eric Sandeen <sandeen@sandeen.net>
---

diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
index 0aca451..2d306ec 100644
--- a/arch/arm/mach-kirkwood/Kconfig
+++ b/arch/arm/mach-kirkwood/Kconfig
@@ -8,6 +8,12 @@ config MACH_DB88F6281_BP
 	  Say 'Y' here if you want your kernel to support the
 	  Marvell DB-88F6281-BP Development Board.
 
+config MACH_IX4_88F6281_NAS
+	bool "Iomega ix4-200d NAS"
+	help
+	  Say 'Y' here if you want your kernel to support the
+	  Iomega ix4-200d NAS.
+
 config MACH_RD88F6192_NAS
 	bool "Marvell RD-88F6192-NAS Reference Board"
 	help
diff --git a/arch/arm/mach-kirkwood/Makefile b/arch/arm/mach-kirkwood/Makefile
index 80ab0ec..8613f6b 100644
--- a/arch/arm/mach-kirkwood/Makefile
+++ b/arch/arm/mach-kirkwood/Makefile
@@ -1,6 +1,7 @@
 obj-y				+= common.o addr-map.o irq.o pcie.o mpp.o
 
 obj-$(CONFIG_MACH_DB88F6281_BP)		+= db88f6281-bp-setup.o
+obj-$(CONFIG_MACH_IX4_88F6281_NAS)	+= ix4-88f6281-setup.o
 obj-$(CONFIG_MACH_RD88F6192_NAS)	+= rd88f6192-nas-setup.o
 obj-$(CONFIG_MACH_RD88F6281)		+= rd88f6281-setup.o
 obj-$(CONFIG_MACH_MV88F6281GTW_GE)	+= mv88f6281gtw_ge-setup.o
diff --git a/arch/arm/mach-kirkwood/ix4-88f6281-setup.c b/arch/arm/mach-kirkwood/ix4-88f6281-setup.c
new file mode 100644
index 0000000..17e8e32
--- /dev/null
+++ b/arch/arm/mach-kirkwood/ix4-88f6281-setup.c
@@ -0,0 +1,135 @@
+/*
+ * Marvell RD-88F6281 Reference Board Setup
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/irq.h>
+#include <linux/mtd/nand.h>
+#include <linux/mtd/partitions.h>
+#include <linux/ata_platform.h>
+#include <linux/mv643xx_eth.h>
+#include <linux/ethtool.h>
+#include <net/dsa.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <mach/kirkwood.h>
+#include <plat/mvsdio.h>
+#include <plat/orion_nand.h>
+#include "common.h"
+#include "mpp.h"
+
+static struct mtd_partition nasix4200d_nand_parts[] = {
+	{
+		.name = "uboot",
+		.offset = 0,
+		.size = 655360
+	}, {
+		.name = "env",
+		.offset = MTDPART_OFS_APPEND,
+		.size = 65536
+	}, {
+		.name = "kernel",
+		.offset = MTDPART_OFS_APPEND,
+		.size = 2293760
+	}, {
+		.name = "rootfs",
+		.offset = MTDPART_OFS_APPEND,
+		.size = 30539776
+	},
+};
+
+static struct resource nasix4200d_nand_resource = {
+	.flags		= IORESOURCE_MEM,
+	.start		= KIRKWOOD_NAND_MEM_PHYS_BASE,
+	.end		= KIRKWOOD_NAND_MEM_PHYS_BASE +
+			  KIRKWOOD_NAND_MEM_SIZE - 1,
+};
+
+static struct orion_nand_data nasix4200d_nand_data = {
+	.parts		= nasix4200d_nand_parts,
+	.nr_parts	= ARRAY_SIZE(nasix4200d_nand_parts),
+	.cle		= 0,
+	.ale		= 1,
+	.width		= 8,
+	.chip_delay	= 25,
+};
+
+static struct platform_device nasix4200d_nand_flash = {
+	.name		= "orion_nand",
+	.id		= -1,
+	.dev		= {
+		.platform_data	= &nasix4200d_nand_data,
+	},
+	.resource	= &nasix4200d_nand_resource,
+	.num_resources	= 1,
+};
+
+/* #ifdef IX4_BOARD MV_BOARD_INFO db88f6281AInfo db88f6281AInfoBoardMacInfo */
+static struct mv643xx_eth_platform_data nasix4200d_ge00_data = {
+	.phy_addr	= MV643XX_ETH_PHY_ADDR(8),
+};
+
+static struct mv643xx_eth_platform_data nasix4200d_ge01_data = {
+	.phy_addr	= MV643XX_ETH_PHY_ADDR(9),
+};
+
+static struct mv_sata_platform_data nasix4200d_sata_data = {
+	.n_ports	= 2,
+};
+
+static struct mvsdio_platform_data nasix4200d_mvsdio_data = {
+	.gpio_write_protect	= 37,
+	.gpio_card_detect	= 38,
+};
+
+static unsigned int nasix4200d_mpp_config[] __initdata = {
+	MPP37_GPIO,
+	MPP38_GPIO,
+	0
+};
+
+static void __init nasix4200d_init(void)
+{
+	/*
+	 * Basic setup. Needs to be called early.
+	 */
+	kirkwood_init();
+	kirkwood_mpp_conf(nasix4200d_mpp_config);
+
+	kirkwood_ehci_init();
+
+	kirkwood_ge00_init(&nasix4200d_ge00_data);
+	kirkwood_ge01_init(&nasix4200d_ge01_data);
+
+	kirkwood_sata_init(&nasix4200d_sata_data);
+	kirkwood_sdio_init(&nasix4200d_mvsdio_data);
+	kirkwood_uart0_init();
+
+	platform_device_register(&nasix4200d_nand_flash);
+}
+
+static int __init nasix4200d_pci_init(void)
+{
+	if (machine_is_nasix4200d())
+		kirkwood_pcie_init();
+
+	return 0;
+}
+subsys_initcall(nasix4200d_pci_init);
+
+MACHINE_START(NASIX4200D, "Iomega NAS ix4-200d")
+	/* Maintainer: Saeed Bishara <saeed@marvell.com> */
+	.phys_io	= KIRKWOOD_REGS_PHYS_BASE,
+	.io_pg_offst	= ((KIRKWOOD_REGS_VIRT_BASE) >> 18) & 0xfffc,
+	.boot_params	= 0x00000100,
+	.init_machine	= nasix4200d_init,
+	.map_io		= kirkwood_map_io,
+	.init_irq	= kirkwood_init_irq,
+	.timer		= &kirkwood_timer,
+MACHINE_END
diff --git a/arch/arm/tools/mach-types b/arch/arm/tools/mach-types
index c8c55b4..7d84176 100644
--- a/arch/arm/tools/mach-types
+++ b/arch/arm/tools/mach-types
@@ -2132,6 +2132,7 @@ apollo			MACH_APOLLO		APOLLO			2141
 at91cap9stk		MACH_AT91CAP9STK	AT91CAP9STK		2142
 spc300			MACH_SPC300		SPC300			2143
 eko			MACH_EKO		EKO			2144
+nasix4200d		MACH_IX4_88F6281_NAS	NASIX4200D		2145
 ccw9m2443		MACH_CCW9M2443		CCW9M2443		2145
 ccw9m2443js		MACH_CCW9M2443JS	CCW9M2443JS		2146
 m2m_router_device	MACH_M2M_ROUTER_DEVICE	M2M_ROUTER_DEVICE	2147
