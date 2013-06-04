From: lee.jones@linaro.org (Lee Jones)
Date: Tue,  4 Jun 2013 16:36:48 +0100
Subject: [PATCH 2/2] ARM: ux500: Silence compiler warnings due to missing
 __cpuinitdata
In-Reply-To: <1370360208-6500-1-git-send-email-lee.jones@linaro.org>
References: <1370360208-6500-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1370360208-6500-2-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

WARNING: vmlinux.o(.text.unlikely+0x25c): Section mismatch in reference \
  from the function write_pen_release() to the variable                 \
  .cpuinit.data:pen_release
The function write_pen_release() references
the variable __cpuinitdata pen_release.
This is often because write_pen_release lacks a __cpuinitdata

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/platsmp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-ux500/platsmp.c b/arch/arm/mach-ux500/platsmp.c
index 14d9046..3a455d5 100644
--- a/arch/arm/mach-ux500/platsmp.c
+++ b/arch/arm/mach-ux500/platsmp.c
@@ -34,7 +34,7 @@ extern void u8500_secondary_startup(void);
  * observers, irrespective of whether they're taking part in coherency
  * or not.  This is necessary for the hotplug code to work reliably.
  */
-static void write_pen_release(int val)
+static void __cpuinitdata write_pen_release(int val)
 {
 	pen_release = val;
 	smp_wmb();
-- 
1.7.10.4
