From: stefan@agner.ch (Stefan Agner)
Date: Sun, 13 Dec 2015 18:53:35 -0800
Subject: [PATCH 1/2] ARM: dts: vf-colibri: split PWM pinctrl
In-Reply-To: <20151214021801.GA25756@tiger>
References: <1449094307-6011-1-git-send-email-stefan@agner.ch>
 <20151214021801.GA25756@tiger>
Message-ID: <86e283b5c7ed5f54ef25c9ff7e747834@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-12-13 18:18, Shawn Guo wrote:
> On Wed, Dec 02, 2015 at 02:11:46PM -0800, Stefan Agner wrote:
>> Split PWM pins into separate pinctrl nodes to allow overrides which
>> select pins individually. This is useful for carrier boards which use
>> only one pin for PWM and would like to use the other pin for a
>> different purpose.
>>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> ---
>>  arch/arm/boot/dts/vf-colibri.dtsi | 18 ++++++++++++++----
>>  1 file changed, 14 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/vf-colibri.dtsi b/arch/arm/boot/dts/vf-colibri.dtsi
>> index e5949b9..924b660 100644
>> --- a/arch/arm/boot/dts/vf-colibri.dtsi
>> +++ b/arch/arm/boot/dts/vf-colibri.dtsi
>> @@ -74,12 +74,12 @@
>>
>>  &pwm0 {
>>  	pinctrl-names = "default";
>> -	pinctrl-0 = <&pinctrl_pwm0>;
>> +	pinctrl-0 = <&pinctrl_pwm0_a &pinctrl_pwm0_c>;
>>  };
>>
>>  &pwm1 {
>>  	pinctrl-names = "default";
>> -	pinctrl-0 = <&pinctrl_pwm1>;
>> +	pinctrl-0 = <&pinctrl_pwm1_b &pinctrl_pwm1_d>;
>>  };
> 
> It may make more sense to define these pwm nodes in the final board
> level dts with only defining the pins that are actually used on the
> board.

Well, if we follow that policy, we would have to remove almost anything
from the -colibri.dtsi device trees...

The Colibri standard defines standard functionality, which is kept
compatible across modules with different SoC's. However, on almost all
pins different functionality is available, and we have some customer
which make use that....

So far we followed the policy that we define the pin/device
configuration of the standard functionality in the -colibri.dtsi files
(since this is the most used functionality). This allows us to also
"bug-fix" standard functionality without having to touch customers
(often out-of-tree) device trees.

This change is not different from that approach, it merely splits the
pin configuration in two individual pinctrl nodes. This makes sense for
PWM signals since they can be used individually (compared to, lets say,
I2C, where it is more like "all or nothing")...  It turned out that
several customers used PWM<A> for the display back light, while using
PWM<C> in a different function, therefor that change.

--
Stefan

>>
>>  &uart0 {
>> @@ -195,16 +195,26 @@
>>  			>;
>>  		};
>>
>> -		pinctrl_pwm0: pwm0grp {
>> +		pinctrl_pwm0_a: pwm0agrp {
>>  			fsl,pins = <
>>  				VF610_PAD_PTB0__FTM0_CH0		0x1182
>> +			>;
>> +		};
>> +
>> +		pinctrl_pwm0_c: pwm0cgrp {
>> +			fsl,pins = <
>>  				VF610_PAD_PTB1__FTM0_CH1		0x1182
>>  			>;
>>  		};
>>
>> -		pinctrl_pwm1: pwm1grp {
>> +		pinctrl_pwm1_b: pwm1bgrp {
>>  			fsl,pins = <
>>  				VF610_PAD_PTB8__FTM1_CH0		0x1182
>> +			>;
>> +		};
>> +
>> +		pinctrl_pwm1_d: pwm1dgrp {
>> +			fsl,pins = <
>>  				VF610_PAD_PTB9__FTM1_CH1		0x1182
>>  			>;
>>  		};
>> --
>> 2.6.2
>>
>>
