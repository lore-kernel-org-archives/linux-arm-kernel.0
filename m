From: benoit.thebaudeau@advansee.com (=?utf-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?=)
Date: Wed, 23 Oct 2013 00:42:11 +0200 (CEST)
Subject: [PATCH 7/8] ARM: dts: imx: add IMX50 SoC device tree bindings
In-Reply-To: <20131022215747.GC31304@pengutronix.de>
References: <1382076260-6422-1-git-send-email-gerg@uclinux.org>
 <1382076260-6422-8-git-send-email-gerg@uclinux.org>
 <20131022123544.GB31304@pengutronix.de>
 <CAHCPf3tLovKaCWAQn13c+ifvzQH4ojcXyevYxbh018XYYK=xJA@mail.gmail.com>
 <20131022215747.GC31304@pengutronix.de>
Message-ID: <1608328105.3024513.1382481731286.JavaMail.zimbra@advansee.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Sascha Hauer,

On Tuesday, October 22, 2013 11:57:47 PM, Sascha Hauer wrote:
> On Tue, Oct 22, 2013 at 03:08:43PM -0500, Matt Sealey wrote:
> > On Tue, Oct 22, 2013 at 7:35 AM, Sascha Hauer <s.hauer@pengutronix.de>
> > wrote:
> > > On Fri, Oct 18, 2013 at 04:04:19PM +1000, gerg at uclinux.org wrote:
> > >> From: Greg Ungerer <gerg@uclinux.org>
> > >>
> > >> Create device tree bindings for the Freescale IMX50 SoC. This was based
> > >> on
> > >> the IMX53 bindings with changes made as necessary.
> > >>
> > >> Signed-off-by: Greg Ungerer <gerg@uclinux.org>
> > >> ---
> > >> +
> > >> +                     iomuxc: iomuxc at 53fa8000 {
> > >> +                             compatible = "fsl,imx50-iomuxc";
> > >> +                             reg = <0x53fa8000 0x4000>;
> > >> +
> > >> +                             fec {
> > >> +                                     pinctrl_fec_1: fecgrp-1 {
> > >> +                                             fsl,pins = <
> > >> +
> > >> MX50_PAD_SSI_RXFS__FEC_MDC
> > >> 0x80
> > >> +
> > >> MX50_PAD_SSI_RXC__FEC_MDIO
> > >> 0x80
> > >> +
> > >> MX50_PAD_DISP_D0__FEC_TX_CLK
> > >> 0x80
> > >> +
> > >> MX50_PAD_DISP_D1__FEC_RX_ERR
> > >> 0x80
> > >> +
> > >> MX50_PAD_DISP_D2__FEC_RX_DV
> > >> 0x80
> > >> +
> > >> MX50_PAD_DISP_D3__FEC_RDATA_1
> > >> 0x80
> > >> +
> > >> MX50_PAD_DISP_D4__FEC_RDATA_0
> > >> 0x80
> > >> +
> > >> MX50_PAD_DISP_D5__FEC_TX_EN
> > >> 0x80
> > >> +
> > >> MX50_PAD_DISP_D6__FEC_TDATA_1
> > >> 0x80
> > >> +
> > >> MX50_PAD_DISP_D7__FEC_TDATA_0
> > >> 0x80
> > >> +                                             >;
> > >> +                                     };
> > >> +
> > >
> > > Shawn recently removed the pinctrl groups here and referenced to this
> > > node by doing
> > >
> > > &iomuxc {
> > >         fec {
> > >                 ...
> > >         };
> > > };
> > >
> > >> +                             cspi {
> > >> +                                     pinctrl_cspi_1: cspigrp-1 {
> > >> +                                             fsl,pins = <
> > >> +
> > >> MX50_PAD_CSPI_SCLK__CSPI_SCLK
> > >> 0
> > >
> > > 0 is definitely wrong here. We have 0x80000000 for "Don't touch
> > > padctrl", but otherwise this should contain some real padctrl settings.
> > 
> > A more pressing question is in what world did the bootloader not
> > already set these pins up and if they are already set up, why are they
> > loitering in the device tree?
> 
> Having NO_PAD_CTRL in the devicetree doesn't make sense, you're right.
> Either a pin has to be configured by the bootloader completely or not at
> all. Having the mux configured by the kernel and the drive strength by
> the bootloader is broken by design. All pins should have a complete
> padctrl setup and NO_PAD_CTRL should be dropped.

Some pins may be configured completely by the kernel, and not at all by the
bootloader. In that case, the device tree may wish to keep the SoC reset pad
configuration. NO_PAD_CTRL is useful in that case, although one might argue that
the reset values should not be trusted for various reasons.

But there is another case. One SoC pin may be connected to several external
devices, e.g. through an external analog mux. In that case, the bootloader may
configure the SoC mux and pad for one usage, while the kernel may afterwards
change only the mux configuration of this pin for the other usage.

So NO_PAD_CTRL is not strictly required for pinctrl, but it can be handy.

Best regards,
Beno?t
