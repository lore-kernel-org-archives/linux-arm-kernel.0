From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue, 10 Aug 2010 22:18:57 +0200
Subject: [PATCH] ARM: imx/pca100: Fix name of spi platform data
In-Reply-To: <1277387397-3467-52-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1277387397-3467-52-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1281471537-802-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit

	7536cf9 (ARM: imx: dynamically register spi_imx devices (imx27))

introduced a variable named "pca100_spi0_data" but passed
"&pca100_spi_0_data" to imx27_add_spi_imx0.  This wasn't noticed earlier
because both SPI_IMX and MACH_PCA100 are not enabled in mx27_defconfig.

This fixes a build failure:

	arch/arm/mach-imx/mach-pca100.c: In function 'pca100_init':
	arch/arm/mach-imx/mach-pca100.c:411: error: 'pca100_spi_0_data' undeclared (first use in this function)
	arch/arm/mach-imx/mach-pca100.c:411: error: (Each undeclared identifier is reported only once
	arch/arm/mach-imx/mach-pca100.c:411: error: for each function it appears in.)

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
KernelVersion: v2.6.35-rc1-49-g7536cf9

 arch/arm/mach-imx/mach-pca100.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-imx/mach-pca100.c b/arch/arm/mach-imx/mach-pca100.c
index 6c92dea..a389d11 100644
--- a/arch/arm/mach-imx/mach-pca100.c
+++ b/arch/arm/mach-imx/mach-pca100.c
@@ -408,7 +408,7 @@ static void __init pca100_init(void)
 	mxc_gpio_mode(GPIO_PORTD | 27 | GPIO_GPIO | GPIO_IN);
 	spi_register_board_info(pca100_spi_board_info,
 				ARRAY_SIZE(pca100_spi_board_info));
-	imx27_add_spi_imx0(&pca100_spi_0_data);
+	imx27_add_spi_imx0(&pca100_spi0_data);
 #endif
 
 	gpio_request(OTG_PHY_CS_GPIO, "usb-otg-cs");
-- 
1.7.1
