From: lkundrak@v3.sk (Lubomir Rintel)
Date: Mon, 12 Nov 2018 04:20:25 +0100
Subject: [PATCH v3 16/18] ARM: mmp: add an instance of pxa-usb-phy to ttc_dkb
 and aspenite
In-Reply-To: <20181112032027.653931-1-lkundrak@v3.sk>
References: <20181112032027.653931-1-lkundrak@v3.sk>
Message-ID: <20181112032027.653931-17-lkundrak@v3.sk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This will replace the *_pdata.phy_{de,}init()

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

---
Changes since v1:
- Squashed patches with ttc_dkb and aspenite changes together.

 arch/arm/mach-mmp/aspenite.c | 4 ++++
 arch/arm/mach-mmp/ttc_dkb.c  | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm/mach-mmp/aspenite.c b/arch/arm/mach-mmp/aspenite.c
index 6c2ebf01893a..23f99976b5f5 100644
--- a/arch/arm/mach-mmp/aspenite.c
+++ b/arch/arm/mach-mmp/aspenite.c
@@ -256,6 +256,10 @@ static void __init common_init(void)
 	/* off-chip devices */
 	platform_device_register(&smc91x_device);
 
+#if IS_ENABLED(CONFIG_PHY_PXA_USB)
+	platform_device_register(&pxa168_device_usb_phy);
+#endif
+
 #if IS_ENABLED(CONFIG_USB_EHCI_MV)
 	pxa168_add_usb_host(&pxa168_sph_pdata);
 #endif
diff --git a/arch/arm/mach-mmp/ttc_dkb.c b/arch/arm/mach-mmp/ttc_dkb.c
index c7897fb2b6da..767dcb23ee1c 100644
--- a/arch/arm/mach-mmp/ttc_dkb.c
+++ b/arch/arm/mach-mmp/ttc_dkb.c
@@ -282,6 +282,10 @@ static void __init ttc_dkb_init(void)
 				 sizeof(struct pxa_gpio_platform_data));
 	platform_add_devices(ARRAY_AND_SIZE(ttc_dkb_devices));
 
+#if IS_ENABLED(CONFIG_PHY_PXA_USB)
+	platform_device_register(&pxa168_device_usb_phy);
+#endif
+
 #if IS_ENABLED(CONFIG_USB_MV_UDC)
 	pxa168_device_u2o.dev.platform_data = &ttc_usb_pdata;
 	platform_device_register(&pxa168_device_u2o);
-- 
2.19.1
