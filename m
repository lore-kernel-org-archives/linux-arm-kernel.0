From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Fri,  4 Jul 2014 20:43:14 +0800
Subject: [PATCH] ARM: pxa: remove unnecessary pxa3xx io mapping
Message-ID: <1404477794-14927-1-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[    0.000000] BUG: mapping for 0x00000000 at 0xff000000 out of vmalloc
space

UNCACHED PHYS io mapping is redundant of PXA3xx (PXA930). So remove it
from pxa3xx/pxa93x series.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 arch/arm/mach-pxa/generic.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-pxa/generic.c b/arch/arm/mach-pxa/generic.c
index 94f49c2..b52f8f2 100644
--- a/arch/arm/mach-pxa/generic.c
+++ b/arch/arm/mach-pxa/generic.c
@@ -83,7 +83,11 @@ static struct map_desc common_io_desc[] __initdata = {
 		.pfn		= __phys_to_pfn(0x40000000),
 		.length		= 0x02000000,
 		.type		= MT_DEVICE
-	}, {	/* UNCACHED_PHYS_0 */
+	}
+};
+
+static struct map_desc pxa2xx_io_desc[] __initdata = {
+	{	/* UNCACHED_PHYS_0 */
 		.virtual	= 0xff000000,
 		.pfn		= __phys_to_pfn(0x00000000),
 		.length		= 0x00100000,
@@ -95,4 +99,6 @@ void __init pxa_map_io(void)
 {
 	debug_ll_io_init();
 	iotable_init(ARRAY_AND_SIZE(common_io_desc));
+	if (cpu_is_pxa2xx())
+		iotable_init(ARRAY_AND_SIZE(pxa2xx_io_desc));
 }
-- 
1.9.1
