From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 20 Jun 2016 11:26:59 +0200
Subject: [PATCH V3] clocksource/drivers/mps2-timer: Convert init function to
 return error
In-Reply-To: <20160620091506.GO9711@e106497-lin.cambridge.arm.com>
References: <20160620091506.GO9711@e106497-lin.cambridge.arm.com>
Message-ID: <1466414820-19574-1-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The init functions do not return any error. They behave as the following:

  - panic, thus leading to a kernel crash while another timer may work and
       make the system boot up correctly

  or

  - print an error and let the caller unaware if the state of the system

Change that by converting the init functions to return an error conforming
to the CLOCKSOURCE_OF_RET prototype.

Proper error handling (rollback, errno value) will be changed later case
by case, thus this change just return back an error or success in the init
function.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/mps2-timer.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/mps2-timer.c b/drivers/clocksource/mps2-timer.c
index 3d33a5e..c303fa9 100644
--- a/drivers/clocksource/mps2-timer.c
+++ b/drivers/clocksource/mps2-timer.c
@@ -250,7 +250,7 @@ out:
 	return ret;
 }
 
-static void __init mps2_timer_init(struct device_node *np)
+static int __init mps2_timer_init(struct device_node *np)
 {
 	static int has_clocksource, has_clockevent;
 	int ret;
@@ -259,7 +259,7 @@ static void __init mps2_timer_init(struct device_node *np)
 		ret = mps2_clocksource_init(np);
 		if (!ret) {
 			has_clocksource = 1;
-			return;
+			return 0;
 		}
 	}
 
@@ -267,9 +267,11 @@ static void __init mps2_timer_init(struct device_node *np)
 		ret = mps2_clockevent_init(np);
 		if (!ret) {
 			has_clockevent = 1;
-			return;
+			return 0;
 		}
 	}
+
+	return 0;
 }
 
-CLOCKSOURCE_OF_DECLARE(mps2_timer, "arm,mps2-timer", mps2_timer_init);
+CLOCKSOURCE_OF_DECLARE_RET(mps2_timer, "arm,mps2-timer", mps2_timer_init);
-- 
1.9.1
