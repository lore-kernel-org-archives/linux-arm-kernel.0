From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu,  8 Sep 2016 13:57:23 +0200
Subject: [PATCH 5/5] clk: at91: sckc: optimize boot time
In-Reply-To: <20160908115723.11878-1-alexandre.belloni@free-electrons.com>
References: <20160908115723.11878-1-alexandre.belloni@free-electrons.com>
Message-ID: <20160908115723.11878-6-alexandre.belloni@free-electrons.com>
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
index 88907c48092b..b0a41170309f 100644
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
