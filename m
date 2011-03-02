From: nm@ti.com (Nishanth Menon)
Date: Wed,  2 Mar 2011 16:25:31 +0530
Subject: [PATCH v2 18/18] omap3430: sr: class3: restrict cpu to run on
In-Reply-To: <1299063331-27968-1-git-send-email-nm@ti.com>
References: <1299063331-27968-1-git-send-email-nm@ti.com>
Message-ID: <1299063331-27968-19-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use SmartReflex AVS Class3 initialization only for OMAP343x family of
processors.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/smartreflex-class3.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex-class3.c b/arch/arm/mach-omap2/smartreflex-class3.c
index 5f7a33e..f99e517 100644
--- a/arch/arm/mach-omap2/smartreflex-class3.c
+++ b/arch/arm/mach-omap2/smartreflex-class3.c
@@ -11,6 +11,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <plat/cpu.h>
 #include <plat/smartreflex.h>
 
 static int sr_class3_enable(struct voltagedomain *voltdm,
@@ -49,6 +50,10 @@ static struct omap_sr_class_data class3_data = {
 /* Smartreflex Class3 init API to be called from board file */
 static int __init sr_class3_init(void)
 {
+	/* Enable this class only for OMAP343x */
+	if (!cpu_is_omap343x())
+		return -EINVAL;
+
 	pr_info("SmartReflex Class3 initialized\n");
 	return sr_register_class(&class3_data);
 }
-- 
1.7.1
