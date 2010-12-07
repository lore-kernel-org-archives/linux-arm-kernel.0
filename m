From: aric@sdgsystems.com (Aric D. Blumer)
Date: Tue, 07 Dec 2010 12:26:45 -0500
Subject: bad pmd
In-Reply-To: <4CF70607.1010905@sdgsystems.com>
References: <4CF6A7F2.80206@sdgsystems.com>
	<20101201201440.GD29347@n2100.arm.linux.org.uk>
	<4CF70607.1010905@sdgsystems.com>
Message-ID: <4CFE6E55.1080308@sdgsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/01/2010 09:35 PM, Aric D. Blumer wrote:
> On 12/01/2010 03:14 PM, Russell King - ARM Linux wrote:
>> On Wed, Dec 01, 2010 at 02:54:26PM -0500, Aric D. Blumer wrote:
>>> Hi.  I'm using the long-term stable kernel 2.6.32 on a PXA320 platform,
>>> and I'm seeing errors like the following:
>>>
>>> /home/aric/sdg/git/linux/mm/memory.c:144: bad pmd 8040542e.
>>>
>>> I have seen these messages on both the 2.6.32.15 and 2.6.32.24 kernels
>>> (haven't tried others).  Can someone tell me what the message means?  I
>>> suspect memory is being clobbered.  One interesting thing is that
>>> whenever that message is printed, the 8040542e is always the same.  I
>>> have not been able to establish any correlation yet with what causes it.
>> A pmd value of 0x8040542e is a section mapping, which the generic MM
>> code will not understand.
>>
>> It is for address 0x80400000, is read/writable from SVC mode, inaccessible
>> from user mode, domain 1 (which is normally for 'user' memory), and has
>> a memory type of TEXCB=10111.
>>
>> As standard mainline doesn't create mappings with TEX=101, and we don't
>> create mappings with the 'user' domain using sections, the question this
>> immediately raises is: have you modified this kernel?
> Thanks for the info, Russell.  We have modified this kernel in two
> ways:  1) We have added code to support the platform (GPIOs,
> touchscreen, bluetooth UART, etc.).   2) It has the patches for Android
> merged in.
>
> It doesn't look like the Android patches do any mappings different from
> mainline, but the bad entry looks very much like a real page table
> entry.  But, supposing that memory is being trampled, can any driver
> mess up the page tables, or is a special processor mode required?  Could
> a rogue DMA trample page table memory?  Can you suggest how to determine
> what the address of the bad page table entry is?
>
> I'll start removing non-critical drivers to see if I can isolate the
> cause. . . .

Matt Reimer and I believe we have found what is going on here.  I've put
in a fix (no failures yet), but I wanted to bounce it off anyone interested.

The PXA platform does not use the "bad pmd" mapping that Russell
describes above under normal circumstances, but the PXA resume code
(arch/arm/mach-pxa/sleep.S) does on resume:

        @ temporarily map resume_turn_on_mmu into the page table,
        @ otherwise prefetch abort occurs after MMU is turned on
        mov     r1, r7
        bic     r1, r1, #0x00ff
        bic     r1, r1, #0x3f00
        ldr     r2, =0x542e

        adr     r3, resume_turn_on_mmu
        mov     r3, r3, lsr #20
        orr     r4, r2, r3, lsl #20
        ldr     r5, [r1, r3, lsl #2]
        str     r4, [r1, r3, lsl #2]

        @ Mapping page table address in the page table
        mov     r6, r1, lsr #20
        orr     r7, r2, r6, lsl #20
        ldr     r8, [r1, r6, lsl #2]
        str     r7, [r1, r6, lsl #2]

The first four lines of code is where the 0x8040542e page table entry
comes from.  The two 'bic' instructions ensure that r7 contains only the
page table address and not any of the status bits.  This code is fine. 
The problem lies with pxa3xx_resume_after_mmu assuming that r1 is
unmodified, but resume_turn_on_mmu clobbers r1.  It clobbers it with a
read of the page table address, but it does not mask the lower bits of
that register:
