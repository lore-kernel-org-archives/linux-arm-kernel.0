From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 8 Feb 2018 09:52:21 +0100
Subject: [PATCH v2 1/2] ARM: dts: sun8i: h3-h5: Move pinctrl of mmc0 from
 dts to dtsi
In-Reply-To: <20180207204805.16884-2-joonas.kylmala@iki.fi>
References: <20180207204805.16884-1-joonas.kylmala@iki.fi>
 <20180207204805.16884-2-joonas.kylmala@iki.fi>
Message-ID: <20180208085221.zifabhit5adjodb7@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joonas,

On Wed, Feb 07, 2018 at 10:48:04PM +0200, Joonas Kylm?l? wrote:
> Most of the boards use the mmc0 pins and their attributes defined in
> mmc0_pins_a. Let's default to those by moving the pinctrl attributes
> to the dtsi file. This makes it easier to modify device trees in the
> future as there is only one place to change the pinctrl attributes.
> 
> As a side effect this patch also removes the GPIO detect
> pin (mmc0_cd_pin) from pinctrl. The GPIO detect pin is already
> requested and configured by mmc_gpiod_request_cd() in
> drivers/mmc/core/slot-gpio.c so pinctrl is not needed.
> 
> Signed-off-by: Joonas Kylm?l? <joonas.kylmala@iki.fi>

Thanks for your patch, but this should probably be split in two
patches, one to remove the cd_pin node, and then one to migrate the
mmc0_pins_a definition to the DTSI.

I have further comments below.

> diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> index 7a83b15225c7..3a0854a96a04 100644
> --- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> +++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> @@ -141,6 +141,8 @@
>  		mmc0: mmc at 1c0f000 {
>  			/* compatible and clocks are in per SoC .dtsi file */
>  			reg = <0x01c0f000 0x1000>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&mmc0_pins_a>;

If this is the only option, we should rename it to mmc0_pins. The
suffix there is used to differentiate multiple muxing options, but
it's useless if there's just one. That would be in a separate patch as
well.

Also, wouldn't the H5 boards need some change too?

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180208/a4813a6f/attachment-0001.sig>
