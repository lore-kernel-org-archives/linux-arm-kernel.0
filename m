From: joelagnel@ti.com (Joel A Fernandes)
Date: Tue, 25 Jun 2013 20:24:09 -0500
Subject: [PATCH 1/5] MMC: omap_hsmmc: Add reg_offset to DT bindings
Message-ID: <1372209849-6580-1-git-send-email-joelagnel@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Joel A Fernandes <agnel.joel@gmail.com>

Some omap_hsmmc's need to start from a particular offset but
otherwise are same and can be reused. Let the DT tell us about
the HW difference, check for the reg-offset property and use
the same in the driver.

Signed-off-by: Joel A Fernandes <agnel.joel@gmail.com>
---
 drivers/mmc/host/omap_hsmmc.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 5af62c6..aae0994 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1717,6 +1717,7 @@ static struct omap_mmc_platform_data *of_get_hsmmc_pdata(struct device *dev)
 	struct omap_mmc_platform_data *pdata;
 	struct device_node *np = dev->of_node;
 	u32 bus_width, max_freq;
+	u32 reg_offset;
 	int cd_gpio, wp_gpio;
 
 	cd_gpio = of_get_named_gpio(np, "cd-gpios", 0);
@@ -1755,6 +1756,9 @@ static struct omap_mmc_platform_data *of_get_hsmmc_pdata(struct device *dev)
 	if (of_find_property(np, "ti,needs-special-hs-handling", NULL))
 		pdata->slots[0].features |= HSMMC_HAS_HSPE_SUPPORT;
 
+	if (!of_property_read_u32(np, "reg-offset", &reg_offset))
+		pdata->reg_offset = reg_offset;
+
 	return pdata;
 }
 #else
@@ -1785,7 +1789,8 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 		if (IS_ERR(pdata))
 			return PTR_ERR(pdata);
 
-		if (match->data) {
+		/* Provide reg_offset from match->data unless specified in DT */
+		if (match->data && !pdata->reg_offset) {
 			const u16 *offsetp = match->data;
 			pdata->reg_offset = *offsetp;
 		}
-- 
1.7.9.5
