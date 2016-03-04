From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 4 Mar 2016 14:33:32 +0100
Subject: DWord alignment on ARMv7
In-Reply-To: <72900410.JPa1IHPXo5@wuerfel>
References: <56D8BA3F.7050508@pengutronix.de> <3093807.B56fh7Radq@wuerfel>
 <CAKv+Gu_HttHOutHAw-k_uwmTUGjUsTWCotVHroqRK0NQDOGkNg@mail.gmail.com>
 <72900410.JPa1IHPXo5@wuerfel>
Message-ID: <CAKv+Gu8_H-akYc3HF8O23mHhhHMKD86DNwUs9k1Fn1ZAykGpRA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 March 2016 at 14:30, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 04 March 2016 12:44:23 Ard Biesheuvel wrote:
>> On 4 March 2016 at 12:38, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Friday 04 March 2016 12:14:24 Ard Biesheuvel wrote:
>> >> On 4 March 2016 at 12:02, Russell King - ARM Linux
>> > Here is a patch I've come up with independently. I have verified
>> > that it removes all ldrd/strd from the btrfs unaligned data
>> > handling.
>> >
>> > The open question about it is whether we'd rather play safe and
>> > let the compiler handle unaligned accesses itself, removing the
>> > theoretical risk of the compiler optimizing
>> >
>> >         void *p;
>> >         u64 v = get_unaligned((u32)p) + (get_unaligned((u32)(p + 4)) << 32);
>> >
>> > into an ldrd. I think the linux/unaligned/access_ok.h implementation
>> > would allow that.
>> >
>>
>> I would assume that the compiler engineers are aware of the alignment
>> requirement of ldrd/strd, and don't promote adjacent accesses like
>> that if the pointer may not be 64-bit aligned.
>
> Ah, I thought it only required 32-bit alignment like ldm/stm, but it
> seems that it won't do that. However, an implementation like
>

It does only require 32-bit alignment, I was just confused.

> unsigned long long get_unaligned_u64(void *p)
> {
>         unsigned long long upper, lower;
>         lower = *(unsigned long*)p;
>         upper = *(unsigned long*)(p+4);
>
>         return lower | (upper << 32);
> }
>
> does get compiled into
>
> 00000000 <f>:
>    0:   e8900003        ldm     r0, {r0, r1}
>    4:   e12fff1e        bx      lr
>
> which is still wrong, so I assume there is some danger of that remaining
> with both of our patches, as the compiler might  decide to merge
> a series of unaligned 32-bit loads into an ldm, as long as our implementation
> incorrectly tells the compiler that the data is 32-bit aligned.
>
>> > + * This is the most generic implementation of unaligned accesses
>> > + * and should work almost anywhere.
>> > + */
>> > +#include <asm/byteorder.h>
>> > +#include <linux/kernel.h>
>> > +#include <asm/byteorder.h>
>>
>> Any particular reason to include this twice?
>
> No, just a mistake when merging the access_ok.h into this file.
>
>         Arnd
