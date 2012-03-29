From: tony@atomide.com (Tony Lindgren)
Date: Thu, 29 Mar 2012 09:33:10 -0700
Subject: [PATCH] omap2+: pm: fix compilation break.
In-Reply-To: <20120329151128.GT9859@atomide.com>
References: <1333015762-476-1-git-send-email-govindraj.raja@ti.com>
 <20120329151128.GT9859@atomide.com>
Message-ID: <20120329163309.GW9859@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [120329 08:14]:
> * Govindraj.R <govindraj.raja@ti.com> [120329 03:12]:
> > From: "Govindraj.R" <govindraj.raja@ti.com>
> > 
> > Fix the compilation break observed on latest mainline.
> > 
> > Fixes below compilation break:
> > 
> > arch/arm/mach-omap2/pm.c: In function 'omap_pm_begin':
> > arch/arm/mach-omap2/pm.c:239: error: implicit declaration of function 'disable_hlt'
> > arch/arm/mach-omap2/pm.c: In function 'omap_pm_end':
> > arch/arm/mach-omap2/pm.c:247: error: implicit declaration of function 'enable_hlt'
> 
> Care to mention which commit broke the compile?

Seems like it was 9f97da78 (Disintegrate asm/system.h for ARM),
and also needs to be fixed for omap1 too. Using the updated
patch below.

Tony


From: Govindraj.R <govindraj.raja@ti.com>
Date: Thu, 29 Mar 2012 09:30:28 -0700
Subject: [PATCH] ARM: OMAP: pm: fix compilation break
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix the compilation break observed on latest mainline caused
by 9f97da78 (Disintegrate asm/system.h for ARM):

arch/arm/mach-omap1/pm.c: In function ?omap_pm_prepare?:
arch/arm/mach-omap1/pm.c:587: error: implicit declaration of function ?disable_hlt?
arch/arm/mach-omap1/pm.c: In function ?omap_pm_finish?:
arch/arm/mach-omap1/pm.c:624: error: implicit declaration of function ?enable_hlt?
arch/arm/mach-omap1/pm.c: In function ?omap_pm_init?:
arch/arm/mach-omap1/pm.c:681: error: ?arm_pm_idle? undeclared (first use in this function)
...

arch/arm/mach-omap2/pm.c: In function 'omap_pm_begin':
arch/arm/mach-omap2/pm.c:239: error: implicit declaration of function 'disable_hlt'
arch/arm/mach-omap2/pm.c: In function 'omap_pm_end':
arch/arm/mach-omap2/pm.c:247: error: implicit declaration of function 'enable_hlt'

Cc: Kevin Hilman <khilman@ti.com>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
[tony at atomide.com: updated to fix omap1 too]
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap1/pm.c b/arch/arm/mach-omap1/pm.c
index 306beac..f66c329 100644
--- a/arch/arm/mach-omap1/pm.c
+++ b/arch/arm/mach-omap1/pm.c
@@ -44,6 +44,7 @@
 #include <linux/io.h>
 #include <linux/atomic.h>
 
+#include <asm/system_misc.h>
 #include <asm/irq.h>
 #include <asm/mach/time.h>
 #include <asm/mach/irq.h>
diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index a7bdec6..d0c1c96 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -17,6 +17,8 @@
 #include <linux/export.h>
 #include <linux/suspend.h>
 
+#include <asm/system_misc.h>
+
 #include <plat/omap-pm.h>
 #include <plat/omap_device.h>
 #include "common.h"
