From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri, 16 Oct 2009 12:09:48 -0700
Subject: [PATCH 44/46] davinci: dm646x-evm: Add platform data for NAND
In-Reply-To: <1255720190-7452-45-git-send-email-khilman@deeprootsystems.com>
References: <1255720190-7452-1-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-2-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-3-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-4-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-5-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-6-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-7-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-8-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-9-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-10-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-11-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-12-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-13-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-14-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-15-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-16-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-17-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-18-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-19-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-20-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-21-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-22-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-23-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-24-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-25-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-26-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-27-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-28-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-29-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-30-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-31-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-32-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-33-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-34-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-35-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-36-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-37-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-38-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-39-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-40-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-41-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-42-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-43-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-44-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-45-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1255720190-7452-46-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hemant Pedanekar <hemantp@ti.com>

This patch adds platform data and partition info for NAND on dm6467 EVM.

Note that the partition layout is dependent on the UBL, U-Boot etc. used. This
patch tries to minimize that dependency by setting first partition for UBL,
U-Boot and environment altogether.

Signed-off-by: Hemant Pedanekar <hemantp@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/board-dm646x-evm.c |   69 ++++++++++++++++++++++++++++++
 1 files changed, 69 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
index 8cf4979..75b2b6f 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -27,6 +27,10 @@
 
 #include <media/tvp514x.h>
 
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/nand.h>
+#include <linux/mtd/partitions.h>
+
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
@@ -34,6 +38,7 @@
 #include <mach/common.h>
 #include <mach/serial.h>
 #include <mach/i2c.h>
+#include <mach/nand.h>
 
 #if defined(CONFIG_BLK_DEV_PALMCHIP_BK3710) || \
     defined(CONFIG_BLK_DEV_PALMCHIP_BK3710_MODULE)
@@ -42,6 +47,11 @@
 #define HAS_ATA 0
 #endif
 
+#define DAVINCI_ASYNC_EMIF_CONTROL_BASE		0x20008000
+#define DAVINCI_ASYNC_EMIF_DATA_CE0_BASE	0x42000000
+
+#define NAND_BLOCK_SIZE		SZ_128K
+
 /* CPLD Register 0 bits to control ATA */
 #define DM646X_EVM_ATA_RST		BIT(0)
 #define DM646X_EVM_ATA_PWD		BIT(1)
@@ -77,6 +87,63 @@ static struct davinci_uart_config uart_config __initdata = {
 	.enabled_uarts = (1 << 0),
 };
 
+/* Note: We are setting first partition as 'bootloader' constituting UBL, U-Boot
+ * and U-Boot environment this avoids dependency on any particular combination
+ * of UBL, U-Boot or flashing tools etc.
+ */
+static struct mtd_partition davinci_nand_partitions[] = {
+	{
+		/* UBL, U-Boot with environment */
+		.name		= "bootloader",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= 16 * NAND_BLOCK_SIZE,
+		.mask_flags	= MTD_WRITEABLE,	/* force read-only */
+	}, {
+		.name		= "kernel",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= SZ_4M,
+		.mask_flags	= 0,
+	}, {
+		.name		= "filesystem",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= MTDPART_SIZ_FULL,
+		.mask_flags	= 0,
+	}
+};
+
+static struct davinci_nand_pdata davinci_nand_data = {
+	.mask_cle 		= 0x80000,
+	.mask_ale 		= 0x40000,
+	.parts			= davinci_nand_partitions,
+	.nr_parts		= ARRAY_SIZE(davinci_nand_partitions),
+	.ecc_mode		= NAND_ECC_HW,
+	.options		= 0,
+};
+
+static struct resource davinci_nand_resources[] = {
+	{
+		.start		= DAVINCI_ASYNC_EMIF_DATA_CE0_BASE,
+		.end		= DAVINCI_ASYNC_EMIF_DATA_CE0_BASE + SZ_32M - 1,
+		.flags		= IORESOURCE_MEM,
+	}, {
+		.start		= DAVINCI_ASYNC_EMIF_CONTROL_BASE,
+		.end		= DAVINCI_ASYNC_EMIF_CONTROL_BASE + SZ_4K - 1,
+		.flags		= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device davinci_nand_device = {
+	.name			= "davinci_nand",
+	.id			= 0,
+
+	.num_resources		= ARRAY_SIZE(davinci_nand_resources),
+	.resource		= davinci_nand_resources,
+
+	.dev			= {
+		.platform_data	= &davinci_nand_data,
+	},
+};
+
 /* CPLD Register 0 Client: used for I/O Control */
 static int cpld_reg0_probe(struct i2c_client *client,
 			   const struct i2c_device_id *id)
@@ -632,6 +699,8 @@ static __init void evm_init(void)
 	dm646x_init_mcasp0(&dm646x_evm_snd_data[0]);
 	dm646x_init_mcasp1(&dm646x_evm_snd_data[1]);
 
+	platform_device_register(&davinci_nand_device);
+
 	if (HAS_ATA)
 		dm646x_init_ide();
 
-- 
1.6.4.3
