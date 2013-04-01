From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Mon,  1 Apr 2013 23:03:00 +0300
Subject: [PATCH v2 RESEND] ARM: OMAP1: fix omap_udc registration
Message-ID: <1364846580-5256-1-git-send-email-aaro.koskinen@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

omap_udc platform device is not registered properly anymore:
CONFIG_USB_GADGET_OMAP was deleted by 193ab2a6 (usb: gadget: allow
multiple gadgets to be built) already in v3.1.

Fix by using CONFIG_USB_OMAP instead. Tested on Nokia 770 by checking
that omap_udc is probed & working properly when built as a module.

Acked-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---

	Patch history:

	v2: http://marc.info/?t=136266319800006&r=1&w=2
            - use IS_ENABLED()

	v1: http://marc.info/?t=136260886600006&r=1&w=2

 arch/arm/mach-omap1/include/mach/usb.h |    2 +-
 arch/arm/mach-omap1/usb.c              |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap1/include/mach/usb.h b/arch/arm/mach-omap1/include/mach/usb.h
index 753cd5c..45e5ac7 100644
--- a/arch/arm/mach-omap1/include/mach/usb.h
+++ b/arch/arm/mach-omap1/include/mach/usb.h
@@ -2,7 +2,7 @@
  * FIXME correct answer depends on hmc_mode,
  * as does (on omap1) any nonzero value for config->otg port number
  */
-#ifdef	CONFIG_USB_GADGET_OMAP
+#if IS_ENABLED(CONFIG_USB_OMAP)
 #define	is_usb0_device(config)	1
 #else
 #define	is_usb0_device(config)	0
diff --git a/arch/arm/mach-omap1/usb.c b/arch/arm/mach-omap1/usb.c
index 1a1db59..4118db5 100644
--- a/arch/arm/mach-omap1/usb.c
+++ b/arch/arm/mach-omap1/usb.c
@@ -123,7 +123,7 @@ omap_otg_init(struct omap_usb_config *config)
 	syscon = omap_readl(OTG_SYSCON_1);
 	syscon |= HST_IDLE_EN|DEV_IDLE_EN|OTG_IDLE_EN;
 
-#ifdef	CONFIG_USB_GADGET_OMAP
+#if IS_ENABLED(CONFIG_USB_OMAP)
 	if (config->otg || config->register_dev) {
 		struct platform_device *udc_device = config->udc_device;
 		int status;
@@ -169,7 +169,7 @@ omap_otg_init(struct omap_usb_config *config)
 void omap_otg_init(struct omap_usb_config *config) {}
 #endif
 
-#ifdef	CONFIG_USB_GADGET_OMAP
+#if IS_ENABLED(CONFIG_USB_OMAP)
 
 static struct resource udc_resources[] = {
 	/* order is significant! */
@@ -600,7 +600,7 @@ static void __init omap_1510_usb_init(struct omap_usb_config *config)
 	while (!(omap_readw(ULPD_DPLL_CTRL) & DPLL_LOCK))
 		cpu_relax();
 
-#ifdef	CONFIG_USB_GADGET_OMAP
+#if IS_ENABLED(CONFIG_USB_OMAP)
 	if (config->register_dev) {
 		int status;
 
-- 
1.7.10.4
