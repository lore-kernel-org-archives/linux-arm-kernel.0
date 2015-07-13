From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Mon, 13 Jul 2015 13:20:23 +0530
Subject: [PATCH 5/6] mfd: devicetree: bindings: 88pm800: Add DT property
 for dual phase enable
In-Reply-To: <55A0C2CB.6060209@samsung.com>
References: <1436442431-3471-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1436442431-3471-6-git-send-email-vaibhav.hiremath@linaro.org>
 <55A0C2CB.6060209@samsung.com>
Message-ID: <55A36DBF.5020100@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Saturday 11 July 2015 12:46 PM, Krzysztof Kozlowski wrote:
> W dniu 09.07.2015 o 20:47, Vaibhav Hiremath pisze:
>> 88PM860 family of device supports dual phase mode on BUCK1 supply
>> providing total 6A capacity.
>> Note that by default they operate independently with 3A capacity.
>>
>> This patch adds the devicetree binding to enable this
>> feature.
>>
>> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
>> ---
>>   Documentation/devicetree/bindings/mfd/88pm800.txt | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/88pm800.txt b/Documentation/devicetree/bindings/mfd/88pm800.txt
>> index ae1311c..c756b31 100644
>> --- a/Documentation/devicetree/bindings/mfd/88pm800.txt
>> +++ b/Documentation/devicetree/bindings/mfd/88pm800.txt
>> @@ -15,6 +15,12 @@ Optional properties :
>>         CLK32K3 - for 88pm800
>>         CLK32K2 - for 88pm860
>>
>> +   (Applicable only to PXA910 family):
>> +
>> + - marvell,88pm860-buck1-dualphase-en	: If set, enable dual phase on BUCK1,
>> +   providing 6A capacity.
>> +   Without this both BUCK1A and BUCK1B operates independently with 3A capacity.
>> +
>
> 1. How does this relates to regulator driver? The
> drivers/regulator/88pm800.c defines constraints for regulator which may
> be contradictory.
>
> 2. This looks like a job for regulator driver, not MFD. Then you could
> use standard regulator bindings (setting maximum current to 6A would
> change the regulator to different mode).

Make sense. and even better.

I believe you are referring to,

regulator-min-microamp = <3000000>;
regulator-max-microamp = <6000000>;

And provide set_current_limit() callback, to set the dualphase.

Just to clarify more on this,

The DT property would look something like,

regulators {
	compatible = "marvell,88pm80x-regulator";

	buck1a: BUCK1A {
		regulator-compatible = "buck1";
		regulator-min-microvolt = <600000>;
		regulator-max-microvolt = <1800000>;

		regulator-min-microamp = <3000000>;
		regulator-max-microamp = <6000000>;

		regulator-boot-on;
		regulator-always-on;
	};

	buck1b: BUCK1B {
		regulator-compatible = "buck1b";
		regulator-min-microvolt = <600000>;
		regulator-max-microvolt = <1800000>;

		regulator-min-microamp = <3000000>;
		regulator-max-microamp = <6000000>;

		regulator-boot-on;
		regulator-always-on;
	};
};


And for the platforms, where dual phase is not required,
we can either choose not to set these properties or set it to


		regulator-min-microamp = <3000000>;
		regulator-max-microamp = <3000000>;


Thanks,
Vaibhav
