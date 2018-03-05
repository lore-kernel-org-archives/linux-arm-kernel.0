From: robh@kernel.org (Rob Herring)
Date: Mon, 5 Mar 2018 08:10:56 -0600
Subject: [PATCH v1 18/19] arm: dts: mt7623: add MT7623A reference boards
In-Reply-To: <1520043343.8089.216.camel@mtkswgap22>
References: <cover.1519378871.git.sean.wang@mediatek.com>
 <ddffdff293734954ba368be8a54edd3c84a4f4e6.1519378872.git.sean.wang@mediatek.com>
 <20180302154547.xq5nkmkdk3oenbta@rob-hp-laptop>
 <1520043343.8089.216.camel@mtkswgap22>
Message-ID: <CAL_JsqKLYVN8G28GNYVQc=Kduij+0b82ydKG1D=7hh8sPE4GYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 2, 2018 at 8:15 PM, Sean Wang <sean.wang@mediatek.com> wrote:
> On Fri, 2018-03-02 at 09:45 -0600, Rob Herring wrote:
>> On Fri, Feb 23, 2018 at 06:16:38PM +0800, sean.wang at mediatek.com wrote:
>> > From: Sean Wang <sean.wang@mediatek.com>
>> >
>> > Add mt7623a-rfb.dtsi where most nodes can be inherited from
>> > mt7623n-rfb.dtsi and keep these distinctions from MT7623A boards in
>> > mt7623a-rfb.dtsi for most definition can be reused among MT7623A board
>> > variants.
>> >
>> > MT7623A has its specific definition of power domain and thus we need
>> > to change related devices such as audio, ethernet, crypto, high-speed
>> > DMA, NAND, and USB controller to the power domain they specifically
>> > belong to. In addition, MT7530 exists as built-in module inside MT7623A
>> > SoC and I2C2 and UART[0-1] get being removed and UART2 have distinct pin
>> > usage. Those all differences can be totally seen in mt7623a-rfb.dtsi.
>> >
>> > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
>> > ---
>> >  arch/arm/boot/dts/Makefile             |  2 +
>> >  arch/arm/boot/dts/mt7623a-rfb-emmc.dts | 22 +++++++++
>> >  arch/arm/boot/dts/mt7623a-rfb-nand.dts | 26 +++++++++++
>> >  arch/arm/boot/dts/mt7623a-rfb.dtsi     | 84 ++++++++++++++++++++++++++++++++++
>> >  arch/arm/boot/dts/mt7623n-rfb.dtsi     | 15 ++++++
>> >  5 files changed, 149 insertions(+)
>> >  create mode 100644 arch/arm/boot/dts/mt7623a-rfb-emmc.dts
>> >  create mode 100644 arch/arm/boot/dts/mt7623a-rfb-nand.dts
>> >  create mode 100644 arch/arm/boot/dts/mt7623a-rfb.dtsi
>> >
>> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> > index 5af6fce..818817c 100644
>> > --- a/arch/arm/boot/dts/Makefile
>> > +++ b/arch/arm/boot/dts/Makefile
>> > @@ -1122,6 +1122,8 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += \
>> >     mt6580-evbp1.dtb \
>> >     mt6589-aquaris5.dtb \
>> >     mt6592-evb.dtb \
>> > +   mt7623a-rfb-emmc.dtb \
>> > +   mt7623a-rfb-nand.dtb \
>> >     mt7623n-rfb-emmc.dtb \
>> >     mt7623n-rfb-nand.dtb \
>> >     mt7623n-bananapi-bpi-r2.dtb \
>> > diff --git a/arch/arm/boot/dts/mt7623a-rfb-emmc.dts b/arch/arm/boot/dts/mt7623a-rfb-emmc.dts
>> > new file mode 100644
>> > index 0000000..ef6398e
>> > --- /dev/null
>> > +++ b/arch/arm/boot/dts/mt7623a-rfb-emmc.dts
>> > @@ -0,0 +1,22 @@
>> > +// SPDX-License-Identifier: GPL-2.0
>> > +/*
>> > + * Copyright (c) 2017-2018 MediaTek Inc.
>> > + * Author: Sean Wang <sean.wang@mediatek.com>
>> > + *
>> > + */
>> > +
>> > +/dts-v1/;
>> > +#include "mt7623a-rfb.dtsi"
>> > +
>> > +/ {
>> > +   model = "MediaTek MT7623A with eMMC reference board";
>> > +   compatible = "mediatek,mt7623a-rfb-emmc", "mediatek,mt7623";
>> > +
>> > +   chosen {
>> > +           bootargs = "console=ttyS0,115200n8 earlyprintk";
>>
>> Use stdout-path instead. earlyprintk option only works for a kernel
>> built with a debug uart at a fixed address, so drop it.
>>
>
> thanks, I will try and have stdout-path instead.
>
> But for earlyprintk, our kernel can support and be built with a debug
> uart at a fixed address and it is greatly useful to know what's going
> on when a system hang happens on certain device's initialization prior
> to uart initialization such as PCI device.

These days, you only need earlyprintk for *really* early console like
in the assembly boot entry code and before the DT is unflattened. For
anything else, use earlycon instead because earlycon is a runtime
option.

> Thus, I consider to keep it there in special on such kinds of
> development boards for debugging purpose.

Then add this option when you are doing debug. But for what's
"shipped" in mainline, you should not have this enabled.

Rob
