From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri, 13 Jan 2017 16:12:20 +0100
Subject: [PATCH v1 2/2] arm: dts: mt2701: add nor flash node
In-Reply-To: <20170113151747.6bc85245@bbrezillon>
References: <1484291609-20195-1-git-send-email-guochun.mao@mediatek.com>
 <1484291609-20195-3-git-send-email-guochun.mao@mediatek.com>
 <20170113151747.6bc85245@bbrezillon>
Message-ID: <d7b866ad-5b2f-62d3-3aa3-6fa42803d625@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 13/01/17 15:17, Boris Brezillon wrote:
> On Fri, 13 Jan 2017 15:13:29 +0800
> Guochun Mao <guochun.mao@mediatek.com> wrote:
>
>> Add Mediatek nor flash node.
>>
>> Signed-off-by: Guochun Mao <guochun.mao@mediatek.com>
>> ---
>>  arch/arm/boot/dts/mt2701-evb.dts |   25 +++++++++++++++++++++++++
>>  arch/arm/boot/dts/mt2701.dtsi    |   12 ++++++++++++
>>  2 files changed, 37 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/mt2701-evb.dts b/arch/arm/boot/dts/mt2701-evb.dts
>> index 082ca88..85e5ae8 100644
>> --- a/arch/arm/boot/dts/mt2701-evb.dts
>> +++ b/arch/arm/boot/dts/mt2701-evb.dts
>> @@ -24,6 +24,31 @@
>>  	};
>>  };
>>
>> +&nor_flash {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&nor_pins_default>;
>> +	status = "okay";
>> +	flash at 0 {
>> +		compatible = "jedec,spi-nor";
>> +		reg = <0>;
>> +	};
>> +};
>> +
>> +&pio {
>> +	nor_pins_default: nor {
>> +		pins1 {
>> +			pinmux = <MT2701_PIN_240_EXT_XCS__FUNC_EXT_XCS>,
>> +				 <MT2701_PIN_241_EXT_SCK__FUNC_EXT_SCK>,
>> +				 <MT2701_PIN_239_EXT_SDIO0__FUNC_EXT_SDIO0>,
>> +				 <MT2701_PIN_238_EXT_SDIO1__FUNC_EXT_SDIO1>,
>> +				 <MT2701_PIN_237_EXT_SDIO2__FUNC_EXT_SDIO2>,
>> +				 <MT2701_PIN_236_EXT_SDIO3__FUNC_EXT_SDIO3>;
>> +			drive-strength = <MTK_DRIVE_4mA>;
>> +			bias-pull-up;
>> +		};
>> +	};
>> +};
>> +
>>  &uart0 {
>>  	status = "okay";
>>  };
>> diff --git a/arch/arm/boot/dts/mt2701.dtsi b/arch/arm/boot/dts/mt2701.dtsi
>> index bdf8954..1eefce4 100644
>> --- a/arch/arm/boot/dts/mt2701.dtsi
>> +++ b/arch/arm/boot/dts/mt2701.dtsi
>> @@ -227,6 +227,18 @@
>>  		status = "disabled";
>>  	};
>>
>> +	nor_flash: spi at 11014000 {
>> +		compatible = "mediatek,mt2701-nor",
>> +			     "mediatek,mt8173-nor";
>
> Why define both here? Is "mediatek,mt8173-nor" really providing a
> subset of the features supported by "mediatek,mt2701-nor"?
>

I think even if the ip block is the same, we should provide both 
bindings, just in case in the future we find out that mt2701 has some 
hidden bug, feature or bug-feature. This way even if we update the 
driver, we stay compatible with older device tree blobs in the wild.

We can drop the mt2701-nor in the bindings definition if you want.

Regards,
Matthias

>> +		reg = <0 0x11014000 0 0xe0>;
>> +		clocks = <&pericfg CLK_PERI_FLASH>,
>> +			 <&topckgen CLK_TOP_FLASH_SEL>;
>> +		clock-names = "spi", "sf";
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +		status = "disabled";
>> +	};
>> +
>>  	mmsys: syscon at 14000000 {
>>  		compatible = "mediatek,mt2701-mmsys", "syscon";
>>  		reg = <0 0x14000000 0 0x1000>;
>
