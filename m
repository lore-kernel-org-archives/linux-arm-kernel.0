From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Tue,  2 Sep 2014 09:50:18 +0200
Subject: [PATCH 5/5] clk: at91: fix div by zero in USB clock driver
In-Reply-To: <1409644218-13677-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1409644218-13677-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1409644218-13677-6-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Test rate value before calculating the div value to avoid div by zero.

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
Reported-by: Ga?l PORTAY <gael.portay@gmail.com>
---
 drivers/clk/at91/clk-usb.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/at91/clk-usb.c b/drivers/clk/at91/clk-usb.c
index 1838777..24b5b02 100644
--- a/drivers/clk/at91/clk-usb.c
+++ b/drivers/clk/at91/clk-usb.c
@@ -279,10 +279,13 @@ static int at91rm9200_clk_usb_set_rate(struct clk_hw *hw, unsigned long rate,
 	int i;
 	struct at91rm9200_clk_usb *usb = to_at91rm9200_clk_usb(hw);
 	struct at91_pmc *pmc = usb->pmc;
-	unsigned long div = parent_rate / rate;
+	unsigned long div;
 
-	if (parent_rate % rate)
+	if (!rate || parent_rate % rate)
 		return -EINVAL;
+
+	div = parent_rate / rate;
+
 	for (i = 0; i < RM9200_USB_DIV_TAB_SIZE; i++) {
 		if (usb->divisors[i] == div) {
 			tmp = pmc_read(pmc, AT91_CKGR_PLLBR) &
-- 
1.9.1
