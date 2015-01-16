From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 16 Jan 2015 10:05:51 +0100
Subject: [PATCH] clockevents: don't suspend/resume if unused
Message-ID: <1421399151-26800-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no point in calling suspend/resume for unused
clockevents as they are already stopped and disabled.

Furthermore, it can take some time to wait for some IPs to stop counting.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Reported-by: Sylvain Rochet <sylvain.rochet@finsecur.com>
---
 kernel/time/clockevents.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index 55449909f114..0eff982c1c11 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -525,7 +525,7 @@ void clockevents_suspend(void)
 	struct clock_event_device *dev;
 
 	list_for_each_entry_reverse(dev, &clockevent_devices, list)
-		if (dev->suspend)
+		if (dev->suspend && dev->mode != CLOCK_EVT_MODE_UNUSED)
 			dev->suspend(dev);
 }
 
@@ -537,7 +537,7 @@ void clockevents_resume(void)
 	struct clock_event_device *dev;
 
 	list_for_each_entry(dev, &clockevent_devices, list)
-		if (dev->resume)
+		if (dev->resume && dev->mode != CLOCK_EVT_MODE_UNUSED)
 			dev->resume(dev);
 }
 
-- 
2.1.0
