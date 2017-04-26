From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 26 Apr 2017 15:59:28 +0800
Subject: [linux-sunxi] [PATCH 13/15] drm/sun4i: Add HDMI support
In-Reply-To: <20170426065005.zoewz53q7l7r5e7p@lukather>
References: <cover.bc06ffa88f847ddd9ddd7c259415d5f61b55307b.1488876832.git-series.maxime.ripard@free-electrons.com>
 <c63d01aedeccc58bf8d6f5bfd66d8595156e9491.1488876832.git-series.maxime.ripard@free-electrons.com>
 <CAGb2v66n6AXbOAh05V_Gv2UgRp=xEMG9qhJU8JSuy4-F-UOQQQ@mail.gmail.com>
 <20170426065005.zoewz53q7l7r5e7p@lukather>
Message-ID: <CAGb2v67Szt9Xj+hwJD6i9X0XgXOtZBS1Jy4wWjbfSGJSDFM1NQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 26, 2017 at 2:50 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi Chen-Yu,
>
> On Fri, Apr 21, 2017 at 11:17:17PM +0800, Chen-Yu Tsai wrote:
>> Hi,
>>
>> On Tue, Mar 7, 2017 at 4:56 PM, Maxime Ripard
>> <maxime.ripard@free-electrons.com> wrote:
>> > The earlier Allwinner SoCs (A10, A10s, A20, A31) have an embedded HDMI
>> > controller.
>> >
>> > That HDMI controller is able to do audio and CEC, but those have been left
>> > out for now.
>> >
>> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>> > ---
>> >  drivers/gpu/drm/sun4i/Makefile              |   5 +-
>> >  drivers/gpu/drm/sun4i/sun4i_hdmi.h          | 124 ++++++-
>> >  drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.c  | 128 ++++++-
>> >  drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c      | 449 +++++++++++++++++++++-
>> >  drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c | 236 +++++++++++-
>> >  5 files changed, 942 insertions(+), 0 deletions(-)
>> >  create mode 100644 drivers/gpu/drm/sun4i/sun4i_hdmi.h
>> >  create mode 100644 drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.c
>> >  create mode 100644 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
>> >  create mode 100644 drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c
>>
>> Applying patch #9608371 using 'git am'
>> Description: [13/15] drm/sun4i: Add HDMI support
>> Applying: drm/sun4i: Add HDMI support
>> .git/rebase-apply/patch:116: trailing whitespace.
>>
>> .git/rebase-apply/patch:531: trailing whitespace.
>>
>> .git/rebase-apply/patch:701: trailing whitespace.
>>
>> warning: 3 lines add whitespace errors.
>
> Fixed.
>
>> > +int sun4i_ddc_create(struct sun4i_hdmi *hdmi, struct clk *parent)
>> > +{
>> > +       struct clk_init_data init;
>> > +       struct sun4i_ddc *ddc;
>> > +       const char *parent_name;
>> > +
>> > +       parent_name = __clk_get_name(parent);
>> > +       if (!parent_name)
>> > +               return -ENODEV;
>> > +
>> > +       ddc = devm_kzalloc(hdmi->dev, sizeof(*ddc), GFP_KERNEL);
>> > +       if (!ddc)
>> > +               return -ENOMEM;
>> > +
>> > +       init.name = "hdmi-ddc";
>> > +       init.ops = &sun4i_ddc_ops;
>> > +       init.parent_names = &parent_name;
>> > +       init.num_parents = 1;
>> > +       init.flags = CLK_SET_RATE_PARENT;
>>
>> I don't think this is really needed. It probably doesn't hurt though,
>> since DDC is used when HDMI is not used for displaying, but it might
>> affect any upstream PLLs, which theoretically may affect other users
>> of said PLLs. The DDC clock is slow enough that we should be able to
>> generate a usable clock rate anyway.
>
> Good point, I removed it.
>
>> > +       writel(SUN4I_HDMI_VID_TIMING_X(mode->hdisplay) |
>> > +              SUN4I_HDMI_VID_TIMING_Y(mode->vdisplay),
>> > +              hdmi->base + SUN4I_HDMI_VID_TIMING_ACT_REG);
>> > +
>> > +       x = mode->htotal - mode->hsync_start;
>> > +       y = mode->vtotal - mode->vsync_start;
>>
>> I'm a bit skeptical about this one. All the other parameters are not
>> inclusive of other, why would this one be different? Shouldn't it
>> be "Xtotal - Xsync_end" instead?
>
> By the usual meaning of backporch, you're right. However, Allwinner's
> seems to have it's own, which is actually the backporch + sync length.
>
> We also have that on all the other connectors (and TCON), and this was
> confirmed at the time using a scope on an RGB signal.

Yes. On the later SoCs such as the A31, the user manual actually has
timing diagrams showing this.

Unlike the TCON, the HDMI controller's timings lists the front porch
separately, instead of an all inclusive Xtotal. This is what made me
look twice. This should be easy to confirm though. Since the HDMI modes
are well known and can be exactly reproduced on our hardware, we can
just check for any distortions or refresh rate errors.

>
>>
>> > +       writel(SUN4I_HDMI_VID_TIMING_X(x) | SUN4I_HDMI_VID_TIMING_Y(y),
>> > +              hdmi->base + SUN4I_HDMI_VID_TIMING_BP_REG);
>> > +
>> > +       x = mode->hsync_start - mode->hdisplay;
>> > +       y = mode->vsync_start - mode->vdisplay;
>> > +       writel(SUN4I_HDMI_VID_TIMING_X(x) | SUN4I_HDMI_VID_TIMING_Y(y),
>> > +              hdmi->base + SUN4I_HDMI_VID_TIMING_FP_REG);
>> > +
>> > +       x = mode->hsync_end - mode->hsync_start;
>> > +       y = mode->vsync_end - mode->vsync_start;
>> > +       writel(SUN4I_HDMI_VID_TIMING_X(x) | SUN4I_HDMI_VID_TIMING_Y(y),
>> > +              hdmi->base + SUN4I_HDMI_VID_TIMING_SPW_REG);
>> > +
>> > +       val = SUN4I_HDMI_VID_TIMING_POL_TX_CLK;
>> > +       if (mode->flags & DRM_MODE_FLAG_PHSYNC)
>> > +               val |= SUN4I_HDMI_VID_TIMING_POL_HSYNC;
>> > +
>> > +       if (mode->flags & DRM_MODE_FLAG_PVSYNC)
>> > +               val |= SUN4I_HDMI_VID_TIMING_POL_VSYNC;
>> > +
>> > +       writel(val, hdmi->base + SUN4I_HDMI_VID_TIMING_POL_REG);
>>
>> You don't handle the interlaced video here, even though you set
>>
>>     hdmi->connector.interlace_allowed = true
>>
>> later.
>
> I'll fix that.
>
>> The double clock and double scan flags aren't handled either, though
>> I don't understand which one is supposed to represent the need for the
>> HDMI pixel repeater. AFAIK this is required for resolutions with pixel
>> clocks lower than 25 MHz, the lower limit of HDMI's TMDS link.
>
> I'm not sure about this one though. I'd like to keep things quite
> simple for now and build up on that once the basis is working. Is it
> common in the wild?

If you drive the display at SDTV resolutions, then yes. Mode lines from
my HDMI monitor:

  720x576i 50 720 732 795 864 576 580 586 625 flags: nhsync, nvsync,
interlace, dblclk; type: driver
  720x480i 60 720 739 801 858 480 488 494 525 flags: nhsync, nvsync,
interlace, dblclk; type: driver
  720x480i 60 720 739 801 858 480 488 494 525 flags: nhsync, nvsync,
interlace, dblclk; type: driver

AFAIK these are standard modes that all devices should support. Whether
they are used daily is another thing. Maybe block modes with dblclk
in .mode_fixup for now?

>> > +              hdmi->base + SUN4I_HDMI_DDC_FIFO_CTRL_REG);
>> > +       writel(SUN4I_HDMI_DDC_ADDR_SEGMENT(offset >> 8) |
>> > +              SUN4I_HDMI_DDC_ADDR_EDDC(0x60) |
>> > +              SUN4I_HDMI_DDC_ADDR_OFFSET(offset) |
>> > +              SUN4I_HDMI_DDC_ADDR_SLAVE(0x50),
>>
>> You can use DDC_ADDR from drm_edid.h.
>
> Done.

There's also DDC_SEGMENT_ADDR (which is 0x30) you can use to replace 0x60.
The 1 bit shift is probably something related to I2C.

>> > +static enum drm_connector_status
>> > +sun4i_hdmi_connector_detect(struct drm_connector *connector, bool force)
>> > +{
>> > +       struct sun4i_hdmi *hdmi = drm_connector_to_sun4i_hdmi(connector);
>> > +       unsigned long reg;
>> > +
>> > +       if (readl_poll_timeout(hdmi->base + SUN4I_HDMI_HPD_REG, reg,
>> > +                              reg & SUN4I_HDMI_HPD_HIGH,
>> > +                              0, 500000))
>>
>> We shouldn't need to do polling here. It should just return the status
>> at the instance it's called. Instead we should have a worker that does
>> polling to check if something is plugged or unplugged. I don't see any
>> interrupt bits for this though. :(
>
> As far as I know, polling in detect is okay. Why would you want to
> remove it?

Hmm, I guess it only serves to debounce the detection, i.e. extend the
time period of validity from the instance the function is run to the
instance plus 500 ms.

To be clear I'm not against it. However this only really works when
the DRM subsystem is brought up. We still need something else for
hotplugging, which is what I was arguing for.


Regards
ChenYu

>> > +       ret = drm_encoder_init(drm,
>> > +                              &hdmi->encoder,
>> > +                              &sun4i_hdmi_funcs,
>> > +                              DRM_MODE_ENCODER_TMDS,
>> > +                              NULL);
>> > +       if (ret) {
>> > +               dev_err(dev, "Couldn't initialise the HDMI encoder\n");
>> > +               return ret;
>> > +       }
>> > +
>> > +       hdmi->encoder.possible_crtcs = BIT(0);
>>
>> You can use drm_of_find_possible_crtcs() now. See the TV encoder driver.
>
> Ack.
>
>> > +
>> > +       drm_connector_helper_add(&hdmi->connector,
>> > +                                &sun4i_hdmi_connector_helper_funcs);
>> > +       ret = drm_connector_init(drm, &hdmi->connector,
>> > +                                &sun4i_hdmi_connector_funcs,
>> > +                                DRM_MODE_CONNECTOR_HDMIA);
>> > +       if (ret) {
>> > +               dev_err(dev,
>> > +                       "Couldn't initialise the Composite connector\n");
>>
>> Wrong connector.
>
> Fixed.
>
>> > +       ret = sun4i_ddc_create(hdmi, hdmi->tmds_clk);
>> > +       if (ret) {
>> > +               dev_err(&pdev->dev, "Couldn't create the DDC clock\n");
>> > +               return ret;
>> > +       }
>>
>> We do all this in the bind function for all the other components.
>> Any particular reason to do it differently here?
>
> Not really, I'll change it.
>
> Thanks!
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
