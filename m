From: fainelli@broadcom.com (Florian Fainelli)
Date: Wed, 20 May 2015 14:50:37 -0700
Subject: [GIT PULL] Broadcom SoC changes for 4.2
In-Reply-To: <26666329.i6kznPGNxa@wuerfel>
References: <1431556453-11633-1-git-send-email-f.fainelli@gmail.com>
 <3339528.zIO9EH4AJz@wuerfel> <555CF71F.7000409@broadcom.com>
 <26666329.i6kznPGNxa@wuerfel>
Message-ID: <555D01AD.2040705@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/05/15 14:22, Arnd Bergmann wrote:
> On Wednesday 20 May 2015 14:05:35 Florian Fainelli wrote:
>> On 20/05/15 13:59, Arnd Bergmann wrote:
>>> On Wednesday 13 May 2015 15:34:13 Florian Fainelli wrote:
>>>>  arch/arm/include/asm/vfp.h          |   9 ++
>>>>  arch/arm/mach-bcm/Makefile          |   7 +-
>>>>  arch/arm/mach-bcm/bcm63xx_headsmp.S |  23 ++++
>>>>  arch/arm/mach-bcm/bcm63xx_pmb.c     | 221 ++++++++++++++++++++++++++++++++++++
>>>>  arch/arm/mach-bcm/bcm63xx_smp.c     | 170 +++++++++++++++++++++++++++
>>>>  arch/arm/mach-bcm/bcm63xx_smp.h     |   9 ++
>>>>  arch/arm/vfp/vfpmodule.c            |  13 +++
>>>>  include/linux/bcm63xx_pmb.h         |  76 +++++++++++++
>>>>
>>>
>>> And taken out again, sorry.
>>
>> No problem, Rafal reminded me of a patch I forgot to submit earlier, so
>> I will take that as an opportunity to re-do this pull request.
>>
>>>
>>> I got a build error in include/linux/bcm63xx_pmb.h and that triggered me to take
>>> a closer look. I tried to fix up the trivial error first, but then noticed
>>> several other things wrong with bcm63xx_pmb.h:
>>
>> What kind of build error? Do you have it handy?
> 
> I sent it to you on IRC earlier, here is the full error log:
> 
> /git/arm-soc/include/linux/bcm63xx_pmb.h: In function '__bpcm_do_op':
> /git/arm-soc/include/linux/bcm63xx_pmb.h:39:12: error: 'EIO' undeclared (first use in this function)
>     return -EIO;
>             ^
> /git/arm-soc/include/linux/bcm63xx_pmb.h:39:12: note: each undeclared identifier is reported only once for each function it appears in
> /git/arm-soc/include/linux/bcm63xx_pmb.h:42:12: error: 'ETIMEDOUT' undeclared (first use in this function)
>     return -ETIMEDOUT;
>             ^
> In file included from /git/arm-soc/arch/arm/mach-bcm/bcm63xx_pmb.c:15:0:
> /git/arm-soc/include/linux/bcm63xx_pmb.h:48:1: warning: control reaches end of non-void function [-Wreturn-type]
> 
> This is fixed by including linux/errno.h in the header.

Yes, thanks I just reproduced it, not sure how I could have missed that
before...

> 
>>> - it is in include/linux/ where it clearly does not belong, as no other component
>>>   should be including it. Even the function documentation in there mentions that
>>>   one must hold the pmb_lock before calling it, and that is defined statically
>>>   arch/arm/mach-bcm/bcm63xx_pmb.c, so it's impossible for other code to use.
>>>   Just move it all into bcm63xx_pmb.c.
>>
>> This header will later be used by the bcm63138 reset controller, and I
>> thought I had explained the reasoning behind that in either the commit
>> message or cover letter, I will make sure the commit message explains it.
> 
> I see. I still think it's a bit rude to place this header in the top-level
> include/linux directory though. I realize there are a lot of other headers
> like this, but I'm trying not to add too many more.

Would a lesser evil be to create include/linux/resets/ and place this
header file there?

> 
> Maybe a lesser evil would be to put the reset driver into
> arch/arm/mach-bcm/bcm63xx_pmb.c as well?
> 
> How big is it? And is there anything else besides that driver which would
> need these functions?

It is going to be (once feature complete) as big as
arch/arm/mach-bcm/bcm63xx_pmb.c except that it will also have to inspect
the client asking for the reset, e.g: the reset procedure for the SATA
block is a little different than the one for the PCIe PHY, or integrated
Ethernet switch, or USB controlers...

The way we power on a secondary CPU is code that is not shared with how
other on-chip peripherals are powered on, hence the idea behind the
separation.

> 
>> The lock issue is not much of a problem since we do not support CPU
>> hotplug and the reset controller subsystem is initialized later so there
>> is no possibility for these two pieces of code to conflict.
> 
> Ok
> 
> 	Arnd
> 


-- 
Florian
