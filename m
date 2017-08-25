From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 25 Aug 2017 11:49:52 +0200
Subject: [PATCH 1/2] clk: sunxi-ng: Provide a default reset hook
Message-ID: <20170825094953.3247-1-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The reset hook was left implemented. Provide a dumb implementation so that
client drivers can depend on it.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clk/sunxi-ng/ccu_reset.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu_reset.c b/drivers/clk/sunxi-ng/ccu_reset.c
index 6c31d48783a7..1dc4e98ea802 100644
--- a/drivers/clk/sunxi-ng/ccu_reset.c
+++ b/drivers/clk/sunxi-ng/ccu_reset.c
@@ -8,6 +8,7 @@
  * the License, or (at your option) any later version.
  */
 
+#include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/reset-controller.h>
 
@@ -49,7 +50,18 @@ static int ccu_reset_deassert(struct reset_controller_dev *rcdev,
 	return 0;
 }
 
+static int ccu_reset_reset(struct reset_controller_dev *rcdev,
+			   unsigned long id)
+{
+	ccu_reset_assert(rcdev, id);
+	udelay(10);
+	ccu_reset_deassert(rcdev, id);
+
+	return 0;
+}
+
 const struct reset_control_ops ccu_reset_ops = {
 	.assert		= ccu_reset_assert,
 	.deassert	= ccu_reset_deassert,
+	.reset		= ccu_reset_reset,
 };
-- 
2.13.5
