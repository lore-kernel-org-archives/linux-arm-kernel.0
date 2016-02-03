From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 3 Feb 2016 21:36:16 +0100
Subject: [PATCH v2 11/26] ARM: sun5i: Add DRAM gates
In-Reply-To: <CAGb2v65gCieH2-WS+1WeBNCVqRyw8fOxODdSC5xeKf-hkfgs6A@mail.gmail.com>
References: <1452785109-6172-1-git-send-email-maxime.ripard@free-electrons.com>
 <1452785109-6172-12-git-send-email-maxime.ripard@free-electrons.com>
 <CAGb2v65gCieH2-WS+1WeBNCVqRyw8fOxODdSC5xeKf-hkfgs6A@mail.gmail.com>
Message-ID: <20160203203616.GG3327@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 17, 2016 at 01:10:02AM +0800, Chen-Yu Tsai wrote:
> On Thu, Jan 14, 2016 at 11:24 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > The DRAM gates control whether the image / display devices on the SoC have
> > access to the DRAM clock or not.
> >
> > Enable it.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  arch/arm/boot/dts/sun5i-a10s.dtsi |  7 ++++---
> >  arch/arm/boot/dts/sun5i-a13.dtsi  |  2 +-
> >  arch/arm/boot/dts/sun5i-r8.dtsi   |  2 +-
> >  arch/arm/boot/dts/sun5i.dtsi      | 19 +++++++++++++++++++
> >  4 files changed, 25 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
> > index bddd0de88af6..52d2c79cb37b 100644
> > --- a/arch/arm/boot/dts/sun5i-a10s.dtsi
> > +++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
> > @@ -66,7 +66,7 @@
> >                                      "simple-framebuffer";
> >                         allwinner,pipeline = "de_be0-lcd0-hdmi";
> >                         clocks = <&pll5 1>, <&ahb_gates 36>, <&ahb_gates 43>,
> > -                                <&ahb_gates 44>;
> > +                                <&ahb_gates 44>, <&dram_gates 26>;
> >                         status = "disabled";
> >                 };
> >
> > @@ -74,7 +74,8 @@
> >                         compatible = "allwinner,simple-framebuffer",
> >                                      "simple-framebuffer";
> >                         allwinner,pipeline = "de_be0-lcd0";
> > -                       clocks = <&pll5 1>, <&ahb_gates 36>, <&ahb_gates 44>;
> > +                       clocks = <&pll5 1>, <&ahb_gates 36>, <&ahb_gates 44>,
> > +                                <&dram_gates 26>;
> >                         status = "disabled";
> >                 };
> >
> > @@ -83,7 +84,7 @@
> >                                      "simple-framebuffer";
> >                         allwinner,pipeline = "de_be0-lcd0-tve0";
> >                         clocks = <&pll5 1>, <&ahb_gates 34>, <&ahb_gates 36>,
> > -                                <&ahb_gates 44>;
> > +                                <&ahb_gates 44>, <&dram_gates 26>;
> >                         status = "disabled";
> >                 };
> >         };
> > diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
> > index 9669b03f20f3..f29163650ca8 100644
> > --- a/arch/arm/boot/dts/sun5i-a13.dtsi
> > +++ b/arch/arm/boot/dts/sun5i-a13.dtsi
> > @@ -62,7 +62,7 @@
> >                                      "simple-framebuffer";
> >                         allwinner,pipeline = "de_be0-lcd0";
> >                         clocks = <&ahb_gates 36>, <&ahb_gates 44>, <&de_be_clk>,
> > -                                <&tcon_ch0_clk>;
> > +                                <&tcon_ch0_clk>, <&dram_gates 26>;
> >                         status = "disabled";
> >                 };
> >         };
> > diff --git a/arch/arm/boot/dts/sun5i-r8.dtsi b/arch/arm/boot/dts/sun5i-r8.dtsi
> > index b1e4e0170d51..691d3de75b35 100644
> > --- a/arch/arm/boot/dts/sun5i-r8.dtsi
> > +++ b/arch/arm/boot/dts/sun5i-r8.dtsi
> > @@ -53,7 +53,7 @@
> >                         allwinner,pipeline = "de_be0-lcd0-tve0";
> >                         clocks = <&ahb_gates 34>, <&ahb_gates 36>,
> >                                  <&ahb_gates 44>, <&de_be_clk>,
> > -                                <&tcon_ch1_clk>;
> > +                                <&tcon_ch1_clk>, <&dram_gates 26>;
> >                         status = "disabled";
> >                 };
> >         };
> > diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
> > index 0840612b5ed6..c72d94228915 100644
> > --- a/arch/arm/boot/dts/sun5i.dtsi
> > +++ b/arch/arm/boot/dts/sun5i.dtsi
> > @@ -338,6 +338,25 @@
> >                         clock-output-names = "usb_ohci0", "usb_phy";
> >                 };
> >
> > +               dram_gates: clk at 01c20100 {
> > +                       #clock-cells = <1>;
> > +                       compatible = "allwinner,sun5i-a13-dram-gates-clk";
> > +                       reg = <0x01c20100 0x4>;
> > +                       clocks = <&pll5 0>;
> > +                       clock-indices = <0>,
> > +                                       <1>,
> 
> According to A10s manual, bit 3 is DRAM clock for TS (transport stream
> decoder), while bit 5 is for the TV encoder.
> 
> The others look good.

I'll fix that, thanks!

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160203/6fac5061/attachment.sig>
