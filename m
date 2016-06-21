From: tony@atomide.com (Tony Lindgren)
Date: Tue, 21 Jun 2016 00:52:45 -0700
Subject: [PATCH 4/4] ARM: OMAP4+: Allow kexec on SMP variants
In-Reply-To: <1466495565-17480-1-git-send-email-tony@atomide.com>
References: <1466495565-17480-1-git-send-email-tony@atomide.com>
Message-ID: <1466495565-17480-5-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kexec needs omap4_cpu_kill, otherwise kexec will produce on SMP:

kexec_load failed: Invalid argument

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/common.h       | 1 +
 arch/arm/mach-omap2/omap-hotplug.c | 6 ++++++
 arch/arm/mach-omap2/omap-smp.c     | 1 +
 3 files changed, 8 insertions(+)

diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index 0136405..deed42e 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -272,6 +272,7 @@ extern void omap_auxcoreboot_addr(u32 cpu_addr);
 extern u32 omap_read_auxcoreboot0(void);
 
 extern void omap4_cpu_die(unsigned int cpu);
+extern int omap4_cpu_kill(unsigned int cpu);
 
 extern const struct smp_operations omap4_smp_ops;
 
diff --git a/arch/arm/mach-omap2/omap-hotplug.c b/arch/arm/mach-omap2/omap-hotplug.c
index 593fec7..d3fb566 100644
--- a/arch/arm/mach-omap2/omap-hotplug.c
+++ b/arch/arm/mach-omap2/omap-hotplug.c
@@ -64,3 +64,9 @@ void omap4_cpu_die(unsigned int cpu)
 		pr_debug("CPU%u: spurious wakeup call\n", cpu);
 	}
 }
+
+/* Needed by kexec and platform_can_cpu_hotplug() */
+int omap4_cpu_kill(unsigned int cpu)
+{
+	return 1;
+}
diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index 81bb053..d53a0de 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -329,5 +329,6 @@ const struct smp_operations omap4_smp_ops __initconst = {
 	.smp_boot_secondary	= omap4_boot_secondary,
 #ifdef CONFIG_HOTPLUG_CPU
 	.cpu_die		= omap4_cpu_die,
+	.cpu_kill		= omap4_cpu_kill,
 #endif
 };
-- 
2.8.1
