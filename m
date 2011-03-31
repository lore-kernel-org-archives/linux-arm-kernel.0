From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 31 Mar 2011 15:12:09 +0200
Subject: [PATCH] mmci: force negative edge on clock bypass for ux500
Message-ID: <1301577129-28514-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This fixes a regression on high clock speeds with the MMCI on
ux500. We need to make sure we derive the passthru clock on the
falling edge of the incoming clock if it shall work at high
frequencies, and on the ux500's there is a special bit for this.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/mmci.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index bda958b..5da5bea 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -116,6 +116,8 @@ static void mmci_set_clkreg(struct mmci_host *host, unsigned int desired)
 	if (desired) {
 		if (desired >= host->mclk) {
 			clk = MCI_CLK_BYPASS;
+			if (variant->st_clkdiv)
+				clk |= MCI_ST_UX500_NEG_EDGE;
 			host->cclk = host->mclk;
 		} else if (variant->st_clkdiv) {
 			/*
-- 
1.7.3.2
