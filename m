From: afzal@ti.com (Afzal Mohammed)
Date: Mon, 11 Jun 2012 20:29:58 +0530
Subject: [PATCH 8/9] ARM: OMAP2+: board omap3evm: use gpmc driver
In-Reply-To: <cover.1339419379.git.afzal@ti.com>
References: <cover.1339419379.git.afzal@ti.com>
Message-ID: <52d9d9fdb8e104ff099c4f7dcce1bf4c017fd4fa.1339419379.git.afzal@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gpmc code has been converted to driver. Modify the board
code to provide gpmc driver with required information

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/board-omap3evm.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 639bd07..aa9429d 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -43,6 +43,7 @@
 
 #include <plat/board.h>
 #include <plat/usb.h>
+#include <plat/gpmc.h>
 #include "common.h"
 #include <plat/mcspi.h>
 #include <video/omapdss.h>
@@ -102,6 +103,12 @@ static void __init omap3_evm_get_revision(void)
 	}
 }
 
+static struct gpmc_device_pdata *gpmc_device_data[2];
+
+static struct gpmc_pdata gpmc_data = {
+	.device_pdata = gpmc_device_data,
+};
+
 #if defined(CONFIG_SMSC911X) || defined(CONFIG_SMSC911X_MODULE)
 #include <plat/gpmc-smsc911x.h>
 
@@ -122,7 +129,9 @@ static inline void __init omap3evm_init_smsc911x(void)
 			smsc911x_cfg.gpio_reset = OMAP3EVM_GEN2_ETHR_GPIO_RST;
 	}
 
-	gpmc_smsc911x_init(&smsc911x_cfg);
+	*gpmc_device_data = gpmc_smsc911x_update(&smsc911x_cfg);
+	if (!*gpmc_device_data)
+		pr_err("error: unable to initilaize gpmc smsc911x\n");
 }
 
 #else
@@ -658,6 +667,7 @@ static void __init omap3_evm_init(void)
 	usbhs_init(&usbhs_bdata);
 	omap_ads7846_init(1, OMAP3_EVM_TS_GPIO, 310, NULL);
 	omap3evm_init_smsc911x();
+	omap_gpmc_init(&gpmc_data);
 	omap3_evm_display_init();
 	omap3_evm_wl12xx_init();
 }
-- 
1.7.10.2
