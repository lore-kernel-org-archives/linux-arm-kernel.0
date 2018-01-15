From: Claudiu.Beznea@microchip.com (Claudiu Beznea)
Date: Mon, 15 Jan 2018 11:01:34 +0200
Subject: [PATCH v2 03/16] pwm: cros-ec: update documentation regarding
 pwm-cells
In-Reply-To: <20180112183122.GA102880@google.com>
References: <1515766983-15151-1-git-send-email-claudiu.beznea@microchip.com>
 <1515766983-15151-4-git-send-email-claudiu.beznea@microchip.com>
 <20180112183122.GA102880@google.com>
Message-ID: <61b85600-7aee-e9d1-6587-17e5e419b03a@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12.01.2018 20:31, Brian Norris wrote:
> On Fri, Jan 12, 2018 at 04:22:50PM +0200, Claudiu Beznea wrote:
>> pwm-cells should be at least 2 to provide channel number and period value.
> 
> Nacked-by: Brian Norris <briannorris@chromium.org>
> 
> We don't control the period from the kernel; only the duty cycle.
I agree, I saw this in the driver. This is the way I put the 0xffff
period in the patch 7 of this series. I though that since all the drivers
which uses PWM framework uses the generic PWM bindings (except pwm-pxa.c,
pwm-cros-ec.c and pwm-clps711x.c) I though it would be simpler (from the
driver's perspective and also from core's perspective) to have generic
bindings for all as follows:
pwms = <&controller PWM-channel PWM-period PWM-flags>;

To allow pwm-cross-ec.c to use this generic binding, since it is uses a
fix period and of_pwm_xlate() xlate DT arguments without taking care of
the cross-ec particularity, using 0xffff period in the pwms binding will
not harm this driver (correct me if I'm wrong). For this, the pwm-cells
argument need to be increased at 2. In patch 7 of this series I used
pwms = <&cros_ec_pwm 1 65535>;
which initialize the PWM 1 with 0xffff period.

Thanks,
Claudiu

(Now,
> that's perhaps not a wise firmware interface, and we may fix that
> someday, but you can't just declare a breaking change to a documented,
> reviewed binding.
> 
>> Cc: Brian Norris <briannorris@chromium.org>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
>> ---
>>  Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.txt | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.txt b/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.txt
>> index 472bd46ab5a4..03347fd302b5 100644
>> --- a/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.txt
>> +++ b/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.txt
>> @@ -8,7 +8,7 @@ Documentation/devicetree/bindings/mfd/cros-ec.txt).
>>  
>>  Required properties:
>>  - compatible: Must contain "google,cros-ec-pwm"
>> -- #pwm-cells: Should be 1. The cell specifies the PWM index.
>> +- #pwm-cells: Should be 2. The cell specifies the PWM index.
> 
> Umm, "2 cells", but you use the singular "cell", and don't document what
> the second one is? That's nonsense.
> 
> Brian
> 
>>  
>>  Example:
>>  	cros-ec at 0 {
>> @@ -18,6 +18,6 @@ Example:
>>  
>>  		cros_ec_pwm: ec-pwm {
>>  			compatible = "google,cros-ec-pwm";
>> -			#pwm-cells = <1>;
>> +			#pwm-cells = <2>;
>>  		};
>>  	};
>> -- 
>> 2.7.4
>>
> 
