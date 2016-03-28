From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 28 Mar 2016 09:08:48 +0900
Subject: [PATCH] ARM: dts: exynos: Fix invalid maximum voltage for buck9
 supplying SD card
In-Reply-To: <56F4D070.4020403@osg.samsung.com>
References: <1458807125-13580-1-git-send-email-k.kozlowski@samsung.com>
 <56F4D070.4020403@osg.samsung.com>
Message-ID: <56F87610.2040304@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25.03.2016 14:45, Javier Martinez Canillas wrote:
> Hello Krzysztof,
> 
> On 03/24/2016 05:12 AM, Krzysztof Kozlowski wrote:
>> The buck9 regulator of S2MPS11 PMIC had incorrect maximum voltage -
>> lower by 5 mV than specified by datasheet. This buck9 provides power to
>> other regulators, including LDO13 and LDO19 which supply the MMC2 (SD
>> card).
>>
>> When constraints were applied, the depending regulators were not
>> providing enough power, leading to SD card detection errors:
>> 	mmc1: card never left busy state
>> 	mmc1: error -110 whilst initialising SD card
>>
>> Fixes: 86a2d2ac5e5d ("ARM: dts: Add dts file for Odroid XU3 board")
>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>>
>> ---
>>
>> The issue can be reproduced on next-20160324 with
>> bae4fdc88d7f7dda1 (regulator: core: Ensure we are at least in bounds for our constraints).
>> ---
>>  arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
>> index 1bd507bfa750..82b2ba632cf6 100644
>> --- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
>> +++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
>> @@ -299,7 +299,7 @@
>>  			buck9_reg: BUCK9 {
>>  				regulator-name = "vdd_2.8v_ldo";
>>  				regulator-min-microvolt = <3000000>;
>> -				regulator-max-microvolt = <3750000>;
>> +				regulator-max-microvolt = <3755000>;
>>  				regulator-always-on;
>>  				regulator-boot-on;
>>  			};
>>
> 
> I tested next-20160324 + $SUBJECT on an Odroid XU4 (with exynos_defconfig)
> and while it's true that the patch makes the SD card error to go away, I see
> that the s2mps11 regulator driver fails to probe due an -EINVAL being return
> by machine_constraints_voltage() -> _regulator_do_set_voltage():
> 
> [    1.710300] vdd_2.8v_ldo: failed to apply 3755000-3755000uV constraint(-22)
> [    1.716387] s2mps11-pmic s2mps11-regulator: regulator init failed for 46
> [    1.734878] s2mps11-pmic: probe of s2mps11-regulator failed with error -22

Oh, damn, so the fix was only because driver failed to probe (which I
missed). This explains Friday's next failures. I'll drop it from next
because it makes more harm than good...

BR,
Krzysztof

> I wonder how neither Markus nor you saw this issue when testing so maybe I'm
> doing something wrong? Since AFAICT it's only working because the driver fails
> to probe so the same effect can be achieved disabling CONFIG_REGULATOR_S2MPS11.
> 
> Best regards,
> 
