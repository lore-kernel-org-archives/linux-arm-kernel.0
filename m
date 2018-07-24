From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 24 Jul 2018 14:51:51 +0200
Subject: [PATCH] arm64: activate spi flash on pine64 LTS board
In-Reply-To: <1532274409-9921-1-git-send-email-Akash_Gajjar@mentor.com>
References: <Akash_Gajjar@mentor.com>
 <1532274409-9921-1-git-send-email-Akash_Gajjar@mentor.com>
Message-ID: <20180724125151.plhn5g3x37ah62xu@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On Sun, Jul 22, 2018 at 09:16:49PM +0530, Akash Gajjar wrote:
> This board has a 128M SPI flash. add spi flash support in device tree.
> 
> Tested on pine64 LTS.
> 
> Signed-off-by: Akash Gajjar <Akash_Gajjar@mentor.com>

The author email should match the one in the SoB, and the prefix of
your commit title should be "arm64: dts: allwinner: ..."

> ---
>  .../dts/allwinner/sun50i-a64-sopine-baseboard.dts  | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
> index abe179d..d54637d 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
> @@ -134,6 +134,29 @@
>  	regulator-name = "vcc-wifi";
>  };
>  
> +&spi0  {
> +	status = "okay";
> +
> +	m25p80 at 0 {

The node-name should be the device class, not the device model

> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "w25q128";

According to the binding, this should have "jedec,spi-nor", and you
should put the vendor name before the model name as well.

> +		reg = <0x0>;
> +		linux,modalias = "m25p80", "w25q128";

This property isn

> +		spi-max-frequency = <40000000>;
> +
> +		uboot at 0 {
> +			label = "uboot";
> +			reg = <0x0 0x100000>;
> +		};
> +
> +		rootfs at 0 {
> +			label = "rootfs";
> +			reg = <0x100000 0x7F00000>;
> +		};

This forces a partition scheme on users that might feel
differently. This should be removed.

maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180724/4a70fe4c/attachment.sig>
