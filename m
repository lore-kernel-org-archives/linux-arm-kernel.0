From: bdegraaf@codeaurora.org (bdegraaf at codeaurora.org)
Date: Tue, 20 Sep 2016 09:02:05 -0400
Subject: [RFC] arm64: Ensure proper addressing for ldnp/stnp
In-Reply-To: <c1911e82-e65a-73e4-f878-8e25f609f58b@arm.com>
References: <1474306586-25118-1-git-send-email-bdegraaf@codeaurora.org>
 <be5f5bfd-fd41-d202-cec9-0ca3fcad28db@arm.com>
 <9a3f86d9037a478f0a1a87b2084c7496@codeaurora.org>
 <c1911e82-e65a-73e4-f878-8e25f609f58b@arm.com>
Message-ID: <1933af26f77630507137e88498f885a0@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016-09-20 07:00, Robin Murphy wrote:
> On 19/09/16 19:25, bdegraaf at codeaurora.org wrote:
>> On 2016-09-19 14:01, Robin Murphy wrote:
>>> On 19/09/16 18:36, Brent DeGraaf wrote:
>>>> According to section 6.3.8 of the ARM Programmer's Guide, 
>>>> non-temporal
>>>> loads and stores do not verify that address dependency is met 
>>>> between a
>>>> load of an address to a register and a subsequent non-temporal load 
>>>> or
>>>> store using that address on the executing PE. Therefore, context 
>>>> switch
>>>> code and subroutine calls that use non-temporally accessed addresses 
>>>> as
>>>> parameters that might depend on a load of an address into an 
>>>> argument
>>>> register must ensure that ordering requirements are met by 
>>>> introducing
>>>> a barrier prior to the successive non-temporal access.  Add 
>>>> appropriate
>>>> barriers whereever this specific situation comes into play.
>>>> 
>>>> Signed-off-by: Brent DeGraaf <bdegraaf@codeaurora.org>
>>>> ---
>>>>  arch/arm64/kernel/entry.S  | 1 +
>>>>  arch/arm64/lib/copy_page.S | 2 ++
>>>>  2 files changed, 3 insertions(+)
>>>> 
>>>> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
>>>> index 441420c..982c4d3 100644
>>>> --- a/arch/arm64/kernel/entry.S
>>>> +++ b/arch/arm64/kernel/entry.S
>>>> @@ -679,6 +679,7 @@ ENTRY(cpu_switch_to)
>>>>      ldp    x27, x28, [x8], #16
>>>>      ldp    x29, x9, [x8], #16
>>>>      ldr    lr, [x8]
>>>> +    dmb    nshld    // Existence of instructions with loose 
>>>> load-use
>>>> dependencies (e.g. ldnp/stnp) make this barrier necessary
>>>>      mov    sp, x9
>>>>      and    x9, x9, #~(THREAD_SIZE - 1)
>>>>      msr    sp_el0, x9
>>>> diff --git a/arch/arm64/lib/copy_page.S b/arch/arm64/lib/copy_page.S
>>>> index 4c1e700..21c6892 100644
>>>> --- a/arch/arm64/lib/copy_page.S
>>>> +++ b/arch/arm64/lib/copy_page.S
>>>> @@ -47,6 +47,8 @@ alternative_endif
>>>>      ldp    x14, x15, [x1, #96]
>>>>      ldp    x16, x17, [x1, #112]
>>>> 
>>>> +    dmb    nshld // In case x0 (for stnp) is dependent on a load
>>> 
>>> The ARMv8 ARM (B2.7.2 in issue j) says that when an address 
>>> dependency
>>> exists between a load and a subsequent LDNP, *other* observers may
>>> observe those accesses in any order. How's that related to an STNP on
>>> the same CPU?
>>> 
>>> Robin.
>>> 
>>>> +
>>>>      mov    x18, #(PAGE_SIZE - 128)
>>>>      add    x1, x1, #128
>>>>  1:
>>>> 
>> 
>> Yes, I have seen the section in the ARM ARM about this. But the
>> Programmer's Guide goes further, even providing a concrete example:
>> 
>> "Non-temporal loads and stores relax the memory ordering
>> requirements...the LDNP instruction might
>> be observed before the preceding LDR instruction, which can result in
>> reading from an unpredictable
>> address in X0.
>> 
>> For example:
>> LDR X0, [X3]
>> LDNP X2, X1, [X0]
>> To correct the above, you need an explicit load barrier:
>> LDR X0, [X3]
>> DMB NSHLD
>> LDNP X2, X1, [X0]"
>> 
>> Did the ARM ARM leave this out?  Or is the Programmer's Guide section
>> incorrect?
> 
> If the ARM ARM and the Programmer's Guide don't agree, then the
> Programmer's Guide is wrong (I'll raise a bug against it).
> 
> All the ARM ARM says is that in this situation:
> 
>      P1                        P2
>  STP x0, x1, [x2]      1: LDR x0, <ptr>
>  DMB ISH                  CBZ x0, 1b
>  STR x2, <ptr>            LDNP x1, x2, [x0]
> 
> P2's address dependency still very much exists from the point of view 
> of
> P2's execution, it just may not guarantee order13.2.4 against the DMB 
> on P1,
> so P2's LDNP isn't guaranteed to see the data from P1's STP (as opposed
> to how a regular LDP *is*), and may still load older stale data 
> instead.
> 
> Robin.
> 
>> 
>> Thanks for your comments,
>> Brent
>> 

Thank you Robin.  This was concerning to me because the ARM ARM 
description
does not explicitly disagree with the Programmer's Guide, it just 
doesn't
touch on the PEe ordering.  Meanwhile, as you can see from the quote 
above,
the Programmer's Guide doesn't talk about PEy, and even includes sample 
code
that would only affect PEe ordering (the "nsh" option), leaving PEy 
ordering
impacts completely out of the picture, meaning some degree of thought 
was
applied toward it.

I went back through older versions of both the ARM ARM last week and the
Guide and the ARM ARM has never mentioned an issue with PEe ordering of
non-temporal accesses, so I am unsure where the Guide could have gotten
its information.

Also, please be aware that this description is in the Programmer's Guide
*twice*, both in section 6.3.8 which I mentioned in the commit text and 
is
duplicated in section 13.2.4.

Please keep me posted as to when the Guide will be corrected (or if it 
is
discovered to be correct).

Thanks again,
Brent
