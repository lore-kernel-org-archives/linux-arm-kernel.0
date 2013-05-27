From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 27 May 2013 18:00:50 +0900
Subject: [PATCH 6/8] ARM: shmobile: sh73a0: Always use shmobile_setup_delay()
In-Reply-To: <1369645252-3847-1-git-send-email-horms+renesas@verge.net.au>
References: <1369645252-3847-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1369645252-3847-7-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Break out the function sh73a0_init_delay() that now
gets called both for the C version of the code and
the DT -reference boards. This way we handle both
cases in the same way.

Allows us to boot with TWD only in the kernel configuration
for C board code. TWD is not yet enabled in the case of
DT -reference - this due to a dependency on CCF.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-sh73a0.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index 9986515..8bb879f 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -915,11 +915,17 @@ void __init sh73a0_add_standard_devices(void)
 			    ARRAY_SIZE(sh73a0_late_devices));
 }
 
+void __init sh73a0_init_delay(void)
+{
+	shmobile_setup_delay(1196, 44, 46); /* Cortex-A9 @ 1196MHz */
+}
+
 /* do nothing for !CONFIG_SMP or !CONFIG_HAVE_TWD */
 void __init __weak sh73a0_register_twd(void) { }
 
 void __init sh73a0_earlytimer_init(void)
 {
+	sh73a0_init_delay();
 	sh73a0_clock_init();
 	shmobile_earlytimer_init();
 	sh73a0_register_twd();
@@ -938,11 +944,6 @@ void __init sh73a0_add_early_devices(void)
 
 #ifdef CONFIG_USE_OF
 
-void __init sh73a0_init_delay(void)
-{
-	shmobile_setup_delay(1196, 44, 46); /* Cortex-A9 @ 1196MHz */
-}
-
 static const struct of_dev_auxdata sh73a0_auxdata_lookup[] __initconst = {
 	{},
 };
-- 
1.7.10.4
