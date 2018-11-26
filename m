From: broonie@kernel.org (Mark Brown)
Date: Mon, 26 Nov 2018 16:57:38 +0000
Subject: [PATCH 09/14] regulator: dts: add full voltage range to LDO4 on
 the Lime2
In-Reply-To: <0b1aa5b28cb5efe17c04150a181ef1fa4027bc55.1543245984.git-series.plaes@plaes.org>
References: <cover.156212c9c5df493e098556cad9793a07dcab5e32.1543245984.git-series.plaes@plaes.org>
 <0b1aa5b28cb5efe17c04150a181ef1fa4027bc55.1543245984.git-series.plaes@plaes.org>
Message-ID: <20181126165738.GI9715@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 26, 2018 at 05:27:50PM +0200, Priit Laes wrote:

> In the defense of LDO3, LDO3 is the regulator that feeds port bank E,
> which has no other purpose then a CSI/TS interface, however the case
> may still be, that the connected IO may be just as well be 3.3 volts.
> The big misnomer is however, that the schematic names GPIO-2 pin4
> LDO3_2.8V, rather then VDD-CSI0 or similar.

In general you want to run regulators at the lowest voltage you can,
this tends to reduce power consumption.

> Ideally, we want to set a supply voltage for each port bank, but the
> monolithic nature of the sunxi pinctroller currently prevents this and
> as such, the board should at least configure the LDO4 with the proper
> ranges.

>  &reg_ldo4 {
> -	regulator-min-microvolt = <2800000>;
> -	regulator-max-microvolt = <2800000>;
> -	regulator-name = "vddio-csi1";
> +	regulator-always-on;
> +	regulator-min-microvolt = <1250000>;
> +	regulator-max-microvolt = <3300000>;
> +	regulator-name = "vdd-io-pg";
>  };

This is obviously broken even according to your analysis above - if you
have consumers for which 2.8V is too low allowing other consumers to set
even lower voltages is not going to help as soon as they start doing
that.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181126/4225ebda/attachment.sig>
