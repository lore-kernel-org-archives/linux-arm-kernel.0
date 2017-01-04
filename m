From: andre.przywara@arm.com (=?UTF-8?Q?Andr=c3=a9_Przywara?=)
Date: Wed, 4 Jan 2017 02:16:23 +0000
Subject: [PATCH v2 9/9] ARM: sunxi: Convert pinctrl nodes to generic
 bindings
In-Reply-To: <CAGb2v67_4iriM2WS33hUWzNZY8R2WvGjqzntGBPGmNkr1Ryr_w@mail.gmail.com>
References: <cover.7edc6c25be8a5e2efdda6a82e102dbf7ece6aa64.1476200742.git-series.maxime.ripard@free-electrons.com>
 <e32d044d2d967f24f12d83eea50e7f14f2ae1073.1476200742.git-series.maxime.ripard@free-electrons.com>
 <CAGb2v67_4iriM2WS33hUWzNZY8R2WvGjqzntGBPGmNkr1Ryr_w@mail.gmail.com>
Message-ID: <58723369-50ad-1792-9be1-c277eb719044@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/10/16 08:43, Chen-Yu Tsai wrote:

Hi Maxime, Chen-Yu,

I just stumbled over this patch in Maxime's -next tree and think I
missed it before. I guess it's a bit late, but I just wanted to express
my concerns and write out the issues with the current DT approach:

> On Tue, Oct 11, 2016 at 11:46 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
>> Now that we can handle the generic pinctrl bindings, convert our DT to it.

Do we really want to do this? This makes the new DTs incompatible to
older kernels, for no good reasons. Or are there any? Does this "lock
muxed pins" functionality (users cannot export GPIOs which are used by a
driver) rely on the new binding?

Anyway ...
I understand that in sunxi world a kernel is always accompanied by a
matching .dtb, but we should really get away from this, as this doesn't
scale and more importantly creates big headaches in arm64 world:

1) Scaling: Providing a board .dtb together with a kernel puts the
burden of board support to each distribution, which means that _every_
distribution needs to ship matching DTs for _every_ board. There are a
lot of Allwinner boards (around 100 these days?), I am not sure every
distribution seriously wants to put every .dtb into some bootloader
accessible directory. Also this kind of defeats the original DT idea,
where the .dtb is provided by firmware and a generic kernel just works
with whatever it gets presented.
Either distributions will not support certain boards because of this or
there is a lot of maintenance churn in distros.
Yes, arm(32) has lived with this for years, but that doesn't mean we
need to keep it this way.

2) Firmware DT: We start to see more and more Allwinner boards with SPI
flash now, which is supposed to hold some firmware bits. This gives the
ultimate opportunity to store the DT in there as well. BUT this relies
on there being _one_ DT (to rule them all). I don't see issues with
older DTs not having full functionality on newer kernels (this would be
a reason for a firmware update), but there should at any given time _one
best_ DT which is a candidate for being burned into the flash.
Otherwise people are stuck with a certain kernel version (range).
As an example in this case: Kernel 4.9 is LTS and will probably be
elected by Debian to be _the_ kernel for the next release and supported
over several years. But it relies on an old style DT (allwinner,pins
properties), newer pinctrl DT nodes will be rejected by the driver.
But for new features (upcoming HDMI support for H3, for instance) to be
usable a newer DT is required, even if an old kernel will ignore those
features. So if the flash provides a new DT, we cannot boot stable
Debian, whereas if the flash provides a legacy DT, we cannot use new
features in newer kernels.
Not changing the DT in a way that breaks forward compatibility can be
done, for instance we just drop this patch here. For new SoCs (like A64
or H5, where there are no backward compatibility issues) we can happily
use the new bindings in the official DTs, but for anything already
supported by older kernels we just stick which what we have. We have to
keep the old support code in anyway.
Yes, providing both forward and backward compatibility is not going to
be a walk in the park, but is inevitable if we want to get those board
out of the toy area. Other platform can cope with this.

3) On EFI setups the generation(!) of the DT is actually done in EFI
firmware (very much like in the original PowerPC OF setup). It is
expected that the generation relies on a static DT scaffold, but
firmware is free to add or remove nodes. Providing different DTs for
each kernel is hard to integrate into this approach.

4) Generic boot images: On the x86 side everybody expects this just to
work: You put in a generic USB stick with one (or two) generic kernels
and it just boots, without this installation having to know each
supported machine beforehand. It even works with machines newer than the
distro. While the last is hard work, it can be done, but only if the DT
is provided by firmware, which requires there to be one best DT for each
board.

5) arm64: Distributions providing support for arm64 machines generally
do not seem to provide DTs, because most platform do not require them
to. It is not clear that every distribution will do so for the sake or
supporting Allwinner boards.

6) Other OSes (or U-Boot) are affected by this as well. Eventually this
will lead them to create their own DTs (and their own bindings?), which
makes this situation really a mess. We can hardly request them to stick
with the Linux bindings if we break them regularly.

7) Dynamic DT alteration (by firmware/U-Boot and using overlays, for
instance), will be much easier if the DT is originally stored in the
firmware and snippets are stored there as well. This is for instance a
use case for the (optional) WiFi module on the Pine64.

8) Those patches also create a lot of potential merge conflicts, since
they touch almost every sunxi DT file. They are trivial to solve,
probably, but still tend to create a lot of work and cause nuisance for
other people (as proven with the A64 CCU driver in this cycle).

So can I ask that we start taking this seriously and stop doing things
which prevent Allwinner boards from being supported properly?
Which would first involve dropping this very patch?
Having done breakage in the past (with "allwinner,sun7i-a20-mmc", for
instance) is no excuse for doing it again. And especially I want to
avoid this habit creeping into the arm64 world (thinking about the H5
here, which may be impacted by this very patch, for instance).

Cheers,
Andre.
