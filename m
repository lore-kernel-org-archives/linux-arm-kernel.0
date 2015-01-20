From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 20 Jan 2015 16:07:25 +0000
Subject: [PATCHv2 1/5] arm: realview: specify PMU types
In-Reply-To: <1421770049-32029-1-git-send-email-mark.rutland@arm.com>
References: <1421770049-32029-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1421770049-32029-2-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we can specify which PMU variant we're likely to deal with, do
so in the realview board code. This will allow us to split the ARMv6,
ARMv7, and XScale PMU drivers.

The Realview EB may be used with ARMv6 or ARMv7 CPUs, but luckily
there's only a single ARMv7 CPU, so we can match that explicitly to
determine whether or not we have an ARMv7 PMU.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>
Cc: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/mach-realview/realview_eb.c     | 3 ++-
 arch/arm/mach-realview/realview_pb1176.c | 2 +-
 arch/arm/mach-realview/realview_pb11mp.c | 2 +-
 arch/arm/mach-realview/realview_pba8.c   | 2 +-
 arch/arm/mach-realview/realview_pbx.c    | 2 +-
 5 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-realview/realview_eb.c b/arch/arm/mach-realview/realview_eb.c
index 739d4f1..64c88d6 100644
--- a/arch/arm/mach-realview/realview_eb.c
+++ b/arch/arm/mach-realview/realview_eb.c
@@ -37,6 +37,7 @@
 #include <asm/pgtable.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/smp_twd.h>
+#include <asm/system_info.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -296,7 +297,6 @@ static struct resource pmu_resources[] = {
 };
 
 static struct platform_device pmu_device = {
-	.name			= "arm-pmu",
 	.id			= -1,
 	.num_resources		= ARRAY_SIZE(pmu_resources),
 	.resource		= pmu_resources,
@@ -451,6 +451,7 @@ static void __init realview_eb_init(void)
 		 */
 		l2x0_init(__io_address(REALVIEW_EB11MP_L220_BASE), 0x00790000, 0xfe000fff);
 #endif
+		pmu_device.name = core_tile_a9mp() ? "armv7-pmu" : "armv6-pmu";
 		platform_device_register(&pmu_device);
 	}
 
diff --git a/arch/arm/mach-realview/realview_pb1176.c b/arch/arm/mach-realview/realview_pb1176.c
index b0e0dca..ce92c18 100644
--- a/arch/arm/mach-realview/realview_pb1176.c
+++ b/arch/arm/mach-realview/realview_pb1176.c
@@ -280,7 +280,7 @@ static struct resource pmu_resource = {
 };
 
 static struct platform_device pmu_device = {
-	.name			= "arm-pmu",
+	.name			= "armv6-pmu",
 	.id			= -1,
 	.num_resources		= 1,
 	.resource		= &pmu_resource,
diff --git a/arch/arm/mach-realview/realview_pb11mp.c b/arch/arm/mach-realview/realview_pb11mp.c
index 47bf55f..15c45e2 100644
--- a/arch/arm/mach-realview/realview_pb11mp.c
+++ b/arch/arm/mach-realview/realview_pb11mp.c
@@ -262,7 +262,7 @@ static struct resource pmu_resources[] = {
 };
 
 static struct platform_device pmu_device = {
-	.name			= "arm-pmu",
+	.name			= "armv6-pmu",
 	.id			= -1,
 	.num_resources		= ARRAY_SIZE(pmu_resources),
 	.resource		= pmu_resources,
diff --git a/arch/arm/mach-realview/realview_pba8.c b/arch/arm/mach-realview/realview_pba8.c
index 4e57a85..4c64662 100644
--- a/arch/arm/mach-realview/realview_pba8.c
+++ b/arch/arm/mach-realview/realview_pba8.c
@@ -240,7 +240,7 @@ static struct resource pmu_resource = {
 };
 
 static struct platform_device pmu_device = {
-	.name			= "arm-pmu",
+	.name			= "armv7-pmu",
 	.id			= -1,
 	.num_resources		= 1,
 	.resource		= &pmu_resource,
diff --git a/arch/arm/mach-realview/realview_pbx.c b/arch/arm/mach-realview/realview_pbx.c
index d89eb40..9a22b86 100644
--- a/arch/arm/mach-realview/realview_pbx.c
+++ b/arch/arm/mach-realview/realview_pbx.c
@@ -280,7 +280,7 @@ static struct resource pmu_resources[] = {
 };
 
 static struct platform_device pmu_device = {
-	.name			= "arm-pmu",
+	.name			= "armv7-pmu",
 	.id			= -1,
 	.num_resources		= ARRAY_SIZE(pmu_resources),
 	.resource		= pmu_resources,
-- 
1.9.1
