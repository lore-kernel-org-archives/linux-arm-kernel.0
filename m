From: alex@digriz.org.uk (Alexander Clouter)
Date: Fri, 9 Oct 2009 13:39:56 +0100
Subject: [PATCH] [ARM] kirkwood: combine support for openrd base/client support
Message-ID: <20091009123956.GA6085@chipmunk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Based on the work done by Dhaval Vasa to add OpenRD Base support (and 
the unmerged Client) support, this patch adds support for the 
Kirkwood OpenRD Client board.

I was 'inspired' by the work Hartley Sweeten had done in flattening 
mach-ep93xx into a single setup.c file; as there is really not much 
difference between the OpenRD Base and Client boards I think it is 
appropriate to do the same here.

Signed-off-by: Alexander Clouter <alex@digriz.org.uk>

diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
index 0aca451..8e9ac7d 100644
--- a/arch/arm/mach-kirkwood/Kconfig
+++ b/arch/arm/mach-kirkwood/Kconfig
@@ -38,12 +38,23 @@ config MACH_TS219
 	  Say 'Y' here if you want your kernel to support the
 	  QNAP TS-119 and TS-219 Turbo NAS devices.
 
+config MACH_OPENRD
+        bool
+
 config MACH_OPENRD_BASE
 	bool "Marvell OpenRD Base Board"
+	select MACH_OPENRD
 	help
 	  Say 'Y' here if you want your kernel to support the
 	  Marvell OpenRD Base Board.
 
+config MACH_OPENRD_CLIENT
+	bool "Marvell OpenRD Client Board"
+	select MACH_OPENRD
+	help
+	  Say 'Y' here if you want your kernel to support the
+	  Marvell OpenRD Client Board.
+
 endmenu
 
 endif
diff --git a/arch/arm/mach-kirkwood/Makefile b/arch/arm/mach-kirkwood/Makefile
index 80ab0ec..5ad19dd 100644
--- a/arch/arm/mach-kirkwood/Makefile
+++ b/arch/arm/mach-kirkwood/Makefile
@@ -6,6 +6,6 @@ obj-$(CONFIG_MACH_RD88F6281)		+= rd88f6281-setup.o
 obj-$(CONFIG_MACH_MV88F6281GTW_GE)	+= mv88f6281gtw_ge-setup.o
 obj-$(CONFIG_MACH_SHEEVAPLUG)		+= sheevaplug-setup.o
 obj-$(CONFIG_MACH_TS219)		+= ts219-setup.o
-obj-$(CONFIG_MACH_OPENRD_BASE)		+= openrd_base-setup.o
+obj-$(CONFIG_MACH_OPENRD)		+= openrd-setup.o
 
 obj-$(CONFIG_CPU_IDLE)			+= cpuidle.o
diff --git a/arch/arm/mach-kirkwood/openrd-setup.c b/arch/arm/mach-kirkwood/openrd-setup.c
new file mode 100644
index 0000000..6bdeeab
--- /dev/null
+++ b/arch/arm/mach-kirkwood/openrd-setup.c
@@ -0,0 +1,109 @@
+/*
+ * arch/arm/mach-kirkwood/openrd-setup.c
+ *
+ * Marvell OpenRD (Base|Client) Board Setup
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/mtd/partitions.h>
+#include <linux/ata_platform.h>
+#include <linux/mv643xx_eth.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <mach/kirkwood.h>
+#include <plat/mvsdio.h>
+#include "common.h"
+#include "mpp.h"
+
+static struct mtd_partition openrd_nand_parts[] = {
+	{
+		.name = "u-boot",
+		.offset = 0,
+		.size = SZ_1M
+	}, {
+		.name = "uImage",
+		.offset = MTDPART_OFS_NXTBLK,
+		.size = SZ_4M
+	}, {
+		.name = "root",
+		.offset = MTDPART_OFS_NXTBLK,
+		.size = MTDPART_SIZ_FULL
+	},
+};
+
+static struct mv643xx_eth_platform_data openrd_ge00_data = {
+	.phy_addr	= MV643XX_ETH_PHY_ADDR(8),
+};
+
+#ifdef CONFIG_MACH_OPENRD_CLIENT
+static struct mv643xx_eth_platform_data openrd_ge01_data = {
+	.phy_addr	= MV643XX_ETH_PHY_ADDR(18),
+};
+#endif
+
+static struct mv_sata_platform_data openrd_sata_data = {
+	.n_ports	= 2,
+};
+
+static struct mvsdio_platform_data openrd_mvsdio_data = {
+	.gpio_card_detect = 29,	/* MPP29 used as SD card detect */
+};
+
+static unsigned int openrd_mpp_config[] __initdata = {
+	MPP29_GPIO,
+	0
+};
+
+static void __init openrd_init(void)
+{
+	/*
+	 * Basic setup. Needs to be called early.
+	 */
+	kirkwood_init();
+	kirkwood_mpp_conf(openrd_mpp_config);
+
+	kirkwood_uart0_init();
+	kirkwood_nand_init(ARRAY_AND_SIZE(openrd_nand_parts), 25);
+
+	kirkwood_ehci_init();
+
+	kirkwood_ge00_init(&openrd_ge00_data);
+#ifdef CONFIG_MACH_OPENRD_CLIENT
+	if (machine_is_openrd_client())
+		kirkwood_ge01_init(&openrd_ge01_data);
+#endif
+	kirkwood_sata_init(&openrd_sata_data);
+	kirkwood_sdio_init(&openrd_mvsdio_data);
+}
+
+#ifdef CONFIG_MACH_OPENRD_BASE
+MACHINE_START(OPENRD_BASE, "Marvell OpenRD Base Board")
+	/* Maintainer: Dhaval Vasa <dhaval.vasa@einfochips.com> */
+	.phys_io	= KIRKWOOD_REGS_PHYS_BASE,
+	.io_pg_offst	= ((KIRKWOOD_REGS_VIRT_BASE) >> 18) & 0xfffc,
+	.boot_params	= 0x00000100,
+	.init_machine	= openrd_init,
+	.map_io		= kirkwood_map_io,
+	.init_irq	= kirkwood_init_irq,
+	.timer		= &kirkwood_timer,
+MACHINE_END
+#endif
+
+#ifdef CONFIG_MACH_OPENRD_CLIENT
+MACHINE_START(OPENRD_CLIENT, "Marvell OpenRD Client Board")
+	/* Maintainer: Dhaval Vasa <dhaval.vasa@einfochips.com> */
+	.phys_io	= KIRKWOOD_REGS_PHYS_BASE,
+	.io_pg_offst	= ((KIRKWOOD_REGS_VIRT_BASE) >> 18) & 0xfffc,
+	.boot_params	= 0x00000100,
+	.init_machine	= openrd_init,
+	.map_io		= kirkwood_map_io,
+	.init_irq	= kirkwood_init_irq,
+	.timer		= &kirkwood_timer,
+MACHINE_END
+#endif
diff --git a/arch/arm/mach-kirkwood/openrd_base-setup.c b/arch/arm/mach-kirkwood/openrd_base-setup.c
deleted file mode 100644
index 947dfb8..0000000
--- a/arch/arm/mach-kirkwood/openrd_base-setup.c
+++ /dev/null
@@ -1,84 +0,0 @@
-/*
- * arch/arm/mach-kirkwood/openrd_base-setup.c
- *
- * Marvell OpenRD Base Board Setup
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/mtd/partitions.h>
-#include <linux/ata_platform.h>
-#include <linux/mv643xx_eth.h>
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-#include <mach/kirkwood.h>
-#include <plat/mvsdio.h>
-#include "common.h"
-#include "mpp.h"
-
-static struct mtd_partition openrd_base_nand_parts[] = {
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
-static struct mv643xx_eth_platform_data openrd_base_ge00_data = {
-	.phy_addr	= MV643XX_ETH_PHY_ADDR(8),
-};
-
-static struct mv_sata_platform_data openrd_base_sata_data = {
-	.n_ports	= 2,
-};
-
-static struct mvsdio_platform_data openrd_base_mvsdio_data = {
-	.gpio_card_detect = 29,	/* MPP29 used as SD card detect */
-};
-
-static unsigned int openrd_base_mpp_config[] __initdata = {
-	MPP29_GPIO,
-	0
-};
-
-static void __init openrd_base_init(void)
-{
-	/*
-	 * Basic setup. Needs to be called early.
-	 */
-	kirkwood_init();
-	kirkwood_mpp_conf(openrd_base_mpp_config);
-
-	kirkwood_uart0_init();
-	kirkwood_nand_init(ARRAY_AND_SIZE(openrd_base_nand_parts), 25);
-
-	kirkwood_ehci_init();
-
-	kirkwood_ge00_init(&openrd_base_ge00_data);
-	kirkwood_sata_init(&openrd_base_sata_data);
-	kirkwood_sdio_init(&openrd_base_mvsdio_data);
-}
-
-MACHINE_START(OPENRD_BASE, "Marvell OpenRD Base Board")
-	/* Maintainer: Dhaval Vasa <dhaval.vasa@einfochips.com> */
-	.phys_io	= KIRKWOOD_REGS_PHYS_BASE,
-	.io_pg_offst	= ((KIRKWOOD_REGS_VIRT_BASE) >> 18) & 0xfffc,
-	.boot_params	= 0x00000100,
-	.init_machine	= openrd_base_init,
-	.map_io		= kirkwood_map_io,
-	.init_irq	= kirkwood_init_irq,
-	.timer		= &kirkwood_timer,
-MACHINE_END
