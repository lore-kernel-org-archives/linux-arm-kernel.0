From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Tue, 27 Aug 2013 15:19:21 +0200
Subject: [PATCH] pinctrl: at91: fix get_pullup/down function return
Message-ID: <1377609561-22054-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In PIO_PUSR and PIO_PPDSR register if a given bit is set 1 this means the
pullup/down for this pin (pin is represented as a bit position) is
disabled.

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
---
 drivers/pinctrl/pinctrl-at91.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index b90a3a0..19afb9a 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -325,7 +325,7 @@ static void at91_mux_disable_interrupt(void __iomem *pio, unsigned mask)
 
 static unsigned at91_mux_get_pullup(void __iomem *pio, unsigned pin)
 {
-	return (readl_relaxed(pio + PIO_PUSR) >> pin) & 0x1;
+	return !((readl_relaxed(pio + PIO_PUSR) >> pin) & 0x1);
 }
 
 static void at91_mux_set_pullup(void __iomem *pio, unsigned mask, bool on)
@@ -445,7 +445,7 @@ static void at91_mux_pio3_set_debounce(void __iomem *pio, unsigned mask,
 
 static bool at91_mux_pio3_get_pulldown(void __iomem *pio, unsigned pin)
 {
-	return (__raw_readl(pio + PIO_PPDSR) >> pin) & 0x1;
+	return !((__raw_readl(pio + PIO_PPDSR) >> pin) & 0x1);
 }
 
 static void at91_mux_pio3_set_pulldown(void __iomem *pio, unsigned mask, bool is_on)
-- 
1.7.9.5
