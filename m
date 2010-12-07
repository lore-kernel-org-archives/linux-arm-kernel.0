From: cyril@ti.com (Cyril Chemparathy)
Date: Tue,  7 Dec 2010 09:51:57 -0500
Subject: [PATCH v7 07/12] davinci: add tnetv107x evm regulators
In-Reply-To: <1291733522-3626-1-git-send-email-cyril@ti.com>
References: <1291733522-3626-1-git-send-email-cyril@ti.com>
Message-ID: <1291733522-3626-8-git-send-email-cyril@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds regulator and spi board info definitions for the tps6524x
power management IC found on tnetv107x evm boards.

Signed-off-by: Cyril Chemparathy <cyril@ti.com>
---
 arch/arm/mach-davinci/board-tnetv107x-evm.c |   85 +++++++++++++++++++++++++++
 1 files changed, 85 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/board-tnetv107x-evm.c b/arch/arm/mach-davinci/board-tnetv107x-evm.c
index 1a656e8..ca23516 100644
--- a/arch/arm/mach-davinci/board-tnetv107x-evm.c
+++ b/arch/arm/mach-davinci/board-tnetv107x-evm.c
@@ -26,6 +26,9 @@
 #include <linux/input.h>
 #include <linux/input/matrix_keypad.h>
 #include <linux/spi/spi.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/consumer.h>
+#include <linux/regulator/driver.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
@@ -254,7 +257,89 @@ static struct tnetv107x_device_info evm_device_info __initconst = {
 	.ssp_config		= &ssp_config,
 };
 
+static struct regulator_consumer_supply usb_consumers[] = {
+	REGULATOR_SUPPLY("vbus", "musb_hdrc.1"),
+};
+
+static struct regulator_consumer_supply lcd_consumers[] = {
+	REGULATOR_SUPPLY("vlcd", "tps6116x"),
+};
+
+static struct regulator_init_data regulators[] = {
+	{
+		.constraints		= {
+			.name		= "DCDC1",
+			.min_uV		= 1000000,
+			.max_uV		= 1000000,
+			.always_on	= 1,
+			.boot_on	= 1,
+		},
+	},
+	{
+		.constraints		= {
+			.name		= "DCDC2",
+			.min_uV		= 1800000,
+			.max_uV		= 1800000,
+			.always_on	= 1,
+			.boot_on	= 1,
+		},
+	},
+	{
+		.constraints		= {
+			.name		= "DCDC3",
+			.min_uV		= 3300000,
+			.max_uV		= 3300000,
+			.always_on	= 1,
+			.boot_on	= 1,
+		},
+	},
+	{
+		.constraints		= {
+			.name		= "LDO1",
+			.min_uV		= 4800000,
+			.max_uV		= 4800000,
+			.always_on	= 1,
+			.boot_on	= 1,
+		},
+	},
+	{
+		.constraints		= {
+			.name		= "LDO1",
+			.min_uV		= 3300000,
+			.max_uV		= 3300000,
+			.always_on	= 1,
+			.boot_on	= 1,
+		},
+	},
+	{
+		.num_consumer_supplies	= ARRAY_SIZE(usb_consumers),
+		.consumer_supplies	= usb_consumers,
+		.constraints		= {
+			.name		= "USB",
+			.min_uA		= 200000,
+			.max_uA		= 1000000,
+			.valid_ops_mask	= REGULATOR_CHANGE_CURRENT |
+					  REGULATOR_CHANGE_STATUS,
+		},
+	},
+	{
+		.num_consumer_supplies	= ARRAY_SIZE(lcd_consumers),
+		.consumer_supplies	= lcd_consumers,
+		.constraints		= {
+			.name		= "LCD",
+			.valid_ops_mask	= REGULATOR_CHANGE_STATUS,
+		},
+	},
+};
+
 static struct spi_board_info spi_info[] __initconst = {
+	{
+		.modalias	= "tps6524x",
+		.bus_num	= 1,
+		.chip_select	= 0,
+		.mode		= SPI_MODE_0,
+		.platform_data	= regulators,
+	},
 };
 
 static __init void tnetv107x_evm_board_init(void)
-- 
1.7.1
