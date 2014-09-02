From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Tue,  2 Sep 2014 09:50:17 +0200
Subject: [PATCH 4/5] clk: at91: rework rm9200 USB clock to propagate set_rate
 to the parent clk
In-Reply-To: <1409644218-13677-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1409644218-13677-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1409644218-13677-5-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The RM9200 USB clock is actually connected to a single parent (the PLLB)
on which we can apply a specific divider.
The USB clock divider does not allow for fine grained control on the USB
clock frequency, hence propagating the set_rate request to the parent is
the only choice we have to properly configure the USB clock rate.

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
Reported-by: Ga?l PORTAY <gael.portay@gmail.com>
---
 drivers/clk/at91/clk-usb.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/at91/clk-usb.c b/drivers/clk/at91/clk-usb.c
index 7d1d26a..1838777 100644
--- a/drivers/clk/at91/clk-usb.c
+++ b/drivers/clk/at91/clk-usb.c
@@ -238,16 +238,22 @@ static long at91rm9200_clk_usb_round_rate(struct clk_hw *hw, unsigned long rate,
 					  unsigned long *parent_rate)
 {
 	struct at91rm9200_clk_usb *usb = to_at91rm9200_clk_usb(hw);
+	struct clk *parent = __clk_get_parent(hw->clk);
 	unsigned long bestrate = 0;
 	int bestdiff = -1;
 	unsigned long tmprate;
 	int tmpdiff;
 	int i = 0;
 
-	for (i = 0; i < 4; i++) {
+	for (i = 0; i < RM9200_USB_DIV_TAB_SIZE; i++) {
+		unsigned long tmp_parent_rate;
+
 		if (!usb->divisors[i])
 			continue;
-		tmprate = *parent_rate / usb->divisors[i];
+
+		tmp_parent_rate = rate * usb->divisors[i];
+		tmp_parent_rate = __clk_round_rate(parent, tmp_parent_rate);
+		tmprate = tmp_parent_rate / usb->divisors[i];
 		if (tmprate < rate)
 			tmpdiff = rate - tmprate;
 		else
@@ -256,6 +262,7 @@ static long at91rm9200_clk_usb_round_rate(struct clk_hw *hw, unsigned long rate,
 		if (bestdiff < 0 || bestdiff > tmpdiff) {
 			bestrate = tmprate;
 			bestdiff = tmpdiff;
+			*parent_rate = tmp_parent_rate;
 		}
 
 		if (!bestdiff)
@@ -311,7 +318,7 @@ at91rm9200_clk_register_usb(struct at91_pmc *pmc, const char *name,
 	init.ops = &at91rm9200_usb_ops;
 	init.parent_names = &parent_name;
 	init.num_parents = 1;
-	init.flags = 0;
+	init.flags = CLK_SET_RATE_PARENT;
 
 	usb->hw.init = &init;
 	usb->pmc = pmc;
-- 
1.9.1
