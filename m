From: Claudiu.Beznea@microchip.com (Claudiu.Beznea at microchip.com)
Date: Fri, 12 Oct 2018 13:05:50 +0000
Subject: [RESEND PATCH v5 8/9] pwm: add documentation for pwm push-pull
 mode
In-Reply-To: <20181012121552.GE31561@ulmo>
References: <1535461286-12308-1-git-send-email-claudiu.beznea@microchip.com>
 <1535461286-12308-9-git-send-email-claudiu.beznea@microchip.com>
 <20181012121552.GE31561@ulmo>
Message-ID: <f4a1f9e3-b3a8-2847-f13e-bb07dab400e6@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12.10.2018 15:15, Thierry Reding wrote:
> On Tue, Aug 28, 2018 at 04:01:25PM +0300, Claudiu Beznea wrote:
>> Add documentation for PWM push-pull mode.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> ---
>>  Documentation/devicetree/bindings/pwm/pwm.txt |  2 ++
>>  Documentation/pwm.txt                         | 16 ++++++++++++++++
>>  include/dt-bindings/pwm/pwm.h                 |  1 +
>>  3 files changed, 19 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pwm/pwm.txt b/Documentation/devicetree/bindings/pwm/pwm.txt
>> index 7c8aaac43f92..6a60c0fca112 100644
>> --- a/Documentation/devicetree/bindings/pwm/pwm.txt
>> +++ b/Documentation/devicetree/bindings/pwm/pwm.txt
>> @@ -49,6 +49,8 @@ Optionally, the pwm-specifier can encode a number of flags (defined in
>>  - PWM_MODE_COMPLEMENTARY: PWM complementary working mode (for PWM channels
>>  with two outputs); if not specified, the default for PWM channel will be
>>  used
>> +- PWM_MODE_PUSH_PULL: PWM push-pull working modes (for PWM channels with
>> +two outputs); if not specified the default for PWM channel will be used
> 
> What if somebody has this in the DT:
> 
> 	PWM_MODE_COMPLEMENTARY | PWM_MODE_PUSH_PULL
> 
> which one takes precedence, or do we reject it?

The first valid one will be selected.

In patch 1/1 from this series, changes added to of_pwm_xlate_with_flags()
function, there is this code:

+		for (modebit = PWMC_MODE_COMPLEMENTARY_BIT;
+		     modebit < PWMC_MODE_CNT; modebit++) {
+			unsigned long mode = BIT(modebit);
+
+			if ((args->args[2] & mode) &&
+			    pwm_mode_valid(pwm, mode)) {
+				pwm->args.mode = mode;
+				break;
+			}
+		}

And since the modes bits are defined as follows:

enum {
	PWMC_MODE_NORMAL_BIT,
	PWMC_MODE_COMPLEMENTARY_BIT,
	PWMC_MODE_PUSH_PULL_BIT,
	PWMC_MODE_CNT,
};

in your proposed scenario: PWM_MODE_COMPLEMENTARY | PWM_MODE_PUSH_PULL
the PWM_MODE_COMPLEMENTARY mode will be selected since it is the first
valid one.

> 
> Wouldn't it be preferable to either move the modes into an extra field
> within the flags field, or perhaps even add another field?

This approach was proposed in version 2 of this series and based on the
discussions I had with Rob Herring [1] I decided to use the remaining space
from cell specific to PWM flags.

Thank you,
Claudiu Beznea

[1] https://lkml.org/lkml/2018/1/22/655

> 
> I guess since Rob's already acked this, that concern may be unfounded.
> 
> Thierry
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
