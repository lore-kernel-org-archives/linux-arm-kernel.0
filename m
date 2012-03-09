From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 9 Mar 2012 17:48:21 +0100
Subject: [PATCH] ARM: smp_twd: Only wait for reprogramming on active cpus
Message-ID: <1331311701-32071-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jonas Aaberg <jonas.aberg@stericsson.com>

During booting of cpu1, there is a short window where cpu1
is online, but not active where cpu1 is occupied by waiting
to become active. If cpu0 then decides to schedule something
on cpu1 and wait for it to complete, before cpu0 has set
cpu1 active, we have a deadlock.

Typically it's this CPU frequency transition that happens at
this time, so let's just not wait for it to happen, it will
happen whenever the CPU eventually comes online instead.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: stable at kernel.org
Signed-off-by: Jonas Aaberg <jonas.aberg@stericsson.com>
Reviewed-by: Rickard Andersson <rickard.andersson@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
This situation occurs as discussed here:
https://lkml.org/lkml/2012/2/29/141

We're also testing this patch from Peter:
https://lkml.org/lkml/2011/12/15/255
---
 arch/arm/kernel/smp_twd.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index 7a79b24..692afa4 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -115,10 +115,14 @@ static int twd_cpufreq_transition(struct notifier_block *nb,
 	 * The twd clock events must be reprogrammed to account for the new
 	 * frequency.  The timer is local to a cpu, so cross-call to the
 	 * changing cpu.
+	 *
+	 * Only wait for it to finish, if the cpu is active to avoid
+	 * deadlock when cpu1 is spinning on while(!cpu_active(cpu1)) during
+	 * booting of that cpu.
 	 */
 	if (state == CPUFREQ_POSTCHANGE || state == CPUFREQ_RESUMECHANGE)
 		smp_call_function_single(freqs->cpu, twd_update_frequency,
-			NULL, 1);
+					 NULL, cpu_active(freqs->cpu));
 
 	return NOTIFY_OK;
 }
-- 
1.7.8
