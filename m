From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Thu, 28 Jun 2012 14:05:14 +0200
Subject: [PATCH v2 2/2] net: flexcan: add transceiver switch gpios support
In-Reply-To: <20120628114559.GE22990@S2101-09.ap.freescale.net>
References: <1340853701-4488-1-git-send-email-shawn.guo@linaro.org>
 <1340853701-4488-3-git-send-email-shawn.guo@linaro.org>
 <20120628113327.GJ6406@shlinux2.ap.freescale.net>
 <20120628114559.GE22990@S2101-09.ap.freescale.net>
Message-ID: <4FEC487A.2050901@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/28/2012 01:46 PM, Shawn Guo wrote:
> On Thu, Jun 28, 2012 at 07:33:28PM +0800, Dong Aisheng wrote:
>>> +		phy_stby_gpio = of_get_named_gpio_flags(pdev->dev.of_node,
>>> +							"phy-standby-gpios",
>>> +							0, &flags);
>>> +		if (gpio_is_valid(phy_stby_gpio)) {
>>> +			if (flags == OF_GPIO_ACTIVE_LOW)
>>> +				phy_stby_high = false;
>>> +			err = devm_gpio_request_one(&pdev->dev, phy_stby_gpio,
>>> +						    GPIOF_DIR_OUT,
>>> +						    "phy-standby");
>>> +			if (err) {
>>> +				dev_err(&pdev->dev,
>>> +					"failed to request gpio %d: %d\n",
>>> +					phy_stby_gpio, err);
>>> +				goto failed_gpio;
>> I checked mx28 evk, it seems the phy only has a STB gpio and shared by both CAN0&CAN1.
>> I wonder the CAN1 probe may fail here.
>>
> It can be managed by dts.  Here is what I have in imx28-evk.dts, where
> only can0 has phy-enable-gpios property.
> 
> 
> 	can0: can at 80032000 {
> 		pinctrl-names = "default";
> 		pinctrl-0 = <&can0_pins_a>;
> 		phy-enable-gpios = <&gpio2 13 0>;
> 		status = "okay";
> 	};
> 
> 	can1: can at 80034000 {
> 		pinctrl-names = "default";
> 		pinctrl-0 = <&can1_pins_a>;
> 		status = "okay";
> 	};

Will this work if can0 is down and can1 is up?

Can we abstract the transceiver power as a regulator? Or a clock? :P

Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 262 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120628/6de502a1/attachment.sig>
