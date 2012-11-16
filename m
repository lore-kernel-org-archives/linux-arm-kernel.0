From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 16 Nov 2012 10:27:42 -0500
Subject: [PATCH 1/1] ARM: kirkwood: Add support for the MPL CEC4
In-Reply-To: <20121116151128.GO22106@titan.lakedaemon.net>
References: <cover.1353055273.git.s.peter@mpl.ch>
 <7f8832a749a9ebc378460f26d13ed524b7da18a8.1353055273.git.s.peter@mpl.ch>
 <20121116151128.GO22106@titan.lakedaemon.net>
Message-ID: <20121116152742.GQ22106@titan.lakedaemon.net>
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
> 
> > +
> > +		sata at 80000 {
> > +			nr-ports = <2>;
> > +			status = "okay";
> > +
> > +		};
> > +	};
> > +
> > +	gpio-leds {
> > +		compatible = "gpio-leds";
> > +
> > +		health {
> > +			label = "status:green:health";
> > +			gpios = <&gpio0 7 1>;
> > +		};
> > +
> > +		user1o {
> > +			label = "user1:orange";
> > +			gpios = <&gpio1 8 1>;
> > +			default-state = "on";
> > +		};
> > +
> > +		user1g {
> > +			label = "user1:green";
> > +			gpios = <&gpio1 9 1>;
> > +			default-state = "on";
> > +		};
> > +
> > +		user0o {
> > +			label = "user0:orange";
> > +			gpios = <&gpio1 12 1>;
> > +			default-state = "on";
> > +		};
> > +
> > +		user0g {
> > +			label = "user0:green";
> > +			gpios = <&gpio1 13 1>;
> > +			default-state = "on";
> > +		};
> > +
> > +		misc {
> > +			label = "status:orange:misc";
> > +			gpios = <&gpio1 14 1>;
> > +			default-state = "on";
> > +		};
> > +
> > +	};
> > +};
> > +
> > diff --git a/arch/arm/configs/kirkwood_defconfig b/arch/arm/configs/kirkwood_defconfig
> > index 74eee0c..6b50d97 100644
> > --- a/arch/arm/configs/kirkwood_defconfig
> > +++ b/arch/arm/configs/kirkwood_defconfig
> > @@ -27,6 +27,7 @@ CONFIG_MACH_GOFLEXNET_DT=y
> >  CONFIG_MACH_LSXL_DT=y
> >  CONFIG_MACH_IOMEGA_IX2_200_DT=y
> >  CONFIG_MACH_KM_KIRKWOOD_DT=y
> > +CONFIG_MACH_MPLCEC4_DT=y
> 
> Thank you.  :-)
> 
> >  CONFIG_MACH_TS219=y
> >  CONFIG_MACH_TS41X=y
> >  CONFIG_MACH_DOCKSTAR=y
> > diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
> > index 50bca50..19fd95c 100644
> > --- a/arch/arm/mach-kirkwood/Kconfig
> > +++ b/arch/arm/mach-kirkwood/Kconfig
> > @@ -130,6 +130,13 @@ config MACH_KM_KIRKWOOD_DT
> >  	  Say 'Y' here if you want your kernel to support the
> >  	  Keymile Kirkwood Reference Desgin, using Flattened Device Tree.
> >  
> > +config MACH_MPLCEC4_DT
> > +	bool "MPL CEC4 (Flattened Device Tree)"
> > +	select ARCH_KIRKWOOD_DT
> > +	help
> > +	  Say 'Y' here if you want your kernel to support the
> > +	  MPL CEC4 (Flattened Device Tree).
> > +
> >  config MACH_TS219
> >  	bool "QNAP TS-110, TS-119, TS-119P+, TS-210, TS-219, TS-219P and TS-219P+ Turbo NAS"
> >  	help
> > diff --git a/arch/arm/mach-kirkwood/Makefile b/arch/arm/mach-kirkwood/Makefile
> > index 294779f..a523b90 100644
> > --- a/arch/arm/mach-kirkwood/Makefile
> > +++ b/arch/arm/mach-kirkwood/Makefile
> > @@ -31,3 +31,4 @@ obj-$(CONFIG_MACH_GOFLEXNET_DT)		+= board-goflexnet.o
> >  obj-$(CONFIG_MACH_LSXL_DT)		+= board-lsxl.o
> >  obj-$(CONFIG_MACH_IOMEGA_IX2_200_DT)	+= board-iomega_ix2_200.o
> >  obj-$(CONFIG_MACH_KM_KIRKWOOD_DT)	+= board-km_kirkwood.o
> > +obj-$(CONFIG_MACH_MPLCEC4_DT)		+= board-mplcec4.o
> > diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
> > index d94872f..e2e650e 100644
> > --- a/arch/arm/mach-kirkwood/board-dt.c
> > +++ b/arch/arm/mach-kirkwood/board-dt.c
> > @@ -94,6 +94,9 @@ static void __init kirkwood_dt_init(void)
> >  	if (of_machine_is_compatible("keymile,km_kirkwood"))
> >  		km_kirkwood_init();
> >  
> > +	if (of_machine_is_compatible("mpl,mplcec4"))
> 
> With the above comment, this would be "mpl,cec4"
> 
> > +		mplcec4_init();
> > +
> >  	of_platform_populate(NULL, kirkwood_dt_match_table,
> >  			     kirkwood_auxdata_lookup, NULL);
> >  }
> > @@ -110,6 +113,7 @@ static const char *kirkwood_dt_board_compat[] = {
> >  	"buffalo,lsxl",
> >  	"iom,ix2-200",
> >  	"keymile,km_kirkwood",
> > +	"mpl,mplcec4",
> 
> Same.
> 
> >  	NULL
> >  };
> >  
> > diff --git a/arch/arm/mach-kirkwood/board-mplcec4.c b/arch/arm/mach-kirkwood/board-mplcec4.c
> > new file mode 100644
> > index 0000000..ea26b62
> > --- /dev/null
> > +++ b/arch/arm/mach-kirkwood/board-mplcec4.c
> > @@ -0,0 +1,82 @@
> > +/*
> > + * Copyright (C) 2012 MPL AG, Switzerland
> > + * Stefan Peter <s.peter@mpl.ch>
> > + *
> > + * arch/arm/mach-kirkwood/board-mplcec4.c
> > + *
> > + * This file is licensed under the terms of the GNU General Public
> > + * License version 2.  This program is licensed "as is" without any
> > + * warranty of any kind, whether express or implied.
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/init.h>
> > +#include <linux/mv643xx_eth.h>
> > +#include <linux/clk.h>
> > +#include <linux/clk-private.h>
> > +#include <linux/platform_data/mmc-mvsdio.h>
> > +#include "common.h"
> > +#include "mpp.h"
> > +
> > +static struct mv643xx_eth_platform_data mplcec4_ge00_data = {
> > +	.phy_addr	= MV643XX_ETH_PHY_ADDR(1),
> > +};
> > +
> > +static struct mv643xx_eth_platform_data mplcec4_ge01_data = {
> > +	.phy_addr	= MV643XX_ETH_PHY_ADDR(2),
> > +};
> > +
> > +static unsigned int mplcec4_mpp_config[] __initdata = {
> > +	MPP0_NF_IO2,
> > +	MPP1_NF_IO3,
> > +	MPP2_NF_IO4,
> > +	MPP3_NF_IO5,
> > +	MPP4_NF_IO6,
> > +	MPP5_NF_IO7,
> > +	MPP6_SYSRST_OUTn,
> > +	MPP7_GPO,	/* Status LED Green High Active */
> > +	MPP10_UART0_TXD,
> > +	MPP11_UART0_RXD,
> > +	MPP12_SD_CLK,
> > +	MPP13_SD_CMD,	/* Alt UART1_TXD */
> > +	MPP14_SD_D0,	/* Alt UART1_RXD */
> > +	MPP15_SD_D1,
> > +	MPP16_SD_D2,
> > +	MPP17_SD_D3,
> > +	MPP18_NF_IO0,
> > +	MPP19_NF_IO1,
> > +	MPP28_GPIO,	/* Input SYS_POR_DET (active High) */
> > +	MPP29_GPIO,	/* Input SYS_RTC_INT (active High) */
> > +	MPP34_SATA1_ACTn,
> > +	MPP35_SATA0_ACTn,
> > +	MPP40_GPIO,	/* LED User1 orange */
> > +	MPP41_GPIO,	/* LED User1 green */
> > +	MPP44_GPIO,	/* LED User0 orange */
> > +	MPP45_GPIO,	/* LED User0 green */
> > +	MPP46_GPIO,	/* Status LED Yellow High Active */
> > +	MPP47_GPIO,	/* SD_CD# (in/IRQ)*/
> > +	0
> > +};
> 
> We're this to DT during this merge window, but don't worry about

*We're converting this (MPP)...

thx,

Jason.

> changing it.  We'll be doing a cleanup patch to catch the new boards.
> If you could just keep an eye out for it and test, it would be
> appreciated.
> 
> This looks really good, if you can turn around a V2, I should be able to
> get this in for v3.8.  It's getting close, though.
> 
> thx,
> 
> Jason.
> 
> > +
> > +
> > +static struct mvsdio_platform_data mplcec4_mvsdio_data = {
> > +	.gpio_card_detect = 47,	/* MPP47 used as SD card detect */
> > +};
> > +
> > +
> > +
> > +void __init mplcec4_init(void)
> > +{
> > +	/*
> > +	 * Basic setup. Needs to be called early.
> > +	 */
> > +	kirkwood_mpp_conf(mplcec4_mpp_config);
> > +	kirkwood_ehci_init();
> > +	kirkwood_ge00_init(&mplcec4_ge00_data);
> > +	kirkwood_ge01_init(&mplcec4_ge01_data);
> > +	kirkwood_sdio_init(&mplcec4_mvsdio_data);
> > +	kirkwood_pcie_init(KW_PCIE0);
> > +}
> > +
> > +
> > +
> > diff --git a/arch/arm/mach-kirkwood/common.h b/arch/arm/mach-kirkwood/common.h
> > index bcffd7c..6f18f27 100644
> > --- a/arch/arm/mach-kirkwood/common.h
> > +++ b/arch/arm/mach-kirkwood/common.h
> > @@ -112,6 +112,12 @@ void km_kirkwood_init(void);
> >  static inline void km_kirkwood_init(void) {};
> >  #endif
> >  
> > +#ifdef CONFIG_MACH_MPLCEC4_DT
> > +void mplcec4_init(void);
> > +#else
> > +static inline void mplcec4_init(void) {};
> > +#endif
> > +
> >  /* early init functions not converted to fdt yet */
> >  char *kirkwood_id(void);
> >  void kirkwood_l2_init(void);
> > -- 
> > 1.7.9.5
> > 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
