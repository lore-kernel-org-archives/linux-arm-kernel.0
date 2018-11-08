From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 8 Nov 2018 09:24:47 +0100
Subject: [PATCH 14/15] ARM: dts: sunxi: Enable Broadcom-based Bluetooth
 for multiple boards
In-Reply-To: <20181107101308.7626-15-wens@csie.org>
References: <20181107101308.7626-1-wens@csie.org>
 <20181107101308.7626-15-wens@csie.org>
Message-ID: <20181108082447.5og6sz7ump7ccjnq@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 07, 2018 at 06:13:07PM +0800, Chen-Yu Tsai wrote:
> This patch adds the Bluetooth node, and the underlying UART node if it's
> missing, to the board device tree file for several boards. The LPO clock
> is also added to the WiFi side's power sequencing node if it's missing,
> to correctly represent the shared connections. There is also a PCM
> connection for Bluetooth, but this is not covered in this patch.
> 
> These boards all have a WiFi+BT module from AMPAK, which contains one or
> two Broadcom chips, depending on the model. The older AP6210 contains
> two, while the newer AP6212 and AP6330 contain just one, as they use
> two-in-one combo chips.
> 
> The Bluetooth side of the module is always connected to a UART on the
> same pingroup as the SDIO pins for the WiFi side, in a 4 wire
> configuration. Power to the VBAT and VDDIO pins are provided either by
> the PMIC, using one or several of its regulator outputs, or other fixed
> regulators on the board. The VBAT and VDDIO pins are shared with the
> WiFi side, which would correspond to vmmc-supply and vqmmc-supply in the
> mmc host node. A clock output from the SoC or the external X-Powers RTC
> provides the LPO low power clock at 32.768 kHz.
> 
> All the boards covered in this patch are ones that do not require extra
> changes to the SoC's dtsi file. For the remaining boards that I have
> worked on, properties or device nodes for the LPO clock's source are
> missing.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  arch/arm/boot/dts/sun7i-a20-cubietruck.dts    | 22 +++++++++++++++++++
>  arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts  | 18 +++++++++++++++
>  .../boot/dts/sun8i-a83t-cubietruck-plus.dts   | 18 +++++++++++++++
>  arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts  | 14 ++++++++++++
>  4 files changed, 72 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> index 5649161de1d7..ccbf3b7a062b 100644
> --- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> @@ -103,6 +103,8 @@
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&mmc3_pwrseq_pin_cubietruck>;
>  		reset-gpios = <&pio 7 9 GPIO_ACTIVE_LOW>; /* PH9 WIFI_EN */
> +		clocks = <&ccu CLK_OUT_A>;
> +		clock-names = "ext_clock";
>  	};
>  
>  	sound {
> @@ -246,6 +248,10 @@
>  };
>  
>  &pio {
> +	/* Pin outputs low power clock for WiFi and BT */
> +	pinctrl-0 = <&clk_out_a_pins_a>;
> +	pinctrl-names = "default";
> +

I guess we should make it clear in the comment why it cannot be tied
to both devices.

>  	ahci_pwr_pin_cubietruck: ahci_pwr_pin at 1 {
>  		pins = "PH12";
>  		function = "gpio_out";
> @@ -350,6 +356,22 @@
>  	status = "okay";
>  };
>  
> +&uart2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart2_pins_a>;
> +	status = "okay";

No RTS/CTS?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181108/2ff2d767/attachment.sig>
