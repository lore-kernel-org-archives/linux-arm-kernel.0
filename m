From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Wed, 19 Oct 2016 10:28:24 +0800
Subject: [PATCH v7, 5/8] usb: mtu3: Super-Speed Peripheral mode support
In-Reply-To: <1476844107-31087-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1476844107-31087-1-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <1476844107-31087-6-git-send-email-chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add super-speed funtion for peripheral mode

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3.h            |   13 ++-
 drivers/usb/mtu3/mtu3_core.c       |  202 ++++++++++++++++++++++++++++++++----
 drivers/usb/mtu3/mtu3_gadget.c     |   45 +++++---
 drivers/usb/mtu3/mtu3_gadget_ep0.c |   90 ++++++++++++++++
 drivers/usb/mtu3/mtu3_hw_regs.h    |   33 ++++++
 5 files changed, 346 insertions(+), 37 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3.h b/drivers/usb/mtu3/mtu3.h
index ad1a133..41a0473 100644
--- a/drivers/usb/mtu3/mtu3.h
+++ b/drivers/usb/mtu3/mtu3.h
@@ -53,6 +53,7 @@
 #define USB_QMU_TQSAR(epnum)	(U3D_TXQSAR1 + (((epnum) - 1) * 0x10))
 #define USB_QMU_TQCPR(epnum)	(U3D_TXQCPR1 + (((epnum) - 1) * 0x10))
 
+#define SSUSB_U3_CTRL(p)	(U3D_SSUSB_U3_CTRL_0P + ((p) * 0x08))
 #define SSUSB_U2_CTRL(p)	(U3D_SSUSB_U2_CTRL_0P + ((p) * 0x08))
 
 #define MTU3_DRIVER_NAME	"mtu3"
@@ -63,6 +64,7 @@
 #define MTU3_EP_WEDGE		BIT(2)
 #define MTU3_EP_BUSY		BIT(3)
 
+#define MTU3_U3_IP_SLOT_DEFAULT 2
 #define MTU3_U2_IP_SLOT_DEFAULT 1
 
 /**
@@ -87,6 +89,7 @@ enum mtu3_speed {
 	MTU3_SPEED_INACTIVE = 0,
 	MTU3_SPEED_FULL = 1,
 	MTU3_SPEED_HIGH = 3,
+	MTU3_SPEED_SUPER = 4,
 };
 
 /**
@@ -190,6 +193,7 @@ struct mtu3_ep {
 
 	struct list_head req_list;
 	struct mtu3_gpd_ring gpd_ring;
+	const struct usb_ss_ep_comp_descriptor *comp_desc;
 	const struct usb_endpoint_descriptor *desc;
 
 	int flags;
@@ -208,7 +212,8 @@ struct mtu3_request {
 
 /**
  * struct mtu3 - device driver instance data.
- * @slot: MTU3_U2_IP_SLOT_DEFAULT for U2 IP
+ * @slot: MTU3_U2_IP_SLOT_DEFAULT for U2 IP only,
+ *		MTU3_U3_IP_SLOT_DEFAULT for U3 IP
  * @may_wakeup: means device's remote wakeup is enabled
  * @is_self_powered: is reported in device status and the config descriptor
  * @ep0_req: dummy request used while handling standard USB requests
@@ -242,12 +247,16 @@ struct mtu3 {
 	struct usb_gadget_driver *gadget_driver;
 	struct mtu3_request ep0_req;
 	u8 setup_buf[EP0_RESPONSE_BUF];
+	u32 max_speed;
 
 	unsigned is_active:1;
 	unsigned may_wakeup:1;
 	unsigned is_self_powered:1;
 	unsigned test_mode:1;
 	unsigned softconnect:1;
+	unsigned u1_enable:1;
+	unsigned u2_enable:1;
+	unsigned is_u3_ip:1;
 
 	u8 address;
 	u8 test_mode_nr;
@@ -324,7 +333,7 @@ int mtu3_config_ep(struct mtu3 *mtu, struct mtu3_ep *mep,
 void mtu3_ep0_setup(struct mtu3 *mtu);
 void mtu3_start(struct mtu3 *mtu);
 void mtu3_stop(struct mtu3 *mtu);
-void mtu3_hs_softconn_set(struct mtu3 *mtu, bool enable);
+void mtu3_dev_on_off(struct mtu3 *mtu, int is_on);
 
 int mtu3_gadget_setup(struct mtu3 *mtu);
 void mtu3_gadget_cleanup(struct mtu3 *mtu);
diff --git a/drivers/usb/mtu3/mtu3_core.c b/drivers/usb/mtu3/mtu3_core.c
index 33d21dd..f9817ad 100644
--- a/drivers/usb/mtu3/mtu3_core.c
+++ b/drivers/usb/mtu3/mtu3_core.c
@@ -72,8 +72,20 @@ static void ep_fifo_free(struct mtu3_ep *mep)
 		__func__, mep->fifo_seg_size, mep->fifo_size, start_bit);
 }
 
+/* enable/disable U3D SS function */
+static inline void mtu3_ss_func_set(struct mtu3 *mtu, bool enable)
+{
+	/* If usb3_en==0, LTSSM will go to SS.Disable state */
+	if (enable)
+		mtu3_setbits(mtu->mac_base, U3D_USB3_CONFIG, USB3_EN);
+	else
+		mtu3_clrbits(mtu->mac_base, U3D_USB3_CONFIG, USB3_EN);
+
+	dev_dbg(mtu->dev, "USB3_EN = %d\n", !!enable);
+}
+
 /* set/clear U3D HS device soft connect */
-void mtu3_hs_softconn_set(struct mtu3 *mtu, bool enable)
+static inline void mtu3_hs_softconn_set(struct mtu3 *mtu, bool enable)
 {
 	if (enable) {
 		mtu3_setbits(mtu->mac_base, U3D_POWER_MANAGEMENT,
@@ -92,6 +104,13 @@ static int mtu3_device_enable(struct mtu3 *mtu)
 	u32 check_clk = 0;
 
 	mtu3_clrbits(ibase, U3D_SSUSB_IP_PW_CTRL2, SSUSB_IP_DEV_PDN);
+
+	if (mtu->is_u3_ip) {
+		check_clk = SSUSB_U3_MAC_RST_B_STS;
+		mtu3_clrbits(ibase, SSUSB_U3_CTRL(0),
+			(SSUSB_U3_PORT_DIS | SSUSB_U3_PORT_PDN |
+			SSUSB_U3_PORT_HOST_SEL));
+	}
 	mtu3_clrbits(ibase, SSUSB_U2_CTRL(0),
 		(SSUSB_U2_PORT_DIS | SSUSB_U2_PORT_PDN |
 		SSUSB_U2_PORT_HOST_SEL));
@@ -104,6 +123,10 @@ static void mtu3_device_disable(struct mtu3 *mtu)
 {
 	void __iomem *ibase = mtu->ippc_base;
 
+	if (mtu->is_u3_ip)
+		mtu3_setbits(ibase, SSUSB_U3_CTRL(0),
+			(SSUSB_U3_PORT_DIS | SSUSB_U3_PORT_PDN));
+
 	mtu3_setbits(ibase, SSUSB_U2_CTRL(0),
 		SSUSB_U2_PORT_DIS | SSUSB_U2_PORT_PDN);
 	mtu3_clrbits(ibase, SSUSB_U2_CTRL(0), SSUSB_U2_PORT_OTG_SEL);
@@ -142,6 +165,9 @@ static void mtu3_intr_status_clear(struct mtu3 *mtu)
 	/* Clear U2 USB common interrupts status */
 	mtu3_writel(mbase, U3D_COMMON_USB_INTR, ~0x0);
 
+	/* Clear U3 LTSSM interrupts status */
+	mtu3_writel(mbase, U3D_LTSSM_INTR, ~0x0);
+
 	/* Clear speed change interrupt status */
 	mtu3_writel(mbase, U3D_DEV_LINK_INTR, ~0x0);
 }
@@ -153,13 +179,20 @@ static void mtu3_intr_enable(struct mtu3 *mtu)
 	u32 value;
 
 	/*Enable level 1 interrupts (BMU, QMU, MAC3, DMA, MAC2, EPCTL) */
-	value = BMU_INTR | QMU_INTR | MAC2_INTR | EP_CTRL_INTR;
+	value = BMU_INTR | QMU_INTR | MAC3_INTR | MAC2_INTR | EP_CTRL_INTR;
 	mtu3_writel(mbase, U3D_LV1IESR, value);
 
 	/* Enable U2 common USB interrupts */
 	value = SUSPEND_INTR | RESUME_INTR | RESET_INTR;
 	mtu3_writel(mbase, U3D_COMMON_USB_INTR_ENABLE, value);
 
+	if (mtu->is_u3_ip) {
+		/* Enable U3 LTSSM interrupts */
+		value = HOT_RST_INTR | WARM_RST_INTR | VBUS_RISE_INTR |
+		    VBUS_FALL_INTR | ENTER_U3_INTR | EXIT_U3_INTR;
+		mtu3_writel(mbase, U3D_LTSSM_INTR_ENABLE, value);
+	}
+
 	/* Enable QMU interrupts. */
 	value = TXQ_CSERR_INT | TXQ_LENERR_INT | RXQ_CSERR_INT |
 			RXQ_LENERR_INT | RXQ_ZLPERR_INT;
@@ -205,6 +238,17 @@ void mtu3_ep_stall_set(struct mtu3_ep *mep, bool set)
 		set ? "SEND STALL" : "CLEAR STALL, with EP RESET");
 }
 
+void mtu3_dev_on_off(struct mtu3 *mtu, int is_on)
+{
+	if (mtu->is_u3_ip && (mtu->max_speed == USB_SPEED_SUPER))
+		mtu3_ss_func_set(mtu, is_on);
+	else
+		mtu3_hs_softconn_set(mtu, is_on);
+
+	dev_info(mtu->dev, "gadget (%s) pullup D%s\n",
+		usb_speed_string(mtu->max_speed), is_on ? "+" : "-");
+}
+
 void mtu3_start(struct mtu3 *mtu)
 {
 	void __iomem *mbase = mtu->mac_base;
@@ -214,13 +258,21 @@ void mtu3_start(struct mtu3 *mtu)
 
 	mtu3_clrbits(mtu->ippc_base, U3D_SSUSB_IP_PW_CTRL2, SSUSB_IP_DEV_PDN);
 
+	/*
+	 * When disable U2 port, USB2_CSR's register will be reset to
+	 * default value after re-enable it again(HS is enabled by default).
+	 * So if force mac to work as FS, disable HS function.
+	 */
+	if (mtu->max_speed == USB_SPEED_FULL)
+		mtu3_clrbits(mbase, U3D_POWER_MANAGEMENT, HS_ENABLE);
+
 	/* Initialize the default interrupts */
 	mtu3_intr_enable(mtu);
 
 	mtu->is_active = 1;
 
 	if (mtu->softconnect)
-		mtu3_hs_softconn_set(mtu, 1);
+		mtu3_dev_on_off(mtu, 1);
 }
 
 void mtu3_stop(struct mtu3 *mtu)
@@ -231,7 +283,7 @@ void mtu3_stop(struct mtu3 *mtu)
 	mtu3_intr_status_clear(mtu);
 
 	if (mtu->softconnect)
-		mtu3_hs_softconn_set(mtu, 0);
+		mtu3_dev_on_off(mtu, 0);
 
 	mtu->is_active = 0;
 	mtu3_setbits(mtu->ippc_base, U3D_SSUSB_IP_PW_CTRL2, SSUSB_IP_DEV_PDN);
@@ -362,7 +414,10 @@ void mtu3_deconfig_ep(struct mtu3 *mtu, struct mtu3_ep *mep)
 }
 
 /*
- * 1. when supports only HS, the fifo is shared for all EPs, and
+ * Two scenarios:
+ * 1. when device IP supports SS, the fifo of EP0, TX EPs, RX EPs
+ *	are separated;
+ * 2. when supports only HS, the fifo is shared for all EPs, and
  *	the capability registers of @EPNTXFFSZ or @EPNRXFFSZ indicate
  *	the total fifo size of non-ep0, and ep0's is fixed to 64B,
  *	so the total fifo size is 64B + @EPNTXFFSZ;
@@ -376,18 +431,33 @@ static void get_ep_fifo_config(struct mtu3 *mtu)
 	struct mtu3_fifo_info *rx_fifo;
 	u32 fifosize;
 
-	fifosize = mtu3_readl(mtu->mac_base, U3D_CAP_EPNTXFFSZ);
-	tx_fifo = &mtu->tx_fifo;
-	tx_fifo->base = MTU3_U2_IP_EP0_FIFO_SIZE;
-	tx_fifo->limit = (fifosize / MTU3_EP_FIFO_UNIT) >> 1;
-	bitmap_zero(tx_fifo->bitmap, MTU3_FIFO_BIT_SIZE);
-
-	rx_fifo = &mtu->rx_fifo;
-	rx_fifo->base =
-		tx_fifo->base + tx_fifo->limit * MTU3_EP_FIFO_UNIT;
-	rx_fifo->limit = tx_fifo->limit;
-	bitmap_zero(rx_fifo->bitmap, MTU3_FIFO_BIT_SIZE);
-	mtu->slot = MTU3_U2_IP_SLOT_DEFAULT;
+	if (mtu->is_u3_ip) {
+		fifosize = mtu3_readl(mtu->mac_base, U3D_CAP_EPNTXFFSZ);
+		tx_fifo = &mtu->tx_fifo;
+		tx_fifo->base = 0;
+		tx_fifo->limit = fifosize / MTU3_EP_FIFO_UNIT;
+		bitmap_zero(tx_fifo->bitmap, MTU3_FIFO_BIT_SIZE);
+
+		fifosize = mtu3_readl(mtu->mac_base, U3D_CAP_EPNRXFFSZ);
+		rx_fifo = &mtu->rx_fifo;
+		rx_fifo->base = 0;
+		rx_fifo->limit = fifosize / MTU3_EP_FIFO_UNIT;
+		bitmap_zero(rx_fifo->bitmap, MTU3_FIFO_BIT_SIZE);
+		mtu->slot = MTU3_U3_IP_SLOT_DEFAULT;
+	} else {
+		fifosize = mtu3_readl(mtu->mac_base, U3D_CAP_EPNTXFFSZ);
+		tx_fifo = &mtu->tx_fifo;
+		tx_fifo->base = MTU3_U2_IP_EP0_FIFO_SIZE;
+		tx_fifo->limit = (fifosize / MTU3_EP_FIFO_UNIT) >> 1;
+		bitmap_zero(tx_fifo->bitmap, MTU3_FIFO_BIT_SIZE);
+
+		rx_fifo = &mtu->rx_fifo;
+		rx_fifo->base =
+			tx_fifo->base + tx_fifo->limit * MTU3_EP_FIFO_UNIT;
+		rx_fifo->limit = tx_fifo->limit;
+		bitmap_zero(rx_fifo->bitmap, MTU3_FIFO_BIT_SIZE);
+		mtu->slot = MTU3_U2_IP_SLOT_DEFAULT;
+	}
 
 	dev_dbg(mtu->dev, "%s, TX: base-%d, limit-%d; RX: base-%d, limit-%d\n",
 		__func__, tx_fifo->base, tx_fifo->limit,
@@ -416,17 +486,21 @@ static int mtu3_mem_alloc(struct mtu3 *mtu)
 	void __iomem *mbase = mtu->mac_base;
 	struct mtu3_ep *ep_array;
 	int in_ep_num, out_ep_num;
-	u32 cap_epinfo;
+	u32 cap_epinfo, cap_dev;
 	int ret;
 	int i;
 
 	mtu->hw_version = mtu3_readl(mtu->ippc_base, U3D_SSUSB_HW_ID);
 
+	cap_dev = mtu3_readl(mtu->ippc_base, U3D_SSUSB_IP_DEV_CAP);
+	mtu->is_u3_ip = !!SSUSB_IP_DEV_U3_PORT_NUM(cap_dev);
+
 	cap_epinfo = mtu3_readl(mbase, U3D_CAP_EPINFO);
 	in_ep_num = CAP_TX_EP_NUM(cap_epinfo);
 	out_ep_num = CAP_RX_EP_NUM(cap_epinfo);
 
-	dev_info(mtu->dev, "IP version 0x%x\n", mtu->hw_version);
+	dev_info(mtu->dev, "IP version 0x%x(%s IP)\n", mtu->hw_version,
+		mtu->is_u3_ip ? "U3" : "U2");
 	dev_info(mtu->dev, "fifosz/epnum: Tx=%#x/%d, Rx=%#x/%d\n",
 		 mtu3_readl(mbase, U3D_CAP_EPNTXFFSZ), in_ep_num,
 		 mtu3_readl(mbase, U3D_CAP_EPNRXFFSZ), out_ep_num);
@@ -469,6 +543,27 @@ static void mtu3_mem_free(struct mtu3 *mtu)
 	kfree(mtu->ep_array);
 }
 
+static void mtu3_set_speed(struct mtu3 *mtu)
+{
+	void __iomem *mbase = mtu->mac_base;
+
+	if (!mtu->is_u3_ip && (mtu->max_speed > USB_SPEED_HIGH))
+		mtu->max_speed = USB_SPEED_HIGH;
+
+	if (mtu->max_speed == USB_SPEED_FULL) {
+		/* disable U3 SS function */
+		mtu3_clrbits(mbase, U3D_USB3_CONFIG, USB3_EN);
+		/* disable HS function */
+		mtu3_clrbits(mbase, U3D_POWER_MANAGEMENT, HS_ENABLE);
+	} else if (mtu->max_speed == USB_SPEED_HIGH) {
+		mtu3_clrbits(mbase, U3D_USB3_CONFIG, USB3_EN);
+		/* HS/FS detected by HW */
+		mtu3_setbits(mbase, U3D_POWER_MANAGEMENT, HS_ENABLE);
+	}
+	dev_info(mtu->dev, "max_speed: %s\n",
+		usb_speed_string(mtu->max_speed));
+}
+
 static void mtu3_regs_init(struct mtu3 *mtu)
 {
 
@@ -478,9 +573,16 @@ static void mtu3_regs_init(struct mtu3 *mtu)
 	mtu3_intr_disable(mtu);
 	mtu3_intr_status_clear(mtu);
 
-	mtu3_clrbits(mbase, U3D_USB3_CONFIG, USB3_EN);
-	/* HS/FS detected by HW */
-	mtu3_setbits(mbase, U3D_POWER_MANAGEMENT, HS_ENABLE);
+	if (mtu->is_u3_ip) {
+		/* disable LGO_U1/U2 by default */
+		mtu3_clrbits(mbase, U3D_LINK_POWER_CONTROL,
+				SW_U1_ACCEPT_ENABLE | SW_U2_ACCEPT_ENABLE |
+				SW_U1_REQUEST_ENABLE | SW_U2_REQUEST_ENABLE);
+		/* device responses to u3_exit from host automatically */
+		mtu3_clrbits(mbase, U3D_LTSSM_CTRL, SOFT_U3_EXIT_EN);
+	}
+
+	mtu3_set_speed(mtu);
 
 	/* delay about 0.1us from detecting reset to send chirp-K */
 	mtu3_clrbits(mbase, U3D_LINK_RESET_INFO, WTCHRP_MSK);
@@ -530,6 +632,10 @@ static irqreturn_t mtu3_link_isr(struct mtu3 *mtu)
 		mtu3_setbits(mbase, U3D_POWER_MANAGEMENT,
 				LPM_BESL_STALL | LPM_BESLD_STALL);
 		break;
+	case MTU3_SPEED_SUPER:
+		udev_speed = USB_SPEED_SUPER;
+		maxpkt = 512;
+		break;
 	default:
 		udev_speed = USB_SPEED_UNKNOWN;
 		break;
@@ -548,6 +654,34 @@ static irqreturn_t mtu3_link_isr(struct mtu3 *mtu)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t mtu3_u3_ltssm_isr(struct mtu3 *mtu)
+{
+	void __iomem *mbase = mtu->mac_base;
+	u32 ltssm;
+
+	ltssm = mtu3_readl(mbase, U3D_LTSSM_INTR);
+	ltssm &= mtu3_readl(mbase, U3D_LTSSM_INTR_ENABLE);
+	mtu3_writel(mbase, U3D_LTSSM_INTR, ltssm); /* W1C */
+	dev_dbg(mtu->dev, "=== LTSSM[%x] ===\n", ltssm);
+
+	if (ltssm & (HOT_RST_INTR | WARM_RST_INTR))
+		mtu3_gadget_reset(mtu);
+
+	if (ltssm & VBUS_FALL_INTR)
+		mtu3_ss_func_set(mtu, false);
+
+	if (ltssm & VBUS_RISE_INTR)
+		mtu3_ss_func_set(mtu, true);
+
+	if (ltssm & EXIT_U3_INTR)
+		mtu3_gadget_resume(mtu);
+
+	if (ltssm & ENTER_U3_INTR)
+		mtu3_gadget_suspend(mtu);
+
+	return IRQ_HANDLED;
+}
+
 static irqreturn_t mtu3_u2_common_isr(struct mtu3 *mtu)
 {
 	void __iomem *mbase = mtu->mac_base;
@@ -588,6 +722,9 @@ irqreturn_t mtu3_irq(int irq, void *data)
 	if (level1 & MAC2_INTR)
 		mtu3_u2_common_isr(mtu);
 
+	if (level1 & MAC3_INTR)
+		mtu3_u3_ltssm_isr(mtu);
+
 	if (level1 & BMU_INTR)
 		mtu3_ep0_isr(mtu);
 
@@ -633,6 +770,27 @@ int ssusb_gadget_init(struct mtu3 *mtu)
 	struct device *dev = mtu->dev;
 	int ret;
 
+	mtu->max_speed = usb_get_maximum_speed(dev);
+
+	/* check the max_speed parameter */
+	switch (mtu->max_speed) {
+	case USB_SPEED_FULL:
+	case USB_SPEED_HIGH:
+	case USB_SPEED_SUPER:
+		break;
+	default:
+		dev_err(dev, "invalid max_speed: %s\n",
+			usb_speed_string(mtu->max_speed));
+		/* fall through */
+	case USB_SPEED_UNKNOWN:
+		/* default as SS */
+		mtu->max_speed = USB_SPEED_SUPER;
+		break;
+	}
+
+	dev_dbg(dev, "mac_base=0x%p, ippc_base=0x%p\n",
+		mtu->mac_base, mtu->ippc_base);
+
 	ret = mtu3_hw_init(mtu);
 	if (ret) {
 		dev_err(dev, "mtu3 hw init failed:%d\n", ret);
diff --git a/drivers/usb/mtu3/mtu3_gadget.c b/drivers/usb/mtu3/mtu3_gadget.c
index 0e25e0f..84f3fe1 100644
--- a/drivers/usb/mtu3/mtu3_gadget.c
+++ b/drivers/usb/mtu3/mtu3_gadget.c
@@ -73,6 +73,7 @@ static void nuke(struct mtu3_ep *mep, const int status)
 static int mtu3_ep_enable(struct mtu3_ep *mep)
 {
 	const struct usb_endpoint_descriptor *desc;
+	const struct usb_ss_ep_comp_descriptor *comp_desc;
 	struct mtu3 *mtu = mep->mtu;
 	u32 interval = 0;
 	u32 mult = 0;
@@ -81,11 +82,24 @@ static int mtu3_ep_enable(struct mtu3_ep *mep)
 	int ret;
 
 	desc = mep->desc;
+	comp_desc = mep->comp_desc;
 	mep->type = usb_endpoint_type(desc);
 	max_packet = usb_endpoint_maxp(desc);
 	mep->maxp = max_packet & GENMASK(10, 0);
 
 	switch (mtu->g.speed) {
+	case USB_SPEED_SUPER:
+		if (usb_endpoint_xfer_int(desc) ||
+				usb_endpoint_xfer_isoc(desc)) {
+			interval = desc->bInterval;
+			interval = clamp_val(interval, 1, 16) - 1;
+			if (usb_endpoint_xfer_isoc(desc) && comp_desc)
+				mult = comp_desc->bmAttributes;
+		}
+		if (comp_desc)
+			burst = comp_desc->bMaxBurst;
+
+		break;
 	case USB_SPEED_HIGH:
 		if (usb_endpoint_xfer_isoc(desc) ||
 				usb_endpoint_xfer_int(desc)) {
@@ -103,6 +117,7 @@ static int mtu3_ep_enable(struct mtu3_ep *mep)
 
 	mep->ep.maxpacket = mep->maxp;
 	mep->ep.desc = desc;
+	mep->ep.comp_desc = comp_desc;
 
 	/* slot mainly affects bulk/isoc transfer, so ignore int */
 	mep->slot = usb_endpoint_xfer_int(desc) ? 0 : mtu->slot;
@@ -135,6 +150,7 @@ static int mtu3_ep_disable(struct mtu3_ep *mep)
 
 	mep->desc = NULL;
 	mep->ep.desc = NULL;
+	mep->comp_desc = NULL;
 	mep->type = 0;
 	mep->flags = 0;
 
@@ -178,6 +194,7 @@ static int mtu3_gadget_ep_enable(struct usb_ep *ep,
 
 	spin_lock_irqsave(&mtu->lock, flags);
 	mep->desc = desc;
+	mep->comp_desc = ep->comp_desc;
 
 	ret = mtu3_ep_enable(mep);
 	if (ret)
@@ -439,13 +456,15 @@ static int mtu3_gadget_wakeup(struct usb_gadget *gadget)
 		return  -EOPNOTSUPP;
 
 	spin_lock_irqsave(&mtu->lock, flags);
-
-	mtu3_setbits(mtu->mac_base, U3D_POWER_MANAGEMENT, RESUME);
-	spin_unlock_irqrestore(&mtu->lock, flags);
-	usleep_range(10000, 11000);
-	spin_lock_irqsave(&mtu->lock, flags);
-	mtu3_clrbits(mtu->mac_base, U3D_POWER_MANAGEMENT, RESUME);
-
+	if (mtu->g.speed == USB_SPEED_SUPER) {
+		mtu3_setbits(mtu->mac_base, U3D_LINK_POWER_CONTROL, UX_EXIT);
+	} else {
+		mtu3_setbits(mtu->mac_base, U3D_POWER_MANAGEMENT, RESUME);
+		spin_unlock_irqrestore(&mtu->lock, flags);
+		usleep_range(10000, 11000);
+		spin_lock_irqsave(&mtu->lock, flags);
+		mtu3_clrbits(mtu->mac_base, U3D_POWER_MANAGEMENT, RESUME);
+	}
 	spin_unlock_irqrestore(&mtu->lock, flags);
 	return 0;
 }
@@ -476,7 +495,7 @@ static int mtu3_gadget_pullup(struct usb_gadget *gadget, int is_on)
 		mtu->softconnect = is_on;
 	} else if (is_on != mtu->softconnect) {
 		mtu->softconnect = is_on;
-		mtu3_hs_softconn_set(mtu, is_on);
+		mtu3_dev_on_off(mtu, is_on);
 	}
 
 	spin_unlock_irqrestore(&mtu->lock, flags);
@@ -524,7 +543,7 @@ static void stop_activity(struct mtu3 *mtu)
 	/* deactivate the hardware */
 	if (mtu->softconnect) {
 		mtu->softconnect = 0;
-		mtu3_hs_softconn_set(mtu, 0);
+		mtu3_dev_on_off(mtu, 0);
 	}
 
 	/*
@@ -587,14 +606,14 @@ static void init_hw_ep(struct mtu3 *mtu, struct mtu3_ep *mep,
 	mep->ep.name = mep->name;
 	INIT_LIST_HEAD(&mep->ep.ep_list);
 
-	/* initialize maxpacket as HS */
+	/* initialize maxpacket as SS */
 	if (!epnum) {
-		usb_ep_set_maxpacket_limit(&mep->ep, 64);
+		usb_ep_set_maxpacket_limit(&mep->ep, 512);
 		mep->ep.caps.type_control = true;
 		mep->ep.ops = &mtu3_ep0_ops;
 		mtu->g.ep0 = &mep->ep;
 	} else {
-		usb_ep_set_maxpacket_limit(&mep->ep, 512);
+		usb_ep_set_maxpacket_limit(&mep->ep, 1024);
 		mep->ep.caps.type_iso = true;
 		mep->ep.caps.type_bulk = true;
 		mep->ep.caps.type_int = true;
@@ -637,7 +656,7 @@ int mtu3_gadget_setup(struct mtu3 *mtu)
 	int ret;
 
 	mtu->g.ops = &mtu3_gadget_ops;
-	mtu->g.max_speed = USB_SPEED_HIGH;
+	mtu->g.max_speed = mtu->max_speed;
 	mtu->g.speed = USB_SPEED_UNKNOWN;
 	mtu->g.sg_supported = 0;
 	mtu->g.name = MTU3_DRIVER_NAME;
diff --git a/drivers/usb/mtu3/mtu3_gadget_ep0.c b/drivers/usb/mtu3/mtu3_gadget_ep0.c
index 4e2c2bab..2d7427b 100644
--- a/drivers/usb/mtu3/mtu3_gadget_ep0.c
+++ b/drivers/usb/mtu3/mtu3_gadget_ep0.c
@@ -161,6 +161,41 @@ static void ep0_stall_set(struct mtu3_ep *mep0, bool set, u32 pktrdy)
 static void ep0_dummy_complete(struct usb_ep *ep, struct usb_request *req)
 {}
 
+static void ep0_set_sel_complete(struct usb_ep *ep, struct usb_request *req)
+{
+	struct mtu3_request *mreq;
+	struct mtu3 *mtu;
+	struct usb_set_sel_req sel;
+
+	memcpy(&sel, req->buf, sizeof(sel));
+
+	mreq = to_mtu3_request(req);
+	mtu = mreq->mtu;
+	dev_dbg(mtu->dev, "u1sel:%d, u1pel:%d, u2sel:%d, u2pel:%d\n",
+		sel.u1_sel, sel.u1_pel, sel.u2_sel, sel.u2_pel);
+}
+
+/* queue data stage to handle 6 byte SET_SEL request */
+static int ep0_set_sel(struct mtu3 *mtu, struct usb_ctrlrequest *setup)
+{
+	int ret;
+	u16 length = le16_to_cpu(setup->wLength);
+
+	if (unlikely(length != 6)) {
+		dev_err(mtu->dev, "%s wrong wLength:%d\n",
+			__func__, length);
+		return -EINVAL;
+	}
+
+	mtu->ep0_req.mep = mtu->ep0;
+	mtu->ep0_req.request.length = 6;
+	mtu->ep0_req.request.buf = mtu->setup_buf;
+	mtu->ep0_req.request.complete = ep0_set_sel_complete;
+	ret = ep0_queue(mtu->ep0, &mtu->ep0_req);
+
+	return ret < 0 ? ret : 1;
+}
+
 static int
 ep0_get_status(struct mtu3 *mtu, const struct usb_ctrlrequest *setup)
 {
@@ -174,6 +209,15 @@ static void ep0_dummy_complete(struct usb_ep *ep, struct usb_request *req)
 	case USB_RECIP_DEVICE:
 		result[0] = mtu->is_self_powered << USB_DEVICE_SELF_POWERED;
 		result[0] |= mtu->may_wakeup << USB_DEVICE_REMOTE_WAKEUP;
+		/* superspeed only */
+		if (mtu->g.speed == USB_SPEED_SUPER) {
+			result[0] |= mtu->u1_enable << USB_DEV_STAT_U1_ENABLED;
+			result[0] |= mtu->u2_enable << USB_DEV_STAT_U2_ENABLED;
+		}
+
+		dev_dbg(mtu->dev, "%s result=%x, U1=%x, U2=%x\n", __func__,
+			result[0], mtu->u1_enable, mtu->u2_enable);
+
 		break;
 	case USB_RECIP_INTERFACE:
 		break;
@@ -265,7 +309,9 @@ static int handle_test_mode(struct mtu3 *mtu, struct usb_ctrlrequest *setup)
 static int ep0_handle_feature_dev(struct mtu3 *mtu,
 		struct usb_ctrlrequest *setup, bool set)
 {
+	void __iomem *mbase = mtu->mac_base;
 	int handled = -EINVAL;
+	u32 lpc;
 
 	switch (le16_to_cpu(setup->wValue)) {
 	case USB_DEVICE_REMOTE_WAKEUP:
@@ -279,6 +325,36 @@ static int ep0_handle_feature_dev(struct mtu3 *mtu,
 
 		handled = handle_test_mode(mtu, setup);
 		break;
+	case USB_DEVICE_U1_ENABLE:
+		if (mtu->g.speed != USB_SPEED_SUPER ||
+			mtu->g.state != USB_STATE_CONFIGURED)
+			break;
+
+		lpc = mtu3_readl(mbase, U3D_LINK_POWER_CONTROL);
+		if (set)
+			lpc |= SW_U1_ACCEPT_ENABLE;
+		else
+			lpc &= ~SW_U1_ACCEPT_ENABLE;
+		mtu3_writel(mbase, U3D_LINK_POWER_CONTROL, lpc);
+
+		mtu->u1_enable = !!set;
+		handled = 1;
+		break;
+	case USB_DEVICE_U2_ENABLE:
+		if (mtu->g.speed != USB_SPEED_SUPER ||
+			mtu->g.state != USB_STATE_CONFIGURED)
+			break;
+
+		lpc = mtu3_readl(mbase, U3D_LINK_POWER_CONTROL);
+		if (set)
+			lpc |= SW_U2_ACCEPT_ENABLE;
+		else
+			lpc &= ~SW_U2_ACCEPT_ENABLE;
+		mtu3_writel(mbase, U3D_LINK_POWER_CONTROL, lpc);
+
+		mtu->u2_enable = !!set;
+		handled = 1;
+		break;
 	default:
 		handled = -EINVAL;
 		break;
@@ -303,6 +379,17 @@ static int ep0_handle_feature(struct mtu3 *mtu,
 	case USB_RECIP_DEVICE:
 		handled = ep0_handle_feature_dev(mtu, setup, set);
 		break;
+	case USB_RECIP_INTERFACE:
+		/* superspeed only */
+		if ((value == USB_INTRF_FUNC_SUSPEND)
+			&& (mtu->g.speed == USB_SPEED_SUPER)) {
+			/*
+			 * forward the request because function drivers
+			 * should handle it
+			 */
+			handled = 0;
+		}
+		break;
 	case USB_RECIP_ENDPOINT:
 		epnum = index & USB_ENDPOINT_NUMBER_MASK;
 		if (epnum == 0 || epnum >= mtu->num_eps ||
@@ -390,6 +477,9 @@ static int handle_standard_request(struct mtu3 *mtu,
 	case USB_REQ_GET_STATUS:
 		handled = ep0_get_status(mtu, setup);
 		break;
+	case USB_REQ_SET_SEL:
+		handled = ep0_set_sel(mtu, setup);
+		break;
 	case USB_REQ_SET_ISOCH_DELAY:
 		handled = 1;
 		break;
diff --git a/drivers/usb/mtu3/mtu3_hw_regs.h b/drivers/usb/mtu3/mtu3_hw_regs.h
index 08c83c5..2123672 100644
--- a/drivers/usb/mtu3/mtu3_hw_regs.h
+++ b/drivers/usb/mtu3/mtu3_hw_regs.h
@@ -260,13 +260,46 @@
 
 /*---------------- SSUSB_USB3_MAC_CSR REGISTER DEFINITION ----------------*/
 
+#define U3D_LTSSM_CTRL		(SSUSB_USB3_MAC_CSR_BASE + 0x0010)
 #define U3D_USB3_CONFIG		(SSUSB_USB3_MAC_CSR_BASE + 0x001C)
 
+#define U3D_LTSSM_INTR_ENABLE	(SSUSB_USB3_MAC_CSR_BASE + 0x013C)
+#define U3D_LTSSM_INTR		(SSUSB_USB3_MAC_CSR_BASE + 0x0140)
+
 /*---------------- SSUSB_USB3_MAC_CSR FIELD DEFINITION ----------------*/
 
+/* U3D_LTSSM_CTRL */
+#define FORCE_POLLING_FAIL	BIT(4)
+#define FORCE_RXDETECT_FAIL	BIT(3)
+#define SOFT_U3_EXIT_EN		BIT(2)
+#define COMPLIANCE_EN		BIT(1)
+#define U1_GO_U2_EN		BIT(0)
+
 /* U3D_USB3_CONFIG */
 #define USB3_EN			BIT(0)
 
+/* U3D_LTSSM_INTR_ENABLE */
+/* U3D_LTSSM_INTR */
+#define U3_RESUME_INTR		BIT(18)
+#define U3_LFPS_TMOUT_INTR	BIT(17)
+#define VBUS_FALL_INTR		BIT(16)
+#define VBUS_RISE_INTR		BIT(15)
+#define RXDET_SUCCESS_INTR	BIT(14)
+#define EXIT_U3_INTR		BIT(13)
+#define EXIT_U2_INTR		BIT(12)
+#define EXIT_U1_INTR		BIT(11)
+#define ENTER_U3_INTR		BIT(10)
+#define ENTER_U2_INTR		BIT(9)
+#define ENTER_U1_INTR		BIT(8)
+#define ENTER_U0_INTR		BIT(7)
+#define RECOVERY_INTR		BIT(6)
+#define WARM_RST_INTR		BIT(5)
+#define HOT_RST_INTR		BIT(4)
+#define LOOPBACK_INTR		BIT(3)
+#define COMPLIANCE_INTR		BIT(2)
+#define SS_DISABLE_INTR		BIT(1)
+#define SS_INACTIVE_INTR	BIT(0)
+
 /*---------------- SSUSB_USB3_SYS_CSR REGISTER DEFINITION ----------------*/
 
 #define U3D_LINK_UX_INACT_TIMER	(SSUSB_USB3_SYS_CSR_BASE + 0x020C)
-- 
1.7.9.5
