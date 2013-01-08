From: simon.guinot@sequanux.org (Simon Guinot)
Date: Tue, 8 Jan 2013 17:18:36 +0100
Subject: [PATCH] ARM: Kirkwood: convert ns2 boards to pinctrl
In-Reply-To: <20130108161553.GE3392@lunn.ch>
References: <1357655778-32066-1-git-send-email-simon.guinot@sequanux.org>
 <20130108161553.GE3392@lunn.ch>
Message-ID: <20130108161835.GN1357@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 08, 2013 at 05:15:53PM +0100, Andrew Lunn wrote:
> On Tue, Jan 08, 2013 at 03:36:18PM +0100, Simon Guinot wrote:
> > Note that the pinctrl conversion also fixes GPIO support for ns2 boards.
> > Since commit f9e75922: "ARM: Kirkwood: Make use of mvebu pincltl and
> > gpio", the mvbu_gpio driver is used for DT boards. As mvbu_gpio relies
> > on the pinctrl driver, then a pinctrl definition must be given to allow
> > the GPIO configuration.
> > 
> > Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
> > ---
> >  arch/arm/boot/dts/kirkwood-ns2-common.dtsi |   16 ++++++++++++
> >  arch/arm/mach-kirkwood/board-ns2.c         |   38 ----------------------------
> >  2 files changed, 16 insertions(+), 38 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/kirkwood-ns2-common.dtsi b/arch/arm/boot/dts/kirkwood-ns2-common.dtsi
> > index 9bc6785..77d21ab 100644
> > --- a/arch/arm/boot/dts/kirkwood-ns2-common.dtsi
> > +++ b/arch/arm/boot/dts/kirkwood-ns2-common.dtsi
> > @@ -1,4 +1,5 @@
> >  /include/ "kirkwood.dtsi"
> > +/include/ "kirkwood-6281.dtsi"
> >  
> >  / {
> >  	chosen {
> > @@ -6,6 +7,21 @@
> >  	};
> >  
> >  	ocp at f1000000 {
> > +		pinctrl: pinctrl at 10000 {
> > +			pinctrl-0 = < &pmx_spi &pmx_twsi0 &pmx_uart0
> > +					&pmx_ns2_sata0 &pmx_ns2_sata1>;
> > +			pinctrl-names = "default";
> > +
> > +			pmx_ns2_sata0: pmx-ns2-sata0 {
> > +				marvell,pins = "mpp21";
> > +				marvell,function = "sata0";
> > +			};
> > +			pmx_ns2_sata1: pmx-ns2-sata1 {
> > +				marvell,pins = "mpp20";
> > +				marvell,function = "sata1";
> > +			};
> > +		};
> > +
> >  		serial at 12000 {
> >  			clock-frequency = <166666667>;
> >  			status = "okay";
> > diff --git a/arch/arm/mach-kirkwood/board-ns2.c b/arch/arm/mach-kirkwood/board-ns2.c
> > index 8821720..f4632a8 100644
> > --- a/arch/arm/mach-kirkwood/board-ns2.c
> > +++ b/arch/arm/mach-kirkwood/board-ns2.c
> > @@ -18,47 +18,11 @@
> >  #include <linux/gpio.h>
> >  #include <linux/of.h>
> >  #include "common.h"
> > -#include "mpp.h"
> >  
> >  static struct mv643xx_eth_platform_data ns2_ge00_data = {
> >  	.phy_addr	= MV643XX_ETH_PHY_ADDR(8),
> >  };
> >  
> > -static unsigned int ns2_mpp_config[] __initdata = {
> > -	MPP0_SPI_SCn,
> > -	MPP1_SPI_MOSI,
> > -	MPP2_SPI_SCK,
> > -	MPP3_SPI_MISO,
> > -	MPP4_NF_IO6,
> > -	MPP5_NF_IO7,
> > -	MPP6_SYSRST_OUTn,
> > -	MPP7_GPO,		/* Fan speed (bit 1) */
> > -	MPP8_TW0_SDA,
> > -	MPP9_TW0_SCK,
> > -	MPP10_UART0_TXD,
> > -	MPP11_UART0_RXD,
> > -	MPP12_GPO,		/* Red led */
> > -	MPP14_GPIO,		/* USB fuse */
> > -	MPP16_GPIO,		/* SATA 0 power */
> > -	MPP17_GPIO,		/* SATA 1 power */
> > -	MPP18_NF_IO0,
> > -	MPP19_NF_IO1,
> > -	MPP20_SATA1_ACTn,
> > -	MPP21_SATA0_ACTn,
> > -	MPP22_GPIO,		/* Fan speed (bit 0) */
> > -	MPP23_GPIO,		/* Fan power */
> > -	MPP24_GPIO,		/* USB mode select */
> > -	MPP25_GPIO,		/* Fan rotation fail */
> > -	MPP26_GPIO,		/* USB device vbus */
> > -	MPP28_GPIO,		/* USB enable host vbus */
> > -	MPP29_GPIO,		/* Blue led (slow register) */
> > -	MPP30_GPIO,		/* Blue led (command register) */
> > -	MPP31_GPIO,		/* Board power off */
> > -	MPP32_GPIO,		/* Power button (0 = Released, 1 = Pushed) */
> > -	MPP33_GPO,		/* Fan speed (bit 2) */
> > -	0
> > -};
> > -
> >  #define NS2_GPIO_POWER_OFF	31
> >  
> >  static void ns2_power_off(void)
> > @@ -71,8 +35,6 @@ void __init ns2_init(void)
> >  	/*
> >  	 * Basic setup. Needs to be called early.
> >  	 */
> > -	kirkwood_mpp_conf(ns2_mpp_config);
> > -
> >  	if (of_machine_is_compatible("lacie,netspace_lite_v2") ||
> >  	    of_machine_is_compatible("lacie,netspace_mini_v2"))
> >  		ns2_ge00_data.phy_addr = MV643XX_ETH_PHY_ADDR(0);
> > -- 
> > 1.7.10
> > 
> 
> Acked-by: Andrew Lunn <andrew@lunn.ch>
> 

Do you think it is still possible to merge this patch as a bug fix for
the current release ?

Simon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130108/62ac5237/attachment.sig>
