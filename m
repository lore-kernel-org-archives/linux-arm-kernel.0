From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 7 Oct 2015 20:17:31 +0100
Subject: [PATCH 10/12] drm: bridge/dw_hdmi: fix phy enable/disable handling
In-Reply-To: <5614F68B.6050808@rock-chips.com>
References: <20150808160251.GM7557@n2100.arm.linux.org.uk>
 <E1ZO6bT-0002vk-3d@rmk-PC.arm.linux.org.uk>
 <56149A11.4070102@rock-chips.com>
 <20151007094831.GF21513@n2100.arm.linux.org.uk>
 <5614F68B.6050808@rock-chips.com>
Message-ID: <20151007191731.GA32064@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 07, 2015 at 06:40:11PM +0800, Yakir Yang wrote:
> 
> 
> On 10/07/2015 05:48 PM, Russell King - ARM Linux wrote:
> >On Wed, Oct 07, 2015 at 12:05:37PM +0800, Yakir Yang wrote:
> >>
> >>On 08/09/2015 12:04 AM, Russell King wrote:
> >>>The dw_hdmi enable/disable handling is particularly weak in several
> >>>regards:
> >>>* The hotplug interrupt could call hdmi_poweron() or hdmi_poweroff()
> >>>   while DRM is setting a mode, which could race with a mode being set.
> >>>* Hotplug will always re-enable the phy whenever it detects an active
> >>>   hotplug signal, even if DRM has disabled the output.
> >>>
> >>>Resolve all of these by introducing a mutex to prevent races, and a
> >>>state-tracking bool so we know whether DRM wishes the output to be
> >>>enabled.  We choose to use our own mutex rather than ->struct_mutex
> >>>so that we can still process interrupts in a timely fashion.
> >>>
> >>>Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> >>>---
> >>>  drivers/gpu/drm/bridge/dw_hdmi.c | 29 ++++++++++++++++++++++-------
> >>>  1 file changed, 22 insertions(+), 7 deletions(-)
> >>>
> >>>diff --git a/drivers/gpu/drm/bridge/dw_hdmi.c b/drivers/gpu/drm/bridge/dw_hdmi.c
> >>>index 7b8a4e942a71..0ee188930d26 100644
> >>>--- a/drivers/gpu/drm/bridge/dw_hdmi.c
> >>>+++ b/drivers/gpu/drm/bridge/dw_hdmi.c
> >>>@@ -125,6 +125,9 @@ struct dw_hdmi {
> >>>  	bool sink_is_hdmi;
> >>>  	bool sink_has_audio;
> >>>+	struct mutex mutex;		/* for state below and previous_mode */
> >>>+	bool disabled;			/* DRM has disabled our bridge */
> >>>+
> >>>  	spinlock_t audio_lock;
> >>>  	struct mutex audio_mutex;
> >>>  	unsigned int sample_rate;
> >>>@@ -1389,8 +1392,12 @@ static void dw_hdmi_bridge_mode_set(struct drm_bridge *bridge,
> >>>  {
> >>>  	struct dw_hdmi *hdmi = bridge->driver_private;
> >>>+	mutex_lock(&hdmi->mutex);
> >>>+
> >>>  	/* Store the display mode for plugin/DKMS poweron events */
> >>>  	memcpy(&hdmi->previous_mode, mode, sizeof(hdmi->previous_mode));
> >>>+
> >>>+	mutex_unlock(&hdmi->mutex);
> >>>  }
> >>>  static bool dw_hdmi_bridge_mode_fixup(struct drm_bridge *bridge,
> >>>@@ -1404,14 +1411,20 @@ static void dw_hdmi_bridge_disable(struct drm_bridge *bridge)
> >>>  {
> >>>  	struct dw_hdmi *hdmi = bridge->driver_private;
> >>>+	mutex_lock(&hdmi->mutex);
> >>>+	hdmi->disabled = true;
> >>>  	dw_hdmi_poweroff(hdmi);
> >>>+	mutex_unlock(&hdmi->mutex);
> >>>  }
> >>>  static void dw_hdmi_bridge_enable(struct drm_bridge *bridge)
> >>>  {
> >>>  	struct dw_hdmi *hdmi = bridge->driver_private;
> >>>+	mutex_lock(&hdmi->mutex);
> >>>  	dw_hdmi_poweron(hdmi);
> >>>+	hdmi->disabled = false;
> >>>+	mutex_unlock(&hdmi->mutex);
> >>>  }
> >>>  static void dw_hdmi_bridge_nop(struct drm_bridge *bridge)
> >>>@@ -1534,20 +1547,20 @@ static irqreturn_t dw_hdmi_irq(int irq, void *dev_id)
> >>>  	phy_int_pol = hdmi_readb(hdmi, HDMI_PHY_POL0);
> >>>  	if (intr_stat & HDMI_IH_PHY_STAT0_HPD) {
> >>>+		hdmi_modb(hdmi, ~phy_int_pol, HDMI_PHY_HPD, HDMI_PHY_POL0);
> >>>+		mutex_lock(&hdmi->mutex);
> >>>  		if (phy_int_pol & HDMI_PHY_HPD) {
> >>>  			dev_dbg(hdmi->dev, "EVENT=plugin\n");
> >>>-			hdmi_modb(hdmi, 0, HDMI_PHY_HPD, HDMI_PHY_POL0);
> >>>-
> >>>-			dw_hdmi_poweron(hdmi);
> >>>+			if (!hdmi->disabled)
> >>>+				dw_hdmi_poweron(hdmi);
> >>>  		} else {
> >>>  			dev_dbg(hdmi->dev, "EVENT=plugout\n");
> >>>-			hdmi_modb(hdmi, HDMI_PHY_HPD, HDMI_PHY_HPD,
> >>>-				  HDMI_PHY_POL0);
> >>>-
> >>>-			dw_hdmi_poweroff(hdmi);
> >>>+			if (!hdmi->disabled)
> >>>+				dw_hdmi_poweroff(hdmi);
> >>Just like my reply on 08/12, I thought this could be removed, so
> >>poweron/poweroff would only be called with bridge->enable/
> >>bridge->disable, them maybe no need mutex here.
> >The bridge enable/disable methods do not get called on hotplug changes.
> >
> >[    1.363011] dwhdmi-imx 120000.hdmi: Detected HDMI controller 0x13:0xa:0xa0:0xc1
> >[    1.371341] dwhdmi-imx 120000.hdmi: dw_hdmi_irq(I:RX----,HPD P:RX3210,HPD S:RX----,HPD)
> >[    1.381345] imx-drm display-subsystem: bound 120000.hdmi (ops dw_hdmi_imx_ops)
> >[    1.448691] dwhdmi-imx 120000.hdmi: dw_hdmi_bridge_disable()
> >[    1.450963] dwhdmi-imx 120000.hdmi: dw_hdmi_bridge_enable()
> >
> >and then unplugging and re-plugging the HDMI cable:
> >
> >[   68.307505] dwhdmi-imx 120000.hdmi: dw_hdmi_irq(I:RX----,HPD P:RX3210,--- S:RX----,---)
> >[   73.813970] dwhdmi-imx 120000.hdmi: dw_hdmi_irq(I:RX----,HPD P:RX3210,HPD S:RX----,HPD)
> >
> >As you can see, during the period of disconnection for five seconds,
> >dw_hdmi_bridge_disable() was not called.
> >
> >So, without the code above, we'd be needlessly wasting power with the
> >bridge enabled, trying to drive a disconnected display.
> 
> Strangely, I do see bridge enable/disable in my side, past the log and
> dump_stack bellow.
> 
> And I guess your HDMI maybe not really hot pluged, could you confirm that
> the "status" of HDMI display card have been changed between "connected"
> and "disconnected".

It does.

> Do see bridge_disable when I unpluging the HDMI cable
> [   16.358717] dwhdmi-rockchip ff980000.hdmi: EVENT=plugout
> [   20.613221] [<c010e030>] (unwind_backtrace) from [<c010a4e0>]
> (show_stack+0x20/0x24)
> [   20.631561] [<c010a4e0>] (show_stack) from [<c0896828>]
> (dump_stack+0x70/0x8c)
> [   20.649337] [<c0896828>] (dump_stack) from [<c0414038>]
> (dw_hdmi_bridge_disable+0x1c/0x88)
> [   20.668178] [<c0414038>] (dw_hdmi_bridge_disable) from [<c03e3888>]
> (drm_encoder_disable+0x34/0x78)
> [   20.687857] [<c03e3888>] (drm_encoder_disable) from [<c03e3b1c>]
> (__drm_helper_disable_unused_functions+0x68/0xe4)
> [   20.708975] [<c03e3b1c>] (__drm_helper_disable_unused_functions) from
> [<c03e4320>] (drm_crtc_helper_set_config+0x128/0x85c)
> [   20.731180] [<c03e4320>] (drm_crtc_helper_set_config) from [<c03f5e3c>]
> (drm_mode_set_config_internal+0x58/0xdc)
> [   20.752507] [<c03f5e3c>] (drm_mode_set_config_internal) from [<c0405ed0>]
> (commit_crtc_state+0x124/0x1ec)
> [   20.773342] [<c0405ed0>] (commit_crtc_state) from [<c04055d4>]
> (atomic_commit.isra.3+0x5c/0xc8)
> [   20.793397] [<c04055d4>] (atomic_commit.isra.3) from [<c040565c>]
> (drm_atomic_commit+0x1c/0x20)
> [   20.813467] [<c040565c>] (drm_atomic_commit) from [<c03fa480>]
> (drm_mode_setcrtc+0x324/0x3e4)
> [   20.833379] [<c03fa480>] (drm_mode_setcrtc) from [<c03eb320>]
> (drm_ioctl+0x304/0x478)
> [   20.852557] [<c03eb320>] (drm_ioctl) from [<c021f024>]
> (do_vfs_ioctl+0x494/0x5a8)
> [   20.871377] [<c021f024>] (do_vfs_ioctl) from [<c021f194>]
> (SyS_ioctl+0x5c/0x84)
> [   20.890038] [<c021f194>] (SyS_ioctl) from [<c010646c>]
> (__sys_trace_return+0x0/0x14)

Your userspace is issuing an ioctl to disable the output.  I guess you
have other active outputs besides HDMI.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
