From: yixun.lan@amlogic.com (Yixun Lan)
Date: Sat, 28 Apr 2018 09:56:07 +0800
Subject: [PATCH] ARM64: dts: meson-axg: enable AP6255 wifi module
In-Reply-To: <7h7eos1n68.fsf@baylibre.com>
References: <20180423145729.14368-1-yixun.lan@amlogic.com>
 <7h7eos1n68.fsf@baylibre.com>
Message-ID: <30de15b8-4cc4-7f97-d134-7af75cb6ace1@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/28/18 03:09, Kevin Hilman wrote:
> Yixun Lan <yixun.lan@amlogic.com> writes:
> 
>> The Meson-AXG S400 board is shipped with AP6255 wifi module,
>> which is actually using the brcmfmac 43455 driver.
>>
>> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
>> ---
>>  .../arm64/boot/dts/amlogic/meson-axg-s400.dts | 44 ++++++++++++++++++-
>>  1 file changed, 43 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
>> index f67d4e47e641..b3e1bdca32bb 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
>> +++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
>> @@ -51,7 +51,16 @@
>>  
>>  	sdio_pwrseq: sdio-pwrseq {
>>  		compatible = "mmc-pwrseq-simple";
>> -		reset-gpios = <&gpio GPIOX_6 GPIO_ACTIVE_LOW>;
>> +		reset-gpios = <&gpio GPIOX_7 GPIO_ACTIVE_LOW>;
> 
> You didn't mention this GPIO change in the changelog.  Is it
> intentional?

Yes, the 'sdio_pwrseq' is used by wifi driver till now
previous the reset-gpio is wrongly configured (copy & paste error),
according to the schematics, it's GPIOX_7 which need to be fixed here.

to be clean, in s400 board
 GPIOX_6 is WIFI_WAKE_HOST pin
 GPIOX_7 is WIFI_PWREN pin

do you want me to put a note into the commit message? and resend this patch?

Thanks


> 
>> +		clocks = <&wifi32k>;
>> +		clock-names = "ext_clock";
>> +	};
>> +
>> +	wifi32k: wifi32k {
>> +		compatible = "pwm-clock";
>> +		#clock-cells = <0>;
>> +		clock-frequency = <32768>;
>> +		pwms = <&pwm_ab 0 30518 0>; /* PWM_A at 32.768KHz */
>>  	};
>>  };
>>  
>> @@ -86,6 +95,12 @@
>>  	pinctrl-names = "default";
>>  };
>>  
>> +&pwm_ab {
>> +	status = "okay";
>> +	pinctrl-0 = <&pwm_a_x20_pins>;
>> +	pinctrl-names = "default";
>> +};
>> +
>>  /* emmc storage */
>>  &sd_emmc_c {
>>  	status = "okay";
>> @@ -105,3 +120,30 @@
>>  	vmmc-supply = <&vcc_3v3>;
>>  	vqmmc-supply = <&vddio_boot>;
>>  };
>> +
>> +/* wifi module */
>> +&sd_emmc_b {
>> +	status = "okay";
>> +	#address-cells = <1>;
>> +	#size-cells = <0>;
>> +
>> +	pinctrl-0 = <&sdio_pins>;
>> +	pinctrl-1 = <&sdio_clk_gate_pins>;
>> +	pinctrl-names = "default", "clk-gate";
>> +
>> +	bus-width = <4>;
>> +	cap-sd-highspeed;
>> +	max-frequency = <100000000>;
>> +	non-removable;
>> +	disable-wp;
>> +
>> +	mmc-pwrseq = <&sdio_pwrseq>;
>> +
>> +	vmmc-supply = <&vddao_3v3>;
>> +	vqmmc-supply = <&vddio_boot>;
>> +
>> +	brcmf: wifi at 1 {
>> +		reg = <1>;
>> +		compatible = "brcm,bcm4329-fmac";
>> +	};
>> +};
> 
> .
> 
