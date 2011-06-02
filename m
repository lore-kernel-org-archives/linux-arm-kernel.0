From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Jun 2011 10:46:22 +0100
Subject: [PATCHv2 0/3] clocksource: add db8500 PRCMU timer
In-Reply-To: <1307007271-1004-1-git-send-email-mattias.wallin@stericsson.com>
References: <1307007271-1004-1-git-send-email-mattias.wallin@stericsson.com>
Message-ID: <20110602094622.GS3660@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 02, 2011 at 11:34:31AM +0200, Mattias Wallin wrote:
> The Multi Timer Unit (MTU) is currently used as clocksource and sched_clk
> for the u8500 machine. The MTU block loose power during cpuidle sleep states
> so an alternate clocksource is needed and these patches adds the db8500 PRCMU
> timer.

Why don't we just find a way of fixing sched_clock so that the value
doesn't reset over a suspend/resume cycle?  IOW, lets fix the problem
for _everyone_ rather than only fixing it for one platform at a time.

Could you try this patch to check whether sched_clock() behaves better
across a suspend/resume cycle please?

 arch/arm/kernel/sched_clock.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/sched_clock.c b/arch/arm/kernel/sched_clock.c
index 9a46370..4be4019 100644
--- a/arch/arm/kernel/sched_clock.c
+++ b/arch/arm/kernel/sched_clock.c
@@ -10,6 +10,7 @@
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
+#include <linux/syscore_ops.h>
 #include <linux/timer.h>
 
 #include <asm/sched_clock.h>
@@ -72,3 +73,20 @@ void __init sched_clock_postinit(void)
 {
 	sched_clock_poll(sched_clock_timer.data);
 }
+
+static int sched_clock_suspend(void)
+{
+	sched_clock_poll(sched_clock_timer.data);
+	return 0;
+}
+
+static struct syscore_ops sched_clock_ops = {
+	.suspend	= sched_clock_suspend,
+};
+
+static int __init sched_clock_syscore_init(void)
+{
+	register_syscore_ops(&sched_clock_ops);
+	return 0;
+}
+device_initcall(sched_clock_syscore_init);
