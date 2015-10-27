From: yangyingliang@huawei.com (Yang Yingliang)
Date: Tue, 27 Oct 2015 21:21:12 +0800
Subject: [PATCH 1/2] clocksource: replace cycle_last validation with an equal
 way
In-Reply-To: <1445952073-7260-1-git-send-email-yangyingliang@huawei.com>
References: <1445952073-7260-1-git-send-email-yangyingliang@huawei.com>
Message-ID: <1445952073-7260-2-git-send-email-yangyingliang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mask the cycle values before subtraction. So we can use this
validation while the clocksource mask is not 64-bits.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/timekeeping_internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/timekeeping_internal.h b/kernel/time/timekeeping_internal.h
index 4ea005a..984f02e 100644
--- a/kernel/time/timekeeping_internal.h
+++ b/kernel/time/timekeeping_internal.h
@@ -15,7 +15,7 @@ extern void tk_debug_account_sleep_time(struct timespec64 *t);
 #ifdef CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE
 static inline cycle_t clocksource_delta(cycle_t now, cycle_t last, cycle_t mask)
 {
-	cycle_t ret = (now - last) & mask;
+	cycle_t ret = (now & mask) - (last & mask);
 
 	return (s64) ret > 0 ? ret : 0;
 }
-- 
2.5.0
