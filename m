From: bjorn@kryo.se (Bjorn Andersson)
Date: Tue, 8 Jul 2014 14:59:15 -0700
Subject: a case for a common efuse API?
In-Reply-To: <53BC4DD7.20906@codeaurora.org>
References: <53BC4DD7.20906@codeaurora.org>
Message-ID: <CAJAp7OhUE4LmLtu5AMui_0ws-K_H__07VN=g2Frr0JCMn+Q5Gg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 8, 2014 at 1:00 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> Hi,
>
> On MSM chips we have some efuses (called qfprom) where we store things
> like calibration data, speed bins, etc. We need to read out data from
> the efuses in various drivers like the cpufreq, thermal, etc. This
> essentially boils down to a bunch of readls on the efuse from a handful
> of different drivers. In devicetree this looks a little odd because
> these drivers end up having an extra reg property (or two) that points
> to a register in the efuse and some length, i.e you see this:

Not only does it look odd, but it limits the possible use to devices on the
mmio bus.

[...]
> It's been suggested that we use syscon for this, but I wonder if that is
> the right thing to do. With a syscon you're usually writing some
> registers that got lumped together with other registers that aren't
> directly related to your driver. It doesn't seem like syscon is made for
> reading fuses or other things like eeproms. Maybe I'm wrong though.
>

I've been thinking further about this since we discussed it; and I agree with
you that this probably wasn't in the original plans for syscon.

But looking at the qfprom hardware, we have a span of 32 bit registers that's
supposed to be accessed from various drivers. All these registers are the same
size, so abstracting them with a mmio-regmap makes sense. All we need is a way
for drivers to get a handle to this regmap.

This was exactly what I implemented and then I realized that I had only created
a copy of syscon (although readonly) and given it a different name.


A potential addition to this would be to expose a (preferrably separate) api to
fuse things, for factory use. But looking at the qfprom this is done by writing
to different parts of the register space, so we could simply add a factory fuse
driver on the side - once one is desired.

> Using syscon would probably work if we could add a way to point to
> offsets within the syscon node (the 0x18 part in the example). In my
> specific use-case the calibration data may have different offsets
> depending on which SoC the hardware is instantiated in so we could also
> make syscon work if the compatible field for the sensor node indicates
> which SoC it is.
>

I'm not sure if other users of syscon would find a use for an xlate, if not
then we could just have that as a separate property that lists the reg offsets
within the syscon.

Maybe there's some benefits of common naming of said property so we could put
some common accessor functions somewhere?

Regards,
Bjorn
