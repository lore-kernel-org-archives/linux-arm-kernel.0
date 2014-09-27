From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Sat, 27 Sep 2014 10:39:14 +0200
Subject: [PATCH v5 RESEND 1/3] ARM: EXYNOS: Move code from hotplug.c to
 platsmp.c
In-Reply-To: <201409262313.26272.arnd@arndb.de>
References: <1409920495-16533-1-git-send-email-k.kozlowski@samsung.com>
 <201409262313.26272.arnd@arndb.de>
Message-ID: <542677B2.70506@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

W dniu 26.09.2014 o 23:13, Arnd Bergmann pisze:
> On Friday 05 September 2014, Krzysztof Kozlowski wrote:
>> The commit only moves code around with one additional observable change:
>> the hotplug.c was compiled with custom CFLAGS (-march=armv7-a). These
>> CFLAGS are not necessary any more.
>
> This turns out to be wrong, and your change broke 'allmodconfig' builds
> in linux-next. Please apply this patch on top.

My patch definitely needed more testing.
I posted a fix here:
https://lkml.org/lkml/2014/9/24/163
However it seems that it wasn't picked up by anyone yet.

Russell, could you pick up the patch (with acks from Nicolas and Kukjin)?

Best regards,
Krzysztof


>
> 	Arnd
>
> 8<----------
>  From 4ba6bf8806caec386e35930314dbad071284c837 Mon Sep 17 00:00:00 2001
> From: Arnd Bergmann <arnd@arndb.de>
> Date: Fri, 26 Sep 2014 23:09:38 +0200
> Subject: [PATCH] ARM: EXYNOS: fix build error in platsmp.c
>
> /tmp/ccYeWL3V.s: Assembler messages:
> /tmp/ccYeWL3V.s:659: Error: selected processor does not support ARM mode `isb '
> /tmp/ccYeWL3V.s:664: Error: selected processor does not support ARM mode `isb '
> /tmp/ccYeWL3V.s:665: Error: selected processor does not support ARM mode `dsb '
> make[3]: *** [arch/arm/mach-exynos/platsmp.o] Error 1
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 17342534e1d932 ("ARM: EXYNOS: Move code from hotplug.c to platsmp.c")
>
> diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos/Makefile
> index 4e49d4efb264..64324bf5edb4 100644
> --- a/arch/arm/mach-exynos/Makefile
> +++ b/arch/arm/mach-exynos/Makefile
> @@ -21,6 +21,7 @@ obj-$(CONFIG_PM_SLEEP)		+= suspend.o
>   obj-$(CONFIG_PM_GENERIC_DOMAINS) += pm_domains.o
>
>   obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
> +CFLAGS_platsmp.o		:= -march=armv7-a
>
>   plus_sec := $(call as-instr,.arch_extension sec,+sec)
>   AFLAGS_exynos-smc.o		:=-Wa,-march=armv7-a$(plus_sec)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
