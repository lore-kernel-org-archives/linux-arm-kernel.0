From: tony@atomide.com (Tony Lindgren)
Date: Mon, 7 Nov 2011 12:26:20 -0800
Subject: OMAP CRAP: The Continuing Story Of Brokenness
In-Reply-To: <20111107174645.GE15294@n2100.arm.linux.org.uk>
References: <20111106121829.GB15294@n2100.arm.linux.org.uk>
 <20111107172600.GS31337@atomide.com>
 <20111107174645.GE15294@n2100.arm.linux.org.uk>
Message-ID: <20111107202620.GW31337@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tomi,

* Russell King - ARM Linux <linux@arm.linux.org.uk> [111107 09:12]:

> drivers/video/omap/dispc.c:276: warning: data definition has no type or storage class
> drivers/video/omap/dispc.c:276: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL'
> drivers/video/omap/dispc.c:276: warning: parameter names (without types) in function declaration
> drivers/video/omap/dispc.c:286: warning: data definition has no type or storage class
> drivers/video/omap/dispc.c:286: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL'
> drivers/video/omap/dispc.c:286: warning: parameter names (without types) in function declaration
> drivers/video/omap/dispc.c:320: warning: data definition has no type or storage class
> drivers/video/omap/dispc.c:320: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL'
> drivers/video/omap/dispc.c:320: warning: parameter names (without types) in function declaration
> drivers/video/omap/dispc.c:328: warning: data definition has no type or storage class
> drivers/video/omap/dispc.c:328: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL'
> drivers/video/omap/dispc.c:328: warning: parameter names (without types) in function declaration
> drivers/video/omap/dispc.c:863: warning: data definition has no type or storage class
> drivers/video/omap/dispc.c:863: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL'
> drivers/video/omap/dispc.c:863: warning: parameter names (without types) in function declaration
> drivers/video/omap/dispc.c:883: warning: data definition has no type or storage class
> drivers/video/omap/dispc.c:883: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL'
> drivers/video/omap/dispc.c:883: warning: parameter names (without types) in function declaration

Care to queue something for drivers/video/omap warnings above?
 
> It might be an idea to do this:
> 
> grep -rl EXPORT_SYMBOL arch/arm/*omap* | xargs grep -L linux/export.h
> 
> and for any OMAP drivers as well.  This gives:
> 
> arch/arm/mach-omap1/id.c
> arch/arm/mach-omap1/lcd_dma.c
> arch/arm/mach-omap1/io.c
> arch/arm/mach-omap1/ams-delta-fiq.c
> arch/arm/mach-omap2/gpmc.c
> arch/arm/mach-omap2/id.c
> arch/arm/mach-omap2/io.c
> arch/arm/plat-omap/ocpi.c
> arch/arm/plat-omap/mcbsp.c
> arch/arm/plat-omap/omap_device.c
> arch/arm/plat-omap/mux.c
> arch/arm/plat-omap/devices.c
> arch/arm/plat-omap/io.c
> arch/arm/plat-omap/dma.c
> arch/arm/plat-omap/dmtimer.c
> arch/arm/plat-omap/mailbox.c
> 
> which probably should all be fixed before any more of these errors
> spring up.

I'll add the following patch to fix the remaining arch/arm/*omap*/
warnings in fixes branch.

Tony


From: Tony Lindgren <tony@atomide.com>
Date: Mon, 7 Nov 2011 11:58:55 -0800
Subject: [PATCH] ARM: OMAP: Fix export.h or module.h includes

Commit 32aaeffbd4a7457bf2f7448b33b5946ff2a960eb (Merge branch
'modsplit-Oct31_2011'...) caused some build errors. Fix these
and make sure we always have export.h or module.h included
for MODULE_ and EXPORT_SYMBOL users:

$ grep -rl ^MODULE_ arch/arm/*omap*/*.c | xargs \
  grep -L linux/module.h
arch/arm/mach-omap2/dsp.c
arch/arm/mach-omap2/mailbox.c
arch/arm/mach-omap2/omap-iommu.c
arch/arm/mach-omap2/smartreflex.c

Also check we either have export.h or module.h included
for the files exporting symbols:

$ grep -rl EXPORT_SYMBOL arch/arm/*omap*/*.c | xargs \
  grep -L linux/export.h | xargs grep -L linux/module.h

Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/dsp.c
+++ b/arch/arm/mach-omap2/dsp.c
@@ -18,6 +18,7 @@
  * of the OMAP PM core code.
  */
 
+#include <linux/module.h>
 #include <linux/platform_device.h>
 #include "cm2xxx_3xxx.h"
 #include "prm2xxx_3xxx.h"
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -10,6 +10,7 @@
  * for more details.
  */
 
+#include <linux/module.h>
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/platform_device.h>
--- a/arch/arm/mach-omap2/omap-iommu.c
+++ b/arch/arm/mach-omap2/omap-iommu.c
@@ -10,6 +10,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/module.h>
 #include <linux/platform_device.h>
 
 #include <plat/iommu.h>
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -17,6 +17,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/clk.h>
 #include <linux/io.h>
