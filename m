From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 16 Jan 2015 17:57:19 +0100
Subject: [PATCH v2 2/2] clocksource: don't suspend/resume when unused
In-Reply-To: <1421427439-11699-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1421427439-11699-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1421427439-11699-3-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no point in calling suspend/resume for unused
clocksources.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 kernel/time/clocksource.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 03cfc5a08e3b..da65b3b73a86 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -493,7 +493,7 @@ void clocksource_suspend(void)
 	struct clocksource *cs;
 
 	list_for_each_entry_reverse(cs, &clocksource_list, list)
-		if (cs->suspend)
+		if (cs->suspend && (cs->flags & CLOCK_SOURCE_USED))
 			cs->suspend(cs);
 }
 
@@ -505,7 +505,7 @@ void clocksource_resume(void)
 	struct clocksource *cs;
 
 	list_for_each_entry(cs, &clocksource_list, list)
-		if (cs->resume)
+		if (cs->resume && (cs->flags & CLOCK_SOURCE_USED))
 			cs->resume(cs);
 
 	clocksource_resume_watchdog();
-- 
2.1.0
