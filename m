From: shinya.kuribayashi.px@renesas.com (Shinya Kuribayashi)
Date: Thu, 11 Jul 2013 18:51:39 +0900
Subject: [PATCH 1/4] ARM: shmobile: smp-r8a7790: remove the obsolete RESCNT
 register
In-Reply-To: <51DE7FF4.5050800@renesas.com>
References: <20130710104151.20742.56398.sendpatchset@w520>
 <51DE7FF4.5050800@renesas.com>
Message-ID: <51DE802B.6090401@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I should have notice this one, sorry for bothering you in v4 again.

The RESCNT register, which is supposed to be used to control clock supply
to CA15/CA7 clusters by manipulating dedicated MSTP bits, turned out that
it doesn't do anything good for clock supply to clusters.  It was listed
in the datasheet v0.5, but it's now obsolete in the datasheet v0.6.

This patch removes the defines and routines related to RESCNT.

Note that, this patch removes r8a7790_deassert_reset(0) call in
r8a7790_smp_prepare_cpus at the time.  As we already know, it's pointless
to deassert reset to CPU#0 (boot CPU) in the kernel initialization.  It
was just there to set r8a7790_clst[0].use_count to 1 on start-up to keep
.use_count balanced.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
---
 arch/arm/mach-shmobile/smp-r8a7790.c | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/arch/arm/mach-shmobile/smp-r8a7790.c b/arch/arm/mach-shmobile/smp-r8a7790.c
index a1696f4..1ab4c04 100644
--- a/arch/arm/mach-shmobile/smp-r8a7790.c
+++ b/arch/arm/mach-shmobile/smp-r8a7790.c
@@ -25,7 +25,6 @@
 #define CA7BAR	0x0030
 #define CA15RESCNT 0x0040
 #define CA7RESCNT 0x0044
-#define RESCNT	0x0050
 
 #define APMU	0xe6150000
 #define CA15WUPCR 0x2010
@@ -39,20 +38,16 @@ static struct {
 	unsigned int cabar;
 	unsigned int carescnt;
 	unsigned int carescnt_magic;
-	unsigned int rescnt_bit;
-	unsigned int use_count;
 } r8a7790_clst[R8A7790_CLST_NR] = {
 	[R8A7790_CLST_CA15] = {
 		.cabar = CA15BAR,
 		.carescnt = CA15RESCNT,
 		.carescnt_magic = 0xa5a50000,
-		.rescnt_bit = 1,
 	},
 	[R8A7790_CLST_CA7] = {
 		.cabar = CA7BAR,
 		.carescnt = CA7RESCNT,
 		.carescnt_magic = 0x5a5a0000,
-		.rescnt_bit = 0,
 	},
 };
 
@@ -71,12 +66,6 @@ static void r8a7790_deassert_reset(unsigned int cpu)
 	writel_relaxed(bar, p + r8a7790_clst[clst_id].cabar);
 	writel_relaxed(bar | 0x10, p + r8a7790_clst[clst_id].cabar);
 
-	/* enable clocks for cluster */
-	if (r8a7790_clst[clst_id].use_count++ == 0) {
-		mask = 1 << r8a7790_clst[clst_id].rescnt_bit;
-		writel_relaxed(readl_relaxed(p + RESCNT) & ~mask, p + RESCNT);
-	}
-
 	/* enable per-core clocks */
 	mask = BIT(3 - r8a7790_cpu_id(cpu));
 	magic = r8a7790_clst[clst_id].carescnt_magic;
@@ -100,15 +89,6 @@ static void r8a7790_assert_reset(unsigned int cpu)
 	carescnt = p + r8a7790_clst[clst_id].carescnt;
 	writel_relaxed((readl_relaxed(carescnt) | mask) | magic, carescnt);
 
-	/* disable clocks for cluster */
-	if (r8a7790_clst[clst_id].use_count == 1) {
-		mask = 1 << r8a7790_clst[clst_id].rescnt_bit;
-		writel_relaxed(readl_relaxed(p + RESCNT) | mask, p + RESCNT);
-	}
-
-	if (r8a7790_clst[clst_id].use_count > 0)
-		r8a7790_clst[clst_id].use_count--;
-
 	iounmap(p);
 }
 
@@ -145,8 +125,6 @@ static void __init r8a7790_smp_prepare_cpus(unsigned int max_cpus)
 		r8a7790_assert_reset(k);
 		r8a7790_power_on(k);
 	}
-
-	r8a7790_deassert_reset(0);
 }
 
 static int __cpuinit r8a7790_boot_secondary(unsigned int cpu,
-- 
1.8.3.2
