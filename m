From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 28 Aug 2018 15:45:53 +0200
Subject: [PATCH 1/2] drm/bridge: Add virtual display DT bindings
In-Reply-To: <20180827115302eucas1p24d36cfaf9835ccb217ac81e508484aa1~Ou5eTkYW-3006130061eucas1p2Z@eucas1p2.samsung.com>
References: <CGME20180824122324epcas3p2922f3e5415dacf4c89cfb136fa5c77b2@epcas3p2.samsung.com>
 <20180824122308.3092-1-linus.walleij@linaro.org>
 <20180827115302eucas1p24d36cfaf9835ccb217ac81e508484aa1~Ou5eTkYW-3006130061eucas1p2Z@eucas1p2.samsung.com>
Message-ID: <CACRpkdaGNhxY-xAAEL1Bu4EMr8x7qTGoM9s-At2v7Ev8PwOTDw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 27, 2018 at 1:53 PM Andrzej Hajda <a.hajda@samsung.com> wrote:

> On 24.08.2018 14:23, Linus Walleij wrote:
> > This adds bindings for a virtual display to be used with displays
> > inside entirely virtual environments which do not emulate things
> > like monitors but just need timing information to be supplied to
> > its display controller.
> >
> > This is inspired by earlier work by Liviu Dudau.
>
> If this is pure virtual then it should be connected to other pure
> virtual components.

OK it's a bit of half-half but outside of my grasp, I am just trying
to support legacy systems.

The device tree is there:
arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts
arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi

The latter contains the CLCD which is the display driver.

In RTSM, which is an ARM product I do not develop and
cannot make changes to, there is an emulated CLCD. So
that part appear as if it was real hardware. Like in QEMU.

But the display does not have any emulation. The raw
output from the CLCD is latched out to the screen.

I do not know exactly know how the RTSM emulator
actually works, but I suspect that the little graphic window
on the screeen adapts to what gets written into the
CLCD control registers, so anything goes, more or less.

To satisfy the CLCD with some timings and resolution,
this bridge gives it that, from the device tree, in a way
that clearly conveys that "this is not a real thing".

The old code uses DPI. This is not DPI, not even close
to it. It worked simply because all the DPI really does is
what this patch does: provide timings.

By contrast on QEMU I have patches the emulator to
properly represent the I2C DDC link and provide EDID
so that is all fine.

I cannot patch RTSM to emulate I2C and DDC. It's not
open source. But the device tree in the kernel supports
this "machine" and so, I have to maintain it when modernizng
the fbdev driver to a DRM driver.

I'm sorry RTSM is half/half. Not my fault. I can't fix...

> And one more thing, you are defining virtual panel but you are using
> drm_bridge framework, why not drm_panel?

This was discussed before in the previous patch set:
https://lists.freedesktop.org/archives/dri-devel/2018-July/183516.html

Essentially, it's because the display driver is just connected
to "something" not a panel and a bridge is likely the best I
can come up with - a bridge over to a virtual display.

A patch to add "VGA", "SGA" and "XGA" to the simple panels
was NACKed (sort of, politely):
https://lists.freedesktop.org/archives/dri-devel/2018-July/183698.html

Also it was noted that it would be nice to have something that
would make it easy to change resolutions on these virtual
display things. Voila.

Yours,
Linus Walleij
