From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 11 Feb 2018 12:05:27 +0100
Subject: [PATCH 3/3] drm/pl111: Use max memory bandwidth for resolution
In-Reply-To: <876074dax5.fsf@anholt.net>
References: <20180206121854.4407-1-linus.walleij@linaro.org>
 <20180206121854.4407-4-linus.walleij@linaro.org> <876074dax5.fsf@anholt.net>
Message-ID: <CACRpkdZ9jOhtxKRgv_XtJMTgT0_fSKg9HMoyDGOJTTaLd+GOLA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 10, 2018 at 6:14 PM, Eric Anholt <eric@anholt.net> wrote:
> Linus Walleij <linus.walleij@linaro.org> writes:

>> +static enum drm_mode_status
>> +pl111_mode_valid(struct drm_crtc *crtc,
>> +              const struct drm_display_mode *mode)
>> +{
>> +     struct drm_device *drm = crtc->dev;
>> +     struct pl111_drm_dev_private *priv = drm->dev_private;
>> +     u32 cpp = priv->variant->fb_bpp / 8;
>> +     u64 bw;
>
> Using the variant->fb_bpp for mode_valid checks here feels wrong to me
> -- it means a larger mode wouldn't be considered valid on a
> 32bpp-preferred platform when 16bpp would make it work, and a 16bpp
> platform will happily try to set a 32bpp mode that exceeds the
> bandwidth.

Yeah. So I have an additional patch (that I will send out with the
rest of the v2 patches) that actually go in and set ->fb_bpp to
16 on the RealViews to get some nice 1024x768 on these.

The other mode_valid() checks I've seen (well, OMAPDRM)
just assume 32bpp and goes on. I guess it is saved by not
supporting anything else.

> On the other hand, if it makes things work most of the time I'm also
> kind of OK with it.  Anyone else want to chime in here?

This makes things work but can be improved upon.

The core of the problem is that resolution is CRTC business
and seen as something limited by the monitor or
bridge/connector or so, then it calls this hook into the driver to
check that it can provide what the monitor/bridge/connector
suggests.

And then we have the opportunity to say we can't do such or
such resolution.

The pixel format on the other hand is seen as a display hardware
thing, so if I had an API here to call back into the driver and
restrict the formats to say 16bpp, I could confirm better
resolutions.

We can put that in place later and remove the ->fb_bpp if we
can chisel out the right API to set the pixel format.

I am working on another patch to set the preferred pixel format
instead of BPP when intiializing the framebuffer, so I will
investigate this at the same time, but I'd really like to build
on top of this code to avoid too many variables.

> Maybe DRM_DEBUG_KMS for these?

OK I fix :)

Yours,
Linus Walleij
