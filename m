From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 11 Dec 2013 21:20:02 +0400
Subject: [PATCH] ARM: rcar-gen2: Do not attempt to re-setup timer if
 running correctly
In-Reply-To: <52A89DC7.4070909@codethink.co.uk>
References: <1386753916-25648-1-git-send-email-ben.dooks@codethink.co.uk>
 <52A89D6A.3030707@cogentembedded.com> <52A89DC7.4070909@codethink.co.uk>
Message-ID: <52A89EC2.4040203@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 11-12-2013 21:15, Ben Dooks wrote:

>>> If the system has been started in non-secure mode, then the ARM generic
>>> timer is not configurable during the kernel initialisation. Currently
>>> the only thing we can check for is if the timer has been correctly
>>> configured during the boot process.

>>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>>> Reviewed-by: Ian Molton <ian.molton@codethink.co.uk>
>>> ---
>>>   arch/arm/mach-shmobile/setup-rcar-gen2.c | 18 +++++++++++++-----
>>>   1 file changed, 13 insertions(+), 5 deletions(-)

>>> diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c
>>> b/arch/arm/mach-shmobile/setup-rcar-gen2.c
>>> index 5734c24..6b7b7f1 100644
>>> --- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
>>> +++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
>>> @@ -78,12 +78,20 @@ void __init rcar_gen2_timer_init(void)
>>>       /* Remap "armgcnt address map" space */
>>>       base = ioremap(0xe6080000, PAGE_SIZE);
>>>
>>> -    /* Update registers with correct frequency */
>>> -    iowrite32(freq, base + CNTFID0);
>>> -    asm volatile("mcr p15, 0, %0, c14, c0, 0" : : "r" (freq));
>>> +    /* Update the timer if it is either not running, or is not at the
>>> +     * right frequency. The timer is only configurable in secure mode
>>> +     * so this avoids an abort if the loader started the timer and
>>> +     * started the kernel in non-secure mode. */

>>     You said you've fixed the comment style but you haven't as I see.

> I also said I reposted the previous patch by accident this morning
> and posted the corrected one after it.

    Sorry, I've only read that after sending my comment. I thought that was an 
intended repost with a slightly corrected subject.

WBR, Sergei
