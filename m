From: linux@solonet.org.ua (Denis Kuzmenko)
Date: Wed, 30 Nov 2011 10:20:35 +0200
Subject: [PATCH resend] s3c24xx: cpufreq: Fix compilation error when
 CONFIG_CPU_FREQ_S3C24XX_DEBUGFS selected.
Message-ID: <4ED5E753.1030506@solonet.org.ua>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix compilation error when CONFIG_CPU_FREQ_S3C24XX_DEBUGFS selected.

Signed-off-by: Denis Kuzmenko <linux@solonet.org.ua>
---

Patch is against 3.2-rc3.
CONFIG_S3C2410_IOTIMING wasn't present in Kconfig but was referenced by
Makefile. Because of this the file s3c2410-iotiming.c was not ever compiled
and enabling CONFIG_CPU_FREQ_S3C24XX_DEBUGFS option caused undefined
reference to function s3c2410_iotiming_debugfs defined in that file.

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 44789ef..81d7025 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2104,9 +2104,31 @@ config CPU_FREQ_S3C24XX_DEBUG
 	help
 	  Enable s3c_freq_dbg for the Samsung S3C CPUfreq core
 +config S3C2410_IOTIMING
+	bool "CPUfreq iotiming for Samsung S3C2410 series CPUs"
+	depends on ARCH_S3C2410 && CPU_FREQ && CPU_FREQ_S3C24XX && EXPERIMENTAL
+	help
+	  This enables the CPUfreq driver for the Samsung S3C24XX to change
+	  IO timing according to the CPU frequency.
+
+	  For details, take a look at <file:Documentation/cpu-freq>.
+
+	  If in doubt, say Y.
+
+config S3C2412_IOTIMING
+	bool "CPUfreq iotiming for Samsung S3C2412 series CPUs"
+	depends on ARCH_S3C2412 && CPU_FREQ && CPU_FREQ_S3C24XX && EXPERIMENTAL
+	help
+	  This enables the CPUfreq driver for the Samsung S3C2412 to change
+	  IO timing according to the CPU frequency.
+
+	  For details, take a look at <file:Documentation/cpu-freq>.
+
+	  If in doubt, say Y.
+
 config CPU_FREQ_S3C24XX_IODEBUG
 	bool "Debug CPUfreq Samsung driver IO timing"
-	depends on CPU_FREQ_S3C24XX
+	depends on CPU_FREQ_S3C24XX && (S3C2410_IOTIMING || S3C2412_IOTIMING)
 	help
 	  Enable s3c_freq_iodbg for the Samsung S3C CPUfreq core
 diff --git a/arch/arm/plat-samsung/include/plat/cpu-freq-core.h
b/arch/arm/plat-samsung/include/plat/cpu-freq-core.h
index dac4760..c465252 100644
--- a/arch/arm/plat-samsung/include/plat/cpu-freq-core.h
+++ b/arch/arm/plat-samsung/include/plat/cpu-freq-core.h
@@ -202,13 +202,23 @@ extern int s3c_plltab_register(struct
cpufreq_frequency_table *plls,
 extern struct s3c_cpufreq_config *s3c_cpufreq_getconfig(void);
 extern struct s3c_iotimings *s3c_cpufreq_getiotimings(void);
 -extern void s3c2410_iotiming_debugfs(struct seq_file *seq,
-				     struct s3c_cpufreq_config *cfg,
-				     union s3c_iobank *iob);
-
-extern void s3c2412_iotiming_debugfs(struct seq_file *seq,
-				     struct s3c_cpufreq_config *cfg,
-				     union s3c_iobank *iob);
+#ifdef CONFIG_CPU_FREQ_S3C24XX_DEBUGFS
+	#ifdef CONFIG_S3C2410_IOTIMING
+	extern void s3c2410_iotiming_debugfs(struct seq_file *seq,
+					     struct s3c_cpufreq_config *cfg,
+					     union s3c_iobank *iob);
+	#else
+	#define s3c2410_iotiming_debugfs	NULL
+	#endif
+
+	#ifdef CONFIG_S3C2412_IOTIMING
+	extern void s3c2412_iotiming_debugfs(struct seq_file *seq,
+					     struct s3c_cpufreq_config *cfg,
+					     union s3c_iobank *iob);
+	#else
+	#define s3c2412_iotiming_debugfs	NULL
+	#endif
+#endif
  #ifdef CONFIG_CPU_FREQ_S3C24XX_DEBUGFS
 #define s3c_cpufreq_debugfs_call(x) x
@@ -241,10 +251,7 @@ extern void s3c2410_iotiming_set(struct
s3c_cpufreq_config *cfg,
 #endif /* CONFIG_S3C2410_IOTIMING */
  /* S3C2412 compatible routines */
-
-extern int s3c2412_iotiming_get(struct s3c_cpufreq_config *cfg,
-				struct s3c_iotimings *timings);
-
+#ifdef CONFIG_S3C2412_IOTIMING
 extern int s3c2412_iotiming_get(struct s3c_cpufreq_config *cfg,
 				struct s3c_iotimings *timings);
 @@ -253,6 +260,11 @@ extern int s3c2412_iotiming_calc(struct
s3c_cpufreq_config *cfg,
  extern void s3c2412_iotiming_set(struct s3c_cpufreq_config *cfg,
 				 struct s3c_iotimings *iot);
+#else
+#define s3c2412_iotiming_calc NULL
+#define s3c2412_iotiming_get NULL
+#define s3c2412_iotiming_set NULL
+#endif
  #ifdef CONFIG_CPU_FREQ_S3C24XX_DEBUG
 #define s3c_freq_dbg(x...) printk(KERN_INFO x)
