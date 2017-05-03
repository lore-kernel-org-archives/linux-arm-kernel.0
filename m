From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 3 May 2017 10:41:38 +0200
Subject: [linux-sunxi] [PATCH 13/15] drm/sun4i: Add HDMI support
In-Reply-To: <CAGb2v67Szt9Xj+hwJD6i9X0XgXOtZBS1Jy4wWjbfSGJSDFM1NQ@mail.gmail.com>
References: <cover.bc06ffa88f847ddd9ddd7c259415d5f61b55307b.1488876832.git-series.maxime.ripard@free-electrons.com>
 <c63d01aedeccc58bf8d6f5bfd66d8595156e9491.1488876832.git-series.maxime.ripard@free-electrons.com>
 <CAGb2v66n6AXbOAh05V_Gv2UgRp=xEMG9qhJU8JSuy4-F-UOQQQ@mail.gmail.com>
 <20170426065005.zoewz53q7l7r5e7p@lukather>
 <CAGb2v67Szt9Xj+hwJD6i9X0XgXOtZBS1Jy4wWjbfSGJSDFM1NQ@mail.gmail.com>
Message-ID: <20170503084138.rye2i6qd4ghxifep@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 26, 2017 at 03:59:28PM +0800, Chen-Yu Tsai wrote:
> >> > +       writel(SUN4I_HDMI_VID_TIMING_X(mode->hdisplay) |
> >> > +              SUN4I_HDMI_VID_TIMING_Y(mode->vdisplay),
> >> > +              hdmi->base + SUN4I_HDMI_VID_TIMING_ACT_REG);
> >> > +
> >> > +       x = mode->htotal - mode->hsync_start;
> >> > +       y = mode->vtotal - mode->vsync_start;
> >>
> >> I'm a bit skeptical about this one. All the other parameters are not
> >> inclusive of other, why would this one be different? Shouldn't it
> >> be "Xtotal - Xsync_end" instead?
> >
> > By the usual meaning of backporch, you're right. However, Allwinner's
> > seems to have it's own, which is actually the backporch + sync length.
> >
> > We also have that on all the other connectors (and TCON), and this was
> > confirmed at the time using a scope on an RGB signal.
> 
> Yes. On the later SoCs such as the A31, the user manual actually has
> timing diagrams showing this.
> 
> Unlike the TCON, the HDMI controller's timings lists the front porch
> separately, instead of an all inclusive Xtotal. This is what made me
> look twice. This should be easy to confirm though. Since the HDMI modes
> are well known and can be exactly reproduced on our hardware, we can
> just check for any distortions or refresh rate errors.

This isn't as trivial as that. Screens usually have some tolerancies
on the timings, which will probably make it go unnoticed, even though
they are wrong.

> >>
> >> > +       writel(SUN4I_HDMI_VID_TIMING_X(x) | SUN4I_HDMI_VID_TIMING_Y(y),
> >> > +              hdmi->base + SUN4I_HDMI_VID_TIMING_BP_REG);
> >> > +
> >> > +       x = mode->hsync_start - mode->hdisplay;
> >> > +       y = mode->vsync_start - mode->vdisplay;
> >> > +       writel(SUN4I_HDMI_VID_TIMING_X(x) | SUN4I_HDMI_VID_TIMING_Y(y),
> >> > +              hdmi->base + SUN4I_HDMI_VID_TIMING_FP_REG);
> >> > +
> >> > +       x = mode->hsync_end - mode->hsync_start;
> >> > +       y = mode->vsync_end - mode->vsync_start;
> >> > +       writel(SUN4I_HDMI_VID_TIMING_X(x) | SUN4I_HDMI_VID_TIMING_Y(y),
> >> > +              hdmi->base + SUN4I_HDMI_VID_TIMING_SPW_REG);
> >> > +
> >> > +       val = SUN4I_HDMI_VID_TIMING_POL_TX_CLK;
> >> > +       if (mode->flags & DRM_MODE_FLAG_PHSYNC)
> >> > +               val |= SUN4I_HDMI_VID_TIMING_POL_HSYNC;
> >> > +
> >> > +       if (mode->flags & DRM_MODE_FLAG_PVSYNC)
> >> > +               val |= SUN4I_HDMI_VID_TIMING_POL_VSYNC;
> >> > +
> >> > +       writel(val, hdmi->base + SUN4I_HDMI_VID_TIMING_POL_REG);
> >>
> >> You don't handle the interlaced video here, even though you set
> >>
> >>     hdmi->connector.interlace_allowed = true
> >>
> >> later.
> >
> > I'll fix that.
> >
> >> The double clock and double scan flags aren't handled either, though
> >> I don't understand which one is supposed to represent the need for the
> >> HDMI pixel repeater. AFAIK this is required for resolutions with pixel
> >> clocks lower than 25 MHz, the lower limit of HDMI's TMDS link.
> >
> > I'm not sure about this one though. I'd like to keep things quite
> > simple for now and build up on that once the basis is working. Is it
> > common in the wild?
> 
> If you drive the display at SDTV resolutions, then yes. Mode lines from
> my HDMI monitor:
> 
>   720x576i 50 720 732 795 864 576 580 586 625 flags: nhsync, nvsync,
> interlace, dblclk; type: driver
>   720x480i 60 720 739 801 858 480 488 494 525 flags: nhsync, nvsync,
> interlace, dblclk; type: driver
>   720x480i 60 720 739 801 858 480 488 494 525 flags: nhsync, nvsync,
> interlace, dblclk; type: driver
> 
> AFAIK these are standard modes that all devices should support. Whether
> they are used daily is another thing. Maybe block modes with dblclk
> in .mode_fixup for now?

That would rather be atomic_check and / or mode_valid, but yeah, I can
do that.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170503/5a341757/attachment-0001.sig>
