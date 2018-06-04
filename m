From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 4 Jun 2018 10:49:25 +0200
Subject: [PATCH 3/3] arm64: dts: allwinner: add support for Pinebook
In-Reply-To: <CA+E=qVffecgkCG2V_5ptS9oRxo4XwjpQQhWmf8ywpfF78Yy+7A@mail.gmail.com>
References: <20180601062901.8052-1-anarsoul@gmail.com>
 <20180601062901.8052-4-anarsoul@gmail.com>
 <20180601092346.g2iixqupumn7xo7r@flea>
 <CA+E=qVffecgkCG2V_5ptS9oRxo4XwjpQQhWmf8ywpfF78Yy+7A@mail.gmail.com>
Message-ID: <20180604084925.wbtz7cdcleyaei62@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 01, 2018 at 10:37:29AM -0700, Vasily Khoruzhick wrote:
> On Fri, Jun 1, 2018 at 2:23 AM, Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > On Thu, May 31, 2018 at 11:29:01PM -0700, Vasily Khoruzhick wrote:
> >> From: Icenowy Zheng <icenowy@aosc.xyz>
> >>
> >> Pinebook is a A64-based laptop produced by Pine64, with the following
> >> peripherals:
> >>
> >> USB:
> >> - Two external USB ports (one is directly connected to A64's OTG
> >> controller, the other is under a internal hub connected to the host-only
> >> controller.)
> >> - USB HID keyboard and touchpad connected to the internal hub.
> >> - USB UVC camera connected to the internal hub.
> >>
> >> Power-related:
> >> - A DC IN jack connected to AXP803's DCIN pin.
> >> - A Li-Polymer battery connected to AXP803's battery pins.
> >>
> >> Storage:
> >> - An eMMC by Foresee on the main board (in the product revision of the
> >> main board it's designed to be switchable).
> >> - An external MicroSD card slot.
> >>
> >> Display:
> >> - An eDP LCD panel (1366x768) connected via an ANX6345 RGB-eDP bridge.
> >> - A mini HDMI port.
> >>
> >> Misc:
> >> - A Hall sensor designed to detect the status of lid, connected to GPIO PL12.
> >> - A headphone jack connected to the SoC's internal codec.
> >> - A debug UART port muxed with headphone jack.
> >>
> >> This commit adds basical support for it.
> >>
> >> [vasily: squashed several commits into one, added simplefb node, added usbphy
> >>        to ehci0 and ohci0 nodes]
> >>
> >> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> >> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> >> ---
> >>  arch/arm64/boot/dts/allwinner/Makefile        |   1 +
> >>  .../dts/allwinner/sun50i-a64-pinebook.dts     | 285 ++++++++++++++++++
> >>  2 files changed, 286 insertions(+)
> >>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
> >>
> >> diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
> >> index 8bebe7da5ed9..a8c6d0c6f2c5 100644
> >> --- a/arch/arm64/boot/dts/allwinner/Makefile
> >> +++ b/arch/arm64/boot/dts/allwinner/Makefile
> >> @@ -4,6 +4,7 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-nanopi-a64.dtb
> >>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-olinuxino.dtb
> >>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-orangepi-win.dtb
> >>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-pine64-plus.dtb sun50i-a64-pine64.dtb
> >> +dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-pinebook.dtb
> >>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-sopine-baseboard.dtb
> >>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-teres-i.dtb
> >>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-pc2.dtb
> >> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
> >> new file mode 100644
> >> index 000000000000..d952db217702
> >> --- /dev/null
> >> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
> >> @@ -0,0 +1,285 @@
> >> +/*
> >> + * Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.xyz>
> >> + * Copyright (C) 2018 Vasily Khoruzhick <anarsoul@gmail.com>
> >> + *
> >> + * SPDX-License-Identifier: (GPL-2.0 OR MIT)
> >
> > The SPDX tag should be the first one.
> 
> OK, but it's not in number of other dts files, e.g.
> sun50i-a64-teres-i.dts or sun50i-h5-orangepi-zero-plus.dts

I guess we'd have to fix it then

> >> +/* The ANX6345 eDP-bridge is on r_i2c. There is no linux (mainline)
> >> + * driver for this chip at the moment, the bootloader initializes it.
> >> + * However it can be accessed with the i2c-dev driver from user space.
> >> + */
> >
> > The comment format is wrong, and the part after r_i2c, about i2c-dev
> > and the mainline support is not really relevant. The DT describes the
> > hardware, and is used by several different projects that might or
> > might not have i2c-dev, an interface similar, or might have or not a
> > driver for the bridge.
> 
> Comment is identical to sun50i-a64-teres-i.dts (which was merged few
> months ago).
> I'll remove everything but first sentence.

We don't notice everything unfortunately. Feel free to fix it in the
TERES-I DTS as well.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180604/c568fc46/attachment.sig>
