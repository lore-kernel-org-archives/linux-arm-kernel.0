From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 18 Dec 2015 15:18:19 +0100
Subject: [PATCH 66/69] clocksource/drivers/h8300: Fix timer not overflow case
In-Reply-To: <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
References: <5672CB9E.7090707@linaro.org>
 <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1450448302-27429-66-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yoshinori Sato <ysato@users.sourceforge.jp>

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/h8300_timer16.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/h8300_timer16.c b/drivers/clocksource/h8300_timer16.c
index b14a8da..934ed0b 100644
--- a/drivers/clocksource/h8300_timer16.c
+++ b/drivers/clocksource/h8300_timer16.c
@@ -48,8 +48,10 @@ static unsigned long timer16_get_counter(struct timer16_priv *p)
 	} while (unlikely((o1 != o2) || (v1 > v2 && v1 < v3)
 			  || (v2 > v3 && v2 < v1) || (v3 > v1 && v3 < v2)));
 
-	v2 |= 0x10000;
-	return v2;
+	if (likely(!o1))
+		return v2;
+	else
+		return v2 + 0x10000;
 }
 
 
-- 
1.9.1
