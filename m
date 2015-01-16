From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 16 Jan 2015 10:27:23 +0100
Subject: [PATCH v4 4/4] ARM: mvebu: Armada 385 GP: Add regulators to the
 SATA port
In-Reply-To: <54B8C933.7020502@redhat.com>
References: <1421330978-9694-1-git-send-email-gregory.clement@free-electrons.com>
 <1421330978-9694-5-git-send-email-gregory.clement@free-electrons.com>
 <54B8C933.7020502@redhat.com>
Message-ID: <54B8D97B.3090908@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

On 16/01/2015 09:17, Hans de Goede wrote:
> Hi,
> 
> On 15-01-15 15:09, Gregory CLEMENT wrote:
>> Add the regulators to each SATA port.
>>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> ---
>>   arch/arm/boot/dts/armada-388-gp.dts | 126 ++++++++++++++++++++++++++++++++++++
>>   1 file changed, 126 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/armada-388-gp.dts b/arch/arm/boot/dts/armada-388-gp.dts
>> index 4df22bf91683..590b383db323 100644
>> --- a/arch/arm/boot/dts/armada-388-gp.dts
>> +++ b/arch/arm/boot/dts/armada-388-gp.dts
>> @@ -173,6 +173,16 @@
>>   				status = "okay";
>>   				#address-cells = <1>;
>>   				#size-cells = <0>;
>> +
>> +				sata0: sata-port at 0 {
>> +					reg = <0>;
>> +					target-supply = <&reg_5v_sata0>;
>> +				};
>> +
>> +				sata1: sata-port at 1 {
>> +					reg = <1>;
>> +					target-supply = <&reg_5v_sata1>;
>> +				};
>>   			};
>>
>>   			sata at e0000 {
>> @@ -181,6 +191,16 @@
>>   				status = "okay";
>>   				#address-cells = <1>;
>>   				#size-cells = <0>;
>> +
>> +				sata2: sata-port at 0 {
>> +					reg = <0>;
>> +					target-supply = <&reg_5v_sata2>;
>> +				};
>> +
>> +				sata3: sata-port at 1 {
>> +					reg = <1>;
>> +					target-supply = <&reg_5v_sata3>;
>> +				};
>>   			};
>>
>>   			sdhci at d8000 {
>> @@ -278,6 +298,112 @@
>>   		regulator-always-on;
>>   		gpio = <&expander0 4 GPIO_ACTIVE_HIGH>;
>>   	};
>> +
>> +	reg_sata0: pwr-sata0 {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "pwr_en_sata0";
>> +		enable-active-high;
>> +		regulator-always-on;
>> +
>> +	};
>> +
>> +	reg_5v_sata0: v5-sata0 {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "v5.0-sata0";
>> +		regulator-min-microvolt = <5000000>;
>> +		regulator-max-microvolt = <5000000>;
>> +		regulator-always-on;
>> +		vin-supply = <&reg_sata0>;
>> +	};
>> +
>> +	reg_12v_sata0: v12-sata0 {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "v12.0-sata0";
>> +		regulator-min-microvolt = <12000000>;
>> +		regulator-max-microvolt = <12000000>;
>> +		regulator-always-on;
>> +		vin-supply = <&reg_sata0>;
>> +	};
> 
> AFAIK the separate v5 / 12v regulators you're creating here
> are not used anywhere. So I guess there just here to
> accurately / completely describe the power topology ?

Yes it was the point.

> 
>> +
>> +	reg_sata1: pwr-sata1 {
>> +		regulator-name = "pwr_en_sata1";
>> +		compatible = "regulator-fixed";
>> +		regulator-min-microvolt = <12000000>;
>> +		regulator-max-microvolt = <12000000>;
>> +		enable-active-high;
>> +		regulator-always-on;
> 
> 
> The always on here seems to a bit weird, wasn't the
> whole purpose of this patch set to teach ahci_platform
> to turn it on as needed ?

Maybe I misunderstood the regulator binding, but I thought
that (once the suspend will be available on this platform) I
could use:

regulator-state-mem {
			regulator-off-in-suspend;
		};

> 
> You do probably want to put a regulator-boot-on here so
> that disks do not get an unwanted powercycle (bad for
> their lifetime) when the firmware has already turned on
> the disk. Downside of using regulator-boot-on is that if
> the power is not actually turned on no power-on-delay is

That's why I didn't use it

> done, but we're not using a power on delay anyways.

But if regulator-always-on prevent to switch it off in
suspend then yes using regulator-boot-on is better.

Thanks,

Gregory

> 
> The same goes for reg_sata2 & reg_sata3.
> 
>> +		gpio = <&expander0 3 GPIO_ACTIVE_HIGH>;
>> +	};
>> +
>> +	reg_5v_sata1: v5-sata1 {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "v5.0-sata1";
>> +		regulator-min-microvolt = <5000000>;
>> +		regulator-max-microvolt = <5000000>;
>> +		regulator-always-on;
>> +		vin-supply = <&reg_sata1>;
>> +	};
>> +
>> +	reg_12v_sata1: v12-sata1 {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "v12.0-sata1";
>> +		regulator-min-microvolt = <12000000>;
>> +		regulator-max-microvolt = <12000000>;
>> +		regulator-always-on;
>> +		vin-supply = <&reg_sata1>;
>> +	};
>> +
>> +	reg_sata2: pwr-sata2 {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "pwr_en_sata2";
>> +		enable-active-high;
>> +		regulator-always-on;
>> +		gpio = <&expander0 11 GPIO_ACTIVE_HIGH>;
>> +	};
>> +
>> +	reg_5v_sata2: v5-sata2 {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "v5.0-sata2";
>> +		regulator-min-microvolt = <5000000>;
>> +		regulator-max-microvolt = <5000000>;
>> +		regulator-always-on;
>> +		vin-supply = <&reg_sata2>;
>> +	};
>> +
>> +	reg_12v_sata2: v12-sata2 {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "v12.0-sata2";
>> +		regulator-min-microvolt = <12000000>;
>> +		regulator-max-microvolt = <12000000>;
>> +		regulator-always-on;
>> +		vin-supply = <&reg_sata2>;
>> +	};
>> +
>> +	reg_sata3: pwr-sata3 {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "pwr_en_sata3";
>> +		enable-active-high;
>> +		regulator-always-on;
>> +		gpio = <&expander0 12 GPIO_ACTIVE_HIGH>;
>> +	};
>> +
>> +	reg_5v_sata3: v5-sata3 {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "v5.0-sata3";
>> +		regulator-min-microvolt = <5000000>;
>> +		regulator-max-microvolt = <5000000>;
>> +		regulator-always-on;
>> +		vin-supply = <&reg_sata3>;
>> +	};
>> +
>> +	reg_12v_sata3: v12-sata3 {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "v12.0-sata3";
>> +		regulator-min-microvolt = <12000000>;
>> +		regulator-max-microvolt = <12000000>;
>> +		regulator-always-on;
>> +		vin-supply = <&reg_sata3>;
>> +	};
>>   };
>>
>>   &pinctrl {
>>
> 
> Regards,
> 
> Hans
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
