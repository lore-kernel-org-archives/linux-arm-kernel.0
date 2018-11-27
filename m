From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 10:38:52 +0100
Subject: [PATCH 09/14] regulator: dts: add full voltage range to LDO4 on
 the Lime2
In-Reply-To: <0b1aa5b28cb5efe17c04150a181ef1fa4027bc55.1543245984.git-series.plaes@plaes.org>
References: <cover.156212c9c5df493e098556cad9793a07dcab5e32.1543245984.git-series.plaes@plaes.org>
 <0b1aa5b28cb5efe17c04150a181ef1fa4027bc55.1543245984.git-series.plaes@plaes.org>
Message-ID: <20181127093852.2iavgo4xipjnu25l@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 26, 2018 at 05:27:50PM +0200, Priit Laes wrote:
> From: Olliver Schinagl <oliver@schinagl.nl>
> 
> With commit b43776d65a33b46092 ("ARM: dts: sunxi: Use axp209.dtsi for
> Olinuxino Lime2") we force them an arbitrary 2.8 volts. Granted, for
> LDO3 this may be less arbitrary, but for LDO4 this is just wrong.
> 
> In the defense of LDO3, LDO3 is the regulator that feeds port bank E,
> which has no other purpose then a CSI/TS interface, however the case
> may still be, that the connected IO may be just as well be 3.3 volts.
> The big misnomer is however, that the schematic names GPIO-2 pin4
> LDO3_2.8V, rather then VDD-CSI0 or similar.
> 
> This is much worse for LDO4 however, which is not referenced on any
> pin, is now set to 2.8 volts, but port bank G can also support various
> other peripherals such as UARTS etc.
> 
> By having 2.8 volts however for LDO4, we thus now have peripherals that
> no longer function properly all of the time.
> 
> Ideally, we want to set a supply voltage for each port bank, but the
> monolithic nature of the sunxi pinctroller currently prevents this and
> as such, the board should at least configure the LDO4 with the proper
> ranges.
> 
> Until we can set the consumer at the port bank level, a child
> device-tree has to do something like:
> 
> &reg_ldo4 {
>     regulator-min-microvolt = <3300000>;
>     regulator-max-microvolt = <3300000>;
> };
> 
> While doing this the same way results in the same solution currently,
> we force the hack into the final devicetree rather then having it wrong
> at the board level.
> 
> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
> Signed-off-by: Priit Laes <plaes@plaes.org>
> ---
>  arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
> index ffafe97..1b9867f 100644
> --- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
> @@ -250,9 +250,10 @@
>  };
>  
>  &reg_ldo4 {
> -	regulator-min-microvolt = <2800000>;
> -	regulator-max-microvolt = <2800000>;
> -	regulator-name = "vddio-csi1";
> +	regulator-always-on;
> +	regulator-min-microvolt = <1250000>;
> +	regulator-max-microvolt = <3300000>;
> +	regulator-name = "vdd-io-pg";

As we discussed on the U-Boot ML already, this shouldn't be made
always-on but tied to the consumer device (the pinctrl one) instead.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181127/09a0a0f8/attachment.sig>
