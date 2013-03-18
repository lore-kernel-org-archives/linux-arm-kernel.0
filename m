From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 22:02:28 +0900
Subject: [PATCH 02/12] clocksource: sh_cmt: Initialize 'max_match_value' and
 'lock' in sh_cmt_setup()
In-Reply-To: <1363611758-6655-1-git-send-email-horms+renesas@verge.net.au>
References: <1363611758-6655-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363611758-6655-3-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Move the setup of spinlock and max_match_value to sh_cmt_setup().
There's no need to defer those steps until sh_cmt_register().

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
Signed-off-by: Magnus Damm <damm@opensource.se>
Acked-by: John Stultz <john.stultz@linaro.org>
Tested-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/clocksource/sh_cmt.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index 4b8d296..2e49684 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -625,14 +625,6 @@ static int sh_cmt_register(struct sh_cmt_priv *p, char *name,
 			   unsigned long clockevent_rating,
 			   unsigned long clocksource_rating)
 {
-	if (p->width == (sizeof(p->max_match_value) * 8))
-		p->max_match_value = ~0;
-	else
-		p->max_match_value = (1 << p->width) - 1;
-
-	p->match_value = p->max_match_value;
-	raw_spin_lock_init(&p->lock);
-
 	if (clockevent_rating)
 		sh_cmt_register_clockevent(p, name, clockevent_rating);
 
@@ -703,6 +695,14 @@ static int sh_cmt_setup(struct sh_cmt_priv *p, struct platform_device *pdev)
 		p->clear_bits = ~0xc000;
 	}
 
+	if (p->width == (sizeof(p->max_match_value) * 8))
+		p->max_match_value = ~0;
+	else
+		p->max_match_value = (1 << p->width) - 1;
+
+	p->match_value = p->max_match_value;
+	raw_spin_lock_init(&p->lock);
+
 	ret = sh_cmt_register(p, (char *)dev_name(&p->pdev->dev),
 			      cfg->clockevent_rating,
 			      cfg->clocksource_rating);
-- 
1.7.10.4
