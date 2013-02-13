From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 13 Feb 2013 14:25:24 +0530
Subject: [PATCH v2] ARM: OMAP4: PM: Avoid expensive cpu_suspend() path for all
 CPU power states except off
Message-ID: <1360745724-30058-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current CPU PM code code make use of common cpu_suspend() path for all the
CPU power states which is not optimal. In fact cpu_suspend() path is needed
only when we put CPU power domain to off state where the CPU context is lost.

Update the code accordingly so that the expensive cpu_suspend() path
can be avoided for the shallow CPU power states like CPU PD INA/CSWR.

The patch has been tested on OMAP4430 and OMAP5430(with few out of tree patches)
devices for suspend and CPUidle.

Cc: Kevin Hilman <khilman@deeprootsystems.com>

Reported-by: Richard Woodruff <r-woodruff2@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
Update changelog to include testing details as suggested
by Kevin Hilman.

 arch/arm/mach-omap2/omap-mpuss-lowpower.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
index aac46bf..abdd0f6 100644
--- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
@@ -276,7 +276,10 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
 	/*
 	 * Call low level function  with targeted low power state.
 	 */
-	cpu_suspend(save_state, omap4_finish_suspend);
+	if (save_state)
+		cpu_suspend(save_state, omap4_finish_suspend);
+	else
+		omap4_finish_suspend(save_state);
 
 	/*
 	 * Restore the CPUx power state to ON otherwise CPUx
-- 
1.7.9.5
