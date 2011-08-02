From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 2 Aug 2011 09:22:11 +0800
Subject: [PATCH v3 1/2] arm/mx5: add device tree support for imx53 boards
In-Reply-To: <20110802065814.GM31404@pengutronix.de>
References: <1312226252-8566-1-git-send-email-shawn.guo@linaro.org>
	<1312226252-8566-2-git-send-email-shawn.guo@linaro.org>
	<20110802065814.GM31404@pengutronix.de>
Message-ID: <20110802012209.GA23413@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 02, 2011 at 08:58:14AM +0200, Sascha Hauer wrote:
> On Tue, Aug 02, 2011 at 03:17:31AM +0800, Shawn Guo wrote:
> > From: Shawn Guo <shawn.guo@freescale.com>
> > 
> > It adds device tree support for imx53 boards.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > Cc: Grant Likely <grant.likely@secretlab.ca>
> > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  .../devicetree/bindings/arm/fsl/boards.txt         |   15 ++
> >  arch/arm/boot/dts/imx53-ard.dts                    |  158 +++++++++++++
> >  arch/arm/boot/dts/imx53-evk.dts                    |  144 ++++++++++++
> >  arch/arm/boot/dts/imx53-qsb.dts                    |  148 ++++++++++++
> >  arch/arm/boot/dts/imx53-smd.dts                    |  169 ++++++++++++++
> >  arch/arm/boot/dts/imx53.dtsi                       |  244 ++++++++++++++++++++
> >  arch/arm/mach-mx5/Kconfig                          |   12 +
> >  arch/arm/mach-mx5/Makefile                         |    2 +
> >  arch/arm/mach-mx5/board-mx53_ard.c                 |    9 +-
> >  arch/arm/mach-mx5/board-mx53_evk.c                 |    5 +
> >  arch/arm/mach-mx5/board-mx53_loco.c                |    5 +
> >  arch/arm/mach-mx5/board-mx53_smd.c                 |    5 +
> >  arch/arm/mach-mx5/imx53-dt.c                       |  143 ++++++++++++
> >  arch/arm/plat-mxc/include/mach/common.h            |    2 +
> >  arch/arm/plat-mxc/include/mach/iomux-mx53.h        |    5 +
> >  arch/arm/plat-mxc/include/mach/iomux-v3.h          |    5 +
> >  16 files changed, 1069 insertions(+), 2 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/arm/fsl/boards.txt
> >  create mode 100644 arch/arm/boot/dts/imx53-ard.dts
> >  create mode 100644 arch/arm/boot/dts/imx53-evk.dts
> >  create mode 100644 arch/arm/boot/dts/imx53-qsb.dts
> >  create mode 100644 arch/arm/boot/dts/imx53-smd.dts
> >  create mode 100644 arch/arm/boot/dts/imx53.dtsi
> >  create mode 100644 arch/arm/mach-mx5/imx53-dt.c
> 
> I noticed that the iomux setup is gone for now which makes me very
> happy :) I didn't have a good feeling about this.
> 
But it's just for now :)  We anyway need to set it up from device tree
sooner or later.

> > 
> > diff --git a/arch/arm/boot/dts/imx53-ard.dts b/arch/arm/boot/dts/imx53-ard.dts
> > new file mode 100644
> > index 0000000..fd0cf2c
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/imx53-ard.dts
> > @@ -0,0 +1,158 @@
> > +/*
> > + * Copyright 2011 Freescale Semiconductor, Inc.
> > + * Copyright 2011 Linaro Ltd.
> > + *
> > + * The code contained herein is licensed under the GNU General Public
> > + * License. You may obtain a copy of the GNU General Public License
> > + * Version 2 or later at the following locations:
> > + *
> > + * http://www.opensource.org/licenses/gpl-license.html
> > + * http://www.gnu.org/copyleft/gpl.html
> > + */
> > +
> > +/dts-v1/;
> > +/include/ "imx53.dtsi"
> > +
> > +/ {
> > +	model = "Freescale i.MX53 Automotive Reference Design Board";
> > +	compatible = "fsl,imx53-ard", "fsl,imx53";
> > +
> > +	chosen {
> > +		bootargs = "console=ttymxc0,115200 root=/dev/mmcblk0p3 rootwait";
> > +	};
> > +
> > +	memory {
> > +		reg = <0x70000000 0x40000000>;
> > +	};
> > +
> > +	aips at 50000000 { /* AIPS1 */
> > +		spba at 50000000 {
> > +			esdhc at 50004000 { /* ESDHC1 */
> > +				cd-gpios = <&gpio0 1 0>; /* GPIO1_1 */
> > +				wp-gpios = <&gpio0 9 0>; /* GPIO1_9 */
> > +			};
> > +
> > +			esdhc at 50008000 { /* ESDHC2 */
> > +				status = "disabled";
> > +			};
> 
> I know the decision is that all devices are enabled by default and must
> be explicitely disabled like this. I really hope we can change this in
> the future for the following reasons:
> 
> - The imx53 device tree is not complete, several devices like nand, ipu
>   and rtc are missing. Now when imx53.dtsi gets the nand device, all
>   board devicetrees have to be changed to keep the old behaviour.
> - Most enabled device entries like the esdhc1 above have additional
>   nodes like cd-gpios anyway, so they must appear in the board tree
>   whereas the disabled devices just add additional churn.
> 
I fully have your back on this point.  Let's try one more time to
change Grant's mind.

-- 
Regards,
Shawn
