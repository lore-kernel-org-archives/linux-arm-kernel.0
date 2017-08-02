From: sean.wang@mediatek.com (Sean Wang)
Date: Wed, 2 Aug 2017 15:27:20 +0800
Subject: [PATCH 2/2] arm: dts: mt7623: Add SD-card to bananapi-r2
In-Reply-To: <20170801134009.14349-2-matthias.bgg@gmail.com>
References: <20170801134009.14349-1-matthias.bgg@gmail.com>
 <20170801134009.14349-2-matthias.bgg@gmail.com>
Message-ID: <1501658840.29348.7.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-08-01 at 15:40 +0200, Matthias Brugger wrote:
> The bananapi-r2 board has an SD-card controller, enable
> the device in the devicetree.
> 
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---
>  arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> index 9f3e6ddd545f..d457544c3a1d 100644
> --- a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> +++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> @@ -179,6 +179,19 @@
>  	status = "okay";
>  };
>  
> +&mmc1 {
> +	pinctrl-names = "default", "state_uhs";
> +	pinctrl-0 = <&mmc1_pins_default>;
> +	pinctrl-1 = <&mmc1_pins_uhs>;
> +	status = "okay";
> +	bus-width = <4>;
> +	max-frequency = <50000000>;
> +	cap-sd-highspeed;
> +	cd-gpios = <&pio 261 0>;
> +	vmmc-supply = <&mt6323_vmch_reg>;
> +	vqmmc-supply = <&mt6323_vmc_reg>;
> +};
> +
>  &pio {
>  	cir_pins_a:cir at 0 {
>  		pins_cir {

I can base the patch to fixup and add something in the next version 

such as

1) to add property with extra wp-gpios

2) to correct power source from mt6323_vio18_reg instead of
mt6323_vmc_reg based on the schematic

3) to enable mmc0 that is used as emmc


&mmc0 {
        pinctrl-names = "default", "state_uhs";
        pinctrl-0 = <&mmc0_pins_default>;
        pinctrl-1 = <&mmc0_pins_uhs>;
        status = "okay";
        bus-width = <8>;
        max-frequency = <50000000>;
        cap-mmc-highspeed;
        vmmc-supply = <&mt6323_vemc3v3_reg>;
        vqmmc-supply = <&mt6323_vio18_reg>;
        non-removable;
};


&mmc1 {
        pinctrl-names = "default", "state_uhs";
        pinctrl-0 = <&mmc1_pins_default>;
        pinctrl-1 = <&mmc1_pins_uhs>;
        status = "okay";
        bus-width = <4>;
        max-frequency = <50000000>;
        cap-sd-highspeed;
        cd-gpios = <&pio 261 0>;
        wp-gpios = <&pio 29 0>;
        vmmc-supply = <&mt6323_vmch_reg>;
        vqmmc-supply = <&mt6323_vio18_reg>;
};


those upper nodes could make sdhc sd card/emmc workable
