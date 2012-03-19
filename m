From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 19 Mar 2012 14:36:01 +0100
Subject: [PATCH 3/8] ARM i.MX timer: request correct clock
In-Reply-To: <1332164166-6055-1-git-send-email-s.hauer@pengutronix.de>
References: <1332164166-6055-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1332164166-6055-4-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We used to pass the timer clock directly to mxc_timer_init. We
should instead request the correct clock. This is an intermediate
step: For now we request the clock in the timer code when NULL
is passed as clock.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/plat-mxc/time.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-mxc/time.c b/arch/arm/plat-mxc/time.c
index 1c96cdb..462aecb 100644
--- a/arch/arm/plat-mxc/time.c
+++ b/arch/arm/plat-mxc/time.c
@@ -283,7 +283,10 @@ void __init mxc_timer_init(struct clk *timer_clk, void __iomem *base, int irq)
 {
 	uint32_t tctl_val;
 
-	clk_enable(timer_clk);
+	if (!timer_clk)
+		timer_clk = clk_get_sys("imx-gpt.0", "per");
+
+	clk_prepare_enable(timer_clk);
 
 	timer_base = base;
 
-- 
1.7.9.1
