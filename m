From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 11 Sep 2014 16:40:15 +0200
Subject: [PATCH] pinctrl: at91: disable Pull-Down or Pull-Up property before
 enabling Pull-Up or Pull-Down.
Message-ID: <1410446415-29410-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wenyou Yang <wenyou.yang@atmel.com>

Because the pin's Pull-Up and Pull-Down property is mutually exclusive.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---
 drivers/pinctrl/pinctrl-at91.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index a3d8902438c7..ee9c0b7aad14 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -371,6 +371,9 @@ static unsigned at91_mux_get_pullup(void __iomem *pio, unsigned pin)
 
 static void at91_mux_set_pullup(void __iomem *pio, unsigned mask, bool on)
 {
+	if (on)
+		writel_relaxed(mask, pio + PIO_PPDDR);
+
 	writel_relaxed(mask, pio + (on ? PIO_PUER : PIO_PUDR));
 }
 
@@ -499,6 +502,9 @@ static bool at91_mux_pio3_get_pulldown(void __iomem *pio, unsigned pin)
 
 static void at91_mux_pio3_set_pulldown(void __iomem *pio, unsigned mask, bool is_on)
 {
+	if (is_on)
+		__raw_writel(mask, pio + PIO_PUDR);
+
 	__raw_writel(mask, pio + (is_on ? PIO_PPDER : PIO_PPDDR));
 }
 
-- 
1.9.1
