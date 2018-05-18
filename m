From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 18 May 2018 14:48:50 +0200
Subject: [PATCH 1/5] ARM: shmobile: r8a7790: Remove legacy SMP fallback code
In-Reply-To: <1526647734-1200-1-git-send-email-geert+renesas@glider.be>
References: <1526647734-1200-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1526647734-1200-2-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As of commit f5d70b9cee2282ec ("ARM: shmobile: r8a7790: Prioritize DT
APMU support") in v4.8, non-DT enablement of SMP was left as a fallback
for backwards compatibility with old DTBs.

The time has come to drop backwards compatibility, hence remove the
fallback code.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/Makefile        |  1 -
 arch/arm/mach-shmobile/r8a7790.h       |  7 ----
 arch/arm/mach-shmobile/setup-r8a7790.c |  2 -
 arch/arm/mach-shmobile/smp-r8a7790.c   | 71 ----------------------------------
 4 files changed, 81 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/r8a7790.h
 delete mode 100644 arch/arm/mach-shmobile/smp-r8a7790.c

diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index 1939f521579c6357..9133949b5df2c824 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -32,7 +32,6 @@ obj-$(CONFIG_ARCH_R8A7793)	+= regulator-quirk-rcar-gen2.o
 smp-y				:= $(cpu-y)
 smp-$(CONFIG_ARCH_SH73A0)	+= smp-sh73a0.o headsmp-scu.o platsmp-scu.o
 smp-$(CONFIG_ARCH_R8A7779)	+= smp-r8a7779.o headsmp-scu.o platsmp-scu.o
-smp-$(CONFIG_ARCH_R8A7790)	+= smp-r8a7790.o
 smp-$(CONFIG_ARCH_R8A7791)	+= smp-r8a7791.o
 smp-$(CONFIG_ARCH_EMEV2)	+= smp-emev2.o headsmp-scu.o platsmp-scu.o
 
diff --git a/arch/arm/mach-shmobile/r8a7790.h b/arch/arm/mach-shmobile/r8a7790.h
deleted file mode 100644
index 669c8cd09e076e9b..0000000000000000
--- a/arch/arm/mach-shmobile/r8a7790.h
+++ /dev/null
@@ -1,7 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __ASM_R8A7790_H__
-#define __ASM_R8A7790_H__
-
-extern const struct smp_operations r8a7790_smp_ops;
-
-#endif /* __ASM_R8A7790_H__ */
diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
index 78d3e859bd64ad7d..fd2435b39529438e 100644
--- a/arch/arm/mach-shmobile/setup-r8a7790.c
+++ b/arch/arm/mach-shmobile/setup-r8a7790.c
@@ -19,7 +19,6 @@
 #include <asm/mach/arch.h>
 
 #include "common.h"
-#include "r8a7790.h"
 #include "rcar-gen2.h"
 
 static const char * const r8a7790_boards_compat_dt[] __initconst = {
@@ -29,7 +28,6 @@ static const char * const r8a7790_boards_compat_dt[] __initconst = {
 
 DT_MACHINE_START(R8A7790_DT, "Generic R8A7790 (Flattened Device Tree)")
 	.smp_init	= smp_init_ops(shmobile_smp_init_fallback_ops),
-	.smp		= smp_ops(r8a7790_smp_ops),
 	.init_early	= shmobile_init_delay,
 	.init_time	= rcar_gen2_timer_init,
 	.init_late	= shmobile_init_late,
diff --git a/arch/arm/mach-shmobile/smp-r8a7790.c b/arch/arm/mach-shmobile/smp-r8a7790.c
deleted file mode 100644
index 28f26d5362d8d4d2..0000000000000000
--- a/arch/arm/mach-shmobile/smp-r8a7790.c
+++ /dev/null
@@ -1,71 +0,0 @@
-/*
- * SMP support for r8a7790
- *
- * Copyright (C) 2012-2013 Renesas Solutions Corp.
- * Copyright (C) 2012 Takashi Yoshii <takashi.yoshii.ze@renesas.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; version 2 of the License.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/smp.h>
-#include <linux/io.h>
-#include <linux/soc/renesas/rcar-sysc.h>
-
-#include <asm/smp_plat.h>
-
-#include "common.h"
-#include "platsmp-apmu.h"
-#include "rcar-gen2.h"
-#include "r8a7790.h"
-
-static const struct rcar_sysc_ch r8a7790_ca15_scu = {
-	.chan_offs = 0x180, /* PWRSR5 .. PWRER5 */
-	.isr_bit = 12, /* CA15-SCU */
-};
-
-static const struct rcar_sysc_ch r8a7790_ca7_scu = {
-	.chan_offs = 0x100, /* PWRSR3 .. PWRER3 */
-	.isr_bit = 21, /* CA7-SCU */
-};
-
-static struct rcar_apmu_config r8a7790_apmu_config[] = {
-	{
-		.iomem = DEFINE_RES_MEM(0xe6152000, 0x188),
-		.cpus = { 0, 1, 2, 3 },
-	},
-	{
-		.iomem = DEFINE_RES_MEM(0xe6151000, 0x188),
-		.cpus = { 0x100, 0x0101, 0x102, 0x103 },
-	}
-};
-
-static void __init r8a7790_smp_prepare_cpus(unsigned int max_cpus)
-{
-	/* let APMU code install data related to shmobile_boot_vector */
-	shmobile_smp_apmu_prepare_cpus(max_cpus,
-				       r8a7790_apmu_config,
-				       ARRAY_SIZE(r8a7790_apmu_config));
-
-	/* turn on power to SCU */
-	rcar_gen2_pm_init();
-	rcar_sysc_power_up(&r8a7790_ca15_scu);
-	rcar_sysc_power_up(&r8a7790_ca7_scu);
-}
-
-const struct smp_operations r8a7790_smp_ops __initconst = {
-	.smp_prepare_cpus	= r8a7790_smp_prepare_cpus,
-	.smp_boot_secondary	= shmobile_smp_apmu_boot_secondary,
-#ifdef CONFIG_HOTPLUG_CPU
-	.cpu_can_disable	= shmobile_smp_cpu_can_disable,
-	.cpu_die		= shmobile_smp_apmu_cpu_die,
-	.cpu_kill		= shmobile_smp_apmu_cpu_kill,
-#endif
-};
-- 
2.7.4
