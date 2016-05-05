From: arnd@arndb.de (Arnd Bergmann)
Date: Thu,  5 May 2016 22:10:52 +0200
Subject: [PATCH] drm: sun4i: fix probe error handling
Message-ID: <1462479061-893414-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gcc points out a possible uninitialized variable use in
sun4i_dclk_create():

drivers/gpu/drm/sun4i/sun4i_dotclock.c: In function 'sun4i_dclk_create':
drivers/gpu/drm/sun4i/sun4i_dotclock.c:139:12: error: 'clk_name' may be used uninitialized in this function [-Werror=maybe-uninitialized]
  init.name = clk_name;

The warning only shows up when CONFIG_OF is disabled, and the
property is never filled, but the same bug can show up even
when CONFIG_OF is enabled but of_property_read_string_index
returns another error.

To fix it, this ensures that sun4i_dclk_create propagates
any error from of_property_read_string_index.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 9026e0d122ac ("drm: Add Allwinner A10 Display Engine support")
---
 drivers/gpu/drm/sun4i/sun4i_dotclock.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_dotclock.c b/drivers/gpu/drm/sun4i/sun4i_dotclock.c
index 3ff668cb463c..6c9c090a8006 100644
--- a/drivers/gpu/drm/sun4i/sun4i_dotclock.c
+++ b/drivers/gpu/drm/sun4i/sun4i_dotclock.c
@@ -127,10 +127,14 @@ int sun4i_dclk_create(struct device *dev, struct sun4i_tcon *tcon)
 	const char *clk_name, *parent_name;
 	struct clk_init_data init;
 	struct sun4i_dclk *dclk;
+	int ret;
 
 	parent_name = __clk_get_name(tcon->sclk0);
-	of_property_read_string_index(dev->of_node, "clock-output-names", 0,
-				      &clk_name);
+	ret = of_property_read_string_index(dev->of_node,
+					    "clock-output-names", 0,
+					    &clk_name);
+	if (ret)
+		return ret;
 
 	dclk = devm_kzalloc(dev, sizeof(*dclk), GFP_KERNEL);
 	if (!dclk)
-- 
2.7.0
