From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 23 May 2014 12:31:17 +0200
Subject: [PATCH 37/71] clocksource: sh_mtu2: Turn sh_mtu2_priv fields into
 local variables
In-Reply-To: <1400841111-6683-1-git-send-email-daniel.lezcano@linaro.org>
References: <537F214C.8000700@linaro.org>
 <1400841111-6683-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1400841111-6683-37-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The rate and periodic fields are used in a single function only, as
local variables. Remove them from the structure.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Tested-by: Wolfram Sang <wsa@sang-engineering.com>
---
 drivers/clocksource/sh_mtu2.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clocksource/sh_mtu2.c b/drivers/clocksource/sh_mtu2.c
index 77992e0..6668455 100644
--- a/drivers/clocksource/sh_mtu2.c
+++ b/drivers/clocksource/sh_mtu2.c
@@ -39,8 +39,6 @@ struct sh_mtu2_priv {
 	struct clk *clk;
 	int irq;
 	struct platform_device *pdev;
-	unsigned long rate;
-	unsigned long periodic;
 	struct clock_event_device ced;
 };
 
@@ -122,6 +120,8 @@ static void sh_mtu2_start_stop_ch(struct sh_mtu2_priv *p, int start)
 
 static int sh_mtu2_enable(struct sh_mtu2_priv *p)
 {
+	unsigned long periodic;
+	unsigned long rate;
 	int ret;
 
 	pm_runtime_get_sync(&p->pdev->dev);
@@ -137,13 +137,13 @@ static int sh_mtu2_enable(struct sh_mtu2_priv *p)
 	/* make sure channel is disabled */
 	sh_mtu2_start_stop_ch(p, 0);
 
-	p->rate = clk_get_rate(p->clk) / 64;
-	p->periodic = (p->rate + HZ/2) / HZ;
+	rate = clk_get_rate(p->clk) / 64;
+	periodic = (rate + HZ/2) / HZ;
 
 	/* "Periodic Counter Operation" */
 	sh_mtu2_write(p, TCR, 0x23); /* TGRA clear, divide clock by 64 */
 	sh_mtu2_write(p, TIOR, 0);
-	sh_mtu2_write(p, TGR, p->periodic);
+	sh_mtu2_write(p, TGR, periodic);
 	sh_mtu2_write(p, TCNT, 0);
 	sh_mtu2_write(p, TMDR, 0);
 	sh_mtu2_write(p, TIER, 0x01);
-- 
1.7.9.5
