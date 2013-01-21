From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 21 Jan 2013 23:37:22 +0100
Subject: [PATCH 3/6] arm: kconfig: don't select TWD with local timer for
 Armada 370/XP
In-Reply-To: <201301211831.45947.arnd@arndb.de>
References: <1358790842-2986-1-git-send-email-gregory.clement@free-electrons.com>
 <1358790842-2986-4-git-send-email-gregory.clement@free-electrons.com>
 <201301211831.45947.arnd@arndb.de>
Message-ID: <50FDC322.2040107@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/21/2013 07:31 PM, Arnd Bergmann wrote:
> On Monday 21 January 2013, Gregory CLEMENT wrote:
>> @@ -1624,7 +1624,7 @@ config LOCAL_TIMERS
>>         bool "Use local timer interrupts"
>>         depends on SMP
>>         default y
>> -       select HAVE_ARM_TWD if (!ARCH_MSM_SCORPIONMP && !EXYNOS4_MCT)
>> +       select HAVE_ARM_TWD if (!ARCH_MSM_SCORPIONMP && !EXYNOS4_MCT && !ARMADA_370_XP_TIMER)
>>         
> 
> Your change is fine, but I just noticed that this line is asking for trouble
> when we enable multipleform support for MSM and/or EXYNOS.
> 
> Also, I wonder if we should change this somehow in 3.8, because it seems
> that for a multiplatform kernel including armadaxp and e.g. versatile express,
> you have no ARM_TWD support in the kernel, which seems wrong. Is there any
> reason we can't enable the ARM_TWD code to be built-in on platforms that
> don't use it?

I don't see a strong reason to not enable it if we don't use it. My concern
was that I don't need it so I didn't want to include it and generating extra
code for nothing. Then just after having sent this patch set, I received your
patch set about build regression in 3.8 and especially the part about
CONFIG_MULTIPLATFORM made me realized that it could be a problem.

> 
> Maybe it can be written as
> 
> config LOCAL_TIMERS
> 	bool "Use local timer interrupts"
> 	depends on SMP
> 	default y
> 
> config HAVE_ARM_TWD
> 	depends on LOCAL_TIMERS
> 	default ARCH_MULTIPLATFORM || (!ARCH_MSM_SCORPIONMP && !EXYNOS4_MCT)

So in this case why not written something like this:
 	default ARCH_MULTIPLATFORM || (!ARCH_MSM_SCORPIONMP && !EXYNOS4_MCT && !ARMADA_370_XP_TIMER)

> 	default y
I am not a kconfig expert, but won't this line set HAVE_ARM_TWD to 'y' whatever
the result of the previous line?

> 
> This will still be slightly wrong (generating extra code) on a multiplatform
> kernel that has no platform other than MSM or EXYNOS, but the other alternative
> would be that each platform with TWD support has to select HAVE_ARM_TWD itself.

Gregory
