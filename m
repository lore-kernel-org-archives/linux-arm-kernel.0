From: lkundrak@v3.sk (Lubomir Rintel)
Date: Mon, 12 Nov 2018 04:20:21 +0100
Subject: [PATCH v3 12/18] ARM: mmp/mmp2: use cpu_is_pj4() instead of
 cpu_is_mmp2()
In-Reply-To: <20181112032027.653931-1-lkundrak@v3.sk>
References: <20181112032027.653931-1-lkundrak@v3.sk>
Message-ID: <20181112032027.653931-13-lkundrak@v3.sk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MMP2 platform uses the PJ4 CPU. The cpu_is_mmp2() macro is thus
actually not useful at all and moreover gives the wrong result on
MACH_MMP2_DT.

The actual problem I aim to fix is that on a device-tree enabled system,
the timer ends up being initialized incorrectly. In fact, it ticks like
at rate that's 1/100 slower or so.

Perhaps the other cpu_is_mmp2() uses are more benign, but still useless.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 arch/arm/mach-mmp/cputype.h | 9 ---------
 arch/arm/mach-mmp/mmp2.c    | 2 +-
 arch/arm/mach-mmp/pm-mmp2.c | 2 +-
 arch/arm/mach-mmp/time.c    | 2 +-
 4 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-mmp/cputype.h b/arch/arm/mach-mmp/cputype.h
index 446edaeb78a7..405dbbbbbcdd 100644
--- a/arch/arm/mach-mmp/cputype.h
+++ b/arch/arm/mach-mmp/cputype.h
@@ -44,13 +44,4 @@ static inline int cpu_is_pxa910(void)
 #define cpu_is_pxa910()	(0)
 #endif
 
-#ifdef CONFIG_CPU_MMP2
-static inline int cpu_is_mmp2(void)
-{
-	return (((read_cpuid_id() >> 8) & 0xff) == 0x58);
-}
-#else
-#define cpu_is_mmp2()	(0)
-#endif
-
 #endif /* __ASM_MACH_CPUTYPE_H */
diff --git a/arch/arm/mach-mmp/mmp2.c b/arch/arm/mach-mmp/mmp2.c
index afba5460cdaf..b670fafedeac 100644
--- a/arch/arm/mach-mmp/mmp2.c
+++ b/arch/arm/mach-mmp/mmp2.c
@@ -104,7 +104,7 @@ void __init mmp2_init_irq(void)
 
 static int __init mmp2_init(void)
 {
-	if (cpu_is_mmp2()) {
+	if (cpu_is_pj4()) {
 #ifdef CONFIG_CACHE_TAUROS2
 		tauros2_init(0);
 #endif
diff --git a/arch/arm/mach-mmp/pm-mmp2.c b/arch/arm/mach-mmp/pm-mmp2.c
index 17699be3bc3d..bcd5111ffb37 100644
--- a/arch/arm/mach-mmp/pm-mmp2.c
+++ b/arch/arm/mach-mmp/pm-mmp2.c
@@ -220,7 +220,7 @@ static int __init mmp2_pm_init(void)
 {
 	uint32_t apcr;
 
-	if (!cpu_is_mmp2())
+	if (!cpu_is_pj4())
 		return -EIO;
 
 	suspend_set_ops(&mmp2_pm_ops);
diff --git a/arch/arm/mach-mmp/time.c b/arch/arm/mach-mmp/time.c
index 96ad1db0b04b..0f49ac579a17 100644
--- a/arch/arm/mach-mmp/time.c
+++ b/arch/arm/mach-mmp/time.c
@@ -163,7 +163,7 @@ static void __init timer_config(void)
 
 	__raw_writel(0x0, mmp_timer_base + TMR_CER); /* disable */
 
-	ccr &= (cpu_is_mmp2()) ? (TMR_CCR_CS_0(0) | TMR_CCR_CS_1(0)) :
+	ccr &= (cpu_is_pj4()) ? (TMR_CCR_CS_0(0) | TMR_CCR_CS_1(0)) :
 		(TMR_CCR_CS_0(3) | TMR_CCR_CS_1(3));
 	__raw_writel(ccr, mmp_timer_base + TMR_CCR);
 
-- 
2.19.1
