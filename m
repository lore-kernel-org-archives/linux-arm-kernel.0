From: stefan@agner.ch (Stefan Agner)
Date: Fri, 27 Nov 2015 12:02:46 -0800
Subject: [PATCH 1/2] ARM: dts: imx6: Add support for Toradex Apalis SoM
In-Reply-To: <20151126101742.GM19674@ibawizard.net>
References: <1447935900-13635-1-git-send-email-ynezz@true.cz>
 <1447935900-13635-2-git-send-email-ynezz@true.cz>
 <1447942325.3144.86.camel@pengutronix.de>
 <20151126101742.GM19674@ibawizard.net>
Message-ID: <5b507c5d85e51d56074a8f8c32b8dcf9@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Petr,

On 2015-11-26 02:17, Petr ?tetiar wrote:
> Lucas Stach <l.stach@pengutronix.de> [2015-11-19 15:12:05]:
>> > +&fec {
>> > +	pinctrl-names = "default";
>> > +	pinctrl-0 = <&pinctrl_enet &pinctrl_enet_ctrl>;
>> > +	phy-mode = "rgmii";
>> > +	status = "okay";
>> > +
>> > +	#address-cells = <0>;
>> > +	#size-cells = <1>;
>> > +	phy_int {
>> > +		reg = <0x6>;
>> > +		interrupt-parent = <&gpio1>;
>> > +		interrupts = <30 IRQ_TYPE_LEVEL_LOW>;
>> > +	};
>>
>> I don't think that's the right way to describe a PHY with the mainline
>> kernel bindings.
> 
> I'm quite stuck here as I don't have schematics of that SOM, so I don't know
> how the PHY is connected to the i.MX6. I've asked Toradex about the details,
> but they've just replied with "These signals connect to the on module Ethernet
> PHY.", which isn't much helpful :-) and gave me a link to the DTS[1] with a same
> content.
> 
> So, I've simply tried to convert it to the mainline DTS:
> 
> &fec {
> 	pinctrl-names = "default";
> 	pinctrl-0 = <&pinctrl_enet &pinctrl_enet_ctrl>;
> 	phy-mode = "rgmii";
> 
> 	phy-reset-gpios = <&gpio1 25 GPIO_ACTIVE_HIGH>;
> 	interrupts-extended = <&gpio1 30 IRQ_TYPE_LEVEL_LOW>,
> 			      <&intc 0 119 IRQ_TYPE_LEVEL_HIGH>;
> 	status = "okay";
> };

According to the schema, &gpio1 30 is low active as well as the reset
GPIO &gpio1 25. Both pulled high externally...

So phy reset GPIO should be ACTIVE_LOW, otherwise things look correct to
me.

> but it doesn't work, the PHY isn't being initialized. Then I've tried
> bruteforce method with all remaining combinations of high/low level types for
> both reset and interrupt GPIOs, but without success. If I simply remove reset
> and interrupt GPIO descriptions, then it boots, but I don't know if everything
> is setup as it should be. Any ideas?

I guess in that case U-Boot took care of it. However, this is not a
clean solution...

Not sure what happens exactly, maybe the phy-reset does not honor the
GPIO_ACTIVE_LOW flag?

Maybe also check the reset pad control, I guess you need to set
something different here anyway.
MX6QDL_PAD_ENET_CRS_DV__GPIO1_IO25 PAD_CTRL_NO

In case that does not help, I can have a look here what is going on next
week.

--
Stefan
