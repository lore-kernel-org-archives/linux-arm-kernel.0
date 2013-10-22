From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 22 Oct 2013 23:57:47 +0200
Subject: [PATCH 7/8] ARM: dts: imx: add IMX50 SoC device tree bindings
In-Reply-To: <CAHCPf3tLovKaCWAQn13c+ifvzQH4ojcXyevYxbh018XYYK=xJA@mail.gmail.com>
References: <1382076260-6422-1-git-send-email-gerg@uclinux.org>
 <1382076260-6422-8-git-send-email-gerg@uclinux.org>
 <20131022123544.GB31304@pengutronix.de>
 <CAHCPf3tLovKaCWAQn13c+ifvzQH4ojcXyevYxbh018XYYK=xJA@mail.gmail.com>
Message-ID: <20131022215747.GC31304@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 22, 2013 at 03:08:43PM -0500, Matt Sealey wrote:
> On Tue, Oct 22, 2013 at 7:35 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > On Fri, Oct 18, 2013 at 04:04:19PM +1000, gerg at uclinux.org wrote:
> >> From: Greg Ungerer <gerg@uclinux.org>
> >>
> >> Create device tree bindings for the Freescale IMX50 SoC. This was based on
> >> the IMX53 bindings with changes made as necessary.
> >>
> >> Signed-off-by: Greg Ungerer <gerg@uclinux.org>
> >> ---
> >> +
> >> +                     iomuxc: iomuxc at 53fa8000 {
> >> +                             compatible = "fsl,imx50-iomuxc";
> >> +                             reg = <0x53fa8000 0x4000>;
> >> +
> >> +                             fec {
> >> +                                     pinctrl_fec_1: fecgrp-1 {
> >> +                                             fsl,pins = <
> >> +                                                     MX50_PAD_SSI_RXFS__FEC_MDC      0x80
> >> +                                                     MX50_PAD_SSI_RXC__FEC_MDIO      0x80
> >> +                                                     MX50_PAD_DISP_D0__FEC_TX_CLK    0x80
> >> +                                                     MX50_PAD_DISP_D1__FEC_RX_ERR    0x80
> >> +                                                     MX50_PAD_DISP_D2__FEC_RX_DV     0x80
> >> +                                                     MX50_PAD_DISP_D3__FEC_RDATA_1   0x80
> >> +                                                     MX50_PAD_DISP_D4__FEC_RDATA_0   0x80
> >> +                                                     MX50_PAD_DISP_D5__FEC_TX_EN     0x80
> >> +                                                     MX50_PAD_DISP_D6__FEC_TDATA_1   0x80
> >> +                                                     MX50_PAD_DISP_D7__FEC_TDATA_0   0x80
> >> +                                             >;
> >> +                                     };
> >> +
> >
> > Shawn recently removed the pinctrl groups here and referenced to this
> > node by doing
> >
> > &iomuxc {
> >         fec {
> >                 ...
> >         };
> > };
> >
> >> +                             cspi {
> >> +                                     pinctrl_cspi_1: cspigrp-1 {
> >> +                                             fsl,pins = <
> >> +                                                     MX50_PAD_CSPI_SCLK__CSPI_SCLK   0
> >
> > 0 is definitely wrong here. We have 0x80000000 for "Don't touch
> > padctrl", but otherwise this should contain some real padctrl settings.
> 
> A more pressing question is in what world did the bootloader not
> already set these pins up and if they are already set up, why are they
> loitering in the device tree?

Having NO_PAD_CTRL in the devicetree doesn't make sense, you're right.
Either a pin has to be configured by the bootloader completely or not at
all. Having the mux configured by the kernel and the drive strength by
the bootloader is broken by design. All pins should have a complete
padctrl setup and NO_PAD_CTRL should be dropped.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
