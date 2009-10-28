From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 28 Oct 2009 12:15:44 +0000
Subject: [PATCH 03/12] ARM: S3C2410: Fix link if CONFIG_S3C2410_IOTIMING is
	not set
In-Reply-To: <1256732153-22027-1-git-send-email-ben-linux@fluff.org>
References: <1256732153-22027-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1256732153-22027-3-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the link errors if cpu-frequency support is enabled on s3c2410 systems
but there is no CONFIG_S3C2410_IOTIMING set. Fix this by ensuring the
relevant symbols are defined NULL if the code is not being built in.

Fixes the following error:
arch/arm/mach-s3c2410/built-in.o: undefined reference to `s3c2410_iotiming_get'
arch/arm/mach-s3c2410/built-in.o: undefined reference to `s3c2410_iotiming_set'
arch/arm/mach-s3c2410/built-in.o: undefined reference to `s3c2410_iotiming_calc'

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/plat-s3c24xx/include/plat/cpu-freq-core.h |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-s3c24xx/include/plat/cpu-freq-core.h b/arch/arm/plat-s3c24xx/include/plat/cpu-freq-core.h
index efeb025..c776120 100644
--- a/arch/arm/plat-s3c24xx/include/plat/cpu-freq-core.h
+++ b/arch/arm/plat-s3c24xx/include/plat/cpu-freq-core.h
@@ -222,7 +222,9 @@ extern struct clk *s3c_cpufreq_clk_get(struct device *, const char *);
 /* S3C2410 and compatible exported functions */
 
 extern void s3c2410_cpufreq_setrefresh(struct s3c_cpufreq_config *cfg);
+extern void s3c2410_set_fvco(struct s3c_cpufreq_config *cfg);
 
+#ifdef CONFIG_S3C2410_IOTIMING
 extern int s3c2410_iotiming_calc(struct s3c_cpufreq_config *cfg,
 				 struct s3c_iotimings *iot);
 
@@ -231,8 +233,11 @@ extern int s3c2410_iotiming_get(struct s3c_cpufreq_config *cfg,
 
 extern void s3c2410_iotiming_set(struct s3c_cpufreq_config *cfg,
 				 struct s3c_iotimings *iot);
-
-extern void s3c2410_set_fvco(struct s3c_cpufreq_config *cfg);
+#else
+#define s3c2410_iotiming_calc NULL
+#define s3c2410_iotiming_get NULL
+#define s3c2410_iotiming_set NULL
+#endif /* CONFIG_S3C2410_IOTIMING */
 
 /* S3C2412 compatible routines */
 
-- 
1.6.3.3
