From: elder@linaro.org (Alex Elder)
Date: Tue,  8 Apr 2014 17:31:28 -0500
Subject: [RFC PATCH RESEND] ARM: spear: send SGI to trigger secondary CPU start
Message-ID: <1396996288-32020-1-git-send-email-elder@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM spear machine uses the "holding pen" mechanism for starting
secondary CPUs.  Most implementations indicate it's a secondary
core's time to start by writing its CPU id into a location and
then signaling the core with a software-generated interrupt.

The spear code does not send the signal.  Comments elsewhere
in the code seem to indicate it should:
    The BootMonitor waits until it receives a soft interrupt, and
    then the secondary CPU branches to this address.

I suspect this is an oversight, and this patch proposes a remedy.

  *** I need the attention of a maintainer to verify this
  *** because I am unable to test this proposed change.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 arch/arm/mach-spear/platsmp.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-spear/platsmp.c b/arch/arm/mach-spear/platsmp.c
index 5c4a198..c9064fe 100644
--- a/arch/arm/mach-spear/platsmp.c
+++ b/arch/arm/mach-spear/platsmp.c
@@ -62,6 +62,8 @@ static int spear13xx_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	flush_cache_all();
 	outer_flush_all();
 
+	arch_send_wakeup_ipi_mask(cpumask_of(cpu));
+
 	timeout = jiffies + (1 * HZ);
 	while (time_before(jiffies, timeout)) {
 		smp_rmb();
-- 
1.7.9.5
