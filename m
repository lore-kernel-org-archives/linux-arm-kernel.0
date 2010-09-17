From: michael.williamson@criticallink.com (Michael Williamson)
Date: Fri, 17 Sep 2010 09:56:06 -0400
Subject: [PATCH v3] davinci: MityDSP-L138/MityARM-1808 read MAC address from
	I2C Prom
Message-ID: <1284731766-2751-1-git-send-email-michael.williamson@criticallink.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For the MityDSP-L138/MityARM-1808 SOMS, read the factory assigned
MAC address from the onboard I2C EPROM and assign it to the emac
device during platform initialization.

Signed-off-by: Michael Williamson <michael.williamson@criticallink.com>
---
Patch is against e90c3a5344683351c7a37f097f1e17d50ee2063c of linux-davinci 
tree.

Changes since v2:
	1) removed 8 bytes of &'s and [0]'s from &foo[0]'s per comments

 arch/arm/mach-davinci/board-mityomapl138.c |   62 ++++++++++++++++++++++++++++
 1 files changed, 62 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
index 6f12a18..65f7501 100644
--- a/arch/arm/mach-davinci/board-mityomapl138.c
+++ b/arch/arm/mach-davinci/board-mityomapl138.c
@@ -15,6 +15,8 @@
 #include <linux/mtd/partitions.h>
 #include <linux/regulator/machine.h>
 #include <linux/i2c.h>
+#include <linux/i2c/at24.h>
+#include <linux/etherdevice.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -25,6 +27,65 @@
 #include <mach/mux.h>
 
 #define MITYOMAPL138_PHY_ID		"0:03"
+
+#define FACTORY_CONFIG_MAGIC	0x012C0138
+#define FACTORY_CONFIG_VERSION	0x00010001
+
+/* Data Held in On-Board I2C device */
+struct factory_config {
+	u32	magic;
+	u32	version;
+	u8	mac[6];
+	u32	fpga_type;
+	u32	spare;
+	u32	serialnumber;
+	char	partnum[32];
+};
+
+static struct factory_config factory_config;
+
+static void read_factory_config(struct memory_accessor *a, void *context)
+{
+	int ret;
+	struct davinci_soc_info *soc_info = &davinci_soc_info;
+
+	ret = a->read(a, (char *)&factory_config, 0, sizeof(factory_config));
+	if (ret != sizeof(struct factory_config)) {
+		pr_warning("MityOMAPL138: Read Factory Config Failed: %d\n",
+				ret);
+		return;
+	}
+
+	if (factory_config.magic != FACTORY_CONFIG_MAGIC) {
+		pr_warning("MityOMAPL138: Factory Config Magic Wrong (%X)\n",
+				factory_config.magic);
+		return;
+	}
+
+	if (factory_config.version != FACTORY_CONFIG_VERSION) {
+		pr_warning("MityOMAPL138: Factory Config Version Wrong (%X)\n",
+				factory_config.version);
+		return;
+	}
+
+	pr_info("MityOMAPL138: Found MAC = %pM\n", factory_config.mac);
+	pr_info("MityOMAPL138: Part Number = %s\n", factory_config.partnum);
+	if (is_valid_ether_addr(factory_config.mac))
+		memcpy(soc_info->emac_pdata->mac_addr,
+			factory_config.mac, ETH_ALEN);
+	else
+		pr_warning("MityOMAPL138: Invalid MAC found "
+				"in factory config block\n");
+}
+
+static struct at24_platform_data mityomapl138_fd_chip = {
+	.byte_len	= 256,
+	.page_size	= 8,
+	.flags		= AT24_FLAG_READONLY | AT24_FLAG_IRUGO,
+	.setup		= read_factory_config,
+	.context	= NULL,
+};
+
 static struct davinci_i2c_platform_data mityomap_i2c_0_pdata = {
 	.bus_freq	= 100,	/* kHz */
 	.bus_delay	= 0,	/* usec */
@@ -151,6 +212,7 @@ static struct i2c_board_info __initdata mityomap_tps65023_info[] = {
 	},
 	{
 		I2C_BOARD_INFO("24c02", 0x50),
+		.platform_data = &mityomapl138_fd_chip,
 	},
 };
 
-- 
1.7.0.4
