From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 12 Jun 2013 19:30:27 +0800
Subject: [PATCH] irqchip: gic: call gic_cpu_init() as well in
 CPU_STARTING_FROZEN case
Message-ID: <1371036627-13529-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit c011470 (irqchip: gic: Perform the gic_secondary_init() call via
CPU notifier) moves gic_secondary_init() that used to be called in
.smp_secondary_init hook into a notifier call.  But it changes the
system behavior a little bit.  Before the commit, gic_cpu_init()
is called not only when kernel brings up the secondary cores but also
when system resuming procedure hot-plugs the cores back to kernel.
While after the commit, the function will not be called in the latter
case, where the 'action' will not be CPU_STARTING but
CPU_STARTING_FROZEN.  This behavior difference at least causes the
following suspend/resume regression on imx6q.

$ echo mem > /sys/power/state
PM: Syncing filesystems ... done.
PM: Preparing system for mem sleep
mmc1: card e624 removed
Freezing user space processes ... (elapsed 0.01 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.01 seconds) done.
PM: Entering mem sleep
PM: suspend of devices complete after 5.930 msecs
PM: suspend devices took 0.010 seconds
PM: late suspend of devices complete after 0.343 msecs
PM: noirq suspend of devices complete after 0.828 msecs
Disabling non-boot CPUs ...
CPU1: shutdown
CPU2: shutdown
CPU3: shutdown
Enabling non-boot CPUs ...
CPU1: Booted secondary processor
INFO: rcu_sched detected stalls on CPUs/tasks: { 1 2 3} (detected by 0, t=2102 jiffies, g=4294967169, c=4294967168, q=17)
Task dump for CPU 1:
swapper/1       R running      0     0      1 0x00000000
Backtrace:
[<bf895ff4>] (0xbf895ff4) from [<00000000>] (  (null))
Backtrace aborted due to bad frame pointer <8007ccdc>
Task dump for CPU 2:
swapper/2       R running      0     0      1 0x00000000
Backtrace:
[<8075dbdc>] (0x8075dbdc) from [<00000000>] (  (null))
Backtrace aborted due to bad frame pointer <00000002>
Task dump for CPU 3:
swapper/3       R running      0     0      1 0x00000000
Backtrace:
[<8075dbdc>] (0x8075dbdc) from [<00000000>] (  (null))

Fix the regression by checking 'action' being CPU_STARTING_FROZEN to
have gic_cpu_init() called for secondary cores when system resumes.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/irqchip/irq-gic.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 1760ceb..19ceaa6 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -705,7 +705,7 @@ static int gic_irq_domain_xlate(struct irq_domain *d,
 static int __cpuinit gic_secondary_init(struct notifier_block *nfb,
 					unsigned long action, void *hcpu)
 {
-	if (action == CPU_STARTING)
+	if (action == CPU_STARTING || action == CPU_STARTING_FROZEN)
 		gic_cpu_init(&gic_data[0]);
 	return NOTIFY_OK;
 }
-- 
1.7.9.5
