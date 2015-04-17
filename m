From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sat, 18 Apr 2015 01:12:36 +0900
Subject: [PATCH 1/4] ARM: UniPhier: add basic support for UniPhier
 architecture
In-Reply-To: <3655031.20bjeBBBYS@wuerfel>
References: <1429170038-16757-1-git-send-email-yamada.masahiro@socionext.com>
 <1429170038-16757-2-git-send-email-yamada.masahiro@socionext.com>
 <3655031.20bjeBBBYS@wuerfel>
Message-ID: <CAK7LNARZC3GFa6KpZNsFuZ+0XZ7K0dEbb++PQzwtsZ2z86n9kA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

2015-04-16 18:41 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
> On Thursday 16 April 2015 16:40:35 Masahiro Yamada wrote:
>
>>+ENTRY(uniphier_secondary_startup)
>>+       bl      v7_invalidate_l1
>>+       b       secondary_startup
>>+ENDPROC(uniphier_secondary_startup)
>
> Since this file is really trivial, I wonder if you could just use
> a 'naked' inline assembly function from C code here, to have
> the entire SMP support in one file.

I merged platsmp.c and headsmp.c into a single file in v3.
I added __naked as you suggested.



>> +
>> +#define ROM_BOOT_ROMRSV2             0x59801208
>
> Please don't hardcode any physical addresses, instead find the DT node
> or syscon device in the _boot_secondary implementation.

I implemented it as a syscon device in v3.


> Which device is this register part of?

It is just a simple register for storing destination address for the
secondary CPU.


>> +
>> +static const char * const uniphier_board_dt_compat[] __initconst = {
>> +     "socionext,ph1-sld3",
>> +     "socionext,ph1-ld4",
>> +     "socionext,ph1-pro4",
>> +     "socionext,ph1-sld8",
>> +     "socionext,ph1-pro5",
>> +     "socionext,ph1-proxstream2",
>> +     "socionext,ph1-ld6b",
>> +     NULL,
>> +};
>
> Are these chip names or board names? The list should normally have
> just the socs, which I assume you do, but it's not completely clear
> from the source.

SoC names.

Perhaps, the structure name "uniphier_board_dt_compat" might be confusing.
I renamed it into "uniphier_dt_compat" in v3.


Many thanks!



BTW, I had solved the problem "not syncing: Attempted to kill init!
exitcode=0x00000004 ?",
I posted about two weeks ago.
L2 cache had nothing to do with the issue.
With a little fix of the device tree and an initramdisk I regenerated
using Buildroot,
I succeeded in booting the kernel.



-- 
Best Regards
Masahiro Yamada
