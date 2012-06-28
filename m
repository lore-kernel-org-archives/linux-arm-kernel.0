From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Thu, 28 Jun 2012 14:32:22 +0200
Subject: [PATCH v2 2/2] net: flexcan: add transceiver switch gpios support
In-Reply-To: <20120628121817.GA5755@shlinux2.ap.freescale.net>
References: <1340853701-4488-1-git-send-email-shawn.guo@linaro.org>
 <1340853701-4488-3-git-send-email-shawn.guo@linaro.org>
 <20120628113327.GJ6406@shlinux2.ap.freescale.net>
 <20120628114559.GE22990@S2101-09.ap.freescale.net>
 <4FEC487A.2050901@pengutronix.de>
 <20120628121817.GA5755@shlinux2.ap.freescale.net>
Message-ID: <20460.20182.552394.407578@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Dong Aisheng writes:
> On Thu, Jun 28, 2012 at 08:05:14PM +0800, Marc Kleine-Budde wrote:
> > On 06/28/2012 01:46 PM, Shawn Guo wrote:
> > > On Thu, Jun 28, 2012 at 07:33:28PM +0800, Dong Aisheng wrote:
> > >>> +		phy_stby_gpio = of_get_named_gpio_flags(pdev->dev.of_node,
> > >>> +							"phy-standby-gpios",
> > >>> +							0, &flags);
> > >>> +		if (gpio_is_valid(phy_stby_gpio)) {
> > >>> +			if (flags == OF_GPIO_ACTIVE_LOW)
> > >>> +				phy_stby_high = false;
> > >>> +			err = devm_gpio_request_one(&pdev->dev, phy_stby_gpio,
> > >>> +						    GPIOF_DIR_OUT,
> > >>> +						    "phy-standby");
> > >>> +			if (err) {
> > >>> +				dev_err(&pdev->dev,
> > >>> +					"failed to request gpio %d: %d\n",
> > >>> +					phy_stby_gpio, err);
> > >>> +				goto failed_gpio;
> > >> I checked mx28 evk, it seems the phy only has a STB gpio and shared by both CAN0&CAN1.
> > >> I wonder the CAN1 probe may fail here.
> > >>
> > > It can be managed by dts.  Here is what I have in imx28-evk.dts, where
> > > only can0 has phy-enable-gpios property.
> > > 
> > > 
> > > 	can0: can at 80032000 {
> > > 		pinctrl-names = "default";
> > > 		pinctrl-0 = <&can0_pins_a>;
> > > 		phy-enable-gpios = <&gpio2 13 0>;
> > > 		status = "okay";
> > > 	};
> > > 
> > > 	can1: can at 80034000 {
> > > 		pinctrl-names = "default";
> > > 		pinctrl-0 = <&can1_pins_a>;
> > > 		status = "okay";
> > > 	};
> > 
> > Will this work if can0 is down and can1 is up?
> > 
> > Can we abstract the transceiver power as a regulator? Or a clock? :P
> > 
> Hmm, it may not be a power.
> For mx28evk, it's a STBY pin.
> So it may hard to abstract it as a regulator or clock.
> 
I have created a 'gpio-switch' driver in my private tree that can be
used for exactly this purpose. It takes care of the pin polarity and
initial state of the pins and can handle shared pins like in this
case. The client driver does not even need to care whether an actual
GPIO exists for the current platform.

I could prepare a patch and post it here.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
