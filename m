From: lost.distance@yahoo.com (Paul Parsons)
Date: Wed, 26 Sep 2012 11:39:56 +0100
Subject: [PATCH] ARM: pxa: hx4700: Fix backlight PWM device number
In-Reply-To: <CA+E=qVfnjQJrrW-5jYzt8yxEH7t3merHzPH2RVAjD0GbcviTgw@mail.gmail.com>
References: <5062652A.8070603@yahoo.com> <5062659E.6030104@yahoo.com>
 <CA+E=qVfnjQJrrW-5jYzt8yxEH7t3merHzPH2RVAjD0GbcviTgw@mail.gmail.com>
Message-ID: <5062DB7C.5050203@yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Vasily,

On 26/09/12 07:40, Vasily Khoruzhick wrote:
> On Wed, Sep 26, 2012 at 5:17 AM, Paul Parsons <lost.distance@yahoo.com> wrote:
>> Recent changes to PXA PWM support changed the PXA27X PWM device
>> numbering scheme.
>>
>> The linux-3.5 PXA PWM driver followed the hardware numbering scheme for
>> the 4 PWMs, while the linux-3.6-rc1 PXA PWM driver has adopted a linear
>> numbering scheme:
>>
>> Address         Hardware        3.5 pwm_id      3.6-rc1 pwm_id
>> 0x40b00000      PWM0            0               0
>> 0x40b00010      PWM2            2               1
>> 0x40c00000      PWM1            1               2
>> 0x40c00010      PWM3            3               3
>
> Looks very weird to me. Maybe it would be better to fix pwm numbering
> scheme to prevent breakage of
> other machines?

I thought the same thing. However the code doesn't make it easy:

1. The definition of pwm_id values moved from the pwm_probe() in
arch/arm/plat-pxa/pwm.c to pwmchip_add() in drivers/pwm/core.c.
Changing the latter generic code would impact all of the PWM drivers,
not just the PXA PWM driver.

2. Changing just the PXA PWM driver would require its pwm_ops handlers
(config(), enable(), disable()) to quietly translate between PWM1 and
PWM2 devices. However PWM1 and PWM2 are on different chips (i.e.
pwm_chip structures). So what would the driver do when there is only
one chip? i.e.:
a) Between the first and second calls to pwm_probe().
b) Between the first and second calls to pwm_remove().
And in any case quietly translating between PWM1 and PWM2 just doesn't
seem like a good idea: sooner or later it will quietly break the
generic code.

On balance it seemed preferable to change the platform code.

Regards,
Paul
