From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 20 Aug 2014 17:08:25 +0200
Subject: [PATCH] ARM: mm: fix size rounding-down of arm_add_memory()
In-Reply-To: <20140801213719.D537.AA925319@jp.panasonic.com>
References: <1402025567-18021-1-git-send-email-yamada.m@jp.panasonic.com>
 <20140801213719.D537.AA925319@jp.panasonic.com>
Message-ID: <CAMuHMdXjX5AJT9fVja+GCTV4Zxp==xTe8ZFT8_uf=aFDYZ9+Jw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yamada-san,

On Fri, Aug 1, 2014 at 2:37 PM, Masahiro Yamada
<yamada.m@jp.panasonic.com> wrote:
> Any comments for this patch?

Thanks for your patch!

I had a slightly different fix for the same issue, but apparently it got stuck
on the freshly installed machine that didn't have email set up yet ;-(

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

early_init_dt_add_memory_arch() has the same bug, I'll resend my (also stuck)
fix for that.

> Thanks
>
> Best Regards
> Masahiro Yamada
>
>
>
> On Fri,  6 Jun 2014 12:32:47 +0900
> Masahiro Yamada <yamada.m@jp.panasonic.com> wrote:
>
>> The current rounding of "size" is wrong.
>>
>>     size -= start & ~PAGE_MASK;
>>
>> should be
>>
>>     size -= PAGE_SIZE - (start & ~PAGE_MASK);
>>
>> Or more simply
>>
>>     size -= aligned_start - start;
>>
>> Signed-off-by: Masahiro Yamada <yamada.m@jp.panasonic.com>
>> ---
>>  arch/arm/kernel/setup.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
>> index 50e198c..84508c0 100644
>> --- a/arch/arm/kernel/setup.c
>> +++ b/arch/arm/kernel/setup.c
>> @@ -641,8 +641,8 @@ int __init arm_add_memory(u64 start, u64 size)
>>        * Ensure that start/size are aligned to a page boundary.
>>        * Size is appropriately rounded down, start is rounded up.
>>        */
>> -     size -= start & ~PAGE_MASK;
>>       aligned_start = PAGE_ALIGN(start);
>> +     size -= aligned_start - start;
>>
>>  #ifndef CONFIG_ARCH_PHYS_ADDR_T_64BIT
>>       if (aligned_start > ULONG_MAX) {
>> --
>> 1.9.1

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
