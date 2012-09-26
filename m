From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Wed, 26 Sep 2012 14:12:58 +0300
Subject: [PATCH] ARM: pxa: hx4700: Fix backlight PWM device number
In-Reply-To: <5062E082.2010503@yahoo.com>
References: <5062652A.8070603@yahoo.com>
 <20120926060337.GB27855@avionic-0098.mockup.avionic-design.de>
 <5062E082.2010503@yahoo.com>
Message-ID: <CA+E=qVePe3Pp6eUY4_r9rmegD7jmwRDP1bU=U5Hz3kJT3FTA7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 26, 2012 at 2:01 PM, Paul Parsons <lost.distance@yahoo.com> wrote:
> Hello Thierry,
>
> On 26/09/12 07:03, Thierry Reding wrote:
>>
>> On Wed, Sep 26, 2012 at 03:15:06AM +0100, Paul Parsons wrote:
>>>
>>> Recent changes to PXA PWM support changed the PXA27X PWM device
>>> numbering scheme.
>>>
>>> The linux-3.5 PXA PWM driver followed the hardware numbering scheme for
>>> the 4 PWMs, while the linux-3.6-rc1 PXA PWM driver has adopted a linear
>>> numbering scheme:
>>>
>>> Address         Hardware        3.5 pwm_id      3.6-rc1 pwm_id
>>> 0x40b00000      PWM0            0               0
>>> 0x40b00010      PWM2            2               1
>>> 0x40c00000      PWM1            1               2
>>> 0x40c00010      PWM3            3               3
>>>
>>> The hx4700 backlight uses PWM1 at 0x40c00000. Consequently the pwm_id
>>> must be changed from 1 to 2.
>>>
>>> Signed-off-by: Paul Parsons <lost.distance@yahoo.com>
>>> Cc: Thierry Reding <thierry.reding@avionic-design.de>
>>> ---
>>>   arch/arm/mach-pxa/hx4700.c |    2 +-
>>>   1 files changed, 1 insertions(+), 1 deletions(-)
>>
>>
>> I wasn't aware of this difference. Sorry for breaking your board. While
>> at it, would you mind converting this to the new style PWM lookup table?
>>
>> You can find the information in Documentation/pwm.txt, but it should be
>> roughly something like this:
>>
>>         static struct pwm_lookup hx4700_pwm_lookup[] = {
>>                 PWM_LOOKUP("pxa27x-pwm.1", 0, "pwm-backlight", NULL),
>>         };
>>
>> You can then call:
>>
>>         pwm_add_table(hx4700_pwm_lookup, ARRAY_SIZE(hx4700_pwm_lookup));
>>
>> from hx4700_init(). The pwm-backlight driver will then be able to use
>> the new pwm_get() to obtain the PWM device. Note that pwm_request() will
>> go away sometime soon, so this conversion will have to be done anyway.
>> If you do it now I won't have to take care of it anymore. =)
>
>
> OK, will do.
>
> BTW, it is possible that the changed numbering scheme will also have
> broken three other PXA27X/PXA3XX boards which use PWM1 or PWM2:
>
> cm-x300
> tavorevb
> z2
>
> Unfortunately I have no way of testing these.
>
> Regards,
> Paul

I have Z2, looks like it's time to test 3.6-rcs on it :)

Regards
Vasily
