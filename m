From: psodagud@codeaurora.org (Sodagudi Prasad)
Date: Tue, 09 Oct 2018 13:56:14 -0700
Subject: livelock with hrtimer cpu_base->lock
Message-ID: <8f671ebb6b331cd00ce17d111f28c548@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

This is regarding - thread "try to fix contention between expire_timers 
and try_to_del_timer_sync".
https://lkml.org/lkml/2017/7/28/172

I think this live lockup issue was discussed earlier but the final set 
of changes were not concluded.
I would like to check whether you have new updates on this issue or not. 
  This problem is observed with 4.14 .64 stable kernel too.
We see this problem 2 times in overnight testing.

I have to add the following code to avoid live lock. I am thinking that 
fixing this at the cpu_relax() level.

+++ b/kernel/time/hrtimer.c
@@ -52,6 +52,7 @@
  #include <linux/timer.h>
  #include <linux/freezer.h>
  #include <linux/compat.h>
+#include <linux/delay.h>

  #include <linux/uaccess.h>

@@ -152,6 +153,7 @@ struct hrtimer_clock_base *lock_hrtimer_base(const 
struct hrtimer *timer,
                         
raw_spin_unlock_irqrestore(&base->cpu_base->lock, *flags);
                 }
                 cpu_relax();
+               udelay(1);
         }
  }

@@ -1067,6 +1069,7 @@ int hrtimer_cancel(struct hrtimer *timer)
                 if (ret >= 0)
                         return ret;
                 cpu_relax();
+               udelay(1);
         }
  }
  EXPORT_SYMBOL_GPL(hrtimer_cancel);

Note:- Timer event streaming is enabled and still live lock observed.

-Thanks, Prasad

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
Linux Foundation Collaborative Project
