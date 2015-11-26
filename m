From: ynezz@true.cz (Petr =?iso-8859-2?Q?=A9tetiar?=)
Date: Thu, 26 Nov 2015 11:17:42 +0100
Subject: [PATCH 1/2] ARM: dts: imx6: Add support for Toradex Apalis SoM
In-Reply-To: <1447942325.3144.86.camel@pengutronix.de>
References: <1447935900-13635-1-git-send-email-ynezz@true.cz>
 <1447935900-13635-2-git-send-email-ynezz@true.cz>
 <1447942325.3144.86.camel@pengutronix.de>
Message-ID: <20151126101742.GM19674@ibawizard.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lucas Stach <l.stach@pengutronix.de> [2015-11-19 15:12:05]:

> Hi Petr,

Hi,

> > +&fec {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_enet &pinctrl_enet_ctrl>;
> > +	phy-mode = "rgmii";
> > +	status = "okay";
> > +
> > +	#address-cells = <0>;
> > +	#size-cells = <1>;
> > +	phy_int {
> > +		reg = <0x6>;
> > +		interrupt-parent = <&gpio1>;
> > +		interrupts = <30 IRQ_TYPE_LEVEL_LOW>;
> > +	};
>
> I don't think that's the right way to describe a PHY with the mainline
> kernel bindings.

I'm quite stuck here as I don't have schematics of that SOM, so I don't know
how the PHY is connected to the i.MX6. I've asked Toradex about the details,
but they've just replied with "These signals connect to the on module Ethernet
PHY.", which isn't much helpful :-) and gave me a link to the DTS[1] with a same
content.

So, I've simply tried to convert it to the mainline DTS:

&fec {
	pinctrl-names = "default";
	pinctrl-0 = <&pinctrl_enet &pinctrl_enet_ctrl>;
	phy-mode = "rgmii";

	phy-reset-gpios = <&gpio1 25 GPIO_ACTIVE_HIGH>;
	interrupts-extended = <&gpio1 30 IRQ_TYPE_LEVEL_LOW>,
			      <&intc 0 119 IRQ_TYPE_LEVEL_HIGH>;
	status = "okay";
};

but it doesn't work, the PHY isn't being initialized. Then I've tried
bruteforce method with all remaining combinations of high/low level types for
both reset and interrupt GPIOs, but without success. If I simply remove reset
and interrupt GPIO descriptions, then it boots, but I don't know if everything
is setup as it should be. Any ideas?

Thanks.

1. https://git.toradex.com/cgit/linux-toradex.git/tree/arch/arm/boot/dts/imx6qdl-apalis.dtsi?h=colibri&id=Apalis_iMX6_LinuxImageV2.5Beta2_20151106#n278

-- ynezz
