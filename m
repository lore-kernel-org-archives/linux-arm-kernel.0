From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 9 Mar 2018 11:50:20 +0200
Subject: [PATCH] ARM: OMAP2+: powerdomain: use raw_smp_processor_id() for trace
Message-ID: <1520589020-14018-1-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

smp_processor_id() checks preemption if CONFIG_DEBUG_PREEMPT is enabled,
causing a warning dump during boot:

[    5.042377] BUG: using smp_processor_id() in preemptible [00000000] code: swapper/0/1
[    5.050281] caller is pwrdm_set_next_pwrst+0x48/0x88
[    5.055330] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.14.24-g57341df0b4 #1

Use the raw_smp_processor_id() for the trace instead, this value does
not need to be perfectly correct. The alternative of disabling preempt
is too heavy weight operation to be applied in PM hot path for just
tracing purposes.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/powerdomain.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 76eb6ec..1e6a967 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -188,7 +188,7 @@ static int _pwrdm_state_switch(struct powerdomain *pwrdm, int flag)
 				       ((prev & OMAP_POWERSTATE_MASK) << 0));
 			trace_power_domain_target_rcuidle(pwrdm->name,
 							  trace_state,
-							  smp_processor_id());
+							  raw_smp_processor_id());
 		}
 		break;
 	default:
@@ -518,7 +518,7 @@ int pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
 	if (arch_pwrdm && arch_pwrdm->pwrdm_set_next_pwrst) {
 		/* Trace the pwrdm desired target state */
 		trace_power_domain_target_rcuidle(pwrdm->name, pwrst,
-						  smp_processor_id());
+						  raw_smp_processor_id());
 		/* Program the pwrdm desired target state */
 		ret = arch_pwrdm->pwrdm_set_next_pwrst(pwrdm, pwrst);
 	}
-- 
1.9.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
