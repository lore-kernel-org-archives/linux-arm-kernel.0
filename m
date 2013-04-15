From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 15 Apr 2013 10:05:32 +0200
Subject: [PATCH v2 3/4] ARM: dts: mx53qsb: Add support for parallel display
In-Reply-To: <CAOkaPuV2xNR=Vxsa6tPdnPS34Q5ffV9-f8DefhcJfvVvXWOADQ@mail.gmail.com>
References: <1365516452-1287-1-git-send-email-rogerio.pimentel@freescale.com>
 <1365516452-1287-3-git-send-email-rogerio.pimentel@freescale.com>
 <1365520643.4023.52.camel@pizza.hi.pengutronix.de>
 <CAOkaPuV2xNR=Vxsa6tPdnPS34Q5ffV9-f8DefhcJfvVvXWOADQ@mail.gmail.com>
Message-ID: <1366013132.4012.13.camel@pizza.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, den 12.04.2013, 15:49 -0300 schrieb Rogerio Pimentel:
> On Tue, Apr 9, 2013 at 12:17 PM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> > Am Dienstag, den 09.04.2013, 11:07 -0300 schrieb Rogerio Pimentel:
> >> Add support for CLAA WVGA display for i.MX53 QSB.
> >>
> >> Signed-off-by: Rogerio Pimentel <rogerio.pimentel@freescale.com>
> >> ---
> >> Changes since v1:
> >> Changed the label disp1 to disp0 to correctly match the display pins
> >>  arch/arm/boot/dts/imx53-qsb.dtsp |   26 ++++++++++++++++++++++++++
> >>  arch/arm/boot/dts/imx53.dtsip    |   35 +++++++++++++++++++++++++++++++++++
> >>  2 files changed, 61 insertions(+)
> >>
> >> diff --git a/arch/arm/boot/dts/imx53-qsb.dtsp b/arch/arm/boot/dts/imx53-qsb.dtsp
> >> index dae8d9f..6086a3c 100644
> >> --- a/arch/arm/boot/dts/imx53-qsb.dtsp
> >> +++ b/arch/arm/boot/dts/imx53-qsb.dtsp
> >> @@ -21,6 +21,32 @@
> >>               reg = <0x70000000 0x40000000>;
> >>       };
> >>
> >> +     display at di0 {
> >> +             compatible = "fsl,imx-parallel-display";
> >> +             crtcs = <&ipu 0>;
> >> +             interface-pix-fmt = "rgb565";
> >> +             pinctrl-names = "default";
> >> +             pinctrl-0 = <&pinctrl_ipu_disp0_1>;
> >> +             display-timings {
> >> +                     claawvga {
> >> +                             native-mode;
> >> +                             clock-frequency = <27000000>;
> >> +                             hactive = <800>;
> >> +                             vactive = <480>;
> >> +                             hback-porch = <40>;
> >> +                             hfront-porch = <60>;
> >> +                             vback-porch = <10>;
> >> +                             vfront-porch = <10>;
> >> +                             hsync-len = <20>;
> >> +                             vsync-len = <10>;
> >> +                             hsync-active = <0>;
> >> +                             vsync-active = <0>;
> >> +                             de-active = <1>;
> >> +                             pixelclk-active = <0>;
> >> +                     };
> >> +             };
> >> +     };
> >> +
> >
> > This clashes with the MCIMXHDMICARD daughter module, which has a sii902x
> > HDMI encoder connected to DISP0 for i.MX53-QSB. Would it make sense to
> > add all possible options to the device tree but mark them with
> > status = "disabled" by default?
> >
> > regards
> > Philipp
> >
> I'm planning to add support for MCIMXHDMICARD later because it will also
> require support for sii902x.

That's good to hear. We have some (very) work-in-progress sii902x driver
patches floating around, if you are interested.

>  I'd like to add the parallel display that
> we have available
> today and after that add the support for sii902x. What do you think?

As Sascha said, I'm in favor of adding the parallel display support now,
but with the status = "disabled" property in there.
Then anybody who has the CLAAWVGA display can just set status = "okay"
manually at build time or from the bootloader.

regards
Philipp
