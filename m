From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Fri, 24 Aug 2018 10:22:33 +0200
Subject: [RFC PATCH 0/7] add at91sam9 LCDC DRM driver
In-Reply-To: <20180812184152.GA22343@ravnborg.org>
References: <20180812184152.GA22343@ravnborg.org>
Message-ID: <20180824102233.73852596@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sam,

On Sun, 12 Aug 2018 20:41:52 +0200
Sam Ravnborg <sam@ravnborg.org> wrote:

> New DRM based driver for at91sam9 SOC's that uses the
> Atmel LCDC IP core.

First of all, thanks for this contribution.

> 
> This is first version of a patch set that adds
> drivers for the Atmel LCDC IP core.
> Posted for review as the basics works now.
> 
> The LCDC IP core contains two devices:
> - a PWM often used for backlight
> - a LCD display controller
> 
> Both devices are supported today by the atmel_lcdfb driver.
> For this new set of drivers the compatible strings was
> selected to avoid clash with the existing compatible
> strings used for the atmel_lcdfb driver to allow them
> to co-exist.

Hm, I think Rob commented on that already, but we usually try to stay
compatible with the exisiting/old bindings when introducing a new one.
Don't know how feasible this is in this particular case though.

> 
> This patchset implements three drivers.
> - A MFD driver that include the generic parts.
> - A PWM driver.
> - A DRM display controller driver.
> This is the same split as used for the Atmel hlcdc IP.
> 
> The hlcdc and lcdc has only a few things in common and
> trying to share the code for them was not a viable solution.
> 
> The DRM implementation has a few shortcomings compared to the
> existing fbdev based driver:
>     - STN displays are not supported
>             Binding support is missing but most of the
>             STN specific functionality is otherwise ported
>             from the fbdev driver.
>             I assume the info should come from the panel
>             but as I lack HW I have not looked too much
>             into what is required.
>     - gamma support is missing
>             The driver utilises drm_simple_kms_helper and
>             this helper lacks support for setting up gamma.
>             If this is useful please let me know and I
>             will extend drm_simple_kms_helper to support this
>             and update the driver.

I guess you can skip that for now.

>     - modesetting is not checked (see TODO in file)
>             Is this required for such a simple setup?

Well, that's always better if you can check that the requested display
mode is supported before trying to apply it.

>     - support for extra modes as applicable (and lcd-wiring-mode)

Peter already suggested something I think.

>     - support for AVR32 (is it relevant?)

It is, AVR32 is no longer supported in mainline.

> 
> The first patch renames .../drm/atmel-hlcdc to .../drm/atmel
> to have a nice home for both drivers.

Sounds good.

Regards,

Boris
