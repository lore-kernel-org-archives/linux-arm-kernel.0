From: b-liu@ti.com (Bin Liu)
Date: Wed, 21 Sep 2016 21:28:54 -0500
Subject: [PATCH 1/2] phy-sun4i-usb: Add sun4i_usb_phy_force_session_end()
 function
In-Reply-To: <54119844-ce99-bf8c-fc6e-09bcc7523e4d@redhat.com>
References: <20160918165018.24547-1-hdegoede@redhat.com>
 <57E0BEDF.2020603@ti.com>
 <54119844-ce99-bf8c-fc6e-09bcc7523e4d@redhat.com>
Message-ID: <20160922022854.GD3981@uda0271908>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Sep 21, 2016 at 11:05:33AM +0300, Hans de Goede wrote:
> Hi,
> 
> On 09/20/2016 07:45 AM, Kishon Vijay Abraham I wrote:
> >Hi,
> >
> >On Sunday 18 September 2016 10:20 PM, Hans de Goede wrote:
> >>The sunxi musb has a bug where sometimes it will generate a babble
> >>error on device disconnect instead of a disconnect irq. When this
> >>happens the musb-controller switches from host mode to device mode
> >>(it clears MUSB_DEVCTL_SESSION and sets MUSB_DEVCTL_BDEVICE) and
> >>gets stuck in this state.
> >>
> >>Clearing this requires reporting Vbus low for 200 or more ms, but
> >>on some devices Vbus is simply always high (host-only mode, no Vbus
> >>control). The phy-sun4i-usb code already has code to force a session
> >>end for devices without Vbus control.
> >>
> >>This commit adds a sun4i_usb_phy_force_session_end() function exporting
> >>this functionality to the sunxi-musb glue, so that it can force a session
> >>end to fixup the stuck state after a babble error.
> >>
> >>Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >>---
> >> drivers/phy/phy-sun4i-usb.c       | 11 +++++++++++
> >> include/linux/phy/phy-sun4i-usb.h |  7 +++++++
> >> 2 files changed, 18 insertions(+)
> >>
> >>diff --git a/drivers/phy/phy-sun4i-usb.c b/drivers/phy/phy-sun4i-usb.c
> >>index 43c0d98..06f4e11a 100644
> >>--- a/drivers/phy/phy-sun4i-usb.c
> >>+++ b/drivers/phy/phy-sun4i-usb.c
> >>@@ -470,6 +470,17 @@ void sun4i_usb_phy_set_squelch_detect(struct phy *_phy, bool enabled)
> >> }
> >> EXPORT_SYMBOL_GPL(sun4i_usb_phy_set_squelch_detect);
> >>
> >>+void sun4i_usb_phy_force_session_end(struct phy *_phy)
> >>+{
> >>+	struct sun4i_usb_phy *phy = phy_get_drvdata(_phy);
> >>+	struct sun4i_usb_phy_data *data = to_sun4i_usb_phy_data(phy);
> >>+
> >>+	data->id_det = -1;
> >>+	data->force_session_end = true;
> >>+	queue_delayed_work(system_wq, &data->detect, 0);
> >>+}
> >>+EXPORT_SYMBOL_GPL(sun4i_usb_phy_force_session_end);
> >
> >Er.. one more export symbol :-(
> 
> Yes unfortunately we need one more to work around sunxi musb / phy bugs.

Instead, can you somehow reuse sun4i_usb_phy_set_mode()?

Regards,
-Bin.

> 
> >>+
> >> static const struct phy_ops sun4i_usb_phy_ops = {
> >> 	.init		= sun4i_usb_phy_init,
> >> 	.exit		= sun4i_usb_phy_exit,
> >>diff --git a/include/linux/phy/phy-sun4i-usb.h b/include/linux/phy/phy-sun4i-usb.h
> >>index 50aed92..3bb773f 100644
> >>--- a/include/linux/phy/phy-sun4i-usb.h
> >>+++ b/include/linux/phy/phy-sun4i-usb.h
> >>@@ -23,4 +23,11 @@
> >>  */
> >> void sun4i_usb_phy_set_squelch_detect(struct phy *phy, bool enabled);
> >>
> >>+/**
> >>+ * sun4i_usb_force_session_end() - Force the current session to end
> >>+ *				   by reporting VBus low for 200+ ms
> >>+ * @phy: reference to a sun4i usb phy
> >>+ */
> >>+void sun4i_usb_phy_force_session_end(struct phy *phy);
> >
> >Should we include a static inline function if sun4i phy is not defined?
> 
> No, we're also not doing that for the already exported
> sun4i_usb_phy_set_squelch_detect()
> 
> And it is not necessary since the only caller is drivers/usb/musb/sunxi.c,
> and drivers/usb/musb/Kconfig has:
> 
> config USB_MUSB_SUNXI
>         tristate "Allwinner (sunxi)"
>         depends on PHY_SUN4I_USB
> 
> Regards,
> 
> Hans
