From: jan.kiszka@web.de (Jan Kiszka)
Date: Mon, 24 Jul 2017 13:06:43 +0200
Subject: [PATCH] spi: pxa2xx: Only claim CS GPIOs when the slave device is
 created
In-Reply-To: <CAHp75Vf0NuOAvsJDxeB=5uqhMFpQ54vZzegJe=EYZDd3Bd6erw@mail.gmail.com>
References: <90b3e14d-0077-9a25-9d90-ab340577af57@web.de>
 <CAHp75VfpJzOdhMyZoMGnC4CQc5kGxq1k-__dpmVAOaxaD04w6Q@mail.gmail.com>
 <59066818-a284-4da0-d05f-d2503aeee44b@web.de>
 <CAHp75Vf0NuOAvsJDxeB=5uqhMFpQ54vZzegJe=EYZDd3Bd6erw@mail.gmail.com>
Message-ID: <db94e41e-5772-ec74-8587-3192dc866040@web.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017-07-24 13:02, Andy Shevchenko wrote:
> On Mon, Jul 24, 2017 at 1:53 PM, Jan Kiszka <jan.kiszka@web.de> wrote:
>> On 2017-07-24 12:44, Andy Shevchenko wrote:
>>> +Cc: Mika
>>>
>>> On Sat, Jul 8, 2017 at 11:41 AM, Jan Kiszka <jan.kiszka@web.de> wrote:
>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>
>>>> Avoid hogging chip select GPIOs just because they are listed for the
>>>> master. They might be mulitplexed and, if no slave device is attached,
>>>> used for different purposes. Moreover, this strategy avoids having to
>>>> allocate a cs_gpiods structure.
>>>>
>>>> Tested on the IOT2000 where the second SPI bus is connected to an
>>>> Arduino-compatible connector and multiplexed between SPI, GPIO and PWM
>>>> usage.
> 
>>> This breaks all systems which are using _DSD.
>>
>> Err, can you elaborate? Worked fine here with _DSD on the IOT2000.
> 
> Sure, the setup() function can be called several times for the same
> chip (as written in the comment inside the function).
> Definitely your code doesn't follow this, since gpiod_get_index() is
> returning -EBUSY when called 2+ time, that's what I got on all my
> tests.

Ah, multiple devices on the same controller - I only had one.

> 
>>> While I'm looking for fix, I get feeling that the approach itself is not right,
>>>
>>> So, for now I would vote for immediate revert and then rethink what we
>>> can do here.
>>
>> I'm fine with reverting because the patch wasn't clean anyway (mixed old
>> and new GPIO API) - aside from whatever you found in addition.
> 
>> I had an
>> update pending but, as you are looking into this anyway, I'm sure your
>> patches will be more holistic.
> 
> Please, send it as RFC, because it might have something we can use/re-use.
> 

OK, will dig them out later.

Jan

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170724/a9e44a16/attachment.sig>
