From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Wed, 16 Mar 2016 11:58:11 +0100
Subject: [PATCH v3 6/8] arm64: dts: rockchip: Add power key to GeekBox
In-Reply-To: <6BD669A2-4971-4702-8742-77C9994AA4E9@gmail.com>
References: <1457294038-14243-1-git-send-email-afaerber@suse.de>
 <1457294038-14243-7-git-send-email-afaerber@suse.de>
 <6BD669A2-4971-4702-8742-77C9994AA4E9@gmail.com>
Message-ID: <56E93C43.1060500@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 11.03.2016 um 00:04 schrieb Julien Chauveau:
>> Le 6 mars 2016 ? 20:53, Andreas F?rber <afaerber@suse.de> a ?crit :
>>
>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
>> ---
>> v2 -> v3:
>> * Adopted wakeup-source instead of gpio-key,wakeup (Julien)
>> * Dropped gpio-keys #address-cells and #size-cells properties (Julien)
>> * Dropped power button reg property (Julien)
>> * Adopted KEY_POWER (Julien)
>> * Fixed power button pinctrl pull setting (Julien)
>>
>> v2: New
>>
>> arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts | 20 ++++++++++++++++++++
>> 1 file changed, 20 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts b/arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts
>> index 098be3700a6f..7036b49c9206 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts
>> +++ b/arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts
>> @@ -42,6 +42,7 @@
>>
>> /dts-v1/;
>> #include "rk3368.dtsi"
>> +#include <dt-bindings/input/input.h>
>>
>> / {
>> 	model = "GeekBox";
>> @@ -70,6 +71,19 @@
>> 		pinctrl-0 = <&ir_int>;
>> 	};
>>
>> +	keys: gpio-keys {
> 
> I think you don't need the "keys" label, because there?s no phandle that refers to this.

As discussed elsewhere, there are four additional keys on the
Landingship (you proposed as sub-node names key1-key4).
I prefer preparing the label now over adding it in a later patch.

>> +		compatible = "gpio-keys";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pwr_key>;
>> +
>> +		button at 0 {
> 
> Here you should use "power" instead of "button at 0".

Done.

>> +			gpios = <&gpio0 2 GPIO_ACTIVE_LOW>;
>> +			label = "GPIO Power";
>> +			linux,code = <KEY_POWER>;
> 
> According to Documentation/input/event-codes.txt, there?s a special event type for the power button.
> Should we use it here for that purpose?
> 
> 			linux,input-type = <EV_PWR>

The other RK3368 boards don't, so unless you can give a justification to
convert all boards yet again and test how this makes a difference, I'd
rather not do experiments here but leave that to someone who knows what
they're doing and then do it consistently...

Thanks for the detailed review,

Andreas

>> +			wakeup-source;
>> +		};
>> +	};
>> +
>> 	leds: gpio-leds {
>> 		compatible = "gpio-leds";
>>
>> @@ -265,6 +279,12 @@
>> 		};
>> 	};
>>
>> +	keys {
>> +		pwr_key: pwr-key {
>> +			rockchip,pins = <0 2 RK_FUNC_GPIO &pcfg_pull_none>;
>> +		};
>> +	};
>> +
>> 	pmic {
>> 		pmic_sleep: pmic-sleep {
>> 			rockchip,pins = <0 0 RK_FUNC_2 &pcfg_pull_none>;

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton; HRB 21284 (AG N?rnberg)
