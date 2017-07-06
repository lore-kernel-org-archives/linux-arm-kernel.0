From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 6 Jul 2017 14:16:44 -0700
Subject: [PATCH] ARM: owl: smp: Drop owl_secondary_boot()
In-Reply-To: <20170706173949.GC2068@leverpostej>
References: <DC4E6E803E914F4B8AFE57F1456019F10364478E@srv-mail-02.actions.com.cn>
 <20170704233219.18790-1-afaerber@suse.de>
 <3F3740FC-3873-4C01-A625-C8DC7F50A018@gmail.com>
 <c037a437-0e9e-e451-d3a6-3a866db8bb16@suse.de>
 <20170706173949.GC2068@leverpostej>
Message-ID: <663f99ab-85bf-4a8e-67a1-e84f59e7bdcc@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/06/2017 10:39 AM, Mark Rutland wrote:
> On Thu, Jul 06, 2017 at 07:17:28PM +0200, Andreas F?rber wrote:
>> Am 05.07.2017 um 04:36 schrieb Florian Fainelli:
>>> On July 4, 2017 4:32:18 PM PDT, "Andreas F?rber" <afaerber@suse.de> wrote:
>>>> Commit 18cfd9429d8a82c49add8f3ca9d366599bfcac45 ("ARM: owl: smp: Drop
>>>> bogus holding pen") simplified the S500 SMP code by removing a loop for
>>>> pen_release in owl_secondary_boot(). Since then it is only calling
>>>> owl_v7_invalidate_l1() before branching to secondary_startup().
>>>>
>>>> The owl_v7_invalidate_l1() assembler function is superfluous, too.
>>>> Therefore drop owl_secondary_boot() and use secondary_boot() directly.
>>>>
>>>> Cc: David Liu <liuwei@actions-semi.com>
>>>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
>>>> ---
>>>
>>>> -	writel(virt_to_phys(owl_secondary_startup),
>>>> +	writel(virt_to_phys(secondary_startup),
>>>> 	       timer_base_addr + OWL_CPU1_ADDR + (cpu - 1) * 4);
>>>
>>> This is a kernel symbol so please use __pa_symbol() here, also you might want to build with CONFIG_DEBUG_VIRTUAL and see if you get other warnings about using virt_to_phys() in the owl platform code (I did not check if there are other uses)
>>
>> Thanks for the report. There are no other such uses in mach-actions, but
>> git-grep'ing for virt_to_phys in arch/arm/mach-* I spot at least one
>> other such usage in mach-oxnas:
>>
>> arch/arm/mach-oxnas/platsmp.c:
>> writel(virt_to_phys(ox820_secondary_startup),
>>
>> as well as this in mach-mvebu:
>>
>> arch/arm/mach-mvebu/platsmp.c:  writel(virt_to_phys(boot_addr), base +
>> MV98DX3236_CPU_RESUME_ADDR_REG);
>>
>> and these in mach-at91:
>>
>> arch/arm/mach-at91/pm.c:        pm_bu->canary = virt_to_phys(&canary);
>> arch/arm/mach-at91/pm.c:        pm_bu->resume = virt_to_phys(cpu_resume);
>>
>> What exactly is the difference between the two macros that makes it
>> wrong despite apparently working? 
> 
> virt_to_phys() is intended to operate on the linear/direct mapping of
> RAM.
> 
> __pa_symbol() is intended to operate on the kernel mapping, which may
> not be in the linear/direct mapping on all architectures. e.g. arm64 and
> x86_64 map the kernel image and RAM separately.
> 
> On 32-bit ARM the kernel image mapping is tied to the linear/direct
> mapping, so that works, but as it's semantically wrong (and broken for
> generic code), the DEBUG_VIRTUAL checks complain.
> 
>> In particular I am wondering whether
>> the SoC/board vendors in CC need to fix it in their 3.10 trees, too.
>>
>> In any case if this is a bug, I would rather fix it in a separate patch
>> for 4.13 and leave the name swap (this patch) for 4.14.
> 
> To the best of my knowledge there's no functional problem in this
> particular case, though it should be cleaned up so as to keep
> DEBUG_VRITUAL useful.

Exactly, it just happened to catch my eye while looking at this patch
series. I am wondering if there is a way we could check whether it makes
sense to use virt_to_phys() vs. __pa_symbol() at compile time and
produce an appropriate warning would that be the case. checkpatch.pl
would not be able to do this unless there is a prior build of the kernel
image, and a GCC plugin would not necessarily have global visibility
about other translation units either... hmmm.
-- 
Florian
