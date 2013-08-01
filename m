From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  1 Aug 2013 17:26:31 +0900
Subject: [PATCH 09/14] ARM: shmobile: r8a73a4: Remove ->init_machine() special
 case
In-Reply-To: <cover.1375344714.git.horms+renesas@verge.net.au>
References: <cover.1375344714.git.horms+renesas@verge.net.au>
Message-ID: <67fde41ea4251f722b4466597c479fb42fccac2c.1375344714.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

No need to special case r8a73a4 ->init_machine(),
so get rid of undesired cpufreq platform device
from the generic long term r8a73a4 DT support code.

For short term support on APE6EVM the DT reference
implementation already adds a "cpufreq-cpu0" platform
device so that can be used for development.

Regarding more long term cpufreq support, perhaps
it makes sense to adjust the cpufreq driver to check
for DT information directly instead of using a
platform device for software configuration and DT
for hardware parameters.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a73a4.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a73a4.c b/arch/arm/mach-shmobile/setup-r8a73a4.c
index d533bd2..11c0f63 100644
--- a/arch/arm/mach-shmobile/setup-r8a73a4.c
+++ b/arch/arm/mach-shmobile/setup-r8a73a4.c
@@ -210,11 +210,6 @@ void __init r8a73a4_init_delay(void)
 }
 
 #ifdef CONFIG_USE_OF
-void __init r8a73a4_add_standard_devices_dt(void)
-{
-	platform_device_register_simple("cpufreq-cpu0", -1, NULL, 0);
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-}
 
 static const char *r8a73a4_boards_compat_dt[] __initdata = {
 	"renesas,r8a73a4",
@@ -223,7 +218,6 @@ static const char *r8a73a4_boards_compat_dt[] __initdata = {
 
 DT_MACHINE_START(R8A73A4_DT, "Generic R8A73A4 (Flattened Device Tree)")
 	.init_early	= r8a73a4_init_delay,
-	.init_machine	= r8a73a4_add_standard_devices_dt,
 	.init_time	= shmobile_timer_init,
 	.dt_compat	= r8a73a4_boards_compat_dt,
 MACHINE_END
-- 
1.8.3.2
