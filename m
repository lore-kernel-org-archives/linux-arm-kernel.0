From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 9 Dec 2010 09:52:55 +0100
Subject: [PATCH] mmci: partially revert clock divisor code
Message-ID: <1291884775-25509-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I misread the datasheet as if bypass mode was not available at all
on the ux500's, I was wrong. It is there, the datasheet just
states that you should not have to use it.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 drivers/mmc/host/mmci.c |    8 +-------
 1 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 82880e8..907e582 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -101,13 +101,7 @@ static void mmci_set_clkreg(struct mmci_host *host, unsigned int desired)
 
 	if (desired) {
 		if (desired >= host->mclk) {
-			/*
-			 * The ST clock divider does not like the bypass bit,
-			 * even though it's available. Instead the datasheet
-			 * recommends setting the divider to zero.
-			 */
-			if (!variant->st_clkdiv)
-				clk = MCI_CLK_BYPASS;
+			clk = MCI_CLK_BYPASS;
 			host->cclk = host->mclk;
 		} else if (variant->st_clkdiv) {
 			/*
-- 
1.7.3.2
