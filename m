From: kever.yang@rock-chips.com (Kever Yang)
Date: Mon, 10 Apr 2017 11:43:27 +0800
Subject: [PATCH v2 1/2] arm64: dts: rk3399: add support for firefly-rk3399
 board
In-Reply-To: <2449203.Hv4EZXJUvX@phil>
References: <1491384800-22412-1-git-send-email-kever.yang@rock-chips.com>
 <2449203.Hv4EZXJUvX@phil>
Message-ID: <438414b9-33fe-3cb0-9f44-e1e6cf94ea81@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,


On 04/08/2017 07:01 AM, Heiko Stuebner wrote:
> Hi Kever,
>
> Am Mittwoch, 5. April 2017, 17:33:19 CEST schrieb Kever Yang:
>> Firefly-rk3399 is a bord from T-Firefly, you can find detail about
>> it here:
>> http://en.t-firefly.com/en/firenow/Firefly_RK3399/
>>
>> This patch add basic node for the board and make it able to bring
>> up.
>>
>> Peripheral works:
>> - usb hub which connect to ehci controller;
>> - UART2 debug
>> - eMMC
>> - PCIe
>>
>> Not work:
>> - USB 3.0 HOST, type-C port
>> - sdio, sd-card
>>
>> Not test for other peripheral:
>> - HDMI
>> - Ethernet
>> - OPTICAL
>> - WiFi/BT
>> - MIPI CSI/DSI
>> - IR
>> - EDP/DP
>>
>> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> [...]
>
>> +	vdd_log: vdd-log {
>> +		compatible = "pwm-regulator";
>> +		pwms = <&pwm2 0 25000 1>;
>> +		regulator-name = "vdd_log";
>> +		regulator-min-microvolt = <800000>;
>> +		regulator-max-microvolt = <1400000>;
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +
>> +		/* for rockchip boot on */
>> +		rockchip,pwm_id= <2>;
>> +		rockchip,pwm_voltage = <1000000>;
> Vendor-kernel stuff, needs to be dropped

Will drop it next version.
>
> [...]
>
>> +&i2c0 {
>> +	status = "okay";
>> +	i2c-scl-rising-time-ns = <168>;
>> +	i2c-scl-falling-time-ns = <4>;
>> +	clock-frequency = <400000>;
>> +
>> +	vdd_cpu_b: pmic at 40 {
>> +		compatible = "silergy,syr827";
>> +		reg = <0x40>;
>> +		vin-supply = <&vcc5v0_sys>;
>> +		regulator-compatible = "fan53555-reg";
>> +		regulator-name = "vdd_cpu_b";
>> +		regulator-min-microvolt = <712500>;
>> +		regulator-max-microvolt = <1500000>;
>> +		regulator-ramp-delay = <1000>;
>> +		vsel-gpios = <&gpio1 RK_PC2 GPIO_ACTIVE_HIGH>;
> non-mainline property

Will drop it next version.
>
>> +		fcs,suspend-voltage-selector = <0>;
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +		regulator-initial-state = <3>;
> non-mainline property

Will drop it next version.
>
>> +			regulator-state-mem {
> indentation is wrong
>
>> +			regulator-off-in-suspend;
>> +		};
>> +	};
>> +
>> +	vdd_gpu: syr828 at 41 {
>> +		compatible = "silergy,syr828";
>> +		reg = <0x41>;
>> +		vin-supply = <&vcc5v0_sys>;
>> +		regulator-compatible = "fan53555-reg";
>> +		regulator-name = "vdd_gpu";
>> +		regulator-min-microvolt = <712500>;
>> +		regulator-max-microvolt = <1500000>;
>> +		regulator-ramp-delay = <1000>;
>> +		fcs,suspend-voltage-selector = <1>;
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +		regulator-initial-state = <3>;
> non-mainline property

Will drop it next version.
>
>> +			regulator-state-mem {
> indentation is wrong
>
>> +			regulator-off-in-suspend;
>> +		};
>> +	};
>> +
>> +	rk808: pmic at 1b {
>> +		compatible = "rockchip,rk808";
>> +		reg = <0x1b>;
>> +		interrupt-parent = <&gpio1>;
>> +		interrupts = <21 IRQ_TYPE_LEVEL_LOW>;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pmic_int_l>;
>> +		rockchip,system-power-controller;
> system-power-controller without the "rockchip,"?

The driver at drivers/mfd/rk808.c is using "rockchip, 
system-power-controller".
>
>> +		wakeup-source;
>> +		#clock-cells = <1>;
>> +		clock-output-names = "xin32k", "rk808-clkout2";
> [...]
>
>> +&i2c1 {
>> +	status = "okay";
>> +	i2c-scl-rising-time-ns = <300>;
>> +	i2c-scl-falling-time-ns = <15>;
>> +
>> +	gsl3673: gsl3673 at 40 {
> gsl3673: touchscreen at 40
>
>> +		compatible = "GSL,GSL3673";
> compatible lowercase?

This is not using upstream driver, need porting, remove it now.
>
>> +		reg = <0x40>;
>> +		screen_max_x = <1536>;
>> +		screen_max_y = <2048>;
>> +		irq_gpio_number = <&gpio1 RK_PC4 IRQ_TYPE_LEVEL_LOW>;
>> +		rst_gpio_number = <&gpio4 RK_PC6 GPIO_ACTIVE_HIGH>;
>> +	};
>> +
>> +	rt5640: rt5640 at 1c {
>> +		#sound-dai-cells = <0>;
>> +		compatible = "realtek,rt5640";
>> +		reg = <0x1c>;
>> +		clocks = <&cru SCLK_I2S_8CH_OUT>;
>> +		clock-names = "mclk";
>> +		realtek,in1-differential;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&rt5640_hpcon>;
>> +		hp-con-gpio = <&gpio4 RK_PC5 GPIO_ACTIVE_HIGH>;
>> +		io-channels = <&saradc 4>;
>> +		hp-det-adc-value = <500>;
> these last 3 properties are not contained in the rt5640 binding
> document on linux-next-20170407 .

Will drop these properties nex version.
>
>> +	};
>> +};
>> +
>> +&i2c3 {
>> +	status = "okay";
>> +	i2c-scl-rising-time-ns = <450>;
>> +	i2c-scl-falling-time-ns = <15>;
>> +};
>> +
>> +&i2c4 {
>> +	status = "okay";
>> +	i2c-scl-rising-time-ns = <600>;
>> +	i2c-scl-falling-time-ns = <20>;
>> +
>> +	fusb0: fusb30x at 22 {
> fusb0: usb-typec at 22 or so
>
> Also that device is not in mainline yet, so has no approved binding
> so should not be included right now.

Yes, fusb302 driver is not upstreamed, will remove it next version.

Thanks,
- Kever
>
>> +		compatible = "fairchild,fusb302";
>> +		reg = <0x22>;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&fusb0_int>;
>> +		int-n-gpios = <&gpio1 RK_PA2 GPIO_ACTIVE_HIGH>;
>> +		vbus-5v-gpios = <&gpio2 RK_PA0 GPIO_ACTIVE_HIGH>;
>> +		status = "okay";
>> +	};
>> +
>> +	mpu6500 at 68 {
> accelerometer at 68
>
>> +		status = "okay";
>> +		compatible = "invensense,mpu6500";
>> +		reg = <0x68>;
>> +		irq-gpio = <&gpio1 RK_PC6 IRQ_TYPE_EDGE_RISING>;
>> +		mpu-int_config = <0x10>;
>> +		mpu-level_shifter = <0>;
>> +		mpu-orientation = <0 1 0 1 0 0 0 0 1>;
>> +		orientation-x= <1>;
>> +		orientation-y= <0>;
>> +		orientation-z= <0>;
>> +		mpu-debug = <1>;
>> +	};
>> +};
>> +
> [...]
>
>> +&u2phy0 {
>> +	status = "okay";
>> +	extcon = <&fusb0>;
> see comment for fusb302
>
>> +
>> +	u2phy0_otg: otg-port {
>> +		status = "okay";
>> +	};
>> +
>> +	u2phy0_host: host-port {
>> +		phy-supply = <&vcc5v0_host>;
>> +		status = "okay";
>> +	};
>> +};
>> +
>
> Heiko
>
>
