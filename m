From: arnd@arndb.de (Arnd Bergmann)
Date: Mon,  9 Jul 2018 17:51:17 +0200
Subject: [PATCH] ARM: imx: call imx6sx_cpuidle_init() conditionally for 6sll
Message-ID: <20180709155130.2126597-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The imx6sl platform has two different cpuidle implementations,
and fails to link if we only want one of the two:

arch/arm/mach-imx/mach-imx6sl.o: In function `imx6sl_init_late':
mach-imx6sl.c:(.init.text+0x12): undefined reference to `imx6sx_cpuidle_init'

This makes the call into reference conditional on the configuration.

Fixes: e7fa1fb39b11 ("ARM: imx: add cpu idle support for i.MX6SLL")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I had already sent a related patch earlier, but missed this second
problem then.
---
 arch/arm/mach-imx/mach-imx6sl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/mach-imx6sl.c b/arch/arm/mach-imx/mach-imx6sl.c
index 183540e0838b..99be4225297a 100644
--- a/arch/arm/mach-imx/mach-imx6sl.c
+++ b/arch/arm/mach-imx/mach-imx6sl.c
@@ -42,9 +42,9 @@ static void __init imx6sl_init_late(void)
 	if (IS_ENABLED(CONFIG_ARM_IMX6Q_CPUFREQ))
 		platform_device_register_simple("imx6q-cpufreq", -1, NULL, 0);
 
-	if (cpu_is_imx6sl())
+	if (IS_ENABLED(CONFIG_SOC_IMX6SL) && cpu_is_imx6sl())
 		imx6sl_cpuidle_init();
-	else
+	else if (IS_ENABLED(CONFIG_SOC_IMX6SLL))
 		imx6sx_cpuidle_init();
 }
 
-- 
2.9.0
