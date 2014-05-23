From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 23 May 2014 12:30:55 +0200
Subject: [PATCH 15/71] clocksource: sh_cmt: Hardcode CMT clock source rating
 to 125
In-Reply-To: <1400841111-6683-1-git-send-email-daniel.lezcano@linaro.org>
References: <537F214C.8000700@linaro.org>
 <1400841111-6683-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1400841111-6683-15-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

All boards use or should use a clock source rating of 125 for the CMT,
hardcode it in the driver.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/clocksource/sh_cmt.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index 75b1f83..c753efc 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -656,12 +656,12 @@ static void sh_cmt_clocksource_resume(struct clocksource *cs)
 }
 
 static int sh_cmt_register_clocksource(struct sh_cmt_channel *ch,
-				       const char *name, unsigned long rating)
+				       const char *name)
 {
 	struct clocksource *cs = &ch->cs;
 
 	cs->name = name;
-	cs->rating = rating;
+	cs->rating = 125;
 	cs->read = sh_cmt_clocksource_read;
 	cs->enable = sh_cmt_clocksource_enable;
 	cs->disable = sh_cmt_clocksource_disable;
@@ -788,13 +788,13 @@ static void sh_cmt_register_clockevent(struct sh_cmt_channel *ch,
 }
 
 static int sh_cmt_register(struct sh_cmt_channel *ch, const char *name,
-			   bool clockevent, unsigned long clocksource_rating)
+			   bool clockevent, bool clocksource)
 {
 	if (clockevent)
 		sh_cmt_register_clockevent(ch, name);
 
-	if (clocksource_rating)
-		sh_cmt_register_clocksource(ch, name, clocksource_rating);
+	if (clocksource)
+		sh_cmt_register_clocksource(ch, name);
 
 	return 0;
 }
@@ -827,7 +827,7 @@ static int sh_cmt_setup_channel(struct sh_cmt_channel *ch, unsigned int index,
 
 	ret = sh_cmt_register(ch, dev_name(&cmt->pdev->dev),
 			      cfg->clockevent_rating != 0,
-			      cfg->clocksource_rating);
+			      cfg->clocksource_rating != 0);
 	if (ret) {
 		dev_err(&cmt->pdev->dev, "ch%u: registration failed\n",
 			ch->index);
-- 
1.7.9.5
