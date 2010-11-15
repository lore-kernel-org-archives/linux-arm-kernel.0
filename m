From: cyril@ti.com (Cyril Chemparathy)
Date: Mon, 15 Nov 2010 14:12:13 -0500
Subject: [PATCH v5 11/12] davinci: add tnetv107x evm backlight device
In-Reply-To: <1289848334-8695-1-git-send-email-cyril@ti.com>
References: <1289848334-8695-1-git-send-email-cyril@ti.com>
Message-ID: <1289848334-8695-12-git-send-email-cyril@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The tnetv107x evm board has a backlight device that is connected on one of the
SSP ports.  This patch adds the board definitions necessary to plug the
backlight driver to the GPIO corresponding to this SSP pin.

Signed-off-by: Cyril Chemparathy <cyril@ti.com>
---
 arch/arm/mach-davinci/board-tnetv107x-evm.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/board-tnetv107x-evm.c b/arch/arm/mach-davinci/board-tnetv107x-evm.c
index e3863dd..945a958 100644
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
@@ -361,6 +368,8 @@ static __init void tnetv107x_evm_board_init(void)
 
 	tnetv107x_devices_init(&evm_device_info);
 
+	platform_device_register(&backlight_device);
+
 	spi_register_board_info(spi_info, ARRAY_SIZE(spi_info));
 }
 
-- 
1.7.1
