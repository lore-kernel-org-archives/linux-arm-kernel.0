From: omar.ramirez@ti.com (Omar Ramirez Luna)
Date: Tue, 26 Oct 2010 11:16:02 -0500
Subject: [PATCH v3 3/4] OMAP: dsp: convert OMAP3430 adaptation layer to use
	new SCM DSP boot control fns
In-Reply-To: <1288109763-9446-1-git-send-email-omar.ramirez@ti.com>
References: <1288109763-9446-1-git-send-email-omar.ramirez@ti.com>
Message-ID: <1288109763-9446-4-git-send-email-omar.ramirez@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Paul Walmsley <paul@pwsan.com>

DSPBridge currently tries to __raw_writel() to the System Control
Module to control the DSP boot process.  This is a layering violation;
this is SoC-specific code, and belongs in a file in
arch/arm/mach-omap2/*.  None of those CM and PRM register accesses
through struct platform_data belong under drivers/.  (Nor would they
belong in DSP platform init code in arch/arm/mach-omap2/* - such code
must use the clock, clockdomain, powerdomain, omap_device, and
omap_hwmod layers that are provided for this purpose.)

The immediate problem, however, is that after commit
346a5c890a55495c718394b74214be1de9303cf6, this code can no longer compile.
So to fix this immediate problem, convert the DSP boot control code to
use platform_data function pointers.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: <fernando.lugo@ti.com>
---
 arch/arm/mach-omap2/dsp.c             |    4 ++++
 arch/arm/plat-omap/include/plat/dsp.h |    4 ++++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/dsp.c b/arch/arm/mach-omap2/dsp.c
index 6feeeae..307f67a 100644
--- a/arch/arm/mach-omap2/dsp.c
+++ b/arch/arm/mach-omap2/dsp.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/platform_device.h>
+#include "control.h"
 #include "prm.h"
 #include "cm.h"
 #ifdef CONFIG_BRIDGE_DVFS
@@ -31,6 +32,9 @@ static struct omap_dsp_platform_data omap_dsp_pdata __initdata = {
 	.cpu_set_freq = omap_pm_cpu_set_freq,
 	.cpu_get_freq = omap_pm_cpu_get_freq,
 #endif
+	.set_dsp_bootaddr = omap2430_ctrl_set_dsp_bootaddr,
+	.set_dsp_bootmode = omap2430_ctrl_set_dsp_bootmode,
+
 	.dsp_prm_read = prm_read_mod_reg,
 	.dsp_prm_write = prm_write_mod_reg,
 	.dsp_prm_rmw_bits = prm_rmw_mod_reg_bits,
diff --git a/arch/arm/plat-omap/include/plat/dsp.h b/arch/arm/plat-omap/include/plat/dsp.h
index 9c604b3..34e2bd8 100644
--- a/arch/arm/plat-omap/include/plat/dsp.h
+++ b/arch/arm/plat-omap/include/plat/dsp.h
@@ -10,7 +10,11 @@ struct omap_dsp_platform_data {
 	unsigned long (*cpu_get_freq) (void);
 	unsigned long mpu_speed[6];
 
+	void (*set_dsp_bootaddr)(u32 pa);
+	void (*set_dsp_bootmode)(u8 mode);
+
 	/* functions to write and read PRCM registers */
+	/* XXX None of this should be here */
 	void (*dsp_prm_write)(u32, s16 , u16);
 	u32 (*dsp_prm_read)(s16 , u16);
 	u32 (*dsp_prm_rmw_bits)(u32, u32, s16, s16);
-- 
1.7.1
