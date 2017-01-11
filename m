From: david@lechnology.com (David Lechner)
Date: Wed, 11 Jan 2017 10:25:18 -0600
Subject: [PATCH v2 5/5] ARM: dts: Add LEGO MINDSTORMS EV3 dts
In-Reply-To: <e8136b8a-b8f7-7b1b-693a-955dc17f1de9@ti.com>
References: <1483677228-2325-1-git-send-email-david@lechnology.com>
 <1483677228-2325-6-git-send-email-david@lechnology.com>
 <e8136b8a-b8f7-7b1b-693a-955dc17f1de9@ti.com>
Message-ID: <1dd57ac3-554f-7d66-97b0-b76c3ddc7854@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/11/2017 04:42 AM, Sekhar Nori wrote:
> On Friday 06 January 2017 10:03 AM, David Lechner wrote:
>
>> +	beeper {
>> +		compatible = "pwm-beeper";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&ehrpwm0b_pins>, <&amp_pins>;
>> +		pwms = <&ehrpwm0 1 0 0>;
>> +		enable-gpios = <&gpio 111 GPIO_ACTIVE_HIGH>;
>
> Since the enable-gpios binding for pwm beeper is still not accepted, can
> you drop the property or the node itself (if that makes more sense)?

No sound will come out of the speaker without enabling this gpio. So, I 
guess I will just drop this node for now.


>
>> +&spi0 {
>> +	status = "okay";
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&spi0_pins>, <&spi0_cs0_pin>, <&spi0_cs3_pin>;
>> +
>> +	flash at 0 {
>> +		compatible = "n25q128a13", "jedec,spi-nor";
>> +		reg = <0>;
>> +		spi-max-frequency = <50000000>;
>> +		ti,spi-wdelay = <8>;
>> +
>> +		/* Partitions are based on the official firmware from LEGO */
>> +		partitions {
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			partition at 0 {
>> +				label = "U-Boot";
>> +				reg = <0 0x40000>;
>> +			};
>> +
>> +			partition at 40000 {
>> +				label = "U-Boot Env";
>> +				reg = <0x40000 0x10000>;
>> +			};
>> +
>> +			partition at 50000 {
>> +				label = "Kernel";
>> +				reg = <0x50000 0x200000>;
>> +			};
>> +
>> +			partition at 250000 {
>> +				label = "Filesystem";
>> +				reg = <0x250000 0xa50000>;
>> +			};
>> +
>> +			partition at cb0000 {
>> +				label = "Storage";
>> +				reg = <0xcb0000 0x2f0000>;
>> +			};
>> +		};
>> +	};
>> +
>> +	adc at 3 {
>> +		compatible = "ti-ads7957";
>
> So looks like this works because of_register_spi_device() sets up
> modalias of spi device from compatible string. I am fine with it, just
> highlighting it here to make sure this is acceptable practice. I did not
> really find any precedence for using SPI device name as compatible
> property in existing DTS files.

Indeed. It looks like this sort of "trivial" device binding is just used 
for i2c devices. I will submit some patches to add proper device tree 
bindings and change this to "ti,ads7957".

>
>> +		reg = <3>;
>> +		spi-max-frequency = <10000000>;
>> +		refin-supply = <&adc_ref>;
>> +	};
>
> Rest of the patch looks good to me.
>
> Thanks,
> Sekhar
>
