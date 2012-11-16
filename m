From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 16 Nov 2012 17:36:45 +0100
Subject: [PATCH 1/1] ARM: kirkwood: Add support for the MPL CEC4
In-Reply-To: <20121116151128.GO22106@titan.lakedaemon.net>
References: <cover.1353055273.git.s.peter@mpl.ch>
 <7f8832a749a9ebc378460f26d13ed524b7da18a8.1353055273.git.s.peter@mpl.ch>
 <20121116151128.GO22106@titan.lakedaemon.net>
Message-ID: <20121116163645.GC24569@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 16, 2012 at 10:11:28AM -0500, Jason Cooper wrote:
> Stefan,
> 
> Thanks for the patch!  I didn't know kirkwood made it into industrial
> controllers.  Comments below.
> 
> On Fri, Nov 16, 2012 at 11:10:22AM +0100, Stefan Peter wrote:
> > 
> > Signed-off-by: Stefan Peter <s.peter@mpl.ch>
> > 
> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > index f37cf9f..bc1c8f2 100644
> > --- a/arch/arm/boot/dts/Makefile
> > +++ b/arch/arm/boot/dts/Makefile
> > @@ -40,7 +40,8 @@ dtb-$(CONFIG_ARCH_KIRKWOOD) += kirkwood-dns320.dtb \
> >  	kirkwood-lschlv2.dtb \
> >  	kirkwood-lsxhl.dtb \
> >  	kirkwood-ts219-6281.dtb \
> > -	kirkwood-ts219-6282.dtb
> > +	kirkwood-ts219-6282.dtb \
> > +	kirkwood-mplcec4.dtb
> 
> Please insert in alphabetical order.  This reduces merge conflicts for
> us.
> 
> >  dtb-$(CONFIG_ARCH_MSM) += msm8660-surf.dtb \
> >  	msm8960-cdp.dtb
> >  dtb-$(CONFIG_ARCH_MVEBU) += armada-370-db.dtb \
> > diff --git a/arch/arm/boot/dts/kirkwood-mplcec4.dts b/arch/arm/boot/dts/kirkwood-mplcec4.dts
> > new file mode 100644
> > index 0000000..d221487
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/kirkwood-mplcec4.dts
> > @@ -0,0 +1,119 @@
> > +/dts-v1/;
> > +
> > +/include/ "kirkwood.dtsi"
> > +
> > +/ {
> > +	model = "MPL CEC4";
> > +	compatible = "mpl,mplcec4", "marvell,kirkwood-88f6281", "marvell,kirkwood";
> 
> Perhaps "mpl,cec4-10", "mpl,cec4", "marvell..." would be more
> appropriate here, according to the slick sheet.
> 
> > +
> > +        memory {
> > +                device_type = "memory";
> > +                reg = <0x00000000 0x20000000>;
> > +        };
> > +
> > +        chosen {
> > +                bootargs = "console=ttyS0,115200n8 earlyprintk";
> > +        };
> > +
> > +	ocp at f1000000 {
> > +                i2c at 11000 {
> > +                        status = "okay";
> > +
> > +			rtc at 51 {
> > +				compatible = "nxp,pcf8563";
> > +				reg = <0x51>;
> > +			};
> > +
> > +			eeprom at 57 {
> > +				compatible = "atmel,24c02";
> > +				reg = <0x57>;
> > +			};
> > +
> > +                };
> > +
> > +                serial at 12000 {
> > +                        clock-frequency = <200000000>;
> > +                        status = "ok";
> > +                };
> > +
> > +                nand at 3000000 {
> > +                        status = "okay";
> > +
> > +                        partition at 0 {
> > +                                label = "uboot";
> > +                                reg = <0x0000000 0x100000>;
> > +                        };
> > +
> > +                        partition at 100000 {
> > +                                label = "env";
> > +                                reg = <0x100000 0x80000>;
> > +                        };
> > +
> > +                        partition at 180000 {
> > +                                label = "fdt";
> > +                                reg = <0x180000 0x80000>;
> > +                        };
> > +
> > +                        partition at 200000 {
> > +                                label = "kernel";
> > +                                reg = <0x200000 0x400000>;
> > +                        };
> > +
> > +                        partition at 600000 {
> > +                                label = "rootfs";
> > +                                reg = <0x600000 0x1fa00000>;
> > +                        };
> > +                };
> > +
> > +		rtc at 10300 {
> > +			status = "disabled";
> > +		};
> 
> really?

Hi Jason

The pcf8563 on the i2c bus is an RTC.

I don't know why, but my QNAP also has an I2C RTC and the Armada XP
based OpenBlocks AX3 has one as well.

      Andrew
