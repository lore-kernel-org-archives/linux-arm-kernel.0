From: richard.zhao@freescale.com (Richard Zhao)
Date: Mon, 12 Dec 2011 13:50:10 +0800
Subject: [PATCH 1/7] arm/imx6: add imx6q sabrelite board support
In-Reply-To: <20111212054053.GD9572@S2100-06.ap.freescale.net>
References: <1323661352-10291-1-git-send-email-richard.zhao@linaro.org>
 <1323661352-10291-2-git-send-email-richard.zhao@linaro.org>
 <20111212054053.GD9572@S2100-06.ap.freescale.net>
Message-ID: <20111212054857.GB16350@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 12, 2011 at 01:40:54PM +0800, Shawn Guo wrote:
> On Mon, Dec 12, 2011 at 11:42:26AM +0800, Richard Zhao wrote:
> > Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> > ---
> >  arch/arm/boot/dts/imx6q-sabrelite.dts |   54 +++++++++++++++++++++++++++++++++
> >  arch/arm/mach-imx/mach-imx6q.c        |    1 +
> >  2 files changed, 55 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/arm/boot/dts/imx6q-sabrelite.dts
> > 
> > diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
> > new file mode 100644
> > index 0000000..d54363f
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
> > @@ -0,0 +1,54 @@
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
> > +/include/ "imx6q.dtsi"
> > +
> > +/ {
> > +	model = "Freescale i.MX6 Quad SABRE Lite Board";
> > +	compatible = "fsl,imx6q-sabrelite", "fsl,imx6q";
> > +
> > +	chosen {
> > +		bootargs = "console=ttymxc1,115200";
> > +	};
> > +
> Maybe we can start dropping this, since kernel is now able to get
> bootargs from atags even in case that bootloader can not pass dtb
> and the dtb is appended to kernel image.
kernel has a config "Extend bootloader kernel arguments". Does it help
such case?
> 
> > +	memory {
> > +		reg = <0x10000000 0x40000000>;
> > +	};
> > +
> > +	soc {
> > +		aips-bus at 02100000 { /* AIPS2 */
> > +			enet at 02188000 {
> > +				phy-mode = "rgmii";
> > +				local-mac-address = [01 04 9F 01 1B 61];
> 
> Do we still have no way to figure the mac address from hardware setup
> (fuse or something) on sabrelite board?
No.
> 
> > +				phy-reset-gpios = <&gpio2 23 0>; /* gpio3 23 */
> 
> Nit: If you want to comment it, please comment it in the consistent way,
> which is '/* GPIO3_23 */'.
good catch.

Thanks
Richard
> 
> Regards,
> Shawn
> 
> > +				status = "okay";
> > +			};
> > +
> > +			usdhc at 02198000 { /* uSDHC3 */
> > +				cd-gpios = <&gpio6 0 0>; /* GPIO7_0 */
> > +				wp-gpios = <&gpio6 1 0>; /* GPIO7_1 */
> > +				status = "okay";
> > +			};
> > +
> > +			usdhc at 0219c000 { /* uSDHC4 */
> > +				cd-gpios = <&gpio1 6 0>; /* GPIO2_6 */
> > +				wp-gpios = <&gpio1 7 0>; /* GPIO2_7 */
> > +				status = "okay";
> > +			};
> > +
> > +			uart1: uart at 021e8000 { /* UART2 */
> > +				status = "okay";
> > +			};
> > +		};
> > +	};
> > +};
> > diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
> > index 8deb012..d24d6c4 100644
> > --- a/arch/arm/mach-imx/mach-imx6q.c
> > +++ b/arch/arm/mach-imx/mach-imx6q.c
> > @@ -73,6 +73,7 @@ static struct sys_timer imx6q_timer = {
> >  
> >  static const char *imx6q_dt_compat[] __initdata = {
> >  	"fsl,imx6q-sabreauto",
> > +	"fsl,imx6q-sabrelite",
> >  	NULL,
> >  };
> >  
> > -- 
> > 1.7.5.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
