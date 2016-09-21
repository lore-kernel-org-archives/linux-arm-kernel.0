From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 22 Sep 2016 00:09:38 +0200
Subject: [PATCH v2 5/6] misc: sram: add Atmel securam support
In-Reply-To: <20160921220939.27924-1-alexandre.belloni@free-electrons.com>
References: <20160921220939.27924-1-alexandre.belloni@free-electrons.com>
Message-ID: <20160921220939.27924-6-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Atmel secure SRAM is connected to a security module and may be erased
automatically under certain conditions. For that reason, it is necessary to
wait for the security module to flag that SRAM accesses are allowed before
accessing it.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

 drivers/misc/sram.c | 42 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/sram.c b/drivers/misc/sram.c
index f84b53d6ce50..b0d4dd9b0586 100644
--- a/drivers/misc/sram.c
+++ b/drivers/misc/sram.c
@@ -19,12 +19,17 @@
  */
 
 #include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/genalloc.h>
 #include <linux/io.h>
 #include <linux/list_sort.h>
 #include <linux/of_address.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
+#include <linux/mfd/syscon.h>
+#include <soc/at91/atmel-secumod.h>
 
 #define SRAM_GRANULARITY	32
 
@@ -334,12 +339,35 @@ static int sram_reserve_regions(struct sram_dev *sram, struct resource *res)
 	return ret;
 }
 
+static int atmel_securam_wait(void)
+{
+	struct regmap *regmap;
+	u32 val;
+
+	regmap = syscon_regmap_lookup_by_compatible("atmel,sama5d2-secumod");
+	if (IS_ERR(regmap))
+		return -ENODEV;
+
+	return regmap_read_poll_timeout(regmap, AT91_SECUMOD_RAMRDY, val,
+					val & AT91_SECUMOD_RAMRDY_READY,
+					10000, 500000);
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id sram_dt_ids[] = {
+	{ .compatible = "mmio-sram" },
+	{ .compatible = "atmel,sama5d2-securam", .data = atmel_securam_wait },
+	{}
+};
+#endif
+
 static int sram_probe(struct platform_device *pdev)
 {
 	struct sram_dev *sram;
 	struct resource *res;
 	size_t size;
 	int ret;
+	int (*init_func)(void);
 
 	sram = devm_kzalloc(&pdev->dev, sizeof(*sram), GFP_KERNEL);
 	if (!sram)
@@ -384,6 +412,13 @@ static int sram_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, sram);
 
+	init_func = of_device_get_match_data(&pdev->dev);
+	if (init_func) {
+		ret = init_func();
+		if (ret)
+			return ret;
+	}
+
 	dev_dbg(sram->dev, "SRAM pool: %zu KiB @ 0x%p\n",
 		gen_pool_size(sram->pool) / 1024, sram->virt_base);
 
@@ -405,13 +440,6 @@ static int sram_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_OF
-static const struct of_device_id sram_dt_ids[] = {
-	{ .compatible = "mmio-sram" },
-	{}
-};
-#endif
-
 static struct platform_driver sram_driver = {
 	.driver = {
 		.name = "sram",
-- 
2.9.3
