From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 21:32:37 +0900
Subject: [PATCH 27/43] ARM: shmobile: Use R8A7779_SCU_BASE with TWD
In-Reply-To: <1363609973-31086-1-git-send-email-horms+renesas@verge.net.au>
References: <1363609973-31086-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363609973-31086-28-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Rework the IOMEM() usage for the SCU base address in the
case of r8a7779. Adjusts the TWD to use R8A7779_SCU_BASE.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/smp-r8a7779.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/smp-r8a7779.c b/arch/arm/mach-shmobile/smp-r8a7779.c
index 7fd58a3..e69ce25 100644
--- a/arch/arm/mach-shmobile/smp-r8a7779.c
+++ b/arch/arm/mach-shmobile/smp-r8a7779.c
@@ -31,7 +31,7 @@
 #include <asm/smp_twd.h>
 
 #define AVECR IOMEM(0xfe700040)
-#define R8A7779_SCU_BASE IOMEM(0xf0000000)
+#define R8A7779_SCU_BASE 0xf0000000
 
 static struct r8a7779_pm_ch r8a7779_ch_cpu1 = {
 	.chan_offs = 0x40, /* PWRSR0 .. PWRER0 */
@@ -61,8 +61,7 @@ static DEFINE_SPINLOCK(scu_lock);
 static unsigned long tmp;
 
 #ifdef CONFIG_HAVE_ARM_TWD
-static DEFINE_TWD_LOCAL_TIMER(twd_local_timer, 0xf0000600, 29);
-
+static DEFINE_TWD_LOCAL_TIMER(twd_local_timer, R8A7779_SCU_BASE + 0x600, 29);
 void __init r8a7779_register_twd(void)
 {
 	twd_local_timer_register(&twd_local_timer);
@@ -168,7 +167,7 @@ static void __init r8a7779_smp_prepare_cpus(unsigned int max_cpus)
 static void __init r8a7779_smp_init_cpus(void)
 {
 	/* setup r8a7779 specific SCU base */
-	shmobile_scu_base = R8A7779_SCU_BASE;
+	shmobile_scu_base = IOMEM(R8A7779_SCU_BASE);
 
 	shmobile_smp_init_cpus(scu_get_core_count(shmobile_scu_base));
 }
-- 
1.7.10.4
