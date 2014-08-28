From: k.khlebnikov@samsung.com (Konstantin Khlebnikov)
Date: Thu, 28 Aug 2014 15:50:56 +0400
Subject: [PATCH 1/2] ARM: LPAE: load upper bits of early TTBR0/TTBR1
In-Reply-To: <20140828110300.GJ22580@arm.com>
References: <20140722153623.25088.37742.stgit@buzz>
 <20140728181224.GN15536@arm.com>
 <CALYGNiNrK1d32ecz4rw0sgn0GyN-M6hTBuTLGQV53Z4Br-bpYQ@mail.gmail.com>
 <20140728184741.GT15536@arm.com>
 <CALYGNiOd+Dy-2q_woZ9UDbMO24q58jN1Nsq7E8cJMMg_YBK9pA@mail.gmail.com>
 <CABb+yY17Y18oAivi_VxPJqDEGLTbEy_PfsdeK9jXWZ0iV3vZ=w@mail.gmail.com>
 <CALYGNiN-SHr6YJ53_deizb1VoXTBzD7dn8hcwqd4zLjx6utCDw@mail.gmail.com>
 <CABb+yY1VsEwDi5XCRkKbSNPW_+_MgL4gdAChKgX_NGHRzXq6qw@mail.gmail.com>
 <20140828110300.GJ22580@arm.com>
Message-ID: <53FF17A0.1030100@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 2014-08-28 15:03, Will Deacon wrote:
> On Wed, Aug 27, 2014 at 04:45:24PM +0100, Jassi Brar wrote:
>> On Wed, Aug 27, 2014 at 9:01 PM, Konstantin Khlebnikov <koct9i@gmail.com> wrote:
>>> On Wed, Aug 27, 2014 at 7:26 PM, Jassi Brar <jassisinghbrar@gmail.com> wrote:
>>>> It seems the patch wasn't tested on any real platform, I did on my
>>>> CA15 based platform - it breaks boot. Simply reverting the patch gets
>>>> it going again. I am happy to try any fix.
>>>>
>>> Please try to remove adcls line.
>>> Seems like this affects only systems where PHYS_OFFSET == PAGE_OFFSET.
>>>
>>> --- a/arch/arm/mm/proc-v7-3level.S
>>> +++ b/arch/arm/mm/proc-v7-3level.S
>>> @@ -146,7 +146,6 @@ ENDPROC(cpu_v7_set_pte_ext)
>>>          mov     \tmp, \ttbr1, lsr #(32 - ARCH_PGD_SHIFT)        @ upper bits
>>>          mov     \ttbr1, \ttbr1, lsl #ARCH_PGD_SHIFT             @ lower bits
>>>          addls   \ttbr1, \ttbr1, #TTBR1_OFFSET
>>> -       adcls   \tmp, \tmp, #0
>>>          mcrr    p15, 1, \ttbr1, \tmp, c2                        @ load TTBR1
>>>          mov     \tmp, \ttbr0, lsr #(32 - ARCH_PGD_SHIFT)        @ upper bits
>>>          mov     \ttbr0, \ttbr0, lsl #ARCH_PGD_SHIFT             @ lower bits
>>>
>> Yup, restores boot.
> Can somebody write this up as a proper patch and put it in the patch system
> please?

Ok. Done.

http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=8132/1

>
> Will
>

-------------- next part --------------
ARM: LPAE: drop wrong carry flag correction after adding TTBR1_OFFSET

From: Konstantin Khlebnikov <k.khlebnikov@samsung.com>

In commit 7fb00c2fca4b6c58be521eb3676cf4b4ba8dde3b ("ARM: 8114/1: LPAE:
load upper bits of early TTBR0/TTBR1") part which fixes carrying in adding
TTBR1_OFFSET to TTRR1 was wrong:

	addls   \ttbr1, \ttbr1, #TTBR1_OFFSET
	adcls   \tmp, \tmp, #0

addls doesn't update flags, adcls adds carry from cmp above:

	cmp	\ttbr1, \tmp			@ PHYS_OFFSET > PAGE_OFFSET?

Condition 'ls' means carry flag is clear or zero flag is set, thus only one
case is affected: when PHYS_OFFSET == PAGE_OFFSET.

It seems safer to remove this fixup. Bug is here for ages and nobody
complained. Let's fix it separately.

Signed-off-by: Konstantin Khlebnikov <k.khlebnikov@samsung.com>
Reported-and-tested-by: Jassi Brar <jassisinghbrar@gmail.com>
---
 arch/arm/mm/proc-v7-3level.S |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mm/proc-v7-3level.S b/arch/arm/mm/proc-v7-3level.S
index 1a24e92..b64e67c 100644
--- a/arch/arm/mm/proc-v7-3level.S
+++ b/arch/arm/mm/proc-v7-3level.S
@@ -146,7 +146,6 @@ ENDPROC(cpu_v7_set_pte_ext)
 	mov	\tmp, \ttbr1, lsr #(32 - ARCH_PGD_SHIFT)	@ upper bits
 	mov	\ttbr1, \ttbr1, lsl #ARCH_PGD_SHIFT		@ lower bits
 	addls	\ttbr1, \ttbr1, #TTBR1_OFFSET
-	adcls	\tmp, \tmp, #0
 	mcrr	p15, 1, \ttbr1, \tmp, c2			@ load TTBR1
 	mov	\tmp, \ttbr0, lsr #(32 - ARCH_PGD_SHIFT)	@ upper bits
 	mov	\ttbr0, \ttbr0, lsl #ARCH_PGD_SHIFT		@ lower bits
