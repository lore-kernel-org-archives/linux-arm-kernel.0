From: phh@phh.me (Pierre-Hugues Husson)
Date: Sun, 5 Feb 2017 01:22:53 +0100
Subject: [RFCv2 PATCH 3/5] drm/bridge: dw_hdmi: add HDMI notifier support
In-Reply-To: <1479136968-24477-4-git-send-email-hverkuil@xs4all.nl>
References: <1479136968-24477-1-git-send-email-hverkuil@xs4all.nl>
 <1479136968-24477-4-git-send-email-hverkuil@xs4all.nl>
Message-ID: <CAJ-oXjTap_uVu0Ezm+L8JYc1gC2MZo4+ZRm25RbS16iE3pRrYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

2016-11-14 16:22 GMT+01:00 Hans Verkuil <hverkuil@xs4all.nl>:
> From: Russell King <rmk+kernel@arm.linux.org.uk>
>
> Add HDMI notifiers to the HDMI bridge driver.


> @@ -1448,9 +1450,11 @@ static int dw_hdmi_connector_get_modes(struct drm_connector *connector)
>                 hdmi->sink_is_hdmi = drm_detect_hdmi_monitor(edid);
>                 hdmi->sink_has_audio = drm_detect_monitor_audio(edid);
>                 drm_mode_connector_update_edid_property(connector, edid);
> +               hdmi_event_new_edid(hdmi->n, edid, 0);
Considering current hdmi-notifier code, the size must not be 0

Should this be done this way?
> hdmi_event_new_edid(hdmi->n, edid, (edid->extensions + 1) * EDID_LENGTH);

>                 ret = drm_add_edid_modes(connector, edid);
>                 /* Store the ELD */
>                 drm_edid_to_eld(connector, edid);
> +               hdmi_event_new_eld(hdmi->n, connector->eld);
>                 kfree(edid);
>         } else {
>                 dev_dbg(hdmi->dev, "failed to get edid\n");
> @@ -1579,6 +1583,12 @@ static irqreturn_t dw_hdmi_irq(int irq, void *dev_id)
>                         dw_hdmi_update_phy_mask(hdmi);
>                 }
>                 mutex_unlock(&hdmi->mutex);
> +
> +               if ((phy_stat & (HDMI_PHY_RX_SENSE | HDMI_PHY_HPD)) == 0)
> +                       hdmi_event_disconnect(hdmi->n);
> +               else if ((phy_stat & (HDMI_PHY_RX_SENSE | HDMI_PHY_HPD)) ==
> +                        (HDMI_IH_PHY_STAT0_RX_SENSE | HDMI_PHY_HPD))
> +                       hdmi_event_connect(hdmi->n);
On rk3288, I never get this event (connect) to trigger, everything
else (disconnect/edid/eld) are ok though. (which is enough for CEC)
I'll need some extra debugging...
Do you have a platform to test on, which does trigger this event?
