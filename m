From: lauri.hintsala@bluegiga.com (Lauri Hintsala)
Date: Mon,  9 Jan 2012 16:54:06 +0200
Subject: [PATCH] MXS: apx4devkit: add platform data for saif
In-Reply-To: <1325864366-17995-1-git-send-email-shawn.guo@linaro.org>
References: <1325864366-17995-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1326120846-32554-1-git-send-email-lauri.hintsala@bluegiga.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lauri Hintsala <lauri.hintsala@bluegiga.com>
cc: shawn.guo at linaro.org
---

Hi Shawn,

My patch was based on mainline tree and saif patches broke it. This
patch fixes compiling issue which was caused by saif patches. If you
think so we can apply also this patch later when apx4devkit is pulled to
mainline (hopefully to 3.3).

Lauri


 arch/arm/mach-mxs/mach-apx4devkit.c |   18 ++++++++++++++++--
 1 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mxs/mach-apx4devkit.c b/arch/arm/mach-mxs/mach-apx4devkit.c
index 08693f1..013aae5 100644
--- a/arch/arm/mach-mxs/mach-apx4devkit.c
+++ b/arch/arm/mach-mxs/mach-apx4devkit.c
@@ -33,6 +33,7 @@
 
 #include <mach/common.h>
 #include <mach/iomux-mx28.h>
+#include <mach/digctl.h>
 
 #include "devices-mx28.h"
 
@@ -192,6 +193,18 @@ static int apx4devkit_phy_fixup(struct phy_device *phy)
 	return 0;
 }
 
+static const struct mxs_saif_platform_data
+                       apx4devkit_mxs_saif_pdata[] __initconst = {
+       /* working on EXTMSTR0 mode (saif0 master, saif1 slave) */
+       {
+               .master_mode = 1,
+               .master_id = 0,
+       }, {
+               .master_mode = 0,
+               .master_id = 0,
+       },
+};
+
 static void __init apx4devkit_init(void)
 {
 	mxs_iomux_setup_multiple_pads(apx4devkit_pads,
@@ -216,8 +229,9 @@ static void __init apx4devkit_init(void)
 
 	gpio_led_register_device(0, &apx4devkit_led_data);
 
-	mx28_add_saif(0);
-	mx28_add_saif(1);
+	mxs_saif_clkmux_select(MXS_DIGCTL_SAIF_CLKMUX_EXTMSTR0);
+	mx28_add_saif(0, &apx4devkit_mxs_saif_pdata[0]);
+	mx28_add_saif(1, &apx4devkit_mxs_saif_pdata[1]);
 
 	apx4devkit_add_regulators();
 
-- 
1.7.4.1
