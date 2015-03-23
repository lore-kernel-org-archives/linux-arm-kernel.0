From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Mon, 23 Mar 2015 18:54:34 +0100 (CET)
Subject: [PATCH 5/7] ARM: dts: enable regulator support for i.MX23/i.MX28
In-Reply-To: <20150323060706.GB4946@pengutronix.de>
References: <1426984203-9133-1-git-send-email-stefan.wahren@i2se.com>
 <1426984203-9133-6-git-send-email-stefan.wahren@i2se.com>
 <20150323060706.GB4946@pengutronix.de>
Message-ID: <1469391177.549604.1427133274978.JavaMail.open-xchange@oxbaltgw02.schlund.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

> Sascha Hauer <s.hauer@pengutronix.de> hat am 23. M?rz 2015 um 07:07
> geschrieben:
>
>
> On Sun, Mar 22, 2015 at 12:30:01AM +0000, Stefan Wahren wrote:
> > This patch enables the on-chip regulator support for all i.MX23 and
> > i.MX28 boards.
> >
> > Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> > ---
> > arch/arm/boot/dts/imx23.dtsi | 67 +++++++++++++++++++++++++++++++++++++++++-
> > arch/arm/boot/dts/imx28.dtsi | 67 +++++++++++++++++++++++++++++++++++++++++-
> > 2 files changed, 132 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
> > index bbcfb5a..be0aee8 100644
> > --- a/arch/arm/boot/dts/imx23.dtsi
> > +++ b/arch/arm/boot/dts/imx23.dtsi
> > @@ -404,8 +404,73 @@
> > };
> >
> > power at 80044000 {
> > + compatible = "fsl,imx23-power";
> > + #address-cells = <1>;
> > + #size-cells = <1>;
> > reg = <0x80044000 0x2000>;
> > - status = "disabled";
> > + interrupts = <3>;
> > + ranges;
> > +
> > + dcdc: regulator at 80044010 {
> > + reg = <0x80044010 0x10>,
> > + <0x80044090 0x10>,
> > + <0x800440c0 0x10>;
> > + reg-names = "base-address",
> > + "misc-address",
> > + "status-address";
> > + compatible = "fsl,imx23-dcdc";
> > + regulator-name = "dcdc";
> > + regulator-boot-on;
> > + regulator-always-on;
> > + };
>
> It is very unusual to describe the regulators of a device on a register
> level like this and to iomemap each register individually. I think you
> should drop the registers here and put this knowledge into the driver
> like (nearly?) all others do.

do mean dropping the base address of the regulator, too?

How would you implement it (bare register address or regmap or syscon), since
there
are overlapping register regions for different driver?

@Mark: What's your opinion?

Stefan

>
> Sascha
>
> --
> Pengutronix e.K. | |
> Industrial Linux Solutions | http://www.pengutronix.de/ |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0 |
> Amtsgericht Hildesheim, HRA 2686 | Fax: +49-5121-206917-5555 |
