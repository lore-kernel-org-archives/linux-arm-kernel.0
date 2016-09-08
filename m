From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu,  8 Sep 2016 16:51:46 +0200
Subject: [PATCH v2 5/5] clk: at91: sckc: optimize boot time
In-Reply-To: <20160908145146.20422-1-alexandre.belloni@free-electrons.com>
References: <20160908145146.20422-1-alexandre.belloni@free-electrons.com>
Message-ID: <20160908145146.20422-6-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Assume that if the oscillator is enabled (OSC32EN bit is present), the
delay has already elapsed as the bootloader probably waited for the
oscillator to settle. This could waste up to 1.2s.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/clk/at91/sckc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/at91/sckc.c b/drivers/clk/at91/sckc.c
index 04059ea761c2..d669f5ca4dac 100644
--- a/drivers/clk/at91/sckc.c
+++ b/drivers/clk/at91/sckc.c
@@ -69,7 +69,7 @@ static int clk_slow_osc_prepare(struct clk_hw *hw)
 	void __iomem *sckcr = osc->sckcr;
 	u32 tmp = readl(sckcr);
 
-	if (tmp & AT91_SCKC_OSC32BYP)
+	if (tmp & (AT91_SCKC_OSC32BYP | AT91_SCKC_OSC32EN))
 		return 0;
 
 	writel(tmp | AT91_SCKC_OSC32EN, sckcr);
-- 
2.9.3
