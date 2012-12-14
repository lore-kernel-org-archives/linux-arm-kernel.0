From: robherring2@gmail.com (Rob Herring)
Date: Fri, 14 Dec 2012 12:08:20 -0600
Subject: [PATCH 2/2] ARM: SH-Mobile: sh73a0: Add CPU Hotplug
In-Reply-To: <CABYn4syb8yBRwUqbS=2dp1i3FYFt1edYPRh9xa=aHTY9RsWw8A@mail.gmail.com>
References: <1354795719-5578-1-git-send-email-hechtb+renesas@gmail.com>
 <1354795719-5578-2-git-send-email-hechtb+renesas@gmail.com>
 <50CB34F4.8060204@gmail.com>
 <CABYn4syb8yBRwUqbS=2dp1i3FYFt1edYPRh9xa=aHTY9RsWw8A@mail.gmail.com>
Message-ID: <50CB6B14.1070500@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/14/2012 09:33 AM, Bastian Hecht wrote:
> Hi,
> 
> 2012/12/14 Rob Herring <robherring2@gmail.com>:
>> On 12/06/2012 06:08 AM, Bastian Hecht wrote:
>>> From: Bastian Hecht <hechtb@gmail.com>
>>>
>>> Add the capability to add and remove CPUs on the fly.
>>> The Cortex-A9 offers the possibility to take single cores out of the
>>> MP Core. We add this capabilty taking care that caches are kept
>>> coherent. For the actual shutdown via a WFI instruction, a code snippet
>>> from the omap2 code tree is copied. Thanks for that! For verifying the
>>> shutdown we rely on the internal SH73A0 Power Status Register
>>> PSTR.
>>>
>>> Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
>>> ---
>>>  arch/arm/mach-shmobile/headsmp-sh73a0.S      |   46 ++++++++++++++++++++++++++
>>>  arch/arm/mach-shmobile/include/mach/common.h |    1 +
>>>  arch/arm/mach-shmobile/smp-sh73a0.c          |   41 +++++++++++++++++++----
>>>  3 files changed, 82 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-shmobile/headsmp-sh73a0.S b/arch/arm/mach-shmobile/headsmp-sh73a0.S
>>> index bec4c0d..be463a3 100644
>>> --- a/arch/arm/mach-shmobile/headsmp-sh73a0.S
>>> +++ b/arch/arm/mach-shmobile/headsmp-sh73a0.S
>>> @@ -23,6 +23,52 @@
>>>  #include <linux/init.h>
>>>  #include <asm/memory.h>
>>>
>>> +/* Taken from arch/arm/mach-omap2/sleep44xx.S. Thanks! */
>>> +ENTRY(sh73a0_do_wfi)
>>> +        stmfd   sp!, {lr}
>>
>> Why does the lr need to be pushed to the stack?
> 
> Yes I must admit this is paradox - we never return but prepare to do
> so... In the OMAP code they've got a lead out code in case the WFI
> doesn't succeed. I see no reason how this could ever happen here but
> to take a safe route I've decided to keep the mechanism to be able to
> return and spit out an error message back in the C code.

It's not clear to me that OMAP needed this either. The lr value would
have to get lost during wfi.

>>> +
>>> +        /*
>>> +         * Execute an ISB instruction to ensure that all of the
>>> +         * CP15 register changes have been committed.
>>> +         */
>>> +        isb
>>
>> Generally writes to cp15 registers that need an isb already do so.
> 
> Ok nice, I'll check that and throw it out.
> 
>>> +
>>> +        /*
>>> +         * Execute a barrier instruction to ensure that all cache,
>>> +         * TLB and branch predictor maintenance operations issued
>>> +         * by any CPU in the cluster have completed.
>>> +         */
>>> +        dsb
>>> +        dmb
>>
>> A dsb is a superset of a dmb, so you should not need both.
> 
> Same here.
> 
>>> +
>>> +        /*
>>> +         * Execute a WFI instruction and wait until the
>>> +         * STANDBYWFI output is asserted to indicate that the
>>> +         * CPU is in idle and low power state. CPU can specualatively
>>> +         * prefetch the instructions so add NOPs after WFI. Sixteen
>>> +         * NOPs as per Cortex-A9 pipeline.
>>
>> Why do you care what is prefetched? You're never coming back here, right?
> 
> We can jump back to the paradox top. The idea seems to be to have a
> clean pipeline in case the WFI doesn't succeed.
> The thing about this whole code snippet is: I saw no reason to
> reinvent the wheel and tinker on my own solution when there is code
> that does the job in a clean way. I thought this could maybe be moved
> to a general ARM code base when more people rely on it.
> 

Blindly copying code is reinventing the wheel. You are making it appear
that this is needed, but don't seem to have any reason why other than
OMAP did it. If it is in fact needed, then it should be common.

Use cpu_do_idle or figure out and explain why you can't. It's important
to know that if we do go and consolidate this code later.

Rob
