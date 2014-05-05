From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 5 May 2014 15:41:43 -0700
Subject: [PATCH RESEND 1/5] ARM: BCM63XX: add basic support for the
 Broadcom BCM63138 DSL SoC
In-Reply-To: <5674507.GGRAhKo0Eq@wuerfel>
References: <1398130758-19456-1-git-send-email-f.fainelli@gmail.com>
 <7337945.Kibhmj51LR@wuerfel>
 <CAGVrzcayySWxBhXVK0Tq8-foH5tTX0_9EbFL3YtPreHeruNDmQ@mail.gmail.com>
 <5674507.GGRAhKo0Eq@wuerfel>
Message-ID: <CAGVrzcaoxiwTzduK7_uTLsM=oyzT_2FYkiSS=m0rz5AEJrJRkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-05-02 0:55 GMT-07:00 Arnd Bergmann <arnd@arndb.de>:
> On Thursday 01 May 2014 22:32:27 Florian Fainelli wrote:
>> >> +#ifndef __ARM_BCM63XX_H
>> >> +#define __ARM_BCM63XX_H
>> >> +
>> >> +#define IO_ADDRESS(x)                (((x) & 0x00ffffff) + 0xfc000000)
>> >> +
>> >> +/* AHB register space */
>> >> +#define BCM63XX_AHB_PHYS     0x80001000
>> >> +#define BCM63XX_AHB_VIRT     IO_ADDRESS(BCM63XX_AHB_PHYS)
>> >> +#define BCM63XX_AHB_SIZE     0x800000
>> >> +
>> >> +/* PERIPH (legacy) register space */
>> >> +#define BCM63XX_PERIPH_PHYS  0xfffe8000
>> >> +#define BCM63XX_PERIPH_VIRT  IO_ADDRESS(BCM63XX_PERIPH_PHYS)
>> >> +#define BCM63XX_PERIPH_SIZE  0x10000
>> >
>> > You shouldn't need these any more. If you do, just move all of this
>> > into the main file, to ensure no other file accidentally relies
>> > on hardcoded values.
>> >
>> > Note that BCM63XX_AHB_PHYS is nor aligned, so AFAICT you don't
>> > actually get a huge page entry for it, and there is no point
>> > doing this at all, as it has neither functional nor performance
>> > relevance.
>> >
>> > You may have out-of-tree drivers that you haven't cleaned up
>> > or posted yet relying on specific static mappings, but that is
>> > no reason to have these mappings in the mainline kernel.
>>
>> I tried without the iotable entries, and any register access to these
>> regions did hang the system, I will check harder what was going on
>> there.
>
> Can you clarify what you mean with 'any register access to these
> regions did hang the system'?

I would not get any console output progress around the time we
initialize the MMU (roughly), neither would I get an exception since
that is too early in the boot process.

> If you remove the call to iotable_init,
> you obviously can't access the registers through BCM63XX_{AHB,PERIPH}_VIRT
> any longer, but accesses through a pointer returned from ioremap()
> should keep working as before.
>
> The DEBUG_LL early output is a special case here, these need one
> of three options:
>
> - .map_io is NULL (preferred)
> - .map_io points to a function that calls debug_ll_io_init()
> - .map_io points to a function that calls iotable_init with
>   an equivalent or larger mapping as debug_ll_io_init() would.
>
> I suspect you were doing the third here for historic reasons.

I think you are right, I was in the 3rd case where accessing the UART
using its virtual address would make the system. Reading through
devicemaps_init(), defining a custom map_io() functions means you are
in control and you explicitely need to call debug_ll_io_init(), which
I was not doing when I removed my custom map_io() implementation.

Thanks!
-- 
Florian
