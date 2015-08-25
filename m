From: treding@nvidia.com (Thierry Reding)
Date: Tue, 25 Aug 2015 12:06:30 +0200
Subject: [PATCH v3 06/14] Documentation: drm/bridge: add document for
 analogix_dp
In-Reply-To: <55DC383F.4000103@rock-chips.com>
References: <1439995728-18046-1-git-send-email-ykk@rock-chips.com>
 <1439995834-18363-1-git-send-email-ykk@rock-chips.com>
 <CAL_JsqLz+8RtBucctUj4euXZ3Ac0DvB52N9ONpAerh5T9BiTJg@mail.gmail.com>
 <20150824125758.GA7557@n2100.arm.linux.org.uk>
 <CAL_JsqKZYMMzV9Sc2r3K_rnM0FNuyb1TyJEhjGq1Hf7dTiWFKQ@mail.gmail.com>
 <20150825091246.GA14034@ulmo.nvidia.com>
 <55DC383F.4000103@rock-chips.com>
Message-ID: <20150825100628.GD14034@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 25, 2015 at 05:41:19PM +0800, Yakir Yang wrote:
> Hi Thierry,
> 
> ? 2015/8/25 17:12, Thierry Reding ??:
> >On Mon, Aug 24, 2015 at 09:48:27AM -0500, Rob Herring wrote:
> >>On Mon, Aug 24, 2015 at 7:57 AM, Russell King - ARM Linux
> >><linux@arm.linux.org.uk> wrote:
> >>>On Sun, Aug 23, 2015 at 06:23:14PM -0500, Rob Herring wrote:
> >>>>On Wed, Aug 19, 2015 at 9:50 AM, Yakir Yang <ykk@rock-chips.com> wrote:
> >>>>>+       -analogix,color-depth:
> >>>>>+               number of bits per colour component.
> >>>>>+                       COLOR_6 = 0, COLOR_8 = 1, COLOR_10 = 2, COLOR_12 = 3
> >>>>This seems pretty generic. Just use 6, 8, 10, or 12 for values. And
> >>>>drop the vendor prefix.
> >>>Please think about this some more.  What does "color-depth" mean?  Does it
> >>>mean the number of bits per colour _component_, or does it mean the total
> >>>number of bits to represent a particular colour.  It's confusing as it
> >>>stands.
> >>Then "component-color-bpp" perhaps?
> >There should be no need to have this in DT at all. The BPC is a property
> >of the attached panel and it should come from the panel (either the
> >panel driver or parsed from EDID if available).
> 
> Actually I have send an email about this one to you in version 2, just past
> from that email:
> 
> "samsung,color_space" and "samsung,color-depth"
> 
> The drm_display_info's color_formats and bpc indicate the monitor display
> ability, but
> the edp driver could not take it as input video format directly.
> 
> For example, with my DP TV I would found "RGB444 & YCRCB422 & & YCRCB444"
> support in drm_display_info.color_formats and 16bit bpc support, but RK3288
> crtc
> driver could only output RGB & ITU formats, so finally analogix_dp-rockchip
> driver
> config crtc to RGBaaa 10bpc mode.
> 
> In this sutiation, the analogix_dp core driver would pazzled by the
> drm_display_info,
> can't chose the right color_space and bpc.
> 
> And this is the place that confused me, wish you could give some ideas about
> this one :-)

Your display driver should choose whatever it is capable of outputting.
If the display reports that it can do 16 bits-per-color, but your
display driver can't do it, then it should choose a configuration that
it supports. Similarily for the color encodings. If you can't generate
YCrCb444 with your hardware, then it's the driver's job to know about
that and select the next appropriate configuration.

But hard-coding this is not the right solution because the value in DT
may end up conflicting with what the display reports.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150825/6976039d/attachment.sig>
