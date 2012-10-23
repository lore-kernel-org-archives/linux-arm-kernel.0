From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 23 Oct 2012 23:22:58 +0800
Subject: [PATCH 09/10] ARM: SMP: add function arch_send_wakeup_ipi_mask()
In-Reply-To: <1351005779-30347-1-git-send-email-shawn.guo@linaro.org>
References: <1351005779-30347-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1351005779-30347-10-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add function arch_send_wakeup_ipi_mask(), so that platform code can
use it as an easy way to wake up cores that are in WFI.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/include/asm/smp.h |    1 +
 arch/arm/kernel/smp.c      |    5 +++++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm/include/asm/smp.h b/arch/arm/include/asm/smp.h
index 2e3be16..d3a22be 100644
--- a/arch/arm/include/asm/smp.h
+++ b/arch/arm/include/asm/smp.h
@@ -79,6 +79,7 @@ extern void cpu_die(void);
 
 extern void arch_send_call_function_single_ipi(int cpu);
 extern void arch_send_call_function_ipi_mask(const struct cpumask *mask);
+extern void arch_send_wakeup_ipi_mask(const struct cpumask *mask);
 
 struct smp_operations {
 #ifdef CONFIG_SMP
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 8e20754d..dd5dd02 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -415,6 +415,11 @@ void arch_send_call_function_ipi_mask(const struct cpumask *mask)
 	smp_cross_call(mask, IPI_CALL_FUNC);
 }
 
+void arch_send_wakeup_ipi_mask(const struct cpumask *mask)
+{
+	smp_cross_call(mask, IPI_WAKEUP);
+}
+
 void arch_send_call_function_single_ipi(int cpu)
 {
 	smp_cross_call(cpumask_of(cpu), IPI_CALL_FUNC_SINGLE);
-- 
1.7.9.5
