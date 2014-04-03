From: antoine.tenart@free-electrons.com (=?UTF-8?q?Antoine=20T=C3=A9nart?=)
Date: Thu,  3 Apr 2014 10:08:14 +0200
Subject: [PATCH 1/3] ARM: berlin: use CPU_METHOD_OF_DECLARE for smp
In-Reply-To: <1396512496-8030-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1396512496-8030-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1396512496-8030-2-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Get rid of the smp ops in the machine descriptor and select the cpu
enable method in the device tree.

Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
---
 arch/arm/mach-berlin/berlin.c  | 1 -
 arch/arm/mach-berlin/common.h  | 2 --
 arch/arm/mach-berlin/platsmp.c | 3 ++-
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-berlin/berlin.c b/arch/arm/mach-berlin/berlin.c
index 1bbca793174d..3cc3e706719e 100644
--- a/arch/arm/mach-berlin/berlin.c
+++ b/arch/arm/mach-berlin/berlin.c
@@ -38,5 +38,4 @@ static const char * const berlin_dt_compat[] = {
 DT_MACHINE_START(BERLIN_DT, "Marvell Berlin")
 	.dt_compat	= berlin_dt_compat,
 	.init_machine	= berlin_init_machine,
-	.smp		= smp_ops(berlin_smp_ops),
 MACHINE_END
diff --git a/arch/arm/mach-berlin/common.h b/arch/arm/mach-berlin/common.h
index 57c97669af0a..8d585e2481f9 100644
--- a/arch/arm/mach-berlin/common.h
+++ b/arch/arm/mach-berlin/common.h
@@ -13,6 +13,4 @@
 
 extern void berlin_secondary_startup(void);
 
-extern struct smp_operations berlin_smp_ops;
-
 #endif
diff --git a/arch/arm/mach-berlin/platsmp.c b/arch/arm/mach-berlin/platsmp.c
index 5c83941b0918..86fe697577fd 100644
--- a/arch/arm/mach-berlin/platsmp.c
+++ b/arch/arm/mach-berlin/platsmp.c
@@ -132,8 +132,9 @@ static void __init berlin_smp_prepare_cpus(unsigned int max_cpus)
 	iounmap(gpr_base);
 }
 
-struct smp_operations berlin_smp_ops __initdata = {
+static struct smp_operations berlin_smp_ops __initdata = {
 	.smp_prepare_cpus	= berlin_smp_prepare_cpus,
 	.smp_secondary_init	= berlin_secondary_init,
 	.smp_boot_secondary	= berlin_boot_secondary,
 };
+CPU_METHOD_OF_DECLARE(berlin_smp, "marvell,88de31-smp", &berlin_smp_ops);
-- 
1.8.3.2
