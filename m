From: grinberg@compulab.co.il (Igor Grinberg)
Date: Thu, 15 Jul 2010 16:00:16 +0300
Subject: [PATCH 3/3] usb/otg/ulpi: extend the generic ulpi driver.
In-Reply-To: <1279198816-30367-1-git-send-email-grinberg@compulab.co.il>
References: <1279198816-30367-1-git-send-email-grinberg@compulab.co.il>
Message-ID: <1279198816-30367-4-git-send-email-grinberg@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

1) Introduce ulpi specific flags for control of the ulpi phy
2) Extend the generic ulpi driver with support for Function and
Interface control of upli phy
3) Update the platforms using the generic ulpi driver with new ulpi
flags
4) Remove the otg control flags not in use

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
 arch/arm/mach-mx2/mach-pca100.c          |    4 +-
 arch/arm/mach-mx3/mach-armadillo5x0.c    |    4 +-
 arch/arm/mach-mx3/mach-mx31lilly.c       |    4 +-
 arch/arm/mach-mx3/mach-mx31lite.c        |    2 +-
 arch/arm/mach-mx3/mach-mx31moboard.c     |    2 +-
 arch/arm/mach-mx3/mach-pcm037.c          |    4 +-
 arch/arm/mach-mx3/mach-pcm043.c          |    2 +-
 arch/arm/mach-mx3/mx31moboard-smartbot.c |    2 +-
 drivers/usb/otg/ulpi.c                   |  127 +++++++++++++++++++++++++++---
 include/linux/usb/otg.h                  |    7 --
 include/linux/usb/ulpi.h                 |   39 +++++++++
 11 files changed, 168 insertions(+), 29 deletions(-)

diff --git a/arch/arm/mach-mx2/mach-pca100.c b/arch/arm/mach-mx2/mach-pca100.c
index a87422e..09f0d7c 100644
--- a/arch/arm/mach-mx2/mach-pca100.c
+++ b/arch/arm/mach-mx2/mach-pca100.c
@@ -357,13 +357,13 @@ static void __init pca100_init(void)
 #if defined(CONFIG_USB_ULPI)
 	if (otg_mode_host) {
 		otg_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
-				USB_OTG_DRV_VBUS | USB_OTG_DRV_VBUS_EXT);
+				ULPI_OTG_DRVVBUS | ULPI_OTG_DRVVBUS_EXT);
 
 		mxc_register_device(&mxc_otg_host, &otg_pdata);
 	}
 
 	usbh2_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
-				USB_OTG_DRV_VBUS | USB_OTG_DRV_VBUS_EXT);
+				ULPI_OTG_DRVVBUS | ULPI_OTG_DRVVBUS_EXT);
 
 	mxc_register_device(&mxc_usbh2, &usbh2_pdata);
 #endif
diff --git a/arch/arm/mach-mx3/mach-armadillo5x0.c b/arch/arm/mach-mx3/mach-armadillo5x0.c
index 5f72ec9..b400686 100644
--- a/arch/arm/mach-mx3/mach-armadillo5x0.c
+++ b/arch/arm/mach-mx3/mach-armadillo5x0.c
@@ -552,9 +552,9 @@ static void __init armadillo5x0_init(void)
 	/* USB */
 #if defined(CONFIG_USB_ULPI)
 	usbotg_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
-			USB_OTG_DRV_VBUS | USB_OTG_DRV_VBUS_EXT);
+			ULPI_OTG_DRVVBUS | ULPI_OTG_DRVVBUS_EXT);
 	usbh2_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
-			USB_OTG_DRV_VBUS | USB_OTG_DRV_VBUS_EXT);
+			ULPI_OTG_DRVVBUS | ULPI_OTG_DRVVBUS_EXT);
 
 	mxc_register_device(&mxc_otg_host, &usbotg_pdata);
 	mxc_register_device(&mxc_usbh2, &usbh2_pdata);
diff --git a/arch/arm/mach-mx3/mach-mx31lilly.c b/arch/arm/mach-mx3/mach-mx31lilly.c
index b2c7f51..6187988 100644
--- a/arch/arm/mach-mx3/mach-mx31lilly.c
+++ b/arch/arm/mach-mx3/mach-mx31lilly.c
@@ -249,9 +249,9 @@ static struct mxc_usbh_platform_data usbh2_pdata = {
 static void lilly1131_usb_init(void)
 {
 	usbotg_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
-				USB_OTG_DRV_VBUS | USB_OTG_DRV_VBUS_EXT);
+				ULPI_OTG_DRVVBUS | ULPI_OTG_DRVVBUS_EXT);
 	usbh2_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
-				USB_OTG_DRV_VBUS | USB_OTG_DRV_VBUS_EXT);
+				ULPI_OTG_DRVVBUS | ULPI_OTG_DRVVBUS_EXT);
 
 	mxc_register_device(&mxc_usbh1, &usbh1_pdata);
 	mxc_register_device(&mxc_usbh2, &usbh2_pdata);
diff --git a/arch/arm/mach-mx3/mach-mx31lite.c b/arch/arm/mach-mx3/mach-mx31lite.c
index 2b6d114..4bee3c5 100644
--- a/arch/arm/mach-mx3/mach-mx31lite.c
+++ b/arch/arm/mach-mx3/mach-mx31lite.c
@@ -261,7 +261,7 @@ static void __init mxc_board_init(void)
 #if defined(CONFIG_USB_ULPI)
 	/* USB */
 	usbh2_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
-				USB_OTG_DRV_VBUS | USB_OTG_DRV_VBUS_EXT);
+				ULPI_OTG_DRVVBUS | ULPI_OTG_DRVVBUS_EXT);
 
 	mxc_register_device(&mxc_usbh2, &usbh2_pdata);
 #endif
diff --git a/arch/arm/mach-mx3/mach-mx31moboard.c b/arch/arm/mach-mx3/mach-mx31moboard.c
index 62b5e40..8821672 100644
--- a/arch/arm/mach-mx3/mach-mx31moboard.c
+++ b/arch/arm/mach-mx3/mach-mx31moboard.c
@@ -405,7 +405,7 @@ static struct mxc_usbh_platform_data usbh2_pdata = {
 static int __init moboard_usbh2_init(void)
 {
 	usbh2_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
-			USB_OTG_DRV_VBUS | USB_OTG_DRV_VBUS_EXT);
+			ULPI_OTG_DRVVBUS | ULPI_OTG_DRVVBUS_EXT);
 
 	return mxc_register_device(&mxc_usbh2, &usbh2_pdata);
 }
diff --git a/arch/arm/mach-mx3/mach-pcm037.c b/arch/arm/mach-mx3/mach-pcm037.c
index cce4106..9718688 100644
--- a/arch/arm/mach-mx3/mach-pcm037.c
+++ b/arch/arm/mach-mx3/mach-pcm037.c
@@ -658,13 +658,13 @@ static void __init mxc_board_init(void)
 #if defined(CONFIG_USB_ULPI)
 	if (otg_mode_host) {
 		otg_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
-				USB_OTG_DRV_VBUS | USB_OTG_DRV_VBUS_EXT);
+				ULPI_OTG_DRVVBUS | ULPI_OTG_DRVVBUS_EXT);
 
 		mxc_register_device(&mxc_otg_host, &otg_pdata);
 	}
 
 	usbh2_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
-				USB_OTG_DRV_VBUS | USB_OTG_DRV_VBUS_EXT);
+				ULPI_OTG_DRVVBUS | ULPI_OTG_DRVVBUS_EXT);
 
 	mxc_register_device(&mxc_usbh2, &usbh2_pdata);
 #endif
diff --git a/arch/arm/mach-mx3/mach-pcm043.c b/arch/arm/mach-mx3/mach-pcm043.c
index 78d9185..5c80242 100644
--- a/arch/arm/mach-mx3/mach-pcm043.c
+++ b/arch/arm/mach-mx3/mach-pcm043.c
@@ -380,7 +380,7 @@ static void __init mxc_board_init(void)
 #if defined(CONFIG_USB_ULPI)
 	if (otg_mode_host) {
 		otg_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
-				USB_OTG_DRV_VBUS | USB_OTG_DRV_VBUS_EXT);
+				ULPI_OTG_DRVVBUS | ULPI_OTG_DRVVBUS_EXT);
 
 		mxc_register_device(&mxc_otg_host, &otg_pdata);
 	}
diff --git a/arch/arm/mach-mx3/mx31moboard-smartbot.c b/arch/arm/mach-mx3/mx31moboard-smartbot.c
index 293eea6..53c9ad5 100644
--- a/arch/arm/mach-mx3/mx31moboard-smartbot.c
+++ b/arch/arm/mach-mx3/mx31moboard-smartbot.c
@@ -138,7 +138,7 @@ static struct mxc_usbh_platform_data otg_host_pdata = {
 static int __init smartbot_otg_host_init(void)
 {
 	otg_host_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
-			USB_OTG_DRV_VBUS | USB_OTG_DRV_VBUS_EXT);
+			ULPI_OTG_DRVVBUS | ULPI_OTG_DRVVBUS_EXT);
 
 	return mxc_register_device(&mxc_otg_host, &otg_host_pdata);
 }
diff --git a/drivers/usb/otg/ulpi.c b/drivers/usb/otg/ulpi.c
index ef7dbe4..ccc8195 100644
--- a/drivers/usb/otg/ulpi.c
+++ b/drivers/usb/otg/ulpi.c
@@ -37,25 +37,106 @@ static unsigned int ulpi_ids[] = {
 	ULPI_ID(0x0424, 0x0006),        /* SMSC USB3319 */
 };
 
-static int ulpi_set_flags(struct otg_transceiver *otg)
+static int ulpi_set_otg_flags(struct otg_transceiver *otg)
 {
-	unsigned int flags = 0;
+	unsigned int flags = ULPI_OTG_CTRL_DP_PULLDOWN |
+			     ULPI_OTG_CTRL_DM_PULLDOWN;
 
-	if (otg->flags & USB_OTG_PULLUP_ID)
+	if (otg->flags & ULPI_OTG_ID_PULLUP)
 		flags |= ULPI_OTG_CTRL_ID_PULLUP;
 
-	if (otg->flags & USB_OTG_PULLDOWN_DM)
-		flags |= ULPI_OTG_CTRL_DM_PULLDOWN;
+	/*
+	 * ULPI Specification rev.1.1 default
+	 * for Dp/DmPulldown is enabled.
+	 */
+	if (otg->flags & ULPI_OTG_DP_PULLDOWN_DIS)
+		flags &= ~ULPI_OTG_CTRL_DP_PULLDOWN;
 
-	if (otg->flags & USB_OTG_PULLDOWN_DP)
-		flags |= ULPI_OTG_CTRL_DP_PULLDOWN;
+	if (otg->flags & ULPI_OTG_DM_PULLDOWN_DIS)
+		flags &= ~ULPI_OTG_CTRL_DM_PULLDOWN;
 
-	if (otg->flags & USB_OTG_EXT_VBUS_INDICATOR)
+	if (otg->flags & ULPI_OTG_EXTVBUSIND)
 		flags |= ULPI_OTG_CTRL_EXTVBUSIND;
 
 	return otg_io_write(otg, flags, ULPI_OTG_CTRL);
 }
 
+static int ulpi_set_fc_flags(struct otg_transceiver *otg)
+{
+	unsigned int flags = 0;
+
+	/*
+	 * ULPI Specification rev.1.1 default
+	 * for XcvrSelect is Full Speed.
+	 */
+	if (otg->flags & ULPI_FC_HS)
+		flags |= ULPI_FUNC_CTRL_HIGH_SPEED;
+	else if (otg->flags & ULPI_FC_LS)
+		flags |= ULPI_FUNC_CTRL_LOW_SPEED;
+	else if (otg->flags & ULPI_FC_FS4LS)
+		flags |= ULPI_FUNC_CTRL_FS4LS;
+	else
+		flags |= ULPI_FUNC_CTRL_FULL_SPEED;
+
+	if (otg->flags & ULPI_FC_TERMSEL)
+		flags |= ULPI_FUNC_CTRL_TERMSELECT;
+
+	/*
+	 * ULPI Specification rev.1.1 default
+	 * for OpMode is Normal Operation.
+	 */
+	if (otg->flags & ULPI_FC_OP_NODRV)
+		flags |= ULPI_FUNC_CTRL_OPMODE_NONDRIVING;
+	else if (otg->flags & ULPI_FC_OP_DIS_NRZI)
+		flags |= ULPI_FUNC_CTRL_OPMODE_DISABLE_NRZI;
+	else if (otg->flags & ULPI_FC_OP_NSYNC_NEOP)
+		flags |= ULPI_FUNC_CTRL_OPMODE_NOSYNC_NOEOP;
+	else
+		flags |= ULPI_FUNC_CTRL_OPMODE_NORMAL;
+
+	/*
+	 * ULPI Specification rev.1.1 default
+	 * for SuspendM is Powered.
+	 */
+	flags |= ULPI_FUNC_CTRL_SUSPENDM;
+
+	return otg_io_write(otg, flags, ULPI_FUNC_CTRL);
+}
+
+static int ulpi_set_ic_flags(struct otg_transceiver *otg)
+{
+	unsigned int flags = 0;
+
+	if (otg->flags & ULPI_IC_AUTORESUME)
+		flags |= ULPI_IFC_CTRL_AUTORESUME;
+
+	if (otg->flags & ULPI_IC_EXTVBUS_INDINV)
+		flags |= ULPI_IFC_CTRL_EXTERNAL_VBUS;
+
+	if (otg->flags & ULPI_IC_IND_PASSTHRU)
+		flags |= ULPI_IFC_CTRL_PASSTHRU;
+
+	if (otg->flags & ULPI_IC_PROTECT_DIS)
+		flags |= ULPI_IFC_CTRL_PROTECT_IFC_DISABLE;
+
+	return otg_io_write(otg, flags, ULPI_IFC_CTRL);
+}
+
+static int ulpi_set_flags(struct otg_transceiver *otg)
+{
+	int ret;
+
+	ret = ulpi_set_otg_flags(otg);
+	if (ret)
+		return ret;
+
+	ret = ulpi_set_ic_flags(otg);
+	if (ret)
+		return ret;
+
+	return ulpi_set_fc_flags(otg);
+}
+
 static int ulpi_init(struct otg_transceiver *otg)
 {
 	int i, vid, pid, ret;
@@ -80,6 +161,31 @@ static int ulpi_init(struct otg_transceiver *otg)
 	return -ENODEV;
 }
 
+static int ulpi_set_host(struct otg_transceiver *otg, struct usb_bus *host)
+{
+	unsigned int flags = otg_io_read(otg, ULPI_IFC_CTRL);
+
+	if (!host) {
+		otg->host = NULL;
+		return 0;
+	}
+
+	otg->host = host;
+
+	flags &= ~(ULPI_IFC_CTRL_6_PIN_SERIAL_MODE |
+		   ULPI_IFC_CTRL_3_PIN_SERIAL_MODE |
+		   ULPI_IFC_CTRL_CARKITMODE);
+
+	if (otg->flags & ULPI_IC_6PIN_SERIAL)
+		flags |= ULPI_IFC_CTRL_6_PIN_SERIAL_MODE;
+	else if (otg->flags & ULPI_IC_3PIN_SERIAL)
+		flags |= ULPI_IFC_CTRL_3_PIN_SERIAL_MODE;
+	else if (otg->flags & ULPI_IC_CARKIT)
+		flags |= ULPI_IFC_CTRL_CARKITMODE;
+
+	return otg_io_write(otg, flags, ULPI_IFC_CTRL);
+}
+
 static int ulpi_set_vbus(struct otg_transceiver *otg, bool on)
 {
 	unsigned int flags = otg_io_read(otg, ULPI_OTG_CTRL);
@@ -87,10 +193,10 @@ static int ulpi_set_vbus(struct otg_transceiver *otg, bool on)
 	flags &= ~(ULPI_OTG_CTRL_DRVVBUS | ULPI_OTG_CTRL_DRVVBUS_EXT);
 
 	if (on) {
-		if (otg->flags & USB_OTG_DRV_VBUS)
+		if (otg->flags & ULPI_OTG_DRVVBUS)
 			flags |= ULPI_OTG_CTRL_DRVVBUS;
 
-		if (otg->flags & USB_OTG_DRV_VBUS_EXT)
+		if (otg->flags & ULPI_OTG_DRVVBUS_EXT)
 			flags |= ULPI_OTG_CTRL_DRVVBUS_EXT;
 	}
 
@@ -111,6 +217,7 @@ otg_ulpi_create(struct otg_io_access_ops *ops,
 	otg->flags	= flags;
 	otg->io_ops	= ops;
 	otg->init	= ulpi_init;
+	otg->set_host	= ulpi_set_host;
 	otg->set_vbus	= ulpi_set_vbus;
 
 	return otg;
diff --git a/include/linux/usb/otg.h b/include/linux/usb/otg.h
index f8302d0..3dfc3b7 100644
--- a/include/linux/usb/otg.h
+++ b/include/linux/usb/otg.h
@@ -43,13 +43,6 @@ enum usb_xceiv_events {
 	USB_EVENT_ENUMERATED,   /* gadget driver enumerated */
 };
 
-#define USB_OTG_PULLUP_ID		(1 << 0)
-#define USB_OTG_PULLDOWN_DP		(1 << 1)
-#define USB_OTG_PULLDOWN_DM		(1 << 2)
-#define USB_OTG_EXT_VBUS_INDICATOR	(1 << 3)
-#define USB_OTG_DRV_VBUS		(1 << 4)
-#define USB_OTG_DRV_VBUS_EXT		(1 << 5)
-
 struct otg_transceiver;
 
 /* for transceivers connected thru an ULPI interface, the user must
diff --git a/include/linux/usb/ulpi.h b/include/linux/usb/ulpi.h
index 900d97b..82b1507 100644
--- a/include/linux/usb/ulpi.h
+++ b/include/linux/usb/ulpi.h
@@ -15,6 +15,41 @@
 /*-------------------------------------------------------------------------*/
 
 /*
+ * ULPI Flags
+ */
+#define ULPI_OTG_ID_PULLUP		(1 << 0)
+#define ULPI_OTG_DP_PULLDOWN_DIS	(1 << 1)
+#define ULPI_OTG_DM_PULLDOWN_DIS	(1 << 2)
+#define ULPI_OTG_DISCHRGVBUS		(1 << 3)
+#define ULPI_OTG_CHRGVBUS		(1 << 4)
+#define ULPI_OTG_DRVVBUS		(1 << 5)
+#define ULPI_OTG_DRVVBUS_EXT		(1 << 6)
+#define ULPI_OTG_EXTVBUSIND		(1 << 7)
+
+#define ULPI_IC_6PIN_SERIAL		(1 << 8)
+#define ULPI_IC_3PIN_SERIAL		(1 << 9)
+#define ULPI_IC_CARKIT			(1 << 10)
+#define ULPI_IC_CLKSUSPM		(1 << 11)
+#define ULPI_IC_AUTORESUME		(1 << 12)
+#define ULPI_IC_EXTVBUS_INDINV		(1 << 13)
+#define ULPI_IC_IND_PASSTHRU		(1 << 14)
+#define ULPI_IC_PROTECT_DIS		(1 << 15)
+
+#define ULPI_FC_HS			(1 << 16)
+#define ULPI_FC_FS			(1 << 17)
+#define ULPI_FC_LS			(1 << 18)
+#define ULPI_FC_FS4LS			(1 << 19)
+#define ULPI_FC_TERMSEL			(1 << 20)
+#define ULPI_FC_OP_NORM			(1 << 21)
+#define ULPI_FC_OP_NODRV		(1 << 22)
+#define ULPI_FC_OP_DIS_NRZI		(1 << 23)
+#define ULPI_FC_OP_NSYNC_NEOP		(1 << 24)
+#define ULPI_FC_RST			(1 << 25)
+#define ULPI_FC_SUSPM			(1 << 26)
+
+/*-------------------------------------------------------------------------*/
+
+/*
  * Macros for Set and Clear
  * See ULPI 1.1 specification to find the registers with Set and Clear offsets
  */
@@ -59,6 +94,10 @@
 
 /*-------------------------------------------------------------------------*/
 
+/*
+ * Register Bits
+ */
+
 /* Function Control */
 #define ULPI_FUNC_CTRL_XCVRSEL			(1 << 0)
 #define  ULPI_FUNC_CTRL_XCVRSEL_MASK		(3 << 0)
-- 
1.7.1
