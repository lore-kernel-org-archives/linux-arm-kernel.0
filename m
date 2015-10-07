From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 7 Oct 2015 10:18:30 +0100
Subject: [PATCH 08/12] drm: bridge/dw_hdmi: avoid enabling interface in
 mode_set
In-Reply-To: <5614969D.7030201@rock-chips.com>
References: <20150808160251.GM7557@n2100.arm.linux.org.uk>
 <E1ZO6bI-0002rG-PI@rmk-PC.arm.linux.org.uk>
 <5614969D.7030201@rock-chips.com>
Message-ID: <20151007091830.GE21513@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 07, 2015 at 11:50:53AM +0800, Yakir Yang wrote:
> 
> 
> On 08/09/2015 12:04 AM, Russell King wrote:
> >On a mode set, DRM makes the following sequence of calls:
> >* for_each_encoder
> >*   bridge	mode_fixup
> >*   encoder	mode_fixup
> >* crtc		mode_fixup
> >* for_each_encoder
> >*   bridge	disable
> >*   encoder	prepare
> >*   bridge	post_disable
> >* disable unused encoders
> >* crtc		prepare
> >* crtc		mode_set
> >* for_each_encoder
> >*   encoder	mode_set
> >*   bridge	mode_set
> >* crtc		commit
> >* for_each_encoder
> >*   bridge	pre_enable
> >*   encoder	commit
> >*   bridge	enable
> >
> >dw_hdmi enables the HDMI output in both the bridge mode_set() and also
> >the bridge enable() step.  This is duplicated work - we can avoid the
> >setup in mode_set() and just do it in the enable() stage.  This
> >simplifies the code a little.
> >
> >Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> I have noticed that dw_hdmi driver have poweron/poweroff when
> driver detect HPD event in irq thread, that's also duplicated works,
> would you like to collect that changes into this one:
> 
> static irqreturn_t dw_hdmi_irq(int irq, void *dev_id)
> {
>         ......
> 
>         if (intr_stat & HDMI_IH_PHY_STAT0_HPD) {
>                 if (phy_int_pol & HDMI_PHY_HPD) {
>                         dev_dbg(hdmi->dev, "EVENT=plugin\n");
> 
>                         hdmi_modb(hdmi, 0, HDMI_PHY_HPD, HDMI_PHY_POL0);
> 
>                         dw_hdmi_poweron(hdmi);    // no need here
>                 } else {
>                         dev_dbg(hdmi->dev, "EVENT=plugout\n");
> 
>                         hdmi_modb(hdmi, HDMI_PHY_HPD, HDMI_PHY_HPD,
>                                   HDMI_PHY_POL0);
> 
>                         dw_hdmi_poweroff(hdmi);    // no need here
>                 }
>                 drm_helper_hpd_irq_event(hdmi->connector.dev);
>         }
>         ......
> }

I'm very much of the opinion of making small logical changes.  This
patch is one small logical change to the DRM-side logic to get rid
of the identified duplication there without touching anything else.
If removing the above calls to dw_hdmi_poweron()/dw_hdmi_poweroff()
were found to cause a regression, then the whole change would end
up being reverted, which would be annoying.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
