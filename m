From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 18 Dec 2015 15:18:18 +0100
Subject: [PATCH 65/69] clocksource/drivers/h8300: Change to overflow interrupt
In-Reply-To: <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
References: <5672CB9E.7090707@linaro.org>
 <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1450448302-27429-65-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yoshinori Sato <ysato@users.sourceforge.jp>

Counter overflow detection use for overflow interrupt

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/h8300_timer16.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/clocksource/h8300_timer16.c b/drivers/clocksource/h8300_timer16.c
index fc14a3f..b14a8da 100644
--- a/drivers/clocksource/h8300_timer16.c
+++ b/drivers/clocksource/h8300_timer16.c
@@ -14,7 +14,6 @@
 #include <linux/of_irq.h>
 
 #define TSTR	0
-#define TISRA	4
 #define TISRC	6
 
 #define TCR	0
@@ -27,9 +26,8 @@ struct timer16_priv {
 	void __iomem *mapcommon;
 	unsigned short cs_enabled;
 	unsigned char enb;
-	unsigned char imfa;
-	unsigned char imiea;
 	unsigned char ovf;
+	unsigned char ovie;
 	struct clk *clk;
 };
 
@@ -59,8 +57,8 @@ static irqreturn_t timer16_interrupt(int irq, void *dev_id)
 {
 	struct timer16_priv *p = (struct timer16_priv *)dev_id;
 
-	writeb(readb(p->mapcommon + TISRA) & ~p->imfa,
-		  p->mapcommon + TISRA);
+	writeb(readb(p->mapcommon + TISRC) & ~p->ovf,
+		  p->mapcommon + TISRC);
 	p->total_cycles += 0x10000;
 
 	return IRQ_HANDLED;
@@ -93,6 +91,8 @@ static int timer16_enable(struct clocksource *cs)
 	writeb(0x83, p->mapbase + TCR);
 	writeb(readb(p->mapcommon + TSTR) | p->enb,
 		  p->mapcommon + TSTR);
+	writeb(readb(p->mapcommon + TISRC) | p->ovie,
+		  p->mapcommon + TSTR);
 
 	p->cs_enabled = true;
 	return 0;
@@ -161,8 +161,8 @@ static void __init h8300_16timer_init(struct device_node *node)
 	timer16_priv.mapbase = base[REG_CH];
 	timer16_priv.mapcommon = base[REG_COMM];
 	timer16_priv.enb = 1 << ch;
-	timer16_priv.imfa = 1 << ch;
-	timer16_priv.imiea = 1 << (4 + ch);
+	timer16_priv.ovf = 1 << ch;
+	timer16_priv.ovie = 1 << (4 + ch);
 
 	ret = request_irq(irq, timer16_interrupt,
 			  IRQF_TIMER, timer16_priv.cs.name, &timer16_priv);
-- 
1.9.1
