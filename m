From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 26 Oct 2012 01:27:00 +0000 (UTC)
Subject: [PATCH 10/16] ARM: OMAP: Make omap_device local to mach-omap2
In-Reply-To: <20121004220456.26676.31050.stgit@muffinssi.local>
References: <20121004213950.26676.21898.stgit@muffinssi.local>
 <20121004220456.26676.31050.stgit@muffinssi.local>
Message-ID: <alpine.DEB.2.00.1210260124360.11251@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony

On Thu, 4 Oct 2012, Tony Lindgren wrote:

> Let's make omap_device local to mach-omap2 for
> ARM common zImage support.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>

This one breaks a 5912-only build:

arch/arm/mach-omap1/pm_bus.c: In function 'omap1_pm_runtime_init':
arch/arm/mach-omap1/pm_bus.c:69:2: error: implicit declaration of function 
'cpu_class_is_omap1'
make[1]: *** [arch/arm/mach-omap1/pm_bus.o] Error 1

Fixed by the usual change; it's below.


- Paul

---
 arch/arm/mach-omap1/pm_bus.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-omap1/pm_bus.c b/arch/arm/mach-omap1/pm_bus.c
index 16bf2f9..3f2d396 100644
--- a/arch/arm/mach-omap1/pm_bus.c
+++ b/arch/arm/mach-omap1/pm_bus.c
@@ -19,6 +19,8 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 
+#include "soc.h"
+
 #ifdef CONFIG_PM_RUNTIME
 static int omap1_pm_runtime_suspend(struct device *dev)
 {
-- 
1.7.10.4
