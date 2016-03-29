From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 29 Mar 2016 10:38:23 +0900
Subject: [PATCH 1/2] ARM: uniphier: fix up cache ops broadcast of ACTLR
In-Reply-To: <1459215505-18035-1-git-send-email-yamada.masahiro@socionext.com>
References: <1459215505-18035-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1459215505-18035-2-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Boot ROM of the UniPhier ARMv7 SoCs sets ACTLR (Auxiliary Control
Register) to different values for different secure states:

[1] Set ACTLR to 0x41 for Non-secure boot
[2] Set ACTLR to 0x40 for Secure boot

[1] is okay, but [2] is a problem.  Because of commit 1b3a02eb4523
("ARMv7: Check whether the SMP/nAMP mode was already enabled"),
if bit 6 (SMP bit) is already set, the kernel skips the ACTLR setting.
In that case, bit 0 (FW bit) is never set, so cache ops is not
broadcasted, causing a cache coherency problem.

To solve the problem, this commit sets the bit 0 of ACTLR if the bit 4
has already been set.  This change is harmless for [1] because the
Boot ROM has already set NSACR (Non-secure Access Control Register)
bit 18 (NS_SMP bit) before switching to Non-secure state in order to
allow write access to the ACTLR.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/mach-uniphier/platsmp.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/mach-uniphier/platsmp.c b/arch/arm/mach-uniphier/platsmp.c
index db04142..285b684 100644
--- a/arch/arm/mach-uniphier/platsmp.c
+++ b/arch/arm/mach-uniphier/platsmp.c
@@ -170,6 +170,18 @@ static int __init uniphier_smp_enable_scu(void)
 	return 0;
 }
 
+static void __init uniphier_smp_fixup_cache_broadcast(void)
+{
+	u32 tmp;
+
+	asm volatile(
+		"mrc	p15, 0, %0, c1, c0, 1\n"
+		"tst	%0, #(1 << 6)\n"
+		"orrne	%0, #(1 << 0)\n"
+		"mcr	p15, 0, %0, c1, c0, 1\n"
+		: "=r" (tmp) : : "memory", "cc");
+}
+
 static void __init uniphier_smp_prepare_cpus(unsigned int max_cpus)
 {
 	static cpumask_t only_cpu_0 = { CPU_BITS_CPU0 };
@@ -183,6 +195,8 @@ static void __init uniphier_smp_prepare_cpus(unsigned int max_cpus)
 	if (ret)
 		goto err;
 
+	uniphier_smp_fixup_cache_broadcast();
+
 	return;
 err:
 	pr_warn("disabling SMP\n");
@@ -209,9 +223,15 @@ static int __init uniphier_smp_boot_secondary(unsigned int cpu,
 	return 0;
 }
 
+static void __init uniphier_smp_secondary_init(unsigned int cpu)
+{
+	uniphier_smp_fixup_cache_broadcast();
+}
+
 static const struct smp_operations uniphier_smp_ops __initconst = {
 	.smp_prepare_cpus	= uniphier_smp_prepare_cpus,
 	.smp_boot_secondary	= uniphier_smp_boot_secondary,
+	.smp_secondary_init	= uniphier_smp_secondary_init,
 };
 CPU_METHOD_OF_DECLARE(uniphier_smp, "socionext,uniphier-smp",
 		      &uniphier_smp_ops);
-- 
1.9.1
