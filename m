From: slash.tmp@free.fr (Mason)
Date: Mon, 16 Mar 2015 23:17:23 +0100
Subject: read_cpuid_id() in arch/arm/kernel/setup.c
In-Reply-To: <alpine.DEB.2.02.1503161641000.29420@utopia.booyaka.com>
References: <55030A68.6070002@free.fr>
 <20150313161953.GS8656@n2100.arm.linux.org.uk> <550312BB.8020902@free.fr>
 <20150313164546.GV8656@n2100.arm.linux.org.uk> <5505C40C.1050001@free.fr>
 <550697FE.1020804@free.fr>
 <alpine.DEB.2.02.1503161641000.29420@utopia.booyaka.com>
Message-ID: <55075673.5010600@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Paul,

On 16/03/2015 17:54, Paul Walmsley wrote:

> On Mon, 16 Mar 2015, Mason wrote:
> 
>> On 15/03/2015 18:40, Mason wrote:
>>
>>> On 13/03/2015 17:45, Russell King - ARM Linux wrote:
>>>
>>>> Yes, this one I like - and it probably fixes a potential latent bug
>>>> where the compiler was free to re-order that mrc outside of the if()
>>>> statement.
>>>>
>>>> Please wrap it up as a normal submission, thanks.
>>>
>>> Proposed patch at the end of this message.
>>>
>>> I'm now puzzling over why it's required to have "memory"
>>> in read_cpuid_ext's clobber list, and not in read_cpuid's?
> 
> Reviewed-by: Paul Walmsley <paul@pwsan.com>
> 
> Looks reasonable to me.  I'd suggest updating the patch message to 
> describe your change, and why it's needed.  Consider something like:
> 
> ---
> 
> Convert the open-coded MMFR0 register read in __get_cpu_architecture() to 
> use the read_cpuid_ext() macro.  This shortens the function and ensures 
> that a memory clobber is used on the coprocessor read instruction.  The 
> memory clobber works around a bug in gcc 4.5.  gcc 4.5 can reorder 
> coprocessor read instructions with respect to other code, disregarding 
> potential side-effects of the coprocessor read.

To be honest, the reason I wrote the patch in the first place
was merely to fix the code duplication! ;-)

I wasn't aware of the latent-bug issue until Russel mentioned
it. So I didn't want to put too much emphasis on that part,
since it didn't come from me, and it is well-documented in
your own commit, which I referenced.

Do you know why it was necessary to fix read_cpuid_ext and
not read_cpuid? I would think that the same problem affects
both macros.

> Once you've got something that you're happy with, and have reposted it to 
> the public lists, I believe the next step will be for you to post it to 
> rmk's patch tracker at:
> 
> http://www.arm.linux.org.uk/developer/patches/

Oh, I didn't know about that part. It's not mentioned in
https://www.kernel.org/doc/Documentation/SubmittingPatches

Thanks for the review, and for mentioning the tracker.

Ah yes, now I see this:
http://www.arm.linux.org.uk/mailinglists/faq.php#p1

Will post an (hopefully) improved commit message ASAP.

Regards.
