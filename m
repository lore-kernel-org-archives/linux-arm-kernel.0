From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:48:27 +0100
Subject: [PATCH 166/222] imx-drm: dw-hdmi-cec: add HDMI CEC driver
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdecF-0007OT-Az@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a HDMI Consumer Electronics Control driver, making use of the
generic HDMI CEC driver to provide a common user API for these devices.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/staging/imx-drm/Kconfig       |   9 ++
 drivers/staging/imx-drm/Makefile      |   1 +
 drivers/staging/imx-drm/dw-hdmi-cec.c | 205 ++++++++++++++++++++++++++++++++++
 drivers/staging/imx-drm/dw-hdmi-cec.h |  16 +++
 drivers/staging/imx-drm/imx-hdmi.c    |  63 +++++++++--
 5 files changed, 284 insertions(+), 10 deletions(-)
 create mode 100644 drivers/staging/imx-drm/dw-hdmi-cec.c
 create mode 100644 drivers/staging/imx-drm/dw-hdmi-cec.h

diff --git a/drivers/staging/imx-drm/Kconfig b/drivers/staging/imx-drm/Kconfig
index 66ed3e5f132a..52516a7cf26f 100644
--- a/drivers/staging/imx-drm/Kconfig
+++ b/drivers/staging/imx-drm/Kconfig
@@ -69,3 +69,12 @@ config DRM_DW_HDMI_AUDIO
 	  Support the Audio interface which is part of the Synopsis
 	  Designware HDMI block.  This is used in conjunction with
 	  the i.MX HDMI driver.
+
+config DRM_DW_HDMI_CEC
+	tristate "Synopsis Designware CEC interface"
+	depends on DRM_IMX_HDMI != n
+	select HDMI_CEC_CORE
+	help
+	  Support the CEC interface which is part of the Synposis
+	  Designware HDMI block.  This is used in conjunction with
+	  the i.MX HDMI driver.
diff --git a/drivers/staging/imx-drm/Makefile b/drivers/staging/imx-drm/Makefile
index 34c8b9990a66..2295a6805d69 100644
--- a/drivers/staging/imx-drm/Makefile
+++ b/drivers/staging/imx-drm/Makefile
@@ -12,3 +12,4 @@ imx-ipuv3-crtc-objs  := ipuv3-crtc.o ipuv3-plane.o
 obj-$(CONFIG_DRM_IMX_IPUV3)	+= imx-ipuv3-crtc.o
 obj-$(CONFIG_DRM_IMX_HDMI) += imx-hdmi.o
 obj-$(CONFIG_DRM_DW_HDMI_AUDIO) += dw-hdmi-audio.o
+obj-$(CONFIG_DRM_DW_HDMI_CEC) += dw-hdmi-cec.o
diff --git a/drivers/staging/imx-drm/dw-hdmi-cec.c b/drivers/staging/imx-drm/dw-hdmi-cec.c
new file mode 100644
index 000000000000..c94b75aa037b
--- /dev/null
+++ b/drivers/staging/imx-drm/dw-hdmi-cec.c
@@ -0,0 +1,205 @@
+/* http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/tree/drivers/mxc/hdmi-cec/mxc_hdmi-cec.c?h=imx_3.0.35_4.1.0 */
+#include <linux/cec-dev.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+
+#include "imx-hdmi.h"
+#include "dw-hdmi-cec.h"
+
+#define DEV_NAME "mxc_hdmi_cec"
+
+enum {
+	CEC_STAT_DONE		= BIT(0),
+	CEC_STAT_EOM		= BIT(1),
+	CEC_STAT_NACK		= BIT(2),
+	CEC_STAT_ARBLOST	= BIT(3),
+	CEC_STAT_ERROR_INIT	= BIT(4),
+	CEC_STAT_ERROR_FOLL	= BIT(5),
+	CEC_STAT_WAKEUP		= BIT(6),
+
+	CEC_CTRL_START		= BIT(0),
+	CEC_CTRL_NORMAL		= 1 << 1,
+};
+
+struct dw_hdmi_cec {
+	struct cec_dev cec;
+
+	struct device *dev;
+	void __iomem *base;
+	const struct dw_hdmi_cec_ops *ops;
+	void *ops_data;
+	int irq;
+};
+
+static void dw_hdmi_set_address(struct cec_dev *cec_dev, unsigned addresses)
+{
+	struct dw_hdmi_cec *cec = container_of(cec_dev, struct dw_hdmi_cec, cec);
+
+	writeb(addresses & 255, cec->base + HDMI_CEC_ADDR_L);
+	writeb(addresses >> 8, cec->base + HDMI_CEC_ADDR_H);
+}
+
+static void dw_hdmi_send_message(struct cec_dev *cec_dev, u8 *msg,
+	size_t count)
+{
+	struct dw_hdmi_cec *cec = container_of(cec_dev, struct dw_hdmi_cec, cec);
+	unsigned i;
+
+	for (i = 0; i < count; i++)
+		writeb(msg[i], cec->base + HDMI_CEC_TX_DATA0 + i);
+
+	writeb(count, cec->base + HDMI_CEC_TX_CNT);
+	writeb(CEC_CTRL_NORMAL | CEC_CTRL_START, cec->base + HDMI_CEC_CTRL);
+}
+
+static irqreturn_t dw_hdmi_cec_irq(int irq, void *data)
+{
+	struct dw_hdmi_cec *cec = data;
+	struct cec_dev *cec_dev = &cec->cec;
+	unsigned stat = readb(cec->base + HDMI_IH_CEC_STAT0);
+
+	if (stat == 0)
+		return IRQ_NONE;
+
+	writeb(stat, cec->base + HDMI_IH_CEC_STAT0);
+
+	if (stat & CEC_STAT_ERROR_INIT) {
+		if (cec->cec.retries) {
+			unsigned v = readb(cec->base + HDMI_CEC_CTRL);
+			writeb(v | CEC_CTRL_START, cec->base + HDMI_CEC_CTRL);
+			cec->cec.retries -= 1;
+		} else {
+			cec->cec.write_busy = 0;
+			cec_dev_event(cec_dev, MESSAGE_TYPE_SEND_ERROR, NULL, 0);
+		}
+	} else if (stat & (CEC_STAT_DONE | CEC_STAT_NACK))
+		cec_dev_send_complete(cec_dev, stat & CEC_STAT_DONE);
+
+	if (stat & CEC_STAT_EOM) {
+		unsigned len, i;
+		u8 msg[MAX_MESSAGE_LEN];
+
+		len = readb(cec->base + HDMI_CEC_RX_CNT);
+		if (len > sizeof(msg))
+			len = sizeof(msg);
+
+		for (i = 0; i < len; i++)
+			msg[i] = readb(cec->base + HDMI_CEC_RX_DATA0 + i);
+
+		writeb(0, cec->base + HDMI_CEC_LOCK);
+
+		cec_dev_receive(cec_dev, msg, len);
+	}
+
+	return IRQ_HANDLED;
+}
+EXPORT_SYMBOL(dw_hdmi_cec_irq);
+
+static void dw_hdmi_cec_release(struct cec_dev *cec_dev)
+{
+	struct dw_hdmi_cec *cec = container_of(cec_dev, struct dw_hdmi_cec, cec);
+
+	writeb(~0, cec->base + HDMI_CEC_MASK);
+	writeb(~0, cec->base + HDMI_IH_MUTE_CEC_STAT0);
+	writeb(0, cec->base + HDMI_CEC_POLARITY);
+
+	free_irq(cec->irq, cec);
+
+	cec->ops->disable(cec->ops_data);
+}
+
+static int dw_hdmi_cec_open(struct cec_dev *cec_dev)
+{
+	struct dw_hdmi_cec *cec = container_of(cec_dev, struct dw_hdmi_cec, cec);
+	unsigned irqs;
+	int ret;
+
+	writeb(0, cec->base + HDMI_CEC_CTRL);
+	writeb(~0, cec->base + HDMI_IH_CEC_STAT0);
+	writeb(0, cec->base + HDMI_CEC_LOCK);
+
+	ret = request_irq(cec->irq, dw_hdmi_cec_irq, IRQF_SHARED,
+			  DEV_NAME, cec);
+	if (ret < 0)
+		return ret;
+
+	dw_hdmi_set_address(cec_dev, cec_dev->addresses);
+
+	cec->ops->enable(cec->ops_data);
+
+	irqs = CEC_STAT_ERROR_INIT | CEC_STAT_NACK | CEC_STAT_EOM |
+	       CEC_STAT_DONE;
+	writeb(irqs, cec->base + HDMI_CEC_POLARITY);
+	writeb(~irqs, cec->base + HDMI_CEC_MASK);
+	writeb(~irqs, cec->base + HDMI_IH_MUTE_CEC_STAT0);
+
+	return 0;
+}
+
+static int dw_hdmi_cec_probe(struct platform_device *pdev)
+{
+	struct dw_hdmi_cec_data *data = dev_get_platdata(&pdev->dev);
+	struct dw_hdmi_cec *cec;
+
+	if (!data)
+		return -ENXIO;
+
+	cec = devm_kzalloc(&pdev->dev, sizeof(*cec), GFP_KERNEL);
+	if (!cec)
+		return -ENOMEM;
+
+	cec->dev = &pdev->dev;
+	cec->base = data->base;
+	cec->irq = data->irq;
+	cec->ops = data->ops;
+	cec->ops_data = data->ops_data;
+	cec->cec.open = dw_hdmi_cec_open;
+	cec->cec.release = dw_hdmi_cec_release;
+	cec->cec.send_message = dw_hdmi_send_message;
+	cec->cec.set_address = dw_hdmi_set_address;
+
+	cec_dev_init(&cec->cec, THIS_MODULE);
+
+	/* FIXME: soft-reset the CEC interface */
+
+	dw_hdmi_set_address(&cec->cec, cec->cec.addresses);
+	writeb(0, cec->base + HDMI_CEC_TX_CNT);
+	writeb(~0, cec->base + HDMI_CEC_MASK);
+	writeb(~0, cec->base + HDMI_IH_MUTE_CEC_STAT0);
+	writeb(0, cec->base + HDMI_CEC_POLARITY);
+
+	/*
+	 * Our device is just a convenience - we want to link to the real
+	 * hardware device here, so that userspace can see the association
+	 * between the HDMI hardware and its associated CEC chardev.
+	 */
+	return cec_dev_add(&cec->cec, cec->dev->parent, DEV_NAME);
+}
+
+static int dw_hdmi_cec_remove(struct platform_device *pdev)
+{
+	struct dw_hdmi_cec *cec = platform_get_drvdata(pdev);
+
+	cec_dev_remove(&cec->cec);
+
+	return 0;
+}
+
+static struct platform_driver dw_hdmi_cec_driver = {
+	.probe	= dw_hdmi_cec_probe,
+	.remove	= dw_hdmi_cec_remove,
+	.driver = {
+		.name = "dw-hdmi-cec",
+		.owner = THIS_MODULE,
+	},
+};
+module_platform_driver(dw_hdmi_cec_driver);
+
+MODULE_AUTHOR("Russell King <rmk+kernel@arm.linux.org.uk>");
+MODULE_DESCRIPTION("Synopsis Designware HDMI CEC driver for i.MX");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS(PLATFORM_MODULE_PREFIX "dw-hdmi-cec");
diff --git a/drivers/staging/imx-drm/dw-hdmi-cec.h b/drivers/staging/imx-drm/dw-hdmi-cec.h
new file mode 100644
index 000000000000..5ff40cc237a8
--- /dev/null
+++ b/drivers/staging/imx-drm/dw-hdmi-cec.h
@@ -0,0 +1,16 @@
+#ifndef DW_HDMI_CEC_H
+#define DW_HDMI_CEC_H
+
+struct dw_hdmi_cec_ops {
+	void (*enable)(void *);
+	void (*disable)(void *);
+};
+
+struct dw_hdmi_cec_data {
+	void __iomem *base;
+	int irq;
+	const struct dw_hdmi_cec_ops *ops;
+	void *ops_data;
+};
+
+#endif
diff --git a/drivers/staging/imx-drm/imx-hdmi.c b/drivers/staging/imx-drm/imx-hdmi.c
index ac72649448a8..c3bd89d34d40 100644
--- a/drivers/staging/imx-drm/imx-hdmi.c
+++ b/drivers/staging/imx-drm/imx-hdmi.c
@@ -29,6 +29,7 @@
 #include <drm/drm_encoder_slave.h>
 
 #include "dw-hdmi-audio.h"
+#include "dw-hdmi-cec.h"
 #include "ipu-v3/imx-ipu-v3.h"
 #include "imx-hdmi.h"
 #include "imx-drm.h"
@@ -117,6 +118,7 @@ struct imx_hdmi {
 	struct drm_encoder encoder;
 
 	struct platform_device *audio;
+	struct platform_device *cec;
 	enum imx_hdmi_devtype dev_type;
 	struct device *dev;
 	struct clk *isfr_clk;
@@ -126,6 +128,7 @@ struct imx_hdmi {
 	int vic;
 
 	u8 edid[HDMI_EDID_LEN];
+	u8 mc_clkdis;
 	bool cable_plugin;
 
 	bool phy_enabled;
@@ -1154,8 +1157,6 @@ static void imx_hdmi_phy_disable(struct imx_hdmi *hdmi)
 /* HDMI Initialization Step B.4 */
 static void imx_hdmi_enable_video_path(struct imx_hdmi *hdmi)
 {
-	u8 clkdis;
-
 	/* control period minimum duration */
 	hdmi_writeb(hdmi, 12, HDMI_FC_CTRLDUR);
 	hdmi_writeb(hdmi, 32, HDMI_FC_EXCTRLDUR);
@@ -1167,23 +1168,28 @@ static void imx_hdmi_enable_video_path(struct imx_hdmi *hdmi)
 	hdmi_writeb(hdmi, 0x21, HDMI_FC_CH2PREAM);
 
 	/* Enable pixel clock and tmds data path */
-	clkdis = 0x7F;
-	clkdis &= ~HDMI_MC_CLKDIS_PIXELCLK_DISABLE;
-	hdmi_writeb(hdmi, clkdis, HDMI_MC_CLKDIS);
+	hdmi->mc_clkdis |= HDMI_MC_CLKDIS_HDCPCLK_DISABLE |
+			   HDMI_MC_CLKDIS_CSCCLK_DISABLE |
+			   HDMI_MC_CLKDIS_AUDCLK_DISABLE |
+			   HDMI_MC_CLKDIS_PREPCLK_DISABLE |
+			   HDMI_MC_CLKDIS_TMDSCLK_DISABLE;
+	hdmi->mc_clkdis &= ~HDMI_MC_CLKDIS_PIXELCLK_DISABLE;
+	hdmi_writeb(hdmi, hdmi->mc_clkdis, HDMI_MC_CLKDIS);
 
-	clkdis &= ~HDMI_MC_CLKDIS_TMDSCLK_DISABLE;
-	hdmi_writeb(hdmi, clkdis, HDMI_MC_CLKDIS);
+	hdmi->mc_clkdis &= ~HDMI_MC_CLKDIS_TMDSCLK_DISABLE;
+	hdmi_writeb(hdmi, hdmi->mc_clkdis, HDMI_MC_CLKDIS);
 
 	/* Enable csc path */
 	if (is_color_space_conversion(hdmi)) {
-		clkdis &= ~HDMI_MC_CLKDIS_CSCCLK_DISABLE;
-		hdmi_writeb(hdmi, clkdis, HDMI_MC_CLKDIS);
+		hdmi->mc_clkdis &= ~HDMI_MC_CLKDIS_CSCCLK_DISABLE;
+		hdmi_writeb(hdmi, hdmi->mc_clkdis, HDMI_MC_CLKDIS);
 	}
 }
 
 static void hdmi_enable_audio_clk(struct imx_hdmi *hdmi)
 {
-	hdmi_modb(hdmi, 0, HDMI_MC_CLKDIS_AUDCLK_DISABLE, HDMI_MC_CLKDIS);
+	hdmi->mc_clkdis &= ~HDMI_MC_CLKDIS_AUDCLK_DISABLE;
+	hdmi_writeb(hdmi, hdmi->mc_clkdis, HDMI_MC_CLKDIS);
 }
 
 /* Workaround to clear the overflow condition */
@@ -1579,6 +1585,27 @@ static int imx_hdmi_register(struct drm_device *drm, struct imx_hdmi *hdmi)
 	return 0;
 }
 
+static void imx_hdmi_cec_enable(void *data)
+{
+	struct imx_hdmi *hdmi = data;
+
+	hdmi->mc_clkdis &= ~HDMI_MC_CLKDIS_CECCLK_DISABLE;
+	hdmi_writeb(hdmi, hdmi->mc_clkdis, HDMI_MC_CLKDIS);
+}
+
+static void imx_hdmi_cec_disable(void *data)
+{
+	struct imx_hdmi *hdmi = data;
+
+	hdmi->mc_clkdis |= HDMI_MC_CLKDIS_CECCLK_DISABLE;
+	hdmi_writeb(hdmi, hdmi->mc_clkdis, HDMI_MC_CLKDIS);
+}
+
+static const struct dw_hdmi_cec_ops imx_hdmi_cec_ops = {
+	.enable = imx_hdmi_cec_enable,
+	.disable = imx_hdmi_cec_disable,
+};
+
 static struct platform_device_id imx_hdmi_devtype[] = {
 	{
 		.name = "imx6q-hdmi",
@@ -1607,6 +1634,7 @@ static int imx_hdmi_bind(struct device *dev, struct device *master, void *data)
 	struct device_node *np = dev->of_node;
 	struct device_node *ddc_node;
 	struct dw_hdmi_audio_data audio;
+	struct dw_hdmi_cec_data cec;
 	struct imx_hdmi *hdmi;
 	struct resource *iores;
 	int ret, irq;
@@ -1618,6 +1646,7 @@ static int imx_hdmi_bind(struct device *dev, struct device *master, void *data)
 	hdmi->dev = dev;
 	hdmi->sample_rate = 48000;
 	hdmi->ratio = 100;
+	hdmi->mc_clkdis = 0x7f;
 
 	if (of_id) {
 		const struct platform_device_id *device_id = of_id->data;
@@ -1737,6 +1766,18 @@ static int imx_hdmi_bind(struct device *dev, struct device *master, void *data)
 	pdevinfo.dma_mask = DMA_BIT_MASK(32);
 	hdmi->audio = platform_device_register_full(&pdevinfo);
 
+	cec.base = hdmi->regs;
+	cec.irq = irq;
+	cec.ops = &imx_hdmi_cec_ops;
+	cec.ops_data = hdmi;
+
+	pdevinfo.name = "dw-hdmi-cec";
+	pdevinfo.data = &cec;
+	pdevinfo.size_data = sizeof(cec);
+	pdevinfo.dma_mask = 0;
+
+	hdmi->cec = platform_device_register_full(&pdevinfo);
+
 	dev_set_drvdata(dev, hdmi);
 
 	return 0;
@@ -1756,6 +1797,8 @@ static void imx_hdmi_unbind(struct device *dev, struct device *master,
 
 	if (!IS_ERR(hdmi->audio))
 		platform_device_unregister(hdmi->audio);
+	if (!IS_ERR(hdmi->cec))
+		platform_device_unregister(hdmi->cec);
 
 	/* Disable all interrupts */
 	hdmi_writeb(hdmi, ~0, HDMI_IH_MUTE_PHY_STAT0);
-- 
1.8.3.1
