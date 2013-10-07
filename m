From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Mon, 07 Oct 2013 12:55:01 +0200
Subject: [PATCH] ARM: tlb: __flush_tlb_mm need to use int asid var for
 BE correct operation
In-Reply-To: <20131007104936.GG465@mudshark.cambridge.arm.com>
References: <1381128458-32140-1-git-send-email-victor.kamensky@linaro.org>
 <1381128458-32140-2-git-send-email-victor.kamensky@linaro.org>
 <20131007104524.GK12758@n2100.arm.linux.org.uk>
 <20131007104936.GG465@mudshark.cambridge.arm.com>
Message-ID: <52529305.5050306@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/10/13 12:49, Will Deacon wrote:
> On Mon, Oct 07, 2013 at 11:45:24AM +0100, Russell King - ARM Linux wrote:
>> On Sun, Oct 06, 2013 at 11:47:38PM -0700, Victor Kamensky wrote:
>>> __flush_tlb_mm function need to use intermediate 'int' type 'asid'
>>> variable int tlb_op macro call. Direct use of ASID macro produces
>>> 64 bit unsigned long long type passed to inline assembler statement
>>> as 'r' operand (32bit), and resulting behavior is not well specified.
>>> It works in little endian case, but is broken in big endian case. In
>>> big endian case gcc generate such code that 0 is passed to
>>> 'mcr	15, 0, r4, cr8, cr3, {2}' operation.
>>>
>>> Note other functions like __local_flush_tlb_mm, and local_flush_tlb_mm
>>> already use intermediate 'asid' variable in similar code.
>>
>> A much better solution would be to ensure that ASID() only returns
>> the 'unsigned' type, not a long long type.
>>
>> #define ASID(mm)        ((unsigned)(mm)->context.id.counter&  ~ASID_MASK)
>
> Yup, that looks good to me. This is similar to the problem Ben already fixed
> in the mmid macro, so I think this should be included as part of his BE
> series.
>
> Speaking of which -- it's probably a good time to refresh and repost that if
> we're aiming for 3.13...

I intended on rebasing the branch over the weekend, but ran out of
time due to illness. I will try and look at a re-base tonight and
if we can replace this ASID() issue then I can produce a new branch
with it in.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
