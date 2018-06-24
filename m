From: harald@ccbib.org (Harald Geyer)
Date: Sun, 24 Jun 2018 18:34:40 +0200
Subject: [PATCHv2 5/5] arm64: allwinner: a64: Add support for TERES-I
 laptop
In-Reply-To: <a7011fe78d171658742406bf01d50b7e3d7eaf1d.camel@aosc.io>
References: <20180315162510.11669-1-harald@ccbib.org>
 <20180315162510.11669-6-harald@ccbib.org>
 <a7011fe78d171658742406bf01d50b7e3d7eaf1d.camel@aosc.io>
Message-ID: <E1fX7yK-0000OC-HA@stardust.g4.wien.funkfeuer.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Icenowy Zheng writes:
> ? 2018-03-15?? 16:25 +0000?Harald Geyer???
> > +&mmc1 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&mmc1_pins>;
> > +	vmmc-supply = <&reg_aldo2>;
> > +	vqmmc-supply = <&reg_dldo4>;
> > +	mmc-pwrseq = <&wifi_pwrseq>;
> > +	bus-width = <4>;
> > +	non-removable;
> > +	status = "okay";
> > +
> > +	rtl8723bs: wifi at 1 {
> > +		reg = <1>;
> > +		interrupt-parent = <&r_pio>;
> > +		interrupts = <0 3 IRQ_TYPE_LEVEL_LOW>; /* PL3 */
> > +		interrupt-names = "host-wake";
> > +	};
> 
> I think this node has some problem:

Thanks for the heads up! Admittedly, I simply copied this node from
sun50i-a64-olinuxino.dts and since it worked, didn't look into it in
too much detail.

> - This device node has no binding. The "host-wake" interrupt is part of
>  Broadcom SDIO Wi-Fi binding, rather than a generic one.

I think the general mmc and interrupts bindings apply. And the mmc binding
clearly states that for sub-nodes a compatible string is optional.

However I just realized that the 'interrupt-names' property is not part
of the general interrupts binding, so I guess at least this property should
be removed.

> - Without the interrupt this device node isn't needed, as RTL8723BS has
> MAC eFUSE and doesn't need a MAC in device tree.

Indeed. I wasn't aware of this, but I just tested and the device probes
fine without the subnode present. I think the devicetree is mainly for
information which cannot be probed, so maybe the subnode should just get
removed.

> In order to solve the problems. I suggest either drop this device node
> or make a generic "sdio-wifi" device tree binding. Personally I prefer
> the latter, as it's more accurate device representation.
> 
> If such a device tree binding is added, I think it should contain the
> "host-wake" interrupt and a "local-mac-address" property. Both can be
> ignored by the driver. (This interrupt can be needed if a more card-
> ventor-neutral name is found.)

I don't feel qualified to comment on this. If you want to propose such
a patch and fix above node accordingly, I won't object. Otherwise I'll
just send a patch to remove the subnode.

Thanks,
Harald
