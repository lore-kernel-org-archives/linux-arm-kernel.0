From: cyril@ti.com (Cyril Chemparathy)
Date: Tue,  7 Dec 2010 09:51:55 -0500
Subject: [PATCH v7 05/12] davinci: add spi devices on tnetv107x evm
In-Reply-To: <1291733522-3626-1-git-send-email-cyril@ti.com>
References: <1291733522-3626-1-git-send-email-cyril@ti.com>
Message-ID: <1291733522-3626-6-git-send-email-cyril@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds definitions for spi devices on the tnetv107x evm platform.

Signed-off-by: Cyril Chemparathy <cyril@ti.com>
---
 arch/arm/mach-davinci/board-tnetv107x-evm.c |   43 +++++++++++++++++++++++++++
 1 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/board-tnetv107x-evm.c b/arch/arm/mach-davinci/board-tnetv107x-evm.c
index ef526b1..1a656e8 100644
--- a/arch/arm/mach-davinci/board-tnetv107x-evm.c
+++ b/arch/arm/mach-davinci/board-tnetv107x-evm.c
@@ -25,6 +25,7 @@
 #include <linux/mtd/partitions.h>
 #include <linux/input.h>
 #include <linux/input/matrix_keypad.h>
+#include <linux/spi/spi.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
@@ -37,6 +38,7 @@
 
 #define EVM_MMC_WP_GPIO		21
 #define EVM_MMC_CD_GPIO		24
+#define EVM_SPI_CS_GPIO		54
 
 static int initialize_gpio(int gpio, char *desc)
 {
@@ -202,9 +204,45 @@ static struct matrix_keypad_platform_data keypad_config = {
 	.no_autorepeat	= 0,
 };
 
+static void spi_select_device(int cs)
+{
+	static int gpio;
+
+	if (!gpio) {
+		int ret;
+		ret = gpio_request(EVM_SPI_CS_GPIO, "spi chipsel");
+		if (ret < 0) {
+			pr_err("cannot open spi chipsel gpio\n");
+			gpio = -ENOSYS;
+			return;
+		} else {
+			gpio = EVM_SPI_CS_GPIO;
+			gpio_direction_output(gpio, 0);
+		}
+	}
+
+	if (gpio < 0)
+		return;
+
+	return gpio_set_value(gpio, cs ? 1 : 0);
+}
+
+static struct ti_ssp_spi_data spi_master_data = {
+	.num_cs	= 2,
+	.select	= spi_select_device,
+	.iosel	= SSP_PIN_SEL(0, SSP_CLOCK)	| SSP_PIN_SEL(1, SSP_DATA) |
+		  SSP_PIN_SEL(2, SSP_CHIPSEL)	| SSP_PIN_SEL(3, SSP_IN)   |
+		  SSP_INPUT_SEL(3),
+};
+
 static struct ti_ssp_data ssp_config = {
 	.out_clock	= 250 * 1000,
 	.dev_data	= {
+		[1] = {
+			.dev_name = "ti-ssp-spi",
+			.pdata = &spi_master_data,
+			.pdata_size = sizeof(spi_master_data),
+		},
 	},
 };
 
@@ -216,6 +254,9 @@ static struct tnetv107x_device_info evm_device_info __initconst = {
 	.ssp_config		= &ssp_config,
 };
 
+static struct spi_board_info spi_info[] __initconst = {
+};
+
 static __init void tnetv107x_evm_board_init(void)
 {
 	davinci_cfg_reg_list(sdio1_pins);
@@ -223,6 +264,8 @@ static __init void tnetv107x_evm_board_init(void)
 	davinci_cfg_reg_list(ssp_pins);
 
 	tnetv107x_devices_init(&evm_device_info);
+
+	spi_register_board_info(spi_info, ARRAY_SIZE(spi_info));
 }
 
 #ifdef CONFIG_SERIAL_8250_CONSOLE
-- 
1.7.1
