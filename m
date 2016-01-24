From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 24 Jan 2016 17:54:47 +0100
Subject: [PATCH RFC 08/15] ARM: dts: sun6i: Add mmc3 pins for 8 bit emmc
In-Reply-To: <CAGb2v66Ma7QmJpNO=Gv=ojrwL3n_MZm3H5XNKA2fpf_3AbOTBA@mail.gmail.com>
References: <1453354002-28366-1-git-send-email-wens@csie.org>
 <1453354002-28366-9-git-send-email-wens@csie.org>
 <20160122203138.GB3682@lukather>
 <CAGb2v66Ma7QmJpNO=Gv=ojrwL3n_MZm3H5XNKA2fpf_3AbOTBA@mail.gmail.com>
Message-ID: <20160124165447.GA7908@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Jan 23, 2016 at 07:04:54PM +0800, Chen-Yu Tsai wrote:
> Hi,
> 
> On Sat, Jan 23, 2016 at 4:31 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Hi,
> >
> > On Thu, Jan 21, 2016 at 01:26:35PM +0800, Chen-Yu Tsai wrote:
> >> mmc2 and mmc3 are available on the same pins, with different mux values.
> >> However, only mmc3 supports 8 bit DDR transfer modes.
> >>
> >> Since preference for mmc3 over mmc2 is due to DDR transfer modes, just
> >> set the drive strength to 40mA, which is needed for DDR.
> >>
> >> This pinmux setting also includes the hardware reset pin for emmc.
> >>
> >> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> >> ---
> >>  arch/arm/boot/dts/sun6i-a31.dtsi | 10 ++++++++++
> >>  1 file changed, 10 insertions(+)
> >>
> >> diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
> >> index b6ad7850fac6..1867af24ff52 100644
> >> --- a/arch/arm/boot/dts/sun6i-a31.dtsi
> >> +++ b/arch/arm/boot/dts/sun6i-a31.dtsi
> >> @@ -709,6 +709,16 @@
> >>                               allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> >>                       };
> >>
> >> +                     mmc3_8bit_emmc_pins: mmc3 at 1 {
> >> +                             allwinner,pins = "PC6", "PC7", "PC8", "PC9",
> >> +                                              "PC10", "PC11", "PC12",
> >> +                                              "PC13", "PC14", "PC15",
> >> +                                              "PC24";
> >> +                             allwinner,function = "mmc3";
> >> +                             allwinner,drive = <SUN4I_PINCTRL_40_MA>;
> >> +                             allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> >> +                     };
> >> +
> >
> > Is that reset pin optional?
> >
> > If so, I'd prefer it to be a separate node, like we're doing for the
> > SPI chip selects for example.
> >
> > It allows more reusability between different devices without declaring
> > new nodes.
> 
> All eMMC devices have a reset pin. The MMC standard specifies this as
> one way to reset the card, others being a special reset command, or
> powering the card off. It also notes a state when the card will not
> accept commands, and will require a power cycle or asserting the reset
> pin.
> 
> I assume all designs would route this pin. The FEX files also have this
> pin included by default.

I was more concerned about the case were you'd have a 8bits bus
without an emmc. But I guess that can't happen, since all SD cards are
using a 4 bits width anyway.

I'll apply this patch.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160124/6a4f3ebf/attachment.sig>
