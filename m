From: yangyingliang@huawei.com (Yang Yingliang)
Date: Sat, 31 Oct 2015 18:20:55 +0800
Subject: [PATCH resend] clocksource: modify the cycle_last validation to fit
 for non-64bit clocksourece mask
In-Reply-To: <alpine.DEB.2.11.1510301533310.4032@nanos>
References: <1445952073-7260-1-git-send-email-yangyingliang@huawei.com>
 <1445952073-7260-2-git-send-email-yangyingliang@huawei.com>
 <alpine.DEB.2.11.1510301533310.4032@nanos>
Message-ID: <56349607.6070708@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yang Yingliang <yangyingliang@huawei.com>

Check the delta of now and last to make sure it's not
negative while the clocksource mask is not 64-bits.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
  kernel/time/timekeeping_internal.h | 3 ++-
  1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/time/timekeeping_internal.h 
b/kernel/time/timekeeping_internal.h
index 4ea005a..cbfcd2d 100644
--- a/kernel/time/timekeeping_internal.h
+++ b/kernel/time/timekeeping_internal.h
@@ -16,8 +16,9 @@ extern void tk_debug_account_sleep_time(struct 
timespec64 *t);
  static inline cycle_t clocksource_delta(cycle_t now, cycle_t last, 
cycle_t mask)
  {
  	cycle_t ret = (now - last) & mask;
+	cycle_t negative = ret & ~(mask >> 1);

-	return (s64) ret > 0 ? ret : 0;
+	return negative ? 0 : ret;
  }
  #else
  static inline cycle_t clocksource_delta(cycle_t now, cycle_t last, 
cycle_t mask)
-- 
2.5.0
