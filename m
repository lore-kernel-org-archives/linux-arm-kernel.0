From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Thu, 6 Jul 2017 19:17:28 +0200
Subject: [PATCH] ARM: owl: smp: Drop owl_secondary_boot()
In-Reply-To: <3F3740FC-3873-4C01-A625-C8DC7F50A018@gmail.com>
References: <DC4E6E803E914F4B8AFE57F1456019F10364478E@srv-mail-02.actions.com.cn>
 <20170704233219.18790-1-afaerber@suse.de>
 <3F3740FC-3873-4C01-A625-C8DC7F50A018@gmail.com>
Message-ID: <c037a437-0e9e-e451-d3a6-3a866db8bb16@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 05.07.2017 um 04:36 schrieb Florian Fainelli:
> On July 4, 2017 4:32:18 PM PDT, "Andreas F?rber" <afaerber@suse.de> wrote:
>> Commit 18cfd9429d8a82c49add8f3ca9d366599bfcac45 ("ARM: owl: smp: Drop
>> bogus holding pen") simplified the S500 SMP code by removing a loop for
>> pen_release in owl_secondary_boot(). Since then it is only calling
>> owl_v7_invalidate_l1() before branching to secondary_startup().
>>
>> The owl_v7_invalidate_l1() assembler function is superfluous, too.
>> Therefore drop owl_secondary_boot() and use secondary_boot() directly.
>>
>> Cc: David Liu <liuwei@actions-semi.com>
>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
>> ---
> 
>> -	writel(virt_to_phys(owl_secondary_startup),
>> +	writel(virt_to_phys(secondary_startup),
>> 	       timer_base_addr + OWL_CPU1_ADDR + (cpu - 1) * 4);
> 
> This is a kernel symbol so please use __pa_symbol() here, also you might want to build with CONFIG_DEBUG_VIRTUAL and see if you get other warnings about using virt_to_phys() in the owl platform code (I did not check if there are other uses)

Thanks for the report. There are no other such uses in mach-actions, but
git-grep'ing for virt_to_phys in arch/arm/mach-* I spot at least one
other such usage in mach-oxnas:

arch/arm/mach-oxnas/platsmp.c:
writel(virt_to_phys(ox820_secondary_startup),

as well as this in mach-mvebu:

arch/arm/mach-mvebu/platsmp.c:  writel(virt_to_phys(boot_addr), base +
MV98DX3236_CPU_RESUME_ADDR_REG);

and these in mach-at91:

arch/arm/mach-at91/pm.c:        pm_bu->canary = virt_to_phys(&canary);
arch/arm/mach-at91/pm.c:        pm_bu->resume = virt_to_phys(cpu_resume);

What exactly is the difference between the two macros that makes it
wrong despite apparently working? In particular I am wondering whether
the SoC/board vendors in CC need to fix it in their 3.10 trees, too.

In any case if this is a bug, I would rather fix it in a separate patch
for 4.13 and leave the name swap (this patch) for 4.14.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
