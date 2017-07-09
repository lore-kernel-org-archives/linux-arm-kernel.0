From: jan.kiszka@web.de (Jan Kiszka)
Date: Sun, 9 Jul 2017 12:30:40 +0200
Subject: [PATCH] spi: pxa2xx: Only claim CS GPIOs when the slave device is
 created
In-Reply-To: <CAHp75VeSeHuXGmQeGr2Kq3+TOD8uHoKjd0EYLRkJVogOxcLJ2A@mail.gmail.com>
References: <90b3e14d-0077-9a25-9d90-ab340577af57@web.de>
 <CAHp75Vd8GRCwGp8eDFOL=dsgxCR+VqqUy+O50PEW=p99a8xAwQ@mail.gmail.com>
 <1677d448-4cdd-363f-34a6-152c61a06c0e@web.de>
 <CAHp75VeSeHuXGmQeGr2Kq3+TOD8uHoKjd0EYLRkJVogOxcLJ2A@mail.gmail.com>
Message-ID: <70d88e65-5dd1-f218-dc39-e553a1b6acb5@web.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017-07-09 11:55, Andy Shevchenko wrote:
> On Sun, Jul 9, 2017 at 12:30 PM, Jan Kiszka <jan.kiszka@web.de> wrote:
>> On 2017-07-08 23:48, Andy Shevchenko wrote:
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
>>>
>>> Can we first switch the driver to use GPIO descriptors instead of
>>> plain integers?
>>
>> -ENOPARSE
> 
> In code you are trying to modify there is a mix of plain integers and
> GPIO descriptors (and two APIs).
> Can we just convert it to use GPIO descriptors API?

That wasn't helpful either for someone not doing gpio development the
whole day. I suppose you wanted to suggest the conversion of
chip_data::chip_cs to struct gpio_desc * and the consistent usage of
gpiod_*, instead of gpio_*. That's not necessarily a precondition, but
it's a reasonable cleanup.

Jan

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170709/560cf7ff/attachment.sig>
