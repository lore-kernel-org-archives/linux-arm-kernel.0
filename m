From: festevam@gmail.com (Fabio Estevam)
Date: Tue,  3 Apr 2012 16:20:07 -0300
Subject: [PATCH 3/3] ARM: mx28evk: Add SPI NOR flash support
In-Reply-To: <1333480807-10480-1-git-send-email-festevam@gmail.com>
References: <1333480807-10480-1-git-send-email-festevam@gmail.com>
Message-ID: <1333480807-10480-3-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add SPI NOR flash support.

By default, the mx28evk board does not come with a SPI NOR flash populated.

Soldered a sst25vf016b and tested it using mtd-utils.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
I will submit the spi-mxs driver in a day or so.

 arch/arm/mach-mxs/Kconfig        |    1 +
 arch/arm/mach-mxs/mach-mx28evk.c |   20 ++++++++++++++++++++
 2 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
index c57f996..8078fbe 100644
--- a/arch/arm/mach-mxs/Kconfig
+++ b/arch/arm/mach-mxs/Kconfig
@@ -52,6 +52,7 @@ config MACH_MX28EVK
 	select MXS_HAVE_PLATFORM_MXSFB
 	select MXS_HAVE_PLATFORM_MXS_SAIF
 	select MXS_HAVE_PLATFORM_MXS_I2C
+	select MXS_HAVE_PLATFORM_MXS_SPI
 	select MXS_HAVE_PLATFORM_RTC_STMP3XXX
 	select MXS_OCOTP
 	help
diff --git a/arch/arm/mach-mxs/mach-mx28evk.c b/arch/arm/mach-mxs/mach-mx28evk.c
index e386c14..f3bca27 100644
--- a/arch/arm/mach-mxs/mach-mx28evk.c
+++ b/arch/arm/mach-mxs/mach-mx28evk.c
@@ -20,6 +20,7 @@
 #include <linux/i2c.h>
 #include <linux/regulator/machine.h>
 #include <linux/regulator/fixed.h>
+#include <linux/spi/spi.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -204,6 +205,12 @@ static const iomux_cfg_t mx28evk_pads[] __initconst = {
 		(MXS_PAD_12MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
 	MX28_PAD_SAIF1_SDATA0__SAIF1_SDATA0 |
 		(MXS_PAD_12MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
+	/* SPI2 */
+	MX28_PAD_SSP2_SCK__SSP2_SCK,
+	MX28_PAD_SSP2_MOSI__SSP2_CMD,
+	MX28_PAD_SSP2_MISO__SSP2_D0,
+	MX28_PAD_SSP2_SS0__SSP2_D3 |
+		(MXS_PAD_3V3 | MXS_PAD_8MA | MXS_PAD_PULLUP),
 };
 
 /* led */
@@ -409,6 +416,15 @@ static const struct mxs_saif_platform_data
 	},
 };
 
+static struct spi_board_info mx28evk_spi_nor_device[] = {
+	{
+	 .modalias = "sst25vf016b",
+	 .max_speed_hz = 25000000,	/* max spi clock (SCK) speed in HZ */
+	 .bus_num = 2,
+	 .chip_select = 0,
+	},
+};
+
 static void __init mx28evk_init(void)
 {
 	int ret;
@@ -454,6 +470,10 @@ static void __init mx28evk_init(void)
 	mx28_add_rtc_stmp3xxx();
 
 	gpio_led_register_device(0, &mx28evk_led_data);
+
+	mx28_add_mxs_spi(2);
+	spi_register_board_info(mx28evk_spi_nor_device,
+				ARRAY_SIZE(mx28evk_spi_nor_device));
 }
 
 static void __init mx28evk_timer_init(void)
-- 
1.7.1
