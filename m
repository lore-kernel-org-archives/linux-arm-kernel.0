From: broonie@kernel.org (Mark Brown)
Date: Mon,  4 Sep 2017 13:47:10 +0100 (BST)
Subject: Applied "spi: imx: fix use of native chip-selects with devicetree" to
 the spi tree
In-Reply-To: <1489726983-17706-3-git-send-email-gerg@linux-m68k.org>
Message-ID: <20170904124710.B69CA4400FC@finisterre.ee.mobilebroadband>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: imx: fix use of native chip-selects with devicetree

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 602c8f4485cd1e6de67e41c78db96fa4f6808e53 Mon Sep 17 00:00:00 2001
From: Greg Ungerer <gerg@linux-m68k.org>
Date: Tue, 11 Jul 2017 14:22:11 +1000
Subject: [PATCH] spi: imx: fix use of native chip-selects with devicetree

The commonly used mechanism of specifying the hardware or native
chip-select on an SPI device in devicetree (that is "cs-gpios = <0>")
does not result in the native chip-select being configured for use.
So external SPI devices that require use of the native chip-select
will not work.

You can successfully specify native chip-selects if using a platform
setup by specifying the cs-gpio as negative offset by 32. And that
works correctly. You cannot use the same method in devicetree.

The logic in the spi-imx.c driver during probe uses core spi function
of_spi_register_master() in spi.c to parse the "cs-gpios" devicetree tag.
For valid GPIO values that will be recorded for use, all other entries in
the cs_gpios list will be set to -ENOENT. So entries like "<0>" will be
set to -ENOENT in the cs_gpios list.

When the SPI device registers are setup the code will use the GPIO
listed in the cs_gpios list for the desired chip-select. If the cs_gpio
is less then 0 then it is intended to be for a native chip-select, and
its cs_gpio value is added to 32 to get the chipselect number to use.
Problem is that with devicetree this can only ever be -ENOENT (which
is -2), and that alone results in an invalid chip-select number. But also
doesn't allow selection of the native chip-select at all.

To fix, if the cs_gpio specified for this spi device is not a
valid GPIO then use the "chip_select" (that is the native chip-select
number) for hardware setup.

Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>
Tested-by: Vladimir Zapolskiy <vz@mleia.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-imx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 6fcb6adf9565..babb15f07995 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -622,8 +622,8 @@ static int mx31_config(struct spi_device *spi)
 		reg |= MX31_CSPICTRL_POL;
 	if (spi->mode & SPI_CS_HIGH)
 		reg |= MX31_CSPICTRL_SSPOL;
-	if (spi->cs_gpio < 0)
-		reg |= (spi->cs_gpio + 32) <<
+	if (!gpio_is_valid(spi->cs_gpio))
+		reg |= (spi->chip_select) <<
 			(is_imx35_cspi(spi_imx) ? MX35_CSPICTRL_CS_SHIFT :
 						  MX31_CSPICTRL_CS_SHIFT);
 
@@ -714,8 +714,8 @@ static int mx21_config(struct spi_device *spi)
 		reg |= MX21_CSPICTRL_POL;
 	if (spi->mode & SPI_CS_HIGH)
 		reg |= MX21_CSPICTRL_SSPOL;
-	if (spi->cs_gpio < 0)
-		reg |= (spi->cs_gpio + 32) << MX21_CSPICTRL_CS_SHIFT;
+	if (!gpio_is_valid(spi->cs_gpio))
+		reg |= spi->chip_select << MX21_CSPICTRL_CS_SHIFT;
 
 	writel(reg, spi_imx->base + MXC_CSPICTRL);
 
-- 
2.13.2
