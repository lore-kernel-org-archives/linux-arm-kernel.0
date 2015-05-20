From: fainelli@broadcom.com (Florian Fainelli)
Date: Wed, 20 May 2015 14:05:35 -0700
Subject: [GIT PULL] Broadcom SoC changes for 4.2
In-Reply-To: <3339528.zIO9EH4AJz@wuerfel>
References: <1431556453-11633-1-git-send-email-f.fainelli@gmail.com>
 <1431556453-11633-3-git-send-email-f.fainelli@gmail.com>
 <3339528.zIO9EH4AJz@wuerfel>
Message-ID: <555CF71F.7000409@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/05/15 13:59, Arnd Bergmann wrote:
> On Wednesday 13 May 2015 15:34:13 Florian Fainelli wrote:
>>  arch/arm/include/asm/vfp.h          |   9 ++
>>  arch/arm/mach-bcm/Makefile          |   7 +-
>>  arch/arm/mach-bcm/bcm63xx_headsmp.S |  23 ++++
>>  arch/arm/mach-bcm/bcm63xx_pmb.c     | 221 ++++++++++++++++++++++++++++++++++++
>>  arch/arm/mach-bcm/bcm63xx_smp.c     | 170 +++++++++++++++++++++++++++
>>  arch/arm/mach-bcm/bcm63xx_smp.h     |   9 ++
>>  arch/arm/vfp/vfpmodule.c            |  13 +++
>>  include/linux/bcm63xx_pmb.h         |  76 +++++++++++++
>>
> 
> And taken out again, sorry.

No problem, Rafal reminded me of a patch I forgot to submit earlier, so
I will take that as an opportunity to re-do this pull request.

> 
> I got a build error in include/linux/bcm63xx_pmb.h and that triggered me to take
> a closer look. I tried to fix up the trivial error first, but then noticed
> several other things wrong with bcm63xx_pmb.h:

What kind of build error? Do you have it handy?

> 
> - it is in include/linux/ where it clearly does not belong, as no other component
>   should be including it. Even the function documentation in there mentions that
>   one must hold the pmb_lock before calling it, and that is defined statically
>   arch/arm/mach-bcm/bcm63xx_pmb.c, so it's impossible for other code to use.
>   Just move it all into bcm63xx_pmb.c.

This header will later be used by the bcm63138 reset controller, and I
thought I had explained the reasoning behind that in either the commit
message or cover letter, I will make sure the commit message explains it.

The lock issue is not much of a problem since we do not support CPU
hotplug and the reset controller subsystem is initialized later so there
is no possibility for these two pieces of code to conflict.

> 
> - the code uses __raw_readl/__raw_writel for MMIO register access, which is
>   broken on big-endian machines. You need to use readl_relaxed()/write_relaxed()
>   or readl()/writel() instead. If you use the latter, you can also avoid
>   introducing extra barriers.

Fair point, will fix that.

> 
> - finally, a heads-up for the "[PATCH] ARM: v7 setup function should invalidate
>   L1 cache" patch that Russell submitted. I think your bcm63xx_headsmp.S
>   function is completely fine for now, but with his patch applied, it will
>   no longer be needed and you should follow up with a patch to replace it
>   with a direct branch to secondary_startup.

Thanks, I will keep that in mind.
-- 
Florian
