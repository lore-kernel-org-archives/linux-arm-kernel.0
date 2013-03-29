From: simon.guinot@sequanux.org (Simon Guinot)
Date: Fri, 29 Mar 2013 19:51:20 +0100
Subject: [PATCH] ARM: kirkwood: DT board setup for CloudBox
In-Reply-To: <20130329170944.GA20592@lunn.ch>
References: <1364555206-5870-1-git-send-email-simon.guinot@sequanux.org>
 <20130329170944.GA20592@lunn.ch>
Message-ID: <20130329185120.GB16404@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 29, 2013 at 06:09:44PM +0100, Andrew Lunn wrote:
> On Fri, Mar 29, 2013 at 12:06:46PM +0100, Simon Guinot wrote:
> > This patch adds DT board setup for the LaCie NAS CloudBox. The CloudBox
> > is a low cost NAS based on the Network Space v2.
> > 
> > Chipset list:
> > - CPU MARVELL 88F6702 1Ghz
> > - SDRAM memory: 256MB DDR2-800 (2x128MB x8) 400Mhz
> > - 1 Ethernet Gigabit port (PHY MARVELL 88E1318)
> > - SPI flash, NOR 512KB
> > - 1 push button
> > - 2 LEDs (red and blue)
> > 
> > Note that there is no EEPROM and no USB ports embedded.
> > 
> > Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
> > ---
> >  arch/arm/boot/dts/Makefile              |    3 +-
> >  arch/arm/boot/dts/kirkwood-cloudbox.dts |   89 +++++++++++++++++++++++++++++++
> >  arch/arm/configs/kirkwood_defconfig     |    1 +
> >  arch/arm/mach-kirkwood/Kconfig          |    7 +++
> >  arch/arm/mach-kirkwood/Makefile         |    1 +
> >  arch/arm/mach-kirkwood/board-dt.c       |    4 +-
> >  arch/arm/mach-kirkwood/board-ns2.c      |    3 +-
> >  arch/arm/mach-kirkwood/common.h         |    6 +++
> >  8 files changed, 111 insertions(+), 3 deletions(-)
> >  create mode 100644 arch/arm/boot/dts/kirkwood-cloudbox.dts
> > 
> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > index 9c62558..8b535ad 100644
> > --- a/arch/arm/boot/dts/Makefile
> > +++ b/arch/arm/boot/dts/Makefile
> > @@ -51,7 +51,8 @@ dtb-$(CONFIG_ARCH_HIGHBANK) += highbank.dtb \
> >  dtb-$(CONFIG_ARCH_INTEGRATOR) += integratorap.dtb \
> >  	integratorcp.dtb
> >  dtb-$(CONFIG_ARCH_LPC32XX) += ea3250.dtb phy3250.dtb
> > -dtb-$(CONFIG_ARCH_KIRKWOOD) += kirkwood-dns320.dtb \
> > +dtb-$(CONFIG_ARCH_KIRKWOOD) += kirkwood-cloudbox.dtb \
> > +	kirkwood-dns320.dtb \
> >  	kirkwood-dns325.dtb \
> >  	kirkwood-dockstar.dtb \
> >  	kirkwood-dreamplug.dtb \
> > diff --git a/arch/arm/boot/dts/kirkwood-cloudbox.dts b/arch/arm/boot/dts/kirkwood-cloudbox.dts
> > new file mode 100644
> > index 0000000..93024b7
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/kirkwood-cloudbox.dts
> > @@ -0,0 +1,89 @@
> > +/dts-v1/;
> > +
> > +/include/ "kirkwood.dtsi"
> > +/include/ "kirkwood-6281.dtsi"
> > +
> > +/ {
> > +	model = "LaCie CloudBox";
> > +	compatible = "lacie,cloudbox", "marvell,kirkwood-88f6702", "marvell,kirkwood";
> > +
> > +	memory {
> > +		device_type = "memory";
> > +		reg = <0x00000000 0x10000000>;
> > +	};
> > +
> > +	chosen {
> > +		bootargs = "console=ttyS0,115200n8";
> > +	};
> > +
> > +	ocp at f1000000 {
> > +		pinctrl: pinctrl at 10000 {
> > +			pinctrl-0 = < &pmx_spi &pmx_twsi0 &pmx_uart0
> 
> Hi Simon
> 
> Is I2C used? You have pinctrl, but no nodes defined in DT.

No you are right. Good catch.

> 
> > +					&pmx_cloudbox_sata0 >;
> > +			pinctrl-names = "default";
> > +
> > +			pmx_cloudbox_sata0: pmx-cloudbox-sata0 {
> > +				marvell,pins = "mpp15";
> > +				marvell,function = "sata0";
> > +			};
> > +		};
> > +
> > +		serial at 12000 {
> > +			clock-frequency = <166666667>;
> > +			status = "okay";
> > +		};
> > +
> > +		sata at 80000 {
> > +			status = "okay";
> > +			nr-ports = <1>;
> > +		};
> > +
> > +		spi at 10600 {
> > +			status = "okay";
> > +
> > +			flash at 0 {
> > +				#address-cells = <1>;
> > +				#size-cells = <1>;
> > +				compatible = "mx25l4005a";
> > +				reg = <0>;
> > +				spi-max-frequency = <20000000>;
> > +				mode = <0>;
> > +
> > +				partition at 0 {
> > +					reg = <0x0 0x80000>;
> > +					label = "u-boot";
> > +				};
> > +			};
> > +		};
> > +	};
> > +
> > +	gpio_keys {
> > +		compatible = "gpio-keys";
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +
> > +		button at 1 {
> > +			label = "Power push button";
> > +			linux,code = <116>;
> > +			gpios = <&gpio0 16 1>;
> > +		};
> > +	};
> > +
> > +	gpio-leds {
> > +		compatible = "gpio-leds";
> > +
> > +		red-fail {
> > +			label = "cloudbox:red:fail";
> > +			gpios = <&gpio0 14 0>;
> > +		};
> > +		blue-sata {
> > +			label = "cloudbox:blue:sata";
> > +			gpios = <&gpio0 15 0>;
> > +		};
> > +	};
> > +
> > +	gpio_poweroff {
> > +		compatible = "gpio-poweroff";
> > +		gpios = <&gpio0 17 0>;
> > +	};
> > +};
> > diff --git a/arch/arm/configs/kirkwood_defconfig b/arch/arm/configs/kirkwood_defconfig
> > index 13482ea..94aff34 100644
> > --- a/arch/arm/configs/kirkwood_defconfig
> > +++ b/arch/arm/configs/kirkwood_defconfig
> > @@ -35,6 +35,7 @@ CONFIG_MACH_NETSPACE_LITE_V2_DT=y
> >  CONFIG_MACH_NETSPACE_MINI_V2_DT=y
> >  CONFIG_MACH_OPENBLOCKS_A6_DT=y
> >  CONFIG_MACH_TOPKICK_DT=y
> > +CONFIG_MACH_CLOUDBOX_DT=y
> 
> Alphabetic order please. Same below for all other additions. Did Jason
> already so that? Sorry, i did not read his reply yet.

Indirectly I guess. Jason asked me to move the Kconfig CloudBox entry.
As a side effect, the defconfig entry will move too :)

Thanks for the quick feedbacks.

Simon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130329/aa1b5842/attachment.sig>
