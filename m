From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 11 Feb 2014 11:37:09 +0000
Subject: [PATCH 4/7] spi: pl022: attempt to get sspclk by name
In-Reply-To: <1392118632-11312-1-git-send-email-mark.rutland@arm.com>
References: <1392118632-11312-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1392118632-11312-5-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The primecell device tree binding (from which the pl022 binding is
derived from) states that the apb_pclk clock input should be listed
first for all primecell devices. The spi-pl022 driver requires the
sspclk clock input to enable the SPI bus, but the way it currently grabs
the clock means that it always gets the first clock (which should be
apb_pclk).

As the AMBA bus code grabs apb_pclk by name, some existing dts provide
apb_pclk as the second clock in the clocks list to work around this, in
violation of both the primecell binding. The pl022 binding does not
mention clocks at all, so the first clock (SSPCLK) is given an arbitrary
name.

This patch attempts to fix the mess my having the spi-pl022 driver first
attempt to get sspclk by name. If this fails, it falls back to the old
behaviour of simply acquiring the first clock. This is compatible with
any old dtb, whether it lists sspclk by name or not, and allows the
driver to support dtbs which do not violate the bindings. Hopefully this
will lead to future uniformity across dtbs.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
---
 drivers/spi/spi-pl022.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 2789b45..4b3941a 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -2176,7 +2176,14 @@ static int pl022_probe(struct amba_device *adev, const struct amba_id *id)
 	dev_info(&adev->dev, "mapped registers from %pa to %p\n",
 		&adev->res.start, pl022->virtbase);
 
-	pl022->clk = devm_clk_get(&adev->dev, NULL);
+	/*
+	 * For compatibility with old DTBs and platform data, fall back to the
+	 * first clock if there's not an explicitly named "sspclk" entry.
+	 */
+	pl022->clk = devm_clk_get(&adev->dev, "sspclk");
+	if (IS_ERR(pl022->clk))
+		pl022->clk = devm_clk_get(&adev->dev, NULL);
+
 	if (IS_ERR(pl022->clk)) {
 		status = PTR_ERR(pl022->clk);
 		dev_err(&adev->dev, "could not retrieve SSP/SPI bus clock\n");
-- 
1.8.1.1
