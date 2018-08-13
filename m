From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 13 Aug 2018 17:13:10 +0200
Subject: [PATCH] ARM: s3c24xx: Remove empty gta02_pmu children probe
Message-ID: <20180813151310.21960-1-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit 67e67df8da72 ("gta02: Use pcf50633 backlight driver instead
of platform backlight driver.") the list of gta02 pmu children is empty
therefore looping through it and adding devices is a no-op.

This also fixes the GCC v8.1 W=1 warning:

    arch/arm/mach-s3c24xx/mach-gta02.c: In function 'gta02_pmu_attach_child_devices':
    arch/arm/mach-s3c24xx/mach-gta02.c:538:16: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
      for (n = 0; n < ARRAY_SIZE(gta02_devices_pmu_children); n++)
                    ^

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/mach-s3c24xx/mach-gta02.c | 42 --------------------------------------
 1 file changed, 42 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/mach-gta02.c b/arch/arm/mach-s3c24xx/mach-gta02.c
index 9d5595c4ad99..594901f3b8e5 100644
--- a/arch/arm/mach-s3c24xx/mach-gta02.c
+++ b/arch/arm/mach-s3c24xx/mach-gta02.c
@@ -219,17 +219,6 @@ static void gta02_udc_vbus_draw(unsigned int ma)
 #define gta02_udc_vbus_draw		NULL
 #endif
 
-/*
- * This is called when pc50633 is probed, unfortunately quite late in the
- * day since it is an I2C bus device. Here we can belatedly define some
- * platform devices with the advantage that we can mark the pcf50633 as the
- * parent. This makes them get suspended and resumed with their parent
- * the pcf50633 still around.
- */
-
-static void gta02_pmu_attach_child_devices(struct pcf50633 *pcf);
-
-
 static char *gta02_batteries[] = {
 	"battery",
 };
@@ -355,7 +344,6 @@ static struct pcf50633_platform_data gta02_pcf_pdata = {
 		},
 
 	},
-	.probe_done = gta02_pmu_attach_child_devices,
 	.mbc_event_callback = gta02_pmu_event_callback,
 };
 
@@ -512,36 +500,6 @@ static struct platform_device *gta02_devices[] __initdata = {
 	&s3c_device_ts,
 };
 
-/* These guys DO need to be children of PMU. */
-
-static struct platform_device *gta02_devices_pmu_children[] = {
-};
-
-
-/*
- * This is called when pc50633 is probed, quite late in the day since it is an
- * I2C bus device.  Here we can define platform devices with the advantage that
- * we can mark the pcf50633 as the parent.  This makes them get suspended and
- * resumed with their parent the pcf50633 still around.  All devices whose
- * operation depends on something from pcf50633 must have this relationship
- * made explicit like this, or suspend and resume will become an unreliable
- * hellworld.
- */
-
-static void gta02_pmu_attach_child_devices(struct pcf50633 *pcf)
-{
-	int n;
-
-	/* Grab a copy of the now probed PMU pointer. */
-	gta02_pcf = pcf;
-
-	for (n = 0; n < ARRAY_SIZE(gta02_devices_pmu_children); n++)
-		gta02_devices_pmu_children[n]->dev.parent = pcf->dev;
-
-	platform_add_devices(gta02_devices_pmu_children,
-			     ARRAY_SIZE(gta02_devices_pmu_children));
-}
-
 static void gta02_poweroff(void)
 {
 	pcf50633_reg_set_bit_mask(gta02_pcf, PCF50633_REG_OOCSHDWN, 1, 1);
-- 
2.14.1
