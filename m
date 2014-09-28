From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sun, 28 Sep 2014 13:42:21 +0900
Subject: [PATCH v5 RESEND 1/3] ARM: EXYNOS: Move code from hotplug.c to
 platsmp.c
In-Reply-To: <542677B2.70506@samsung.com>
References: <1409920495-16533-1-git-send-email-k.kozlowski@samsung.com>
 <201409262313.26272.arnd@arndb.de> <542677B2.70506@samsung.com>
Message-ID: <542791AD.5080105@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/27/14 17:39, Krzysztof Kozlowski wrote:
> W dniu 26.09.2014 o 23:13, Arnd Bergmann pisze:
>> On Friday 05 September 2014, Krzysztof Kozlowski wrote:
>>> The commit only moves code around with one additional observable change:
>>> the hotplug.c was compiled with custom CFLAGS (-march=armv7-a). These
>>> CFLAGS are not necessary any more.
>>
>> This turns out to be wrong, and your change broke 'allmodconfig' builds
>> in linux-next. Please apply this patch on top.
>
Arnd, Krzysztof commented its fix has been submitted and landed in my 
-test tree not -next because it should be handled in rmk's tree I think.

I sent the patch to RMK patch tracking system just now and it should be 
fine in there.

BTW, I just applied the fix in my -next until its ladning in RMK tree 
but as you know it will be not be sent to arm-soc via samsung tree...

One more, Arnd please pull my pull-request 2nd round and 3rd round for 
samsung stuff for 3.18.

> My patch definitely needed more testing.
> I posted a fix here:
> https://lkml.org/lkml/2014/9/24/163
> However it seems that it wasn't picked up by anyone yet.
>
> Russell, could you pick up the patch (with acks from Nicolas and Kukjin)?
>
I believe Russell will take the patch in his tree.

Thanks,
Kukjin

>> 8<----------
>> From 4ba6bf8806caec386e35930314dbad071284c837 Mon Sep 17 00:00:00 2001
>> From: Arnd Bergmann <arnd@arndb.de>
>> Date: Fri, 26 Sep 2014 23:09:38 +0200
>> Subject: [PATCH] ARM: EXYNOS: fix build error in platsmp.c
>>
>> /tmp/ccYeWL3V.s: Assembler messages:
>> /tmp/ccYeWL3V.s:659: Error: selected processor does not support ARM
>> mode `isb '
>> /tmp/ccYeWL3V.s:664: Error: selected processor does not support ARM
>> mode `isb '
>> /tmp/ccYeWL3V.s:665: Error: selected processor does not support ARM
>> mode `dsb '
>> make[3]: *** [arch/arm/mach-exynos/platsmp.o] Error 1
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> Fixes: 17342534e1d932 ("ARM: EXYNOS: Move code from hotplug.c to
>> platsmp.c")
>>
>> diff --git a/arch/arm/mach-exynos/Makefile
>> b/arch/arm/mach-exynos/Makefile
>> index 4e49d4efb264..64324bf5edb4 100644
>> --- a/arch/arm/mach-exynos/Makefile
>> +++ b/arch/arm/mach-exynos/Makefile
>> @@ -21,6 +21,7 @@ obj-$(CONFIG_PM_SLEEP) += suspend.o
>> obj-$(CONFIG_PM_GENERIC_DOMAINS) += pm_domains.o
>>
>> obj-$(CONFIG_SMP) += platsmp.o headsmp.o
>> +CFLAGS_platsmp.o := -march=armv7-a
>>
>> plus_sec := $(call as-instr,.arch_extension sec,+sec)
>> AFLAGS_exynos-smc.o :=-Wa,-march=armv7-a$(plus_sec)
