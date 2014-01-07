From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 07 Jan 2014 17:29:55 +0100
Subject: [PATCH RFC 27/46] imx-drm: convert to componentised device support
In-Reply-To: <52CC1DA1.8030803@boundarydevices.com>
References: <20140102212528.GD7383@n2100.arm.linux.org.uk>
 <E1VypoB-0007FJ-PA@rmk-PC.arm.linux.org.uk>
 <1388767737.19394.32.camel@pizza.hi.pengutronix.de>
 <20140103170724.GT7383@n2100.arm.linux.org.uk>
 <1388770004.19394.42.camel@pizza.hi.pengutronix.de>
 <52C70C1A.3090108@boundarydevices.com>
 <1389030088.5590.30.camel@pizza.hi.pengutronix.de>
 <20140106174606.GG27432@n2100.arm.linux.org.uk>
 <52CB6719.6040604@boundarydevices.com>
 <1389094187.4815.24.camel@pizza.hi.pengutronix.de>
 <52CC1DA1.8030803@boundarydevices.com>
Message-ID: <1389112195.4815.27.camel@pizza.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, den 07.01.2014, 08:30 -0700 schrieb Eric Nelson:
> Hi Philipp,
> 
> On 01/07/2014 04:29 AM, Philipp Zabel wrote:
> > Am Montag, den 06.01.2014, 19:31 -0700 schrieb Eric Nelson:
> >> Hi Russell,
> >>
> >> On 01/06/2014 10:46 AM, Russell King - ARM Linux wrote:
> >>> On Mon, Jan 06, 2014 at 06:41:28PM +0100, Philipp Zabel wrote:
> >>>> Hi Eric,
> >>>>
> >>>> Am Freitag, den 03.01.2014, 12:14 -0700 schrieb Eric Nelson:
> >>>>> This is an issue we've seen before. The SABRE Lite board has
> >>>>> a voltage divider on the HPD pins and some monitors (esp. DVI
> >>>>> monitors) either don't drive things high enough to assert HPD or
> >>>>> bounce with connect/disconnect.
> >>>>
> >>>> Yes, I used a DVI monitor.
> >>>>
> >>>>> We've instrumented our 3.0.35 kernels to use the RX_SENSE bits
> >>>>> instead.
> >>>>
> >>>> Reacting to RX_SENSE0 instead of HPD seems to work.
> >>>
> >>> However, it's non-compliant, because HPD can be lowered and raised by
> >>> the sink when it changes its EDID data (eg, because you're connected
> >>> through a switch and the routing has been changed.)
> >>>
> >>> So, reacting to RX_SENSE0 instead of HPD has to be a work-around enabled
> >>> only for those boards which are broken in this regard.
> >>>
> >>
> >> I understand. We'll need to carry some patches for a while though,
> >> since there are lots of these boards in the wild.
> >
> > Could you point me to your changes? Maybe this could be added to
> > mainline as a quirk enabled by a device tree property on sabrelite only.
> >
> 
> We only have them for 3.0.35 at the moment.
> 
> Here's the patch to use RXSENSE instead of HPD
> 	https://github.com/boundarydevices/linux-imx6/commit/c0439e262bb6c23887d96466b2ab7916aa0488d9
> 
> A follow-up patch disables the disconnect detection entirely
> unless requested:
> 	https://github.com/boundarydevices/linux-imx6/commit/d9cd79d11ff9f7a7f89cbc94b68757b67cdfe5fc

Thanky you. This is what I came up with so far:

From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH 1/2] staging: imx-hdmi: use RX_SENSE0 for plug detection if
 HPD is unreliable

On some boards HPD might not reliably detect DVI monitors. Allow to use
RX_SENSE0 as a workaround.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/staging/imx-drm/imx-hdmi.c | 45 +++++++++++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/imx-drm/imx-hdmi.c b/drivers/staging/imx-drm/imx-hdmi.c
index 7779337..cc305f3 100644
--- a/drivers/staging/imx-drm/imx-hdmi.c
+++ b/drivers/staging/imx-drm/imx-hdmi.c
@@ -139,6 +139,7 @@ struct imx_hdmi {
 
 	struct regmap *regmap;
 	struct i2c_adapter *ddc;
+	bool hpd_unreliable;
 	void __iomem *regs;
 
 	unsigned int sample_rate;
@@ -1309,6 +1310,14 @@ static int imx_hdmi_setup(struct imx_hdmi *hdmi, struct drm_display_mode *mode)
 /* Wait until we are registered to enable interrupts */
 static int imx_hdmi_fb_registered(struct imx_hdmi *hdmi)
 {
+	int stat_bit = HDMI_IH_PHY_STAT0_HPD;
+	int mask_bits = ~HDMI_PHY_HPD;
+
+	if (hdmi->hpd_unreliable) {
+		stat_bit = HDMI_IH_PHY_STAT0_RX_SENSE0;
+		mask_bits = ~HDMI_PHY_RX_SENSE0;
+	}
+
 	hdmi_writeb(hdmi, HDMI_PHY_I2CM_INT_ADDR_DONE_POL,
 		    HDMI_PHY_I2CM_INT_ADDR);
 
@@ -1317,10 +1326,10 @@ static int imx_hdmi_fb_registered(struct imx_hdmi *hdmi)
 		    HDMI_PHY_I2CM_CTLINT_ADDR);
 
 	/* enable cable hot plug irq */
-	hdmi_writeb(hdmi, (u8)~HDMI_PHY_RX_SENSE0, HDMI_PHY_MASK0);
+	hdmi_writeb(hdmi, (u8)mask_bits, HDMI_PHY_MASK0);
 
 	/* Clear Hotplug interrupts */
-	hdmi_writeb(hdmi, HDMI_IH_PHY_STAT0_RX_SENSE0, HDMI_IH_PHY_STAT0);
+	hdmi_writeb(hdmi, stat_bit, HDMI_IH_PHY_STAT0);
 
 	return 0;
 }
@@ -1524,25 +1533,32 @@ static irqreturn_t imx_hdmi_hardirq(int irq, void *dev_id)
 static irqreturn_t imx_hdmi_irq(int irq, void *dev_id)
 {
 	struct imx_hdmi *hdmi = dev_id;
+	int stat_bit = HDMI_IH_PHY_STAT0_HPD;
+	int pol_bit = HDMI_PHY_HPD;
 	u8 intr_stat;
 	u8 phy_int_pol;
 
+	if (hdmi->hpd_unreliable) {
+		stat_bit = HDMI_IH_PHY_STAT0_RX_SENSE0;
+		pol_bit = HDMI_PHY_RX_SENSE0;
+	}
+
 	intr_stat = hdmi_readb(hdmi, HDMI_IH_PHY_STAT0);
 
 	phy_int_pol = hdmi_readb(hdmi, HDMI_PHY_POL0);
 
-	if (intr_stat & HDMI_IH_PHY_STAT0_RX_SENSE0) {
-		if (phy_int_pol & HDMI_PHY_RX_SENSE0) {
+	if (intr_stat & stat_bit) {
+		if (phy_int_pol & pol_bit) {
 			dev_dbg(hdmi->dev, "EVENT=plugin\n");
 
-			hdmi_modb(hdmi, 0, HDMI_PHY_RX_SENSE0, HDMI_PHY_POL0);
+			hdmi_modb(hdmi, 0, pol_bit, HDMI_PHY_POL0);
 
 			hdmi->connector_status = connector_status_connected;
 			imx_hdmi_poweron(hdmi);
 		} else {
 			dev_dbg(hdmi->dev, "EVENT=plugout\n");
 
-			hdmi_modb(hdmi, HDMI_PHY_RX_SENSE0, HDMI_PHY_RX_SENSE0, HDMI_PHY_POL0);
+			hdmi_modb(hdmi, pol_bit, pol_bit, HDMI_PHY_POL0);
 
 			hdmi->connector_status = connector_status_disconnected;
 			imx_hdmi_poweroff(hdmi);
@@ -1551,7 +1567,7 @@ static irqreturn_t imx_hdmi_irq(int irq, void *dev_id)
 	}
 
 	hdmi_writeb(hdmi, intr_stat, HDMI_IH_PHY_STAT0);
-	hdmi_writeb(hdmi, ~HDMI_IH_PHY_STAT0_RX_SENSE0, HDMI_IH_MUTE_PHY_STAT0);
+	hdmi_writeb(hdmi, ~stat_bit, HDMI_IH_MUTE_PHY_STAT0);
 
 	return IRQ_HANDLED;
 }
@@ -1611,6 +1627,7 @@ static int imx_hdmi_bind(struct device *dev, struct device *master, void *data)
 	struct device_node *ddc_node;
 	struct imx_hdmi *hdmi;
 	struct resource *iores;
+	int pol_bit, stat_bit;
 	int ret, irq;
 
 	hdmi = devm_kzalloc(dev, sizeof(*hdmi), GFP_KERNEL);
@@ -1703,14 +1720,22 @@ static int imx_hdmi_bind(struct device *dev, struct device *master, void *data)
 	 */
 	hdmi_init_clk_regenerator(hdmi);
 
+	pol_bit = HDMI_PHY_HPD;
+	stat_bit =  HDMI_IH_PHY_STAT0_HPD;
+	hdmi->hpd_unreliable = of_property_read_bool(np, "hpd-unreliable");
+	if (hdmi->hpd_unreliable) {
+		pol_bit = HDMI_PHY_RX_SENSE0;
+		stat_bit =  HDMI_IH_PHY_STAT0_RX_SENSE0;
+	}
+
 	/*
 	 * Configure registers related to HDMI interrupt
 	 * generation before registering IRQ.
 	 */
-	hdmi_writeb(hdmi, HDMI_PHY_RX_SENSE0, HDMI_PHY_POL0);
+	hdmi_writeb(hdmi, pol_bit, HDMI_PHY_POL0);
 
 	/* Clear Hotplug interrupts */
-	hdmi_writeb(hdmi, HDMI_IH_PHY_STAT0_RX_SENSE0, HDMI_IH_PHY_STAT0);
+	hdmi_writeb(hdmi, stat_bit, HDMI_IH_PHY_STAT0);
 
 	ret = imx_hdmi_fb_registered(hdmi);
 	if (ret)
@@ -1721,7 +1746,7 @@ static int imx_hdmi_bind(struct device *dev, struct device *master, void *data)
 		goto err_iahb;
 
 	/* Unmute interrupts */
-	hdmi_writeb(hdmi, ~HDMI_IH_PHY_STAT0_RX_SENSE0, HDMI_IH_MUTE_PHY_STAT0);
+	hdmi_writeb(hdmi, ~stat_bit, HDMI_IH_MUTE_PHY_STAT0);
 
 	ret = snd_dw_hdmi_probe(&hdmi->audio, dev, hdmi->regs, irq, hdmi);
 	if (ret)
-- 
1.8.5.2

regards
Philipp
