From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 15 Jun 2015 08:12:56 +0200
Subject: [PATCH v3 2/2] arm64: dts: mt8173: Add I2C device node
In-Reply-To: <CAGS+omB1UadXeKZLmMdhSamsPpipQLmoH_PhbUPvszrYTq68fA@mail.gmail.com>
References: <1434101229-32695-1-git-send-email-eddie.huang@mediatek.com>
 <1434101229-32695-3-git-send-email-eddie.huang@mediatek.com>
 <CAGS+omB1UadXeKZLmMdhSamsPpipQLmoH_PhbUPvszrYTq68fA@mail.gmail.com>
Message-ID: <20150615061256.GM6325@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 12, 2015 at 08:28:51PM +0800, Daniel Kurtz wrote:
> Hi Eddie,
> 
> On Fri, Jun 12, 2015 at 5:27 PM, Eddie Huang <eddie.huang@mediatek.com> wrote:
> >
> > Add MT8173 I2C device nodes, include I2C controllers and pins.
> > MT8173 has six I2C controllers, from i2c0 to i2c6, exclude i2c5.
> > The 6th I2C controller register base doesn't next to 5th I2C,
> > and there is a hardware between 5th and 6th I2C controller. So
> > SoC designer name 6th controller as "i2c6", not "i2c5".
> 
> 
> This is slightly misleading.  There are in fact 7 I2C controllers, but
> "i2c5" is dedicated for use by HDMI for ddc & hdcp.
> Is there a reason why the HDMI I2C port cannot be controlled by the
> generic i2c driver?
> 
> Of course the hdmiddc / i2c5 node can always be added in a later
> patch, so this is no reason to hold up this patch.
> 
> > Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
> > ---
> >  arch/arm64/boot/dts/mediatek/mt8173-evb.dts | 50 ++++++++++++++++++++
> >  arch/arm64/boot/dts/mediatek/mt8173.dtsi    | 72 +++++++++++++++++++++++++++++
> >  2 files changed, 122 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
> > index 43d5401..2e01988 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
> > +++ b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
> > @@ -33,6 +33,56 @@
> >         chosen { };
> >  };
> >
> > +&pio {
> 
> I don't think we needed to move these i2c pinmux descriptions from
> mt8173.dtsi to the board .dts file.
> 
> AFAICT, the "i2cN_pins_a" nodes defined here are the pinctl
> configuration that the corresponding enabled i2c nodes would choose.
> Thus, they are generic to the MT8173 SoC, not specific to any board.
> By themselves, these nodes do not actually select a pin configuration.

On i.MX we started with i2cN_pins_[abcde] groups in the SoC dtsi file
aswell. At some point we realized that this does not scale anymore.
The problems were:

- Whenever a new board came along which needed some pin setting which
  didn't already exist a new group was created in the SoC dtsi file using
  the next free letter from the alphabet. The ordering of the group names
  was rather arbitrary and often enough there were merge conflicts to
  resolve when during one merge window two new boards showed up which both
  added i2cN_pin_x with different content.
- When a new board needs the same pins but with different drive strength
  settings a new group was required
- With SD/MMC we had groups for 4bit data, groups adding the remaining
  pins for 8bit data
- With UARTs we had groups for RX/TX and additionally groups adding
  RTS/CTS
- For graphics we had groups for 16bit data and 24bit data
- There is no way to remove the unused nodes from the binary dtb, so
  every board contained all existing pingroups for every other board,
  so the dtbs became quite big

So with only a few existing boards with very similar pinmux groups
it may work fine to put the groups into the SoC dtsi, but this way
may also explode quite fast with more and different boards.
I don't know how much variation there will be with Mediatek boards, so
I'm fine with either way. You may want to look at:

5a2a7d5 ARM: dts: imx51: make pinctrl nodes board specific
7ac0f70 ARM: dts: imx53: make pinctrl nodes board specific
817c27a ARM: dts: imx6qdl: make pinctrl nodes board specific

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
