From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Thu,  8 Nov 2012 11:08:50 -0800
Subject: [PATCH] ARM: OMAP4: TWL: mux sys_drm_msecure as output for PMIC
Message-ID: <1352401730-4269-1-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Hilman <khilman@ti.com>

On OMAP4 boards using the TWL6030 PMIC, the sys_drm_msecure is
connected to the MSECURE input of the TWL6030 PMIC.  This signal
controls the secure-mode operation of the PMIC.  If its not mux'd
correctly, some functionality of the PMIC will not be accessible since
the PMIC will be in secure mode.

For example, if the TWL RTC is in secure mode, most of its registers
are read-only, meaning (re)programming the RTC (e.g. for wakeup from
suspend) will fail.

To fix, ensure the signal is properly mux'd as output when TWL is
intialized.

This fix is required when using recent versions of u-boot (>= v2012.04.01)
since u-boot is no longer setting the default mux for this pin.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
Based on v3.7-rc4.  Targetted as a fix for v3.7.

A correponding DT fix for this is needed as well, but that will be part of 
a bigger series to get PM working with DT boot and needs to include other
pins like sys_nirq1.

 arch/arm/mach-omap2/twl-common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/twl-common.c
index 635e109..96cae8b 100644
--- a/arch/arm/mach-omap2/twl-common.c
+++ b/arch/arm/mach-omap2/twl-common.c
@@ -73,6 +73,7 @@ void __init omap4_pmic_init(const char *pmic_type,
 {
 	/* PMIC part*/
 	omap_mux_init_signal("sys_nirq1", OMAP_PIN_INPUT_PULLUP | OMAP_PIN_OFF_WAKEUPENABLE);
+	omap_mux_init_signal("fref_clk0_out.sys_drm_msecure", OMAP_PIN_OUTPUT);
 	omap_pmic_init(1, 400, pmic_type, 7 + OMAP44XX_IRQ_GIC_START, pmic_data);
 
 	/* Register additional devices on i2c1 bus if needed */
-- 
1.8.0
