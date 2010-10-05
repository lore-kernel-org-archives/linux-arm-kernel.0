From: eric@eukrea.com (=?UTF-8?q?Eric=20B=C3=A9nard?=)
Date: Tue,  5 Oct 2010 18:51:40 +0200
Subject: [PATCH] cpuimx25 & cpuimx35: fix OTG port registration in host mode
In-Reply-To: <4CAB494F.2060704@eukrea.com>
References: <4CAB494F.2060704@eukrea.com>
Message-ID: <1286297500-21077-1-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

the PHY is UTMI so don't create an ULPI viewpoint.

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 arch/arm/mach-mx25/mach-cpuimx25.c |   14 ++++----------
 arch/arm/mach-mx3/mach-cpuimx35.c  |   14 ++++----------
 2 files changed, 8 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-mx25/mach-cpuimx25.c b/arch/arm/mach-mx25/mach-cpuimx25.c
index e064bb3..c530c8a 100644
--- a/arch/arm/mach-mx25/mach-cpuimx25.c
+++ b/arch/arm/mach-mx25/mach-cpuimx25.c
@@ -41,7 +41,6 @@
 #include <mach/mxc_nand.h>
 #include <mach/imxfb.h>
 #include <mach/mxc_ehci.h>
-#include <mach/ulpi.h>
 #include <mach/iomux-mx25.h>
 
 #include "devices-imx25.h"
@@ -135,18 +134,13 @@ static void __init eukrea_cpuimx25_init(void)
 				ARRAY_SIZE(eukrea_cpuimx25_i2c_devices));
 	imx25_add_imx_i2c0(&eukrea_cpuimx25_i2c0_data);
 
-#if defined(CONFIG_USB_ULPI)
-	if (otg_mode_host) {
-		otg_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
-				ULPI_OTG_DRVVBUS | ULPI_OTG_DRVVBUS_EXT);
-
+	if (otg_mode_host)
 		mxc_register_device(&mxc_otg, &otg_pdata);
-	}
-	mxc_register_device(&mxc_usbh2, &usbh2_pdata);
-#endif
-	if (!otg_mode_host)
+	else
 		mxc_register_device(&otg_udc_device, &otg_device_pdata);
 
+	mxc_register_device(&mxc_usbh2, &usbh2_pdata);
+
 #ifdef CONFIG_MACH_EUKREA_MBIMXSD25_BASEBOARD
 	eukrea_mbimxsd25_baseboard_init();
 #endif
diff --git a/arch/arm/mach-mx3/mach-cpuimx35.c b/arch/arm/mach-mx3/mach-cpuimx35.c
index d16bec8..8ba5321 100644
--- a/arch/arm/mach-mx3/mach-cpuimx35.c
+++ b/arch/arm/mach-mx3/mach-cpuimx35.c
@@ -44,7 +44,6 @@
 #include <mach/iomux-mx35.h>
 #include <mach/mxc_nand.h>
 #include <mach/mxc_ehci.h>
-#include <mach/ulpi.h>
 
 #include "devices-imx35.h"
 #include "devices.h"
@@ -168,18 +167,13 @@ static void __init mxc_board_init(void)
 			ARRAY_SIZE(eukrea_cpuimx35_i2c_devices));
 	imx35_add_imx_i2c0(&eukrea_cpuimx35_i2c0_data);
 
-#if defined(CONFIG_USB_ULPI)
-	if (otg_mode_host) {
-		otg_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
-				ULPI_OTG_DRVVBUS | ULPI_OTG_DRVVBUS_EXT);
-
+	if (otg_mode_host)
 		mxc_register_device(&mxc_otg_host, &otg_pdata);
-	}
-	mxc_register_device(&mxc_usbh1, &usbh1_pdata);
-#endif
-	if (!otg_mode_host)
+	else
 		mxc_register_device(&mxc_otg_udc_device, &otg_device_pdata);
 
+	mxc_register_device(&mxc_usbh1, &usbh1_pdata);
+
 #ifdef CONFIG_MACH_EUKREA_MBIMXSD35_BASEBOARD
 	eukrea_mbimxsd35_baseboard_init();
 #endif
-- 
1.7.0.4
