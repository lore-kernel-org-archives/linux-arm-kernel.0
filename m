From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 5 May 2015 12:51:51 +0900
Subject: [PATCH 3/3] ARM: s3c24xx: H1940: Move gpiochip_add call into
 core_init() callback
In-Reply-To: <CA+E=qVeYgddYLxK8izaJk2ta+d9OT+e-2Je7KZUpwbj3AAQsPQ@mail.gmail.com>
References: <1430676910-30657-1-git-send-email-anarsoul@gmail.com>
 <1430676910-30657-3-git-send-email-anarsoul@gmail.com>
 <CAJKOXPd8XgpcoS2knB8JYNeRVRjO=jetwM64tVYW9hPCYN8UoA@mail.gmail.com>
 <CA+E=qVeYgddYLxK8izaJk2ta+d9OT+e-2Je7KZUpwbj3AAQsPQ@mail.gmail.com>
Message-ID: <CAJKOXPeNL+5GsNxLrjwJFPDSqs5uTzUROhiVn_McKSHTapjaUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-05-05 3:27 GMT+09:00 Vasily Khoruzhick <anarsoul@gmail.com>:
> On Mon, May 4, 2015 at 6:23 AM, Krzysztof Kozlowski
> <k.kozlowski@samsung.com> wrote:
>> 2015-05-04 3:15 GMT+09:00 Vasily Khoruzhick <anarsoul@gmail.com>:
>>> gpiochip_add() allocates memory, however it's not possible anymore
>>
>> "...to call it..."? Something is missing in the sentence.
>
> "it" replaces "memory allocation" here (kzalloc fails)
>
>>> from
>>> machine map_io() callback thus it failed and prevented machine from booting
>>> properly.
>>>
>>> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
>>> ---
>>>  arch/arm/mach-s3c24xx/mach-h1940.c | 7 ++++++-
>>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm/mach-s3c24xx/mach-h1940.c b/arch/arm/mach-s3c24xx/mach-h1940.c
>>> index 86d9ec7..744aa4f 100644
>>> --- a/arch/arm/mach-s3c24xx/mach-h1940.c
>>> +++ b/arch/arm/mach-s3c24xx/mach-h1940.c
>>> @@ -777,9 +777,14 @@ static void __init h1940_map_io(void)
>>>
>>>         /* Add latch gpio chip, set latch initial value */
>>>         h1940_latch_control(0, 0);
>>> -       WARN_ON(gpiochip_add(&h1940_latch_gpiochip));
>>>  }
>>>
>>> +static __init int h1940_gpiolib_init(void)
>>> +{
>>> +       return gpiochip_add(&h1940_latch_gpiochip);
>>> +}
>>> +core_initcall(h1940_gpiolib_init);
>>> +
>>
>> arch_initcall() or init_machine() callback seems more appropriate.
>> What do you think?
>
> I did the same way as Kukjin Kim did in samsung gpio driver.

But that was almost  years ago and actually this is not a core code
but arch code. Anyway I think this shouldn't matter so I have no
strong preference.

Best regards,
Krzysztof
