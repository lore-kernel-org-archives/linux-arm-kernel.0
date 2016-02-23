From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 23 Feb 2016 14:35:58 +0100
Subject: [PATCH] ARM: realview: hide unused 'pmu_device' object
Message-ID: <1456234567-3705502-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pmu_device is only accessed when CACHE_L2X0 is enabled,
and we get a warning otherwise:

mach-realview/realview_pbx.c:274:31: error: 'pmu_device' defined but not used [-Werror=unused-variable]

This adds another #ifdef for it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Linus, I'm not sure how long you plan to keep the board file around,
so just ignore the patch if this is getting deleted anyway, otherwise
it would be nice if you could add the patch to your series.

 arch/arm/mach-realview/realview_pbx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-realview/realview_pbx.c b/arch/arm/mach-realview/realview_pbx.c
index b9f0757787ac..be1cec5fe3ad 100644
--- a/arch/arm/mach-realview/realview_pbx.c
+++ b/arch/arm/mach-realview/realview_pbx.c
@@ -248,6 +248,7 @@ static struct resource realview_pbx_isp1761_resources[] = {
 	},
 };
 
+#ifdef CONFIG_CACHE_L2X0
 static struct resource pmu_resources[] = {
 	[0] = {
 		.start		= IRQ_PBX_PMU_CPU0,
@@ -277,6 +278,7 @@ static struct platform_device pmu_device = {
 	.num_resources		= ARRAY_SIZE(pmu_resources),
 	.resource		= pmu_resources,
 };
+#endif
 
 static void __init gic_init_irq(void)
 {
-- 
2.7.0
