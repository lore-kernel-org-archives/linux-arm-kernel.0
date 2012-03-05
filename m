From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon, 5 Mar 2012 09:33:13 +0100
Subject: [PATCH] ARM: ux500: wake secondary cpu via resched
Message-ID: <1330936393-14105-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jonas Aaberg <jonas.aberg@stericsson.com>

Wake secondary cpu via resched instead of
"Unknown IPI message 0x1"

Signed-off-by: Jonas Aaberg <jonas.aberg@stericsson.com>
Reviewed-by: Rickard Andersson <rickard.andersson@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/platsmp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-ux500/platsmp.c b/arch/arm/mach-ux500/platsmp.c
index d2058ef..eff5842 100644
--- a/arch/arm/mach-ux500/platsmp.c
+++ b/arch/arm/mach-ux500/platsmp.c
@@ -99,7 +99,7 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 */
 	write_pen_release(cpu_logical_map(cpu));
 
-	gic_raise_softirq(cpumask_of(cpu), 1);
+	smp_send_reschedule(cpu);
 
 	timeout = jiffies + (1 * HZ);
 	while (time_before(jiffies, timeout)) {
-- 
1.7.8
