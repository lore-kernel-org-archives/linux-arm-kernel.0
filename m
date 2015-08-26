From: henryc.chen@mediatek.com (Henry Chen)
Date: Wed, 26 Aug 2015 19:43:16 +0800
Subject: [PATCH] regmap: Fix the null function of format_val on
 regmap_bulk_read.
Message-ID: <1440589396-696-1-git-send-email-henryc.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The regmap_format will not be initialize if device driver not declare the regmap_bus
when registering the regmap. To avoid the null function of format_val when
called regmap_bulk_read(). It need to give a format function when regmap init.

Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
---
I ran into this bug when testing Matthias' v4.2-next/for-next branch on mt8173.
It now crashes on boot. The commit [0], which added the call to
map->format.format_val from regmap_bulk_read() when map->bus == NULL.

[0] commit 15b8d2c41fe5839582029f65c5f7004db451cc2b
  Author: Arun Chandran <achandran <at> mvista.com>
  regmap: Fix regmap_bulk_read in BE mode

Please see the error below, thanks.

Call trace:
[<          (null)>]           (null)
[<ffffffc0004cbdd0>] mtk_rtc_read_time+0x9c/0x134
[<ffffffc0004c9618>] __rtc_read_time.isra.3+0x40/0x7c
[<ffffffc0004c9688>] rtc_read_time+0x34/0x58
[<ffffffc0004c9e64>] __rtc_read_alarm+0x20/0x37c
[<ffffffc0004c8d2c>] rtc_device_register+0x194/0x2e0
[<ffffffc0004cbf60>] mtk_rtc_probe+0xf8/0x18c
[<ffffffc0003fb5e0>] platform_drv_probe+0x48/0xc4
[<ffffffc0003f99e0>] driver_probe_device+0x188/0x29c
[<ffffffc0003f9b8c>] __driver_attach+0x98/0xa0
[<ffffffc0003f7ce0>] bus_for_each_dev+0x54/0x98
[<ffffffc0003f94c8>] driver_attach+0x1c/0x28
[<ffffffc0003f9164>] bus_add_driver+0x1c0/0x228
[<ffffffc0003fa45c>] driver_register+0x64/0x130
[<ffffffc0003fb514>] __platform_driver_register+0x5c/0x68
[<ffffffc0008639a4>] mtk_rtc_driver_init+0x14/0x20
[<ffffffc000082864>] do_one_initcall+0x88/0x1ac
[<ffffffc000842b10>] kernel_init_freeable+0x158/0x1fc
[<ffffffc0005f45fc>] kernel_init+0xc/0xd8
---
 drivers/base/regmap/regmap.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 7111d04..9357186 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -607,13 +607,13 @@ struct regmap *regmap_init(struct device *dev,
 		map->reg_write = config->reg_write;
 
 		map->defer_caching = false;
-		goto skip_format_initialization;
+		goto simple_format_initialization;
 	} else if (!bus->read || !bus->write) {
 		map->reg_read = _regmap_bus_reg_read;
 		map->reg_write = _regmap_bus_reg_write;
 
 		map->defer_caching = false;
-		goto skip_format_initialization;
+		goto simple_format_initialization;
 	} else {
 		map->reg_read  = _regmap_bus_read;
 	}
@@ -783,8 +783,22 @@ struct regmap *regmap_init(struct device *dev,
 		map->defer_caching = true;
 		map->reg_write = _regmap_bus_raw_write;
 	}
+/*
+ * For bulk read, need to hook the format function.
+ */
+simple_format_initialization:
 
-skip_format_initialization:
+	switch (config->val_bits) {
+		case 8:
+			map->format.format_val = regmap_format_8;
+			break;
+		case 16:
+			map->format.format_val = regmap_format_16_native;
+			break;
+		case 32:
+			map->format.format_val = regmap_format_32_native;
+			break;
+	}
 
 	map->range_tree = RB_ROOT;
 	for (i = 0; i < config->num_ranges; i++) {
-- 
1.8.1.1.dirty
