From: yangyingliang@huawei.com (Yang Yingliang)
Date: Tue, 27 Oct 2015 21:21:11 +0800
Subject: [PATCH 0/2] validate the delta of cycle_now and cycle_last on arm64
Message-ID: <1445952073-7260-1-git-send-email-yangyingliang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In multi-core system, if the clock is not sync perfectly, it
will make cycle_last that recorded by CPU-A is a little more
than cycle_now that read by CPU-B. With the negative result,
hrtimer_update_base() return a huge and wrong time. It leads
to the cpu can not finish the while loop in hrtimer_interrupt()
until the real nowtime which is returned from ktime_get() catch
up with the wrong time on clock monotonic base.

Fix it by select config CLOCKSOURCE_VALIDATE_LAST_CYCLE.

Cc: Thomas Gleixner <tglx@linutronix.de>

Yang Yingliang (2):
  clocksource: replace cycle_last validation with an equal way
  arm64: validate the cycle_last to prevent time going backwards

 arch/arm64/Kconfig                 | 1 +
 kernel/time/timekeeping_internal.h | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.5.0
