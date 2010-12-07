From: cyril@ti.com (Cyril Chemparathy)
Date: Tue,  7 Dec 2010 09:52:01 -0500
Subject: [PATCH v7 11/12] davinci: add tnetv107x evm backlight device
In-Reply-To: <1291733522-3626-1-git-send-email-cyril@ti.com>
References: <1291733522-3626-1-git-send-email-cyril@ti.com>
Message-ID: <1291733522-3626-12-git-send-email-cyril@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The tnetv107x evm board has a backlight device that is connected on one of the
SSP ports.  This patch adds the board definitions necessary to plug the
backlight driver to the GPIO corresponding to this SSP pin.

Signed-off-by: Cyril Chemparathy <cyril@ti.com>
---
 arch/arm/mach-davinci/board-tnetv107x-evm.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/board-tnetv107x-evm.c b/arch/arm/mach-davinci/board-tnetv107x-evm.c
index e3863dd..ac62de2 100644
--- a/arch/arm/mach-davinci/board-tnetv107x-evm.c
+++ b/arch/arm/mach-davinci/board-tnetv107x-evm.c
@@ -44,6 +44,7 @@
 #define EVM_MMC_WP_GPIO		21
 #define EVM_MMC_CD_GPIO		24
 #define EVM_SPI_CS_GPIO		54
+#define EVM_BACKLIGHT_GPIO	(SSP_GPIO_START + 2)
 
 static int initialize_gpio(int gpio, char *desc)
 {
@@ -353,6 +354,12 @@ static struct spi_board_info spi_info[] __initconst = {
 	},
 };
 
+static struct platform_device backlight_device = {
+	.name		= "tps6116x",
+	.id		= -1,
+	.dev.platform_data = (void *)EVM_BACKLIGHT_GPIO,
+};
+
 static __init void tnetv107x_evm_board_init(void)
 {
 	davinci_cfg_reg_list(sdio1_pins);
@@ -364,6 +371,13 @@ static __init void tnetv107x_evm_board_init(void)
 	spi_register_board_info(spi_info, ARRAY_SIZE(spi_info));
 }
 
+static int __init tnetv107x_evm_late_init(void)
+{
+	platform_device_register(&backlight_device);
+	return 0;
+}
+late_initcall(tnetv107x_evm_late_init);
+
 #ifdef CONFIG_SERIAL_8250_CONSOLE
 static int __init tnetv107x_evm_console_init(void)
 {
-- 
1.7.1
