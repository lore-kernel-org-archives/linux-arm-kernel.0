From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 12 Feb 2016 10:02:40 +0800
Subject: [PATCH v8 03/10] mfd: axp20x: use dev->driver->of_match_table in
 axp20x_match_device()
In-Reply-To: <1455242567-17880-1-git-send-email-wens@csie.org>
References: <1455242567-17880-1-git-send-email-wens@csie.org>
Message-ID: <1455242567-17880-4-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In axp20x_match_device(), match the of_device_id table bound to the
device driver instead of pointing to axp20x_of_match directly. This
will allow us to keep axp20x_match_device() unmodified when we expand
the axp20x driver into multiple ones covering different interface
types.

of_device_get_match_data() cannot be used here as we need to know if
it failed to get a match, or if the match data value just happened to
be 0, as it is for the AXP152.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/axp20x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 685a78614f83..3e186f2dcac3 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -613,7 +613,7 @@ static int axp20x_match_device(struct axp20x_dev *axp20x)
 	const struct of_device_id *of_id;
 
 	if (dev->of_node) {
-		of_id = of_match_device(axp20x_of_match, dev);
+		of_id = of_match_device(dev->driver->of_match_table, dev);
 		if (!of_id) {
 			dev_err(dev, "Unable to match OF ID\n");
 			return -ENODEV;
-- 
2.7.0
