From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Thu, 15 May 2014 23:02:42 +0200
Subject: [PATCH] FIX:cache:exynos: Execute the cache reconfiguration
 unconditionally for Exynos4
In-Reply-To: <537529CE.5030803@samsung.com>
References: <1400153646-827-1-git-send-email-l.majewski@samsung.com>
 <537529CE.5030803@samsung.com>
Message-ID: <53752B72.40308@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15.05.2014 22:55, Kukjin Kim wrote:
> On 05/15/14 20:34, Lukasz Majewski wrote:
>> The commit 2bf73dd61a84cdf27e49f48e08739af6ba70ace1 has made the cache
>> configuration depending on definition of CONFIG_S5P_SLEEP Kconfig flag.
>> It is enabled on various S5PV210 incarnations and not available at
>> Exynos4
>> family of SoCs.
>>
>> The problem emerges when one wants to disable/enable core via hotplug
>> - e.g:
>> echo 0>  /sys/devices/system/cpu/cpu1/online.
>> When CONFIG_CPU_IDLE is enabled (it is not enabled at default
>> exynos_defconfig).
>>
>> On Exynos4 based targets (Exynos4412 and Exynos4210, namely trats2 and
>> trats) board locks up and consumes considerable power.
>>
>> This patch does nothing more than restoration of the state before the
>> offending commit.
>>
>> Tested on top of next-20140514 at Trats board.
>>
>> Signed-off-by: Lukasz Majewski<l.majewski@samsung.com>
>> ---
>>   arch/arm/mach-exynos/exynos.c |    7 +++----
>>   1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/mach-exynos/exynos.c
>> b/arch/arm/mach-exynos/exynos.c
>> index 1b97b93..5c8b334 100644
>> --- a/arch/arm/mach-exynos/exynos.c
>> +++ b/arch/arm/mach-exynos/exynos.c
>> @@ -254,10 +254,9 @@ static int __init exynos4_l2x0_cache_init(void)
>>       if (ret)
>>           return ret;
>>
>> -    if (IS_ENABLED(CONFIG_S5P_SLEEP)) {
>> -        l2x0_regs_phys = virt_to_phys(&l2x0_saved_regs);
>> -        clean_dcache_area(&l2x0_regs_phys, sizeof(unsigned long));
>> -    }
> 
> Hmm...should be PM_SLEEP instead of removing check the S5P_SLEEP. This
> is missed when we stopped to use legacy Samsung PM(commit ID d710aa31)

Yes, should be. I have already discussed this with Lukasz and he was
supposed to send next version.

Best regards,
Tomasz
