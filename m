From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon,  9 Apr 2012 22:53:21 +0200
Subject: [PATCH 1/2] dma/amba-pl08x: check for terminal count status only
Message-ID: <1334004801-20185-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For some reason I can't figure out we're reading the PL080_INT_STATUS
register instead of PL080_TC_STATUS when checking for the terminal
count. The PL080_INT_STATUS is a logical OR between the error and
terminal count status register and may not report what we want it
to, especially if there is an error and a terminal count at the same
time and the former is not lowered in time for the check in the TC
register. Make sure we read what we're actually interested in.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Viresh Kumar <viresh.kumar@st.com>
Cc: Alim Akhtar <alim.akhtar@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/dma/amba-pl08x.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index c301a8e..08589c6 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -1615,7 +1615,7 @@ static irqreturn_t pl08x_irq(int irq, void *dev)
 			__func__, err);
 		writel(err, pl08x->base + PL080_ERR_CLEAR);
 	}
-	tc = readl(pl08x->base + PL080_INT_STATUS);
+	tc = readl(pl08x->base + PL080_TC_STATUS);
 	if (tc)
 		writel(tc, pl08x->base + PL080_TC_CLEAR);
 
-- 
1.7.7.6
