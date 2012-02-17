From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 17 Feb 2012 12:34:29 +0200
Subject: [PATCH] arm: smp-twd: check for uninitialized clock in
 twd_cpufreq_init
Message-ID: <1329474869-32356-1-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Non-smp platforms don't have local timer support, but the twd_cpufreq_init
only checks for IS_ERR during init. Check against null also, to avoid
crashes during cpufreq transitions on non-smp platforms.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/kernel/smp_twd.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index 4285daa..dae8902 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -129,7 +129,7 @@ static struct notifier_block twd_cpufreq_nb = {
 
 static int twd_cpufreq_init(void)
 {
-	if (!IS_ERR(twd_clk))
+	if (twd_clk && !IS_ERR(twd_clk))
 		return cpufreq_register_notifier(&twd_cpufreq_nb,
 			CPUFREQ_TRANSITION_NOTIFIER);
 
-- 
1.7.4.1
