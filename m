From: tony@atomide.com (Tony Lindgren)
Date: Tue, 6 Dec 2011 08:52:15 -0800
Subject: [GIT PULL] ARM perf updates for 3.3
In-Reply-To: <20111206000232.GC31337@atomide.com>
References: <20111202170231.GP5540@mudshark.cambridge.arm.com>
 <20111203092659.GL9581@n2100.arm.linux.org.uk>
 <20111205211136.GF14542@n2100.arm.linux.org.uk>
 <20111205231909.GA31337@atomide.com>
 <20111206000232.GC31337@atomide.com>
Message-ID: <20111206165215.GE31337@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [111205 15:34]:
> * Tony Lindgren <tony@atomide.com> [111205 14:51]:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [111205 12:40]:
> > > Tony,
> > > 
> > > Can you please treat this with the utmost urgency.  If I don't get a
> > > reply from you within the next two hours, then I'm committing this
> > > merge resolution whether or not it's correct for you - as I have other
> > > stuff which needs to be committed to my tree and I can't wait any
> > > longer for your reply.
> > 
> > Sorry only now saw this. Looking at it now.
> 
> Here's what I would do:
> 
> 1. Apply Santosh' omap2plus_defconfig patches first into devel-stable at
>    commit 53fadbdd83039bb1181e4ff76123d612cdf26c37 (Merge branch
>    'irqchip-consolidation' ...). The patches in question are 7188/1 and
>    patch 7189/1.
> 
> 2. Pull Will's for-rmk branch on top of that
> 
> 3. Run git mergetool which produces the resolution you posted earlier
> 
> 4. Before committing apply the following build fix and run git update-index
>    arch/arm/mach-omap2/display.c. This came from the DSS fixes in -rc4.
> 
> Then it all builds and boots fine. 

Added the following fix into patch system as 7194/1. Russell, can you
please apply that one into your devel-stable so we have a common
base for folks to base other omap patches on?

Regards,

Tony


From: Tony Lindgren <tony@atomide.com>
Date: Tue, 6 Dec 2011 08:46:25 -0800
Subject: [PATCH] ARM: OMAP: Fix build after a merge between v3.2-rc4 and ARM restart changes

ARM restart changes needed changes to common.h to make it local.
This conflicted with v3.2-rc4 DSS related hwmod changes that
git mergetool was not able to handle.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -22,12 +22,13 @@
 #include <linux/io.h>
 #include <linux/clk.h>
 #include <linux/err.h>
+#include <linux/delay.h>
 
 #include <video/omapdss.h>
 #include <plat/omap_hwmod.h>
 #include <plat/omap_device.h>
 #include <plat/omap-pm.h>
-#include <plat/common.h>
+#include "common.h"
 
 #include "control.h"
 #include "display.h"
