From: ashwin.chaugule@linaro.org (Ashwin Chaugule)
Date: Thu, 24 Apr 2014 14:07:20 -0400
Subject: [PATCH v6 3/3] ARM: Check if a CPU has gone offline
In-Reply-To: <CAL_Jsq+LUNY4O5mRi5+kNV74H--PpVAMxJxjEnKbtxTYBHG-=A@mail.gmail.com>
References: <1397762146-8337-1-git-send-email-ashwin.chaugule@linaro.org>
 <1397762146-8337-4-git-send-email-ashwin.chaugule@linaro.org>
 <20140417195009.GC24195@e106331-lin.cambridge.arm.com>
 <CAJ5Y-eZMKZYOaQnFPu31Vzg6KXDy7J5gFKh3hAy+GuLz66Wgwg@mail.gmail.com>
 <CAJ5Y-ebZ9M9GM5R40-Yrbx=iNhB4_j-vw=8mBA=1cwZGnhixLw@mail.gmail.com>
 <CAL_Jsq+LUNY4O5mRi5+kNV74H--PpVAMxJxjEnKbtxTYBHG-=A@mail.gmail.com>
Message-ID: <CAJ5Y-eb0eD-8bgNUaRypStNMa0VEy0L=0qZ=cSrmPLZv5fg9FA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 April 2014 11:11, Rob Herring <robherring2@gmail.com> wrote:
>>
>> Hi Rob, I've already got your Reviewed-by on this patch without this
>> "retry" thing. Are you okay with this as well? I can then roll it up
>> in one patch.
>
> Yes. My only comment is I would perhaps add a sleep (or delay if this
> context cannot sleep) on the retry. I'm not sure what I reasonable
> time would be, but at least then you are waiting a defined amount of
> time versus how long it takes this code to execute.


Yea, its tricky to get the delay right. Does this look better? The
caller has a wait_for_completion (which waits for 5secs max) in it, so
this context should be sleepable.

"100 msecs ought to be enough for anyone". ;)

diff --git a/arch/arm/kernel/psci_smp.c b/arch/arm/kernel/psci_smp.c
index 3a83dcf..94485e0 100644
--- a/arch/arm/kernel/psci_smp.c
+++ b/arch/arm/kernel/psci_smp.c
@@ -16,6 +16,7 @@
 #include <linux/init.h>
 #include <linux/smp.h>
 #include <linux/of.h>
+#include <linux/delay.h>
 #include <uapi/linux/psci.h>

 #include <asm/psci.h>
@@ -70,22 +71,23 @@ void __ref psci_cpu_die(unsigned int cpu)

 int __ref psci_cpu_kill(unsigned int cpu)
 {
- int err, retries;
+ int err, retry = 0;

  if (!psci_ops.affinity_info)
  return 1;
  /*
  * cpu_kill could race with cpu_die and we can
  * potentially end up declaring this cpu undead
- * while it is dying. So retry a couple of times.
+ * while it is dying. So, try once more if it fails.
  */
-retry:
+retry_once:
  err = psci_ops.affinity_info(cpu_logical_map(cpu), 0);

  if (err != PSCI_AFFINITY_INFO_RET_OFF) {
- if (++retries < 3) {
- pr_info("Retrying check for CPU kill: %d\n", retries);
- goto retry;
+ if (!retry++) {
+ msleep(100);
+ pr_info("Retrying once more to check for CPU kill\n");
+ goto retry_once;
  }
  pr_err("psci: Cannot kill CPU:%d, psci ret val: %d\n",
  cpu, err);
