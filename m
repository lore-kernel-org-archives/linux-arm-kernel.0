From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 7 Jul 2017 10:32:58 -0700
Subject: [PATCH] ARM: owl: smp: Drop owl_secondary_boot()
In-Reply-To: <87h8yod7k5.fsf@free-electrons.com>
References: <DC4E6E803E914F4B8AFE57F1456019F10364478E@srv-mail-02.actions.com.cn>
 <20170704233219.18790-1-afaerber@suse.de>
 <3F3740FC-3873-4C01-A625-C8DC7F50A018@gmail.com>
 <c037a437-0e9e-e451-d3a6-3a866db8bb16@suse.de>
 <20170706173841.jwaskrrkooget6nk@piout.net>
 <c6336df9-4f38-e636-383a-d0ad31658c65@gmail.com>
 <87h8yod7k5.fsf@free-electrons.com>
Message-ID: <b79e30da-66af-b059-4526-bd7c88d882b4@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/07/2017 12:34 AM, Gregory CLEMENT wrote:
> Hi Florian,
>  
>  On jeu., juil. 06 2017, Florian Fainelli <f.fainelli@gmail.com> wrote:
> 
>> On 07/06/2017 10:38 AM, Alexandre Belloni wrote:
>>> On 06/07/2017 at 19:17:28 +0200, Andreas F?rber wrote:
>>>> Am 05.07.2017 um 04:36 schrieb Florian Fainelli:
>>>>> On July 4, 2017 4:32:18 PM PDT, "Andreas F?rber" <afaerber@suse.de> wrote:
>>>>>> Commit 18cfd9429d8a82c49add8f3ca9d366599bfcac45 ("ARM: owl: smp: Drop
>>>>>> bogus holding pen") simplified the S500 SMP code by removing a loop for
>>>>>> pen_release in owl_secondary_boot(). Since then it is only calling
>>>>>> owl_v7_invalidate_l1() before branching to secondary_startup().
>>>>>>
>>>>>> The owl_v7_invalidate_l1() assembler function is superfluous, too.
>>>>>> Therefore drop owl_secondary_boot() and use secondary_boot() directly.
>>>>>>
>>>>>> Cc: David Liu <liuwei@actions-semi.com>
>>>>>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
>>>>>> ---
>>>>>
>>>>>> -	writel(virt_to_phys(owl_secondary_startup),
>>>>>> +	writel(virt_to_phys(secondary_startup),
>>>>>> 	       timer_base_addr + OWL_CPU1_ADDR + (cpu - 1) * 4);
>>>>>
>>>>> This is a kernel symbol so please use __pa_symbol() here, also you
>>>>> might want to build with CONFIG_DEBUG_VIRTUAL and see if you get
>>>>> other warnings about using virt_to_phys() in the owl platform code
>>>>> (I did not check if there are other uses)
>>>>
>>>> Thanks for the report. There are no other such uses in mach-actions, but
>>>> git-grep'ing for virt_to_phys in arch/arm/mach-* I spot at least one
>>>> other such usage in mach-oxnas:
>>>>
>>>> arch/arm/mach-oxnas/platsmp.c:
>>>> writel(virt_to_phys(ox820_secondary_startup),
>>>>
>>>> as well as this in mach-mvebu:
>>>>
>>>> arch/arm/mach-mvebu/platsmp.c:  writel(virt_to_phys(boot_addr), base +
>>>> MV98DX3236_CPU_RESUME_ADDR_REG);
>>>>
>>>> and these in mach-at91:
>>>>
>>>> arch/arm/mach-at91/pm.c:        pm_bu->canary = virt_to_phys(&canary);
>>>> arch/arm/mach-at91/pm.c:        pm_bu->resume = virt_to_phys(cpu_resume);
>>>>
>>>
>>> They can probably use __pa_symbol() (I must admit I didn't know about
>>> it before this email)
>>
>> This is fine, do you mind sending fixes for the at91 parts? Gregory, can
>> you also fix the mv98dx3236 platform SMP code?
> 
> Yes sure, actually, for Armada XP we already use  __pa_symbol() but from
> an other file that why I didn't pay attention on it.

No worries, the conversion sort of happened in one go, so it's always a
game of catching up patches merged after that one went in.
-- 
Florian
