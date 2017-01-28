From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sat, 28 Jan 2017 22:33:08 +0900
Subject: [PATCH v4] ARM: mmp: let clk_disable() return immediately if clk
 is NULL
In-Reply-To: <CAK7LNASn+-HrzwSnrrR3nuGzvmhLzQRTXduSmF1N51uwyzaYTg@mail.gmail.com>
References: <1474221526-21195-1-git-send-email-yamada.masahiro@socionext.com>
 <CAK7LNASn+-HrzwSnrrR3nuGzvmhLzQRTXduSmF1N51uwyzaYTg@mail.gmail.com>
Message-ID: <CAK7LNARSu0mZ2RPzDDtD6yqFHeo6cLza7EVT8O_L+vPL3uUc1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric Miao, Haojian Zhuang,

Ping again.

Please apply this patch!


2016-11-06 0:42 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> Hi Eric Miao, Haojian Zhuang,
>
> Could you pick up this patch, please?
>
>
> 2016-09-19 2:58 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
>> In many of clk_disable() implementations, it is a no-op for a NULL
>> pointer input, but this is one of the exceptions.
>>
>> Making it treewide consistent will allow clock consumers to call
>> clk_disable() without NULL pointer check.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> ---
>>
>> Changes in v4:
>>   - Split into per-arch patches
>>
>> Changes in v3:
>>   - Return only when clk is NULL.  Do not take care of error pointer.
>>
>> Changes in v2:
>>   - Rebase on Linux 4.6-rc1
>>
>>  arch/arm/mach-mmp/clock.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/arm/mach-mmp/clock.c b/arch/arm/mach-mmp/clock.c
>> index ac6633d..28fe64c 100644
>> --- a/arch/arm/mach-mmp/clock.c
>> +++ b/arch/arm/mach-mmp/clock.c
>> @@ -67,6 +67,9 @@ void clk_disable(struct clk *clk)
>>  {
>>         unsigned long flags;
>>
>> +       if (!clk)
>> +               return;
>> +
>>         WARN_ON(clk->enabled == 0);
>>
>>         spin_lock_irqsave(&clocks_lock, flags);
>> --
>> 1.9.1
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
>
>
> --
> Best Regards
> Masahiro Yamada



-- 
Best Regards
Masahiro Yamada
