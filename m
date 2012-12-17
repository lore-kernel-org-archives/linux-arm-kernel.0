From: nori.sekhar@gmail.com (Sekhar Nori)
Date: Mon, 17 Dec 2012 20:56:05 +0530
Subject: [RFC] drm/lcdc: add TI LCD Controller DRM driver
In-Reply-To: <CAF6AEGtfeXycZjashi=PenX86m7HLBTZ=U04Q4kLSyqJXwQ1fQ@mail.gmail.com>
References: <1355443446-8723-1-git-send-email-robdclark@gmail.com>
 <50CF248B.4010401@ti.com>
 <CAF6AEGvm2TmFh7xiYzjt9yGT4kuBFA=_219NkwQAjbBVZ+Z6rg@mail.gmail.com>
 <CAF6AEGtfeXycZjashi=PenX86m7HLBTZ=U04Q4kLSyqJXwQ1fQ@mail.gmail.com>
Message-ID: <CAKG51UAunsckFj9g7EMrX6=uFakEidQv2AJJMXPVzeY77eU+JA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Monday, December 17, 2012, Rob Clark wrote:

> On Mon, Dec 17, 2012 at 8:39 AM, Rob Clark <robdclark@gmail.com<javascript:;>>
> wrote:
> >> I'm not very enthusiastic about adding ti-lcdc specific panel/chip
> >> drivers. It's not really a big deal if it's only kernel code, but you
> >> add device-tree bindings also, which is an external API that you need to
> >> support after adding it.
> >>
> >> I'd rather see the energy put to common display framework, and get this
> >> whole panel/chip driver issue solved in a generic manner.
> >
> > yeah, I was expecting to migrate to CDF once it exists, but needed
> > something for now.  I'm using the exercise to get my thoughts straight
> > on how CDF should fit into KMS.  (One thing I plan to add support for
> > is an i2c connected hdmi encoder.. which looks like it would fit well
> > in drivers/gpu/drm/i2c.. so the drm encoder-slave stuff might be the
> > way.)
> >
> > If you have any suggestions on the DT bindings, I'd like to hear 'em.
>
> btw, a little bit of-topic, but speaking of DT...
>
> Anybody have any clue about how backlight devices are supposed to work
> in this brave new DT world?


See Runtime interpreted power sequences here:
 http://lkml.indiana.edu/hypermail/linux/kernel/1208.2/00029.html

It is an attempt to address this need.

Thanks,
Sekhar

 In the old days, the board file would
> stuff a fxn ptr to control backlight in pdata for the driver.  But we
> don't have this any more.  I think I need some way to retrieve the
> 'struct backlight_device' ptr associated with the panel driver, so
> that the appropriate dpms fxn ptrs can enable/disable the backlight.
>
> I'm thinking the dt file should have something that looks roughly like:
>
>                 /* Settings for CDTech_S035Q01 / LCD3 cape: */
>                 panel {
>                         compatible = "lcdc,panel";
>                         pinctrl-names = "default";
>                         pinctrl-0 = <&bone_lcd3_cape_lcd_pins>;
>                         panel-info {
>                                 ac-bias           = <255>;
>                                 ac-bias-intrpt    = <0>;
>                                 dma-burst-sz      = <16>;
>                                 bpp               = <16>;
>                                 fdd               = <0x80>;
>                                 tft-alt-mode      = <0>;
>                                 stn-565-mode      = <0>;
>                                 mono-8bit-mode    = <0>;
>                                 invert-line-clock = <1>;
>                                 invert-frm-clock  = <1>;
>                                 sync-edge         = <0>;
>                                 sync-ctrl         = <1>;
>                                 raster-order      = <0>;
>                                 fifo-th           = <0>;
>                         };
>                         display-timings {
>                                 native-mode = <&timing0>;
>                                 timing0: 320x240 {
>                                         hactive         = <320>;
>                                         vactive         = <240>;
>                                         hback-porch     = <21>;
>                                         hfront-porch    = <58>;
>                                         hsync-len       = <47>;
>                                         vback-porch     = <11>;
>                                         vfront-porch    = <23>;
>                                         vsync-len       = <2>;
>                                         clock-frequency = <8000000>;
>                                 };
>                         };
>
>                         backlight {
>                                 compatible = "tps65217-backlight";
>                                 isel = <1>;
>                                 fdim = <200>;
>
>                                 tps = <&tps>;   /* link to the tps */
>                                 brightness = <100>;
>                         };
>                 };
>
> display-timings is based on the of-videomode helpers patch..
> panel-info probably needs to be made to be something more generic, but
> we need something to know how to configure the crtc properly..
>
> but I'm not quite sure what to do with the backlight..
>
> BR,
> -R
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org <javascript:;>
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121217/4154d6df/attachment-0001.html>
