From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed,  6 Jan 2010 10:31:52 -0800
Subject: [PATCH 10/35] davinci: board-dm646x-evm.c: arrange related code
	together
In-Reply-To: <1262802737-6601-10-git-send-email-khilman@deeprootsystems.com>
References: <1262802737-6601-1-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-2-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-3-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-4-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-5-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-6-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-7-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-8-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-9-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-10-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1262802737-6601-11-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sekhar Nori <nsekhar@ti.com>

Currently all the #defines and static variables in the
board-dm646x-evm.c file are located right at the start
of the file because of which the related code is not
together - making reading the code difficult.

This patch moves around the code keeping related code
together.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/board-dm646x-evm.c |   90 +++++++++++++++---------------
 1 files changed, 45 insertions(+), 45 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
index 8d0b0e0..8c05343 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -40,53 +40,8 @@
 #include <mach/i2c.h>
 #include <mach/nand.h>
 
-#if defined(CONFIG_BLK_DEV_PALMCHIP_BK3710) || \
-    defined(CONFIG_BLK_DEV_PALMCHIP_BK3710_MODULE)
-#define HAS_ATA 1
-#else
-#define HAS_ATA 0
-#endif
-
-#define DAVINCI_ASYNC_EMIF_CONTROL_BASE		0x20008000
-#define DAVINCI_ASYNC_EMIF_DATA_CE0_BASE	0x42000000
-
 #define NAND_BLOCK_SIZE		SZ_128K
 
-/* CPLD Register 0 bits to control ATA */
-#define DM646X_EVM_ATA_RST		BIT(0)
-#define DM646X_EVM_ATA_PWD		BIT(1)
-
-#define DM646X_EVM_PHY_MASK		(0x2)
-#define DM646X_EVM_MDIO_FREQUENCY	(2200000) /* PHY bus frequency */
-
-#define VIDCLKCTL_OFFSET	(DAVINCI_SYSTEM_MODULE_BASE + 0x38)
-#define VSCLKDIS_OFFSET		(DAVINCI_SYSTEM_MODULE_BASE + 0x6c)
-#define VCH2CLK_MASK		(BIT_MASK(10) | BIT_MASK(9) | BIT_MASK(8))
-#define VCH2CLK_SYSCLK8		(BIT(9))
-#define VCH2CLK_AUXCLK		(BIT(9) | BIT(8))
-#define VCH3CLK_MASK		(BIT_MASK(14) | BIT_MASK(13) | BIT_MASK(12))
-#define VCH3CLK_SYSCLK8		(BIT(13))
-#define VCH3CLK_AUXCLK		(BIT(14) | BIT(13))
-
-#define VIDCH2CLK		(BIT(10))
-#define VIDCH3CLK		(BIT(11))
-#define VIDCH1CLK		(BIT(4))
-#define TVP7002_INPUT		(BIT(4))
-#define TVP5147_INPUT		(~BIT(4))
-#define VPIF_INPUT_ONE_CHANNEL	(BIT(5))
-#define VPIF_INPUT_TWO_CHANNEL	(~BIT(5))
-#define TVP5147_CH0		"tvp514x-0"
-#define TVP5147_CH1		"tvp514x-1"
-
-static void __iomem *vpif_vidclkctl_reg;
-static void __iomem *vpif_vsclkdis_reg;
-/* spin lock for updating above registers */
-static spinlock_t vpif_reg_lock;
-
-static struct davinci_uart_config uart_config __initdata = {
-	.enabled_uarts = (1 << 0),
-};
-
 /* Note: We are setting first partition as 'bootloader' constituting UBL, U-Boot
  * and U-Boot environment this avoids dependency on any particular combination
  * of UBL, U-Boot or flashing tools etc.
@@ -120,6 +75,9 @@ static struct davinci_nand_pdata davinci_nand_data = {
 	.options		= 0,
 };
 
+#define DAVINCI_ASYNC_EMIF_CONTROL_BASE		0x20008000
+#define DAVINCI_ASYNC_EMIF_DATA_CE0_BASE	0x42000000
+
 static struct resource davinci_nand_resources[] = {
 	{
 		.start		= DAVINCI_ASYNC_EMIF_DATA_CE0_BASE,
@@ -144,6 +102,17 @@ static struct platform_device davinci_nand_device = {
 	},
 };
 
+#if defined(CONFIG_BLK_DEV_PALMCHIP_BK3710) || \
+    defined(CONFIG_BLK_DEV_PALMCHIP_BK3710_MODULE)
+#define HAS_ATA 1
+#else
+#define HAS_ATA 0
+#endif
+
+/* CPLD Register 0 bits to control ATA */
+#define DM646X_EVM_ATA_RST		BIT(0)
+#define DM646X_EVM_ATA_PWD		BIT(1)
+
 /* CPLD Register 0 Client: used for I/O Control */
 static int cpld_reg0_probe(struct i2c_client *client,
 			   const struct i2c_device_id *id)
@@ -424,6 +393,30 @@ static struct davinci_i2c_platform_data i2c_pdata = {
 	.bus_delay      = 0 /* usec */,
 };
 
+#define VIDCLKCTL_OFFSET	(DAVINCI_SYSTEM_MODULE_BASE + 0x38)
+#define VSCLKDIS_OFFSET		(DAVINCI_SYSTEM_MODULE_BASE + 0x6c)
+#define VCH2CLK_MASK		(BIT_MASK(10) | BIT_MASK(9) | BIT_MASK(8))
+#define VCH2CLK_SYSCLK8		(BIT(9))
+#define VCH2CLK_AUXCLK		(BIT(9) | BIT(8))
+#define VCH3CLK_MASK		(BIT_MASK(14) | BIT_MASK(13) | BIT_MASK(12))
+#define VCH3CLK_SYSCLK8		(BIT(13))
+#define VCH3CLK_AUXCLK		(BIT(14) | BIT(13))
+
+#define VIDCH2CLK		(BIT(10))
+#define VIDCH3CLK		(BIT(11))
+#define VIDCH1CLK		(BIT(4))
+#define TVP7002_INPUT		(BIT(4))
+#define TVP5147_INPUT		(~BIT(4))
+#define VPIF_INPUT_ONE_CHANNEL	(BIT(5))
+#define VPIF_INPUT_TWO_CHANNEL	(~BIT(5))
+#define TVP5147_CH0		"tvp514x-0"
+#define TVP5147_CH1		"tvp514x-1"
+
+static void __iomem *vpif_vidclkctl_reg;
+static void __iomem *vpif_vsclkdis_reg;
+/* spin lock for updating above registers */
+static spinlock_t vpif_reg_lock;
+
 static int set_vpif_clock(int mux_mode, int hd)
 {
 	unsigned long flags;
@@ -690,6 +683,13 @@ static void __init davinci_map_io(void)
 	dm646x_init();
 }
 
+static struct davinci_uart_config uart_config __initdata = {
+	.enabled_uarts = (1 << 0),
+};
+
+#define DM646X_EVM_PHY_MASK		(0x2)
+#define DM646X_EVM_MDIO_FREQUENCY	(2200000) /* PHY bus frequency */
+
 static __init void evm_init(void)
 {
 	struct davinci_soc_info *soc_info = &davinci_soc_info;
-- 
1.6.6.rc2.1.g42108
