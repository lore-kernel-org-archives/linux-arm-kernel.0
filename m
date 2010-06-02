From: grinberg@compulab.co.il (Igor Grinberg)
Date: Wed,  2 Jun 2010 10:40:46 +0300
Subject: [PATCH 1/5] usb/otg/ulpi: extend the generic ulpi driver.
In-Reply-To: <1275464450-23003-1-git-send-email-grinberg@compulab.co.il>
References: <1275464450-23003-1-git-send-email-grinberg@compulab.co.il>
Message-ID: <1275464450-23003-2-git-send-email-grinberg@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch extends the generic ulpi driver with support for
Function and Interface control of upli phy.

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
 arch/arm/mach-mx2/mach-pca100.c       |   10 ++++-
 arch/arm/mach-mx3/mach-armadillo5x0.c |   10 ++++-
 arch/arm/mach-mx3/mach-mx31lite.c     |    5 ++-
 arch/arm/mach-mx3/mach-mx31moboard.c  |    5 ++-
 arch/arm/mach-mx3/mach-pcm037.c       |   10 ++++-
 arch/arm/mach-mx3/mach-pcm043.c       |    5 ++-
 drivers/usb/otg/Kconfig               |    2 -
 drivers/usb/otg/ulpi.c                |   64 +++++++++++++++++++++++++++++----
 include/linux/usb/ulpi.h              |   25 ++++++++++++-
 9 files changed, 117 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-mx2/mach-pca100.c b/arch/arm/mach-mx2/mach-pca100.c
index 778fff2..0f2ece0 100644
--- a/arch/arm/mach-mx2/mach-pca100.c
+++ b/arch/arm/mach-mx2/mach-pca100.c
@@ -356,13 +356,19 @@ static void __init pca100_init(void)
 #if defined(CONFIG_USB_ULPI)
 	if (otg_mode_host) {
 		otg_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
-				USB_OTG_DRV_VBUS | USB_OTG_DRV_VBUS_EXT);
+						USB_OTG_DRV_VBUS |
+						USB_OTG_DRV_VBUS_EXT,
+						ULPI_IC_DEFAULT,
+						ULPI_FC_DEFAULT);
 
 		mxc_register_device(&mxc_otg_host, &otg_pdata);
 	}
 
 	usbh2_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
-				USB_OTG_DRV_VBUS | USB_OTG_DRV_VBUS_EXT);
+					  USB_OTG_DRV_VBUS |
+					  USB_OTG_DRV_VBUS_EXT,
+					  ULPI_IC_DEFAULT,
+					  ULPI_FC_DEFAULT);
 
 	mxc_register_device(&mxc_usbh2, &usbh2_pdata);
 #endif
diff --git a/arch/arm/mach-mx3/mach-armadillo5x0.c b/arch/arm/mach-mx3/mach-armadillo5x0.c
index 5f72ec9..81904d4 100644
--- a/arch/arm/mach-mx3/mach-armadillo5x0.c
+++ b/arch/arm/mach-mx3/mach-armadillo5x0.c
@@ -552,9 +552,15 @@ static void __init armadillo5x0_init(void)
 	/* USB */
 #if defined(CONFIG_USB_ULPI)
 	usbotg_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
-			USB_OTG_DRV_VBUS | USB_OTG_DRV_VBUS_EXT);
+					   USB_OTG_DRV_VBUS |
+					   USB_OTG_DRV_VBUS_EXT,
+					   ULPI_IC_DEFAULT,
+					   ULPI_FC_DEFAULT);
 	usbh2_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
-			USB_OTG_DRV_VBUS | USB_OTG_DRV_VBUS_EXT);
+					  USB_OTG_DRV_VBUS |
+					  USB_OTG_DRV_VBUS_EXT,
+					  ULPI_IC_DEFAULT,
+					  ULPI_FC_DEFAULT);
 
 	mxc_register_device(&mxc_otg_host, &usbotg_pdata);
 	mxc_register_device(&mxc_usbh2, &usbh2_pdata);
diff --git a/arch/arm/mach-mx3/mach-mx31lite.c b/arch/arm/mach-mx3/mach-mx31lite.c
index 2b6d114..9413be4 100644
--- a/arch/arm/mach-mx3/mach-mx31lite.c
+++ b/arch/arm/mach-mx3/mach-mx31lite.c
@@ -261,7 +261,10 @@ static void __init mxc_board_init(void)
 #if defined(CONFIG_USB_ULPI)
 	/* USB */
 	usbh2_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
-				USB_OTG_DRV_VBUS | USB_OTG_DRV_VBUS_EXT);
+					  USB_OTG_DRV_VBUS |
+					  USB_OTG_DRV_VBUS_EXT,
+					  ULPI_IC_DEFAULT,
+					  ULPI_FC_DEFAULT);
 
 	mxc_register_device(&mxc_usbh2, &usbh2_pdata);
 #endif
diff --git a/arch/arm/mach-mx3/mach-mx31moboard.c b/arch/arm/mach-mx3/mach-mx31moboard.c
index fccb920..620f21a 100644
--- a/arch/arm/mach-mx3/mach-mx31moboard.c
+++ b/arch/arm/mach-mx3/mach-mx31moboard.c
@@ -391,7 +391,10 @@ static struct mxc_usbh_platform_data usbh2_pdata = {
 static int __init moboard_usbh2_init(void)
 {
 	usbh2_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
-			USB_OTG_DRV_VBUS | USB_OTG_DRV_VBUS_EXT);
+					  USB_OTG_DRV_VBUS |
+					  USB_OTG_DRV_VBUS_EXT,
+					  ULPI_IC_DEFAULT,
+					  ULPI_FC_DEFAULT);
 
 	return mxc_register_device(&mxc_usbh2, &usbh2_pdata);
 }
diff --git a/arch/arm/mach-mx3/mach-pcm037.c b/arch/arm/mach-mx3/mach-pcm037.c
index 2df1ec5..33471c4 100644
--- a/arch/arm/mach-mx3/mach-pcm037.c
+++ b/arch/arm/mach-mx3/mach-pcm037.c
@@ -657,13 +657,19 @@ static void __init mxc_board_init(void)
 #if defined(CONFIG_USB_ULPI)
 	if (otg_mode_host) {
 		otg_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
-				USB_OTG_DRV_VBUS | USB_OTG_DRV_VBUS_EXT);
+						USB_OTG_DRV_VBUS |
+						USB_OTG_DRV_VBUS_EXT,
+						ULPI_IC_DEFAULT,
+						ULPI_FC_DEFAULT);
 
 		mxc_register_device(&mxc_otg_host, &otg_pdata);
 	}
 
 	usbh2_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
-				USB_OTG_DRV_VBUS | USB_OTG_DRV_VBUS_EXT);
+					  USB_OTG_DRV_VBUS |
+					  USB_OTG_DRV_VBUS_EXT,
+					  ULPI_IC_DEFAULT,
+					  ULPI_FC_DEFAULT);
 
 	mxc_register_device(&mxc_usbh2, &usbh2_pdata);
 #endif
diff --git a/arch/arm/mach-mx3/mach-pcm043.c b/arch/arm/mach-mx3/mach-pcm043.c
index 1bf1ec2..63d8719 100644
--- a/arch/arm/mach-mx3/mach-pcm043.c
+++ b/arch/arm/mach-mx3/mach-pcm043.c
@@ -379,7 +379,10 @@ static void __init mxc_board_init(void)
 #if defined(CONFIG_USB_ULPI)
 	if (otg_mode_host) {
 		otg_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
-				USB_OTG_DRV_VBUS | USB_OTG_DRV_VBUS_EXT);
+						USB_OTG_DRV_VBUS |
+						USB_OTG_DRV_VBUS_EXT,
+						ULPI_IC_DEFAULT,
+						ULPI_FC_DEFAULT);
 
 		mxc_register_device(&mxc_otg_host, &otg_pdata);
 	}
diff --git a/drivers/usb/otg/Kconfig b/drivers/usb/otg/Kconfig
index 3d2d3e5..3b12895 100644
--- a/drivers/usb/otg/Kconfig
+++ b/drivers/usb/otg/Kconfig
@@ -49,8 +49,6 @@ config USB_ULPI
 	  Enable this to support ULPI connected USB OTG transceivers which
 	  are likely found on embedded boards.
 
-	  The only chip currently supported is NXP's ISP1504
-
 config TWL4030_USB
 	tristate "TWL4030 USB Transceiver Driver"
 	depends on TWL4030_CORE && REGULATOR_TWL4030
diff --git a/drivers/usb/otg/ulpi.c b/drivers/usb/otg/ulpi.c
index 9010225..0e7a826 100644
--- a/drivers/usb/otg/ulpi.c
+++ b/drivers/usb/otg/ulpi.c
@@ -34,6 +34,7 @@
 #define ULPI_VID_HIGH        0x01    /* Vendor ID high */
 #define ULPI_PID_LOW         0x02    /* Product ID low */
 #define ULPI_PID_HIGH        0x03    /* Product ID high */
+#define ULPI_FUNCTL          0x04    /* Function Control */
 #define ULPI_ITFCTL          0x07    /* Interface Control */
 #define ULPI_OTGCTL          0x0A    /* OTG Control */
 
@@ -60,25 +61,51 @@ static unsigned int ulpi_ids[] = {
 	ULPI_ID(0x04cc, 0x1504),	/* NXP ISP1504 */
 };
 
-static int ulpi_set_flags(struct otg_transceiver *otg)
+static int ulpi_set_otg_flags(struct otg_transceiver *otg)
 {
+	unsigned int otg_flags = otg->flags & 0xff;
 	unsigned int flags = 0;
 
-	if (otg->flags & USB_OTG_PULLUP_ID)
+	if (otg_flags & USB_OTG_PULLUP_ID)
 		flags |= ID_PULL_UP;
 
-	if (otg->flags & USB_OTG_PULLDOWN_DM)
+	if (otg_flags & USB_OTG_PULLDOWN_DM)
 		flags |= DM_PULL_DOWN;
 
-	if (otg->flags & USB_OTG_PULLDOWN_DP)
+	if (otg_flags & USB_OTG_PULLDOWN_DP)
 		flags |= DP_PULL_DOWN;
 
-	if (otg->flags & USB_OTG_EXT_VBUS_INDICATOR)
+	if (otg_flags & USB_OTG_EXT_VBUS_INDICATOR)
 		flags |= USE_EXT_VBUS_IND;
 
 	return otg_io_write(otg, flags, ULPI_OTGCTL + ULPI_REG_SET);
 }
 
+static int ulpi_set_fc_flags(struct otg_transceiver *otg)
+{
+	unsigned int fc_flags = (otg->flags >> 16) & 0xff;
+
+	/*
+	 * Bit 6 in Function Control Register is SuspendM
+	 * 1 - Powered.
+	 * 0 - Suspend.
+	 */
+	fc_flags |= (1 << 6);
+
+	return otg_io_write(otg, fc_flags, ULPI_FUNCTL + ULPI_REG_SET);
+}
+
+static inline int ulpi_set_flags(struct otg_transceiver *otg)
+{
+	int ret;
+
+	ret = ulpi_set_otg_flags(otg);
+	if (ret)
+		return ret;
+
+	return ulpi_set_fc_flags(otg);
+}
+
 static int ulpi_init(struct otg_transceiver *otg)
 {
 	int i, vid, pid;
@@ -98,6 +125,28 @@ static int ulpi_init(struct otg_transceiver *otg)
 	return -ENODEV;
 }
 
+static int ulpi_set_host(struct otg_transceiver *otg, struct usb_bus *host)
+{
+	unsigned int ic_flags = (otg->flags >> 8) & 0xff;
+	unsigned int ic = ic_flags & ~0x7;
+
+	if (!host) {
+		otg->host = NULL;
+		return 0;
+	}
+
+	otg->host = host;
+
+	if (ic_flags & ULPI_IC_3PIN)
+		ic |= ULPI_IC_3PIN;
+	else if (ic_flags & ULPI_IC_CARKIT)
+		ic |= ULPI_IC_CARKIT;
+	else
+		ic |= ULPI_IC_6PIN;
+
+	return otg_io_write(otg, ic, ULPI_ITFCTL + ULPI_REG_SET);
+}
+
 static int ulpi_set_vbus(struct otg_transceiver *otg, bool on)
 {
 	unsigned int flags = otg_io_read(otg, ULPI_OTGCTL);
@@ -117,7 +166,7 @@ static int ulpi_set_vbus(struct otg_transceiver *otg, bool on)
 
 struct otg_transceiver *
 otg_ulpi_create(struct otg_io_access_ops *ops,
-		unsigned int flags)
+		u8 otg_flags, u8 ic_flags, u8 fc_flags)
 {
 	struct otg_transceiver *otg;
 
@@ -126,9 +175,10 @@ otg_ulpi_create(struct otg_io_access_ops *ops,
 		return NULL;
 
 	otg->label	= "ULPI";
-	otg->flags	= flags;
+	otg->flags	= otg_flags | (ic_flags << 8) | (fc_flags << 16);
 	otg->io_ops	= ops;
 	otg->init	= ulpi_init;
+	otg->set_host	= ulpi_set_host;
 	otg->set_vbus	= ulpi_set_vbus;
 
 	return otg;
diff --git a/include/linux/usb/ulpi.h b/include/linux/usb/ulpi.h
index 20675c6..8318067 100644
--- a/include/linux/usb/ulpi.h
+++ b/include/linux/usb/ulpi.h
@@ -1,7 +1,30 @@
 #ifndef __LINUX_USB_ULPI_H
 #define __LINUX_USB_ULPI_H
 
+/* ULPI Function Control Register bits */
+#define ULPI_FC_HS	0		/* Enable HS tcvr */
+#define ULPI_FC_FS	(0x1 << 0)	/* Enable FS tcvr */
+#define ULPI_FC_LS	(0x2 << 0)	/* Enable LS tcvr */
+#define ULPI_FC_FS_LS	(0x3 << 0)	/* Enable FS tcvr for LS packets */
+#define ULPI_FC_TRM_SEL	(0x1 << 2)	/* Internal pullup and HS termination */
+#define ULPI_FC_NODRV	(0x1 << 3)	/* Non-Driving Operation */
+#define ULPI_FC_NONRZI	(0x1 << 4)	/* Disable bit-stuff and NRZI encode */
+#define ULPI_FC_RESET	(0x1 << 5)	/* Reset the UTMI core */
+#define ULPI_FC_DEFAULT	0x41		/* Function Control Register Default */
+
+
+/* ULPI Interface Register bits */
+#define ULPI_IC_6PIN	(1 << 0)	/* XCVR 6 serial pin mode */
+#define ULPI_IC_3PIN	(1 << 1)	/* XCVR 3 serial pin mode */
+#define ULPI_IC_CARKIT	(1 << 2)	/* Carkit mode */
+#define ULPI_IC_CLKSPND	(1 << 3)	/* Active low clock suspend */
+#define ULPI_IC_AUTORES	(1 << 4)	/* PHY auto transmit resume signal */
+#define ULPI_IC_VBUSINV	(1 << 5)	/* Invert the external VBUS indicator */
+#define ULPI_IC_INDPT	(1 << 6)	/* Indicator Pass Through */
+#define ULPI_IC_DISPRT	(1 << 7)	/* Interface Protect Disable */
+#define ULPI_IC_DEFAULT	0x0		/* Interface Control Register Default */
+
 struct otg_transceiver *otg_ulpi_create(struct otg_io_access_ops *ops,
-					unsigned int flags);
+					u8 fc_flags, u8 ic_flags, u8 otg_flags);
 
 #endif /* __LINUX_USB_ULPI_H */
-- 
1.6.4.4
