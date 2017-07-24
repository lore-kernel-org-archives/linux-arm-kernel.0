From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Mon, 24 Jul 2017 14:14:48 +0300
Subject: [PATCH] spi: pxa2xx: Only claim CS GPIOs when the slave device is
 created
In-Reply-To: <db94e41e-5772-ec74-8587-3192dc866040@web.de>
References: <90b3e14d-0077-9a25-9d90-ab340577af57@web.de>
 <CAHp75VfpJzOdhMyZoMGnC4CQc5kGxq1k-__dpmVAOaxaD04w6Q@mail.gmail.com>
 <59066818-a284-4da0-d05f-d2503aeee44b@web.de>
 <CAHp75Vf0NuOAvsJDxeB=5uqhMFpQ54vZzegJe=EYZDd3Bd6erw@mail.gmail.com>
 <db94e41e-5772-ec74-8587-3192dc866040@web.de>
Message-ID: <CAHp75Vc9hVRCEgmjMNO0wDRzMB7SvyJAzr3BPQr5L909xzn5Ow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 24, 2017 at 2:06 PM, Jan Kiszka <jan.kiszka@web.de> wrote:
> On 2017-07-24 13:02, Andy Shevchenko wrote:
>> On Mon, Jul 24, 2017 at 1:53 PM, Jan Kiszka <jan.kiszka@web.de> wrote:
>>> On 2017-07-24 12:44, Andy Shevchenko wrote:
>>>> +Cc: Mika
>>>>
>>>> On Sat, Jul 8, 2017 at 11:41 AM, Jan Kiszka <jan.kiszka@web.de> wrote:
>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>
>>>>> Avoid hogging chip select GPIOs just because they are listed for the
>>>>> master. They might be mulitplexed and, if no slave device is attached,
>>>>> used for different purposes. Moreover, this strategy avoids having to
>>>>> allocate a cs_gpiods structure.
>>>>>
>>>>> Tested on the IOT2000 where the second SPI bus is connected to an
>>>>> Arduino-compatible connector and multiplexed between SPI, GPIO and PWM
>>>>> usage.
>>
>>>> This breaks all systems which are using _DSD.
>>>
>>> Err, can you elaborate? Worked fine here with _DSD on the IOT2000.
>>
>> Sure, the setup() function can be called several times for the same
>> chip (as written in the comment inside the function).
>> Definitely your code doesn't follow this, since gpiod_get_index() is
>> returning -EBUSY when called 2+ time, that's what I got on all my
>> tests.
>
> Ah, multiple devices on the same controller - I only had one.

Nope, one. Since we are talking about recurrent call to
gpiod_get_index() with the same index.

-- 
With Best Regards,
Andy Shevchenko
