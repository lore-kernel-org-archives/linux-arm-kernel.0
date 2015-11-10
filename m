From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Tue, 10 Nov 2015 11:57:49 +0000
Subject: [PATCH v2 1/7] timekeeping: introduce __current_kernel_time64
In-Reply-To: <alpine.DEB.2.02.1511101131350.5676@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1511101131350.5676@kaball.uk.xensource.com>
Message-ID: <1447156675-7418-1-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

__current_kernel_time64 returns a struct timespec64, without taking the
xtime lock. Mirrors __current_kernel_time/current_kernel_time.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
CC: arnd at arndb.de
CC: john.stultz at linaro.org
CC: tglx at linutronix.de
CC: mingo at kernel.org
CC: peterz at infradead.org
---
 include/linux/timekeeping.h |    3 ++-
 kernel/time/timekeeping.c   |    7 +++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index ec89d84..b5802bf 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -19,7 +19,8 @@ extern int do_sys_settimeofday(const struct timespec *tv,
  */
 unsigned long get_seconds(void);
 struct timespec64 current_kernel_time64(void);
-/* does not take xtime_lock */
+/* do not take xtime_lock */
+struct timespec64 __current_kernel_time64(void);
 struct timespec __current_kernel_time(void);
 
 static inline struct timespec current_kernel_time(void)
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index b1356b7..c1221c2 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1881,6 +1881,13 @@ struct timespec __current_kernel_time(void)
 	return timespec64_to_timespec(tk_xtime(tk));
 }
 
+struct timespec64 __current_kernel_time64(void)
+{
+	struct timekeeper *tk = &tk_core.timekeeper;
+
+	return tk_xtime(tk);
+}
+
 struct timespec64 current_kernel_time64(void)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
-- 
1.7.10.4
