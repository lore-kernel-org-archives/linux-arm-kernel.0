From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Tue, 21 Jun 2016 11:31:14 +0200
Subject: [PATCH v2 1/2] ARM: tango: add HOTPLUG_CPU support
In-Reply-To: <576908D6.8090000@sigmadesigns.com>
References: <576908D6.8090000@sigmadesigns.com>
Message-ID: <57690962.8050701@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

cpu_die() and cpu_kill() are implemented in firmware.

Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
---
 arch/arm/mach-tango/platsmp.c | 17 +++++++++++++++++
 arch/arm/mach-tango/smc.h     |  4 +++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-tango/platsmp.c b/arch/arm/mach-tango/platsmp.c
index a21f55e000d2..ff495f6b6f40 100644
--- a/arch/arm/mach-tango/platsmp.c
+++ b/arch/arm/mach-tango/platsmp.c
@@ -9,8 +9,25 @@ static int tango_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	return 0;
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+static int tango_cpu_kill(unsigned int cpu)
+{
+	return tango_aux_core_kill(cpu);
+}
+
+static void tango_cpu_die(unsigned int cpu)
+{
+	tango_aux_core_die(cpu);
+}
+#else
+#define tango_cpu_kill	NULL
+#define tango_cpu_die	NULL
+#endif
+
 static const struct smp_operations tango_smp_ops __initconst = {
 	.smp_boot_secondary	= tango_boot_secondary,
+	.cpu_kill		= tango_cpu_kill,
+	.cpu_die		= tango_cpu_die,
 };
 
 CPU_METHOD_OF_DECLARE(tango4_smp, "sigma,tango4-smp", &tango_smp_ops);
diff --git a/arch/arm/mach-tango/smc.h b/arch/arm/mach-tango/smc.h
index 7a4af35cc390..3d31f984f44c 100644
--- a/arch/arm/mach-tango/smc.h
+++ b/arch/arm/mach-tango/smc.h
@@ -2,4 +2,6 @@ extern int tango_smc(unsigned int val, unsigned int service);
 
 #define tango_set_l2_control(val)	tango_smc(val, 0x102)
 #define tango_start_aux_core(val)	tango_smc(val, 0x104)
-#define tango_set_aux_boot_addr(val)	tango_smc((unsigned int)val, 0x105)
+#define tango_set_aux_boot_addr(val)	tango_smc(val, 0x105)
+#define tango_aux_core_die(val)		tango_smc(val, 0x121)
+#define tango_aux_core_kill(val)	tango_smc(val, 0x122)
-- 
2.8.2
