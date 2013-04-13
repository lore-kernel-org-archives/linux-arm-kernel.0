From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Sat, 13 Apr 2013 19:09:43 +0200
Subject: [PATCH v2 3/4] ARM: dts: mx53qsb: Add support for parallel display
In-Reply-To: <CAOkaPuV2xNR=Vxsa6tPdnPS34Q5ffV9-f8DefhcJfvVvXWOADQ@mail.gmail.com>
References: <1365516452-1287-1-git-send-email-rogerio.pimentel@freescale.com>
 <1365516452-1287-3-git-send-email-rogerio.pimentel@freescale.com>
 <1365520643.4023.52.camel@pizza.hi.pengutronix.de>
 <CAOkaPuV2xNR=Vxsa6tPdnPS34Q5ffV9-f8DefhcJfvVvXWOADQ@mail.gmail.com>
Message-ID: <20130413170943.GX1906@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 12, 2013 at 03:49:09PM -0300, Rogerio Pimentel wrote:
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
> require support for sii902x. I'd like to add the parallel display that
> we have available
> today and after that add the support for sii902x. What do you think?

Having the parallel display support is fine. Philipp just suggested to
add status = "disabled" for both the parallel display and the lvds
encoder so that for example the bootloader can decide which one to enable
during runtime. Otherwise we have two display options on the same pins and
the first one wins.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
