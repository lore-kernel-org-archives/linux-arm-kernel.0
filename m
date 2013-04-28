From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sun, 28 Apr 2013 12:24:41 +0200
Subject: [PATCH] clk: si5351: Allow to build without CONFIG_OF
Message-ID: <1367144681-14248-1-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In clk-si5351 there was some dependency to CONFIG_OF that permitted the
use of the driver on !CONFIG_OF platforms. This patch adds proper #ifdef
around of_clk_add_provider and removes the dependency on CONFIG_OF.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Note:
This patch is based upon v3.9-rc8 with clk-si5351 v8 plus two fixes by
Marek Belisko applied. It has been compile-tested on x86_64 allmodconfig.

Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Rob Landley <rob@landley.net>
Cc: Mike Turquette <mturquette@linaro.org>
Cc: Stephen Warren <swarren@nvidia.com>
Cc: Thierry Reding <thierry.reding@avionic-design.de>
Cc: Dom Cobley <popcornmix@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Rabeeh Khoury <rabeeh@solid-run.com>
Cc: Daniel Mack <zonque@gmail.com>
Cc: Jean-Francois Moine <moinejf@free.fr>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Michal Bachraty <michal.bachraty@streamunlimited.com>
Cc: Marek Belisko <marek.belisko@streamunlimited.com>
Cc: devicetree-discuss at lists.ozlabs.org
Cc: linux-doc at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
---
 drivers/clk/Kconfig      |    1 -
 drivers/clk/clk-si5351.c |    2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 6412f55..5039e41 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -58,7 +58,6 @@ config COMMON_CLK_MAX77686
 config COMMON_CLK_SI5351
 	tristate "Clock driver for SiLabs 5351A/B/C"
 	depends on I2C
-	depends on OF
 	select REGMAP_I2C
 	select RATIONAL
 	---help---
diff --git a/drivers/clk/clk-si5351.c b/drivers/clk/clk-si5351.c
index 8323c31..91c0f01 100644
--- a/drivers/clk/clk-si5351.c
+++ b/drivers/clk/clk-si5351.c
@@ -1489,12 +1489,14 @@ static int si5351_i2c_probe(struct i2c_client *client,
 		}
 	}
 
+#ifdef CONFIG_OF
 	ret = of_clk_add_provider(client->dev.of_node, of_clk_src_onecell_get,
 				  &drvdata->onecell);
 	if (ret) {
 		dev_err(&client->dev, "unable to add clk provider\n");
 		return ret;
 	}
+#endif
 
 	return 0;
 }
-- 
1.7.10.4
