From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 7 Oct 2015 10:48:32 +0100
Subject: [PATCH 10/12] drm: bridge/dw_hdmi: fix phy enable/disable handling
In-Reply-To: <56149A11.4070102@rock-chips.com>
References: <20150808160251.GM7557@n2100.arm.linux.org.uk>
 <E1ZO6bT-0002vk-3d@rmk-PC.arm.linux.org.uk>
 <56149A11.4070102@rock-chips.com>
Message-ID: <20151007094831.GF21513@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 07, 2015 at 12:05:37PM +0800, Yakir Yang wrote:
> 
> 
> On 08/09/2015 12:04 AM, Russell King wrote:
> >The dw_hdmi enable/disable handling is particularly weak in several
> >regards:
> >* The hotplug interrupt could call hdmi_poweron() or hdmi_poweroff()
> >   while DRM is setting a mode, which could race with a mode being set.
> >* Hotplug will always re-enable the phy whenever it detects an active
> >   hotplug signal, even if DRM has disabled the output.
> >
> >Resolve all of these by introducing a mutex to prevent races, and a
> >state-tracking bool so we know whether DRM wishes the output to be
> >enabled.  We choose to use our own mutex rather than ->struct_mutex
> >so that we can still process interrupts in a timely fashion.
> >
> >Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> >---
> >  drivers/gpu/drm/bridge/dw_hdmi.c | 29 ++++++++++++++++++++++-------
> >  1 file changed, 22 insertions(+), 7 deletions(-)
> >
> >diff --git a/drivers/gpu/drm/bridge/dw_hdmi.c b/drivers/gpu/drm/bridge/dw_hdmi.c
> >index 7b8a4e942a71..0ee188930d26 100644
> >--- a/drivers/gpu/drm/bridge/dw_hdmi.c
> >+++ b/drivers/gpu/drm/bridge/dw_hdmi.c
> >@@ -125,6 +125,9 @@ struct dw_hdmi {
> >  	bool sink_is_hdmi;
> >  	bool sink_has_audio;
> >+	struct mutex mutex;		/* for state below and previous_mode */
> >+	bool disabled;			/* DRM has disabled our bridge */
> >+
> >  	spinlock_t audio_lock;
> >  	struct mutex audio_mutex;
> >  	unsigned int sample_rate;
> >@@ -1389,8 +1392,12 @@ static void dw_hdmi_bridge_mode_set(struct drm_bridge *bridge,
> >  {
> >  	struct dw_hdmi *hdmi = bridge->driver_private;
> >+	mutex_lock(&hdmi->mutex);
> >+
> >  	/* Store the display mode for plugin/DKMS poweron events */
> >  	memcpy(&hdmi->previous_mode, mode, sizeof(hdmi->previous_mode));
> >+
> >+	mutex_unlock(&hdmi->mutex);
> >  }
> >  static bool dw_hdmi_bridge_mode_fixup(struct drm_bridge *bridge,
> >@@ -1404,14 +1411,20 @@ static void dw_hdmi_bridge_disable(struct drm_bridge *bridge)
> >  {
> >  	struct dw_hdmi *hdmi = bridge->driver_private;
> >+	mutex_lock(&hdmi->mutex);
> >+	hdmi->disabled = true;
> >  	dw_hdmi_poweroff(hdmi);
> >+	mutex_unlock(&hdmi->mutex);
> >  }
> >  static void dw_hdmi_bridge_enable(struct drm_bridge *bridge)
> >  {
> >  	struct dw_hdmi *hdmi = bridge->driver_private;
> >+	mutex_lock(&hdmi->mutex);
> >  	dw_hdmi_poweron(hdmi);
> >+	hdmi->disabled = false;
> >+	mutex_unlock(&hdmi->mutex);
> >  }
> >  static void dw_hdmi_bridge_nop(struct drm_bridge *bridge)
> >@@ -1534,20 +1547,20 @@ static irqreturn_t dw_hdmi_irq(int irq, void *dev_id)
> >  	phy_int_pol = hdmi_readb(hdmi, HDMI_PHY_POL0);
> >  	if (intr_stat & HDMI_IH_PHY_STAT0_HPD) {
> >+		hdmi_modb(hdmi, ~phy_int_pol, HDMI_PHY_HPD, HDMI_PHY_POL0);
> >+		mutex_lock(&hdmi->mutex);
> >  		if (phy_int_pol & HDMI_PHY_HPD) {
> >  			dev_dbg(hdmi->dev, "EVENT=plugin\n");
> >-			hdmi_modb(hdmi, 0, HDMI_PHY_HPD, HDMI_PHY_POL0);
> >-
> >-			dw_hdmi_poweron(hdmi);
> >+			if (!hdmi->disabled)
> >+				dw_hdmi_poweron(hdmi);
> >  		} else {
> >  			dev_dbg(hdmi->dev, "EVENT=plugout\n");
> >-			hdmi_modb(hdmi, HDMI_PHY_HPD, HDMI_PHY_HPD,
> >-				  HDMI_PHY_POL0);
> >-
> >-			dw_hdmi_poweroff(hdmi);
> >+			if (!hdmi->disabled)
> >+				dw_hdmi_poweroff(hdmi);
> 
> Just like my reply on 08/12, I thought this could be removed, so
> poweron/poweroff would only be called with bridge->enable/
> bridge->disable, them maybe no need mutex here.

The bridge enable/disable methods do not get called on hotplug changes.

[    1.363011] dwhdmi-imx 120000.hdmi: Detected HDMI controller 0x13:0xa:0xa0:0xc1
[    1.371341] dwhdmi-imx 120000.hdmi: dw_hdmi_irq(I:RX----,HPD P:RX3210,HPD S:RX----,HPD)
[    1.381345] imx-drm display-subsystem: bound 120000.hdmi (ops dw_hdmi_imx_ops)
[    1.448691] dwhdmi-imx 120000.hdmi: dw_hdmi_bridge_disable()
[    1.450963] dwhdmi-imx 120000.hdmi: dw_hdmi_bridge_enable()

and then unplugging and re-plugging the HDMI cable:

[   68.307505] dwhdmi-imx 120000.hdmi: dw_hdmi_irq(I:RX----,HPD P:RX3210,--- S:RX----,---)
[   73.813970] dwhdmi-imx 120000.hdmi: dw_hdmi_irq(I:RX----,HPD P:RX3210,HPD S:RX----,HPD)

As you can see, during the period of disconnection for five seconds,
dw_hdmi_bridge_disable() was not called.

So, without the code above, we'd be needlessly wasting power with the
bridge enabled, trying to drive a disconnected display.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
