From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Thu, 3 Aug 2017 12:03:02 +0200
Subject: [PATCH v3] arm: dts: mt7623: Add SD-card and EMMC to bananapi-r2
In-Reply-To: <1501749538.4398.6.camel@mtkswgap22>
References: <687af2dc98feffc678945f130c03ca020d9ca7b5.1501748754.git.sean.wang@mediatek.com>
 <1501749538.4398.6.camel@mtkswgap22>
Message-ID: <18397c89-e569-c3f7-ce3f-24e91c2770c9@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sean,

On 08/03/2017 10:38 AM, Sean Wang wrote:
> Hi, Matthias,
> 
> Ryder and me tried to make the patch better, so the delivery is made in
> v3,  including add missing pin  state for mmc1 and remove wp-gpio
> because the board only has micro-sd slot that can't be adjusted for the
> lock manually. And also some cleanups are made for nodes sorted in
> alphabetical order. Thanks for Ryder to catch.
> 

Thanks for that. Would you mind to split the clean-up into another patch?
We should avoid patches which do cleanup and adding drivers in one go.

Thanks,
Matthias

> 	Sean
> 
> On Thu, 2017-08-03 at 16:29 +0800, sean.wang at mediatek.com wrote:
>> From: Sean Wang <sean.wang@mediatek.com>
>>
>> The bananapi-r2 board has an SD-card controller and built-in
>> EMMC storage so enables those devices in the devicetree. Also
>> cleanup nodes in alphabetical order in the patch.
>>
>> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
>> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
>> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
>> ---
>>   arch/arm/boot/dts/mt7623.dtsi                 | 73 ++++++++++++++-------------
>>   arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts | 73 ++++++++++++++++++++-------
>>   2 files changed, 94 insertions(+), 52 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
>> index 2a877ed..ec8a074 100644
>> --- a/arch/arm/boot/dts/mt7623.dtsi
>> +++ b/arch/arm/boot/dts/mt7623.dtsi
>> @@ -91,6 +91,7 @@
>>   			cooling-max-level = <7>;
>>   			clock-frequency = <1300000000>;
>>   		};
>> +
>>   		cpu1: cpu at 1 {
>>   			device_type = "cpu";
>>   			compatible = "arm,cortex-a7";
>> @@ -98,6 +99,7 @@
>>   			operating-points-v2 = <&cpu_opp_table>;
>>   			clock-frequency = <1300000000>;
>>   		};
>> +
>>   		cpu2: cpu at 2 {
>>   			device_type = "cpu";
>>   			compatible = "arm,cortex-a7";
>> @@ -105,6 +107,7 @@
>>   			operating-points-v2 = <&cpu_opp_table>;
>>   			clock-frequency = <1300000000>;
>>   		};
>> +
>>   		cpu3: cpu at 3 {
>>   			device_type = "cpu";
>>   			compatible = "arm,cortex-a7";
>> @@ -172,10 +175,12 @@
>>   					trip = <&cpu_passive>;
>>   					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>>   				};
>> +
>>   				map1 {
>>   					trip = <&cpu_active>;
>>   					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>>   				};
>> +
>>   				map2 {
>>   					trip = <&cpu_hot>;
>>   					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>> @@ -481,6 +486,31 @@
>>   		nvmem-cell-names = "calibration-data";
>>   	};
>>   
>> +	nandc: nfi at 1100d000 {
>> +		compatible = "mediatek,mt7623-nfc",
>> +			     "mediatek,mt2701-nfc";
>> +		reg = <0 0x1100d000 0 0x1000>;
>> +		interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_LOW>;
>> +		power-domains = <&scpsys MT2701_POWER_DOMAIN_IFR_MSC>;
>> +		clocks = <&pericfg CLK_PERI_NFI>,
>> +			 <&pericfg CLK_PERI_NFI_PAD>;
>> +		clock-names = "nfi_clk", "pad_clk";
>> +		status = "disabled";
>> +		ecc-engine = <&bch>;
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +	};
>> +
>> +	bch: ecc at 1100e000 {
>> +		compatible = "mediatek,mt7623-ecc",
>> +			     "mediatek,mt2701-ecc";
>> +		reg = <0 0x1100e000 0 0x1000>;
>> +		interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_LOW>;
>> +		clocks = <&pericfg CLK_PERI_NFI_ECC>;
>> +		clock-names = "nfiecc_clk";
>> +		status = "disabled";
>> +	};
>> +
>>   	spi1: spi at 11016000 {
>>   		compatible = "mediatek,mt7623-spi",
>>   			     "mediatek,mt2701-spi";
>> @@ -509,31 +539,6 @@
>>   		status = "disabled";
>>   	};
>>   
>> -	nandc: nfi at 1100d000 {
>> -		compatible = "mediatek,mt7623-nfc",
>> -			     "mediatek,mt2701-nfc";
>> -		reg = <0 0x1100d000 0 0x1000>;
>> -		interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_LOW>;
>> -		power-domains = <&scpsys MT2701_POWER_DOMAIN_IFR_MSC>;
>> -		clocks = <&pericfg CLK_PERI_NFI>,
>> -			 <&pericfg CLK_PERI_NFI_PAD>;
>> -		clock-names = "nfi_clk", "pad_clk";
>> -		status = "disabled";
>> -		ecc-engine = <&bch>;
>> -		#address-cells = <1>;
>> -		#size-cells = <0>;
>> -	};
>> -
>> -	bch: ecc at 1100e000 {
>> -		compatible = "mediatek,mt7623-ecc",
>> -			     "mediatek,mt2701-ecc";
>> -		reg = <0 0x1100e000 0 0x1000>;
>> -		interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_LOW>;
>> -		clocks = <&pericfg CLK_PERI_NFI_ECC>;
>> -		clock-names = "nfiecc_clk";
>> -		status = "disabled";
>> -	};
>> -
>>   	afe: audio-controller at 11220000 {
>>   		compatible = "mediatek,mt7623-audio",
>>   			     "mediatek,mt2701-audio";
>> @@ -655,6 +660,15 @@
>>   		status = "disabled";
>>   	};
>>   
>> +	hifsys: syscon at 1a000000 {
>> +		compatible = "mediatek,mt7623-hifsys",
>> +			     "mediatek,mt2701-hifsys",
>> +			     "syscon";
>> +		reg = <0 0x1a000000 0 0x1000>;
>> +		#clock-cells = <1>;
>> +		#reset-cells = <1>;
>> +	};
>> +
>>   	usb1: usb at 1a1c0000 {
>>   		compatible = "mediatek,mt7623-xhci",
>>   			     "mediatek,mt8173-xhci";
>> @@ -733,15 +747,6 @@
>>   		};
>>   	};
>>   
>> -	hifsys: syscon at 1a000000 {
>> -		compatible = "mediatek,mt7623-hifsys",
>> -			     "mediatek,mt2701-hifsys",
>> -			     "syscon";
>> -		reg = <0 0x1a000000 0 0x1000>;
>> -		#clock-cells = <1>;
>> -		#reset-cells = <1>;
>> -	};
>> -
>>   	ethsys: syscon at 1b000000 {
>>   		compatible = "mediatek,mt7623-ethsys",
>>   			     "mediatek,mt2701-ethsys",
>> diff --git a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
>> index 9f3e6dd..0aa1c69 100644
>> --- a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
>> +++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
>> @@ -179,6 +179,32 @@
>>   	status = "okay";
>>   };
>>   
>> +&mmc0 {
>> +	pinctrl-names = "default", "state_uhs";
>> +	pinctrl-0 = <&mmc0_pins_default>;
>> +	pinctrl-1 = <&mmc0_pins_uhs>;
>> +	status = "okay";
>> +	bus-width = <8>;
>> +	max-frequency = <50000000>;
>> +	cap-mmc-highspeed;
>> +	vmmc-supply = <&mt6323_vemc3v3_reg>;
>> +	vqmmc-supply = <&mt6323_vio18_reg>;
>> +	non-removable;
>> +};
>> +
>> +&mmc1 {
>> +	pinctrl-names = "default", "state_uhs";
>> +	pinctrl-0 = <&mmc1_pins_default>;
>> +	pinctrl-1 = <&mmc1_pins_uhs>;
>> +	status = "okay";
>> +	bus-width = <4>;
>> +	max-frequency = <50000000>;
>> +	cap-sd-highspeed;
>> +	cd-gpios = <&pio 261 0>;
>> +	vmmc-supply = <&mt6323_vmch_reg>;
>> +	vqmmc-supply = <&mt6323_vio18_reg>;
>> +};
>> +
>>   &pio {
>>   	cir_pins_a:cir at 0 {
>>   		pins_cir {
>> @@ -314,6 +340,17 @@
>>   			bias-pull-down;
>>   			drive-strength = <MTK_DRIVE_4mA>;
>>   		};
>> +
>> +		pins_wp {
>> +			pinmux = <MT7623_PIN_29_EINT7_FUNC_MSDC1_WP>;
>> +			input-enable;
>> +			bias-pull-up;
>> +		};
>> +
>> +		pins_insert {
>> +			pinmux = <MT7623_PIN_261_MSDC1_INS_FUNC_GPIO261>;
>> +			bias-pull-up;
>> +		};
>>   	};
>>   
>>   	mmc1_pins_uhs: mmc1 {
>> @@ -335,16 +372,6 @@
>>   		};
>>   	};
>>   
>> -	spi0_pins_a: spi at 0 {
>> -		pins_spi {
>> -			pinmux = <MT7623_PIN_53_SPI0_CSN_FUNC_SPI0_CS>,
>> -				<MT7623_PIN_54_SPI0_CK_FUNC_SPI0_CK>,
>> -				<MT7623_PIN_55_SPI0_MI_FUNC_SPI0_MI>,
>> -				<MT7623_PIN_56_SPI0_MO_FUNC_SPI0_MO>;
>> -			bias-disable;
>> -		};
>> -	};
>> -
>>   	pwm_pins_a: pwm at 0 {
>>   		pins_pwm {
>>   			pinmux = <MT7623_PIN_203_PWM0_FUNC_PWM0>,
>> @@ -355,6 +382,16 @@
>>   		};
>>   	};
>>   
>> +	spi0_pins_a: spi at 0 {
>> +		pins_spi {
>> +			pinmux = <MT7623_PIN_53_SPI0_CSN_FUNC_SPI0_CS>,
>> +				<MT7623_PIN_54_SPI0_CK_FUNC_SPI0_CK>,
>> +				<MT7623_PIN_55_SPI0_MI_FUNC_SPI0_MI>,
>> +				<MT7623_PIN_56_SPI0_MO_FUNC_SPI0_MO>;
>> +			bias-disable;
>> +		};
>> +	};
>> +
>>   	uart0_pins_a: uart at 0 {
>>   		pins_dat {
>>   			pinmux = <MT7623_PIN_79_URXD0_FUNC_URXD0>,
>> @@ -414,14 +451,6 @@
>>   	status = "disabled";
>>   };
>>   
>> -&u3phy1 {
>> -	status = "okay";
>> -};
>> -
>> -&u3phy2 {
>> -	status = "okay";
>> -};
>> -
>>   &uart1 {
>>   	pinctrl-names = "default";
>>   	pinctrl-0 = <&uart1_pins_a>;
>> @@ -441,3 +470,11 @@
>>   	vusb33-supply = <&mt6323_vusb_reg>;
>>   	status = "okay";
>>   };
>> +
>> +&u3phy1 {
>> +	status = "okay";
>> +};
>> +
>> +&u3phy2 {
>> +	status = "okay";
>> +};
> 
> 
