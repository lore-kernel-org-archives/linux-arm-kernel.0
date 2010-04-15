From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 15 Apr 2010 20:24:02 +0800
Subject: [PATCH 2/2] arm: invalidate TLBs when enabling mmu
In-Reply-To: <20100414182726.GB13275@n2100.arm.linux.org.uk>
References: <1268143623-22361-1-git-send-email-saeed@marvell.com>
	<1268143623-22361-2-git-send-email-saeed@marvell.com>
	<1268143623-22361-3-git-send-email-saeed@marvell.com>
	<20100414182726.GB13275@n2100.arm.linux.org.uk>
Message-ID: <l2sf17812d71004150524w1dc68807i323660a42a52958f@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 15, 2010 at 2:27 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Mar 09, 2010 at 04:07:03PM +0200, Saeed Bishara wrote:
>> Signed-off-by: Saeed Bishara <saeed@marvell.com>
>> ---
>>  arch/arm/boot/compressed/head.S |    1 +
>>  1 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
>> index 4fddc50..a1ab79f 100644
>> --- a/arch/arm/boot/compressed/head.S
>> +++ b/arch/arm/boot/compressed/head.S
>> @@ -489,6 +489,7 @@ __armv7_mmu_cache_on:
>>               mcr     p15, 0, r0, c1, c0, 0   @ load control register
>>               mrc     p15, 0, r0, c1, c0, 0   @ and read it back
>>               mov     r0, #0
>> +             mcr     p15, 0, r0, c8, c7, 0   @ invalidate I,D TLBs
>>               mcr     p15, 0, r0, c7, c5, 4   @ ISB
>>               mov     pc, r12
>>
>
> This can't be unconditional - if we're running on PMSA (iow, uclinux)
> we should not execute this instruction.  Notice that the previous one
> is conditional.
>

This is true and needs to be fixed.

> The other question is whether this should be done before or after the
> ISB - if it's done before, my understanding is that it could occur
> unordered with respect to the MMU being enabled - if that's indeed
> the problem.
>

Another noticeable difference is the slow decompressing happens so far on
kexec only, a normal boot without this additional "invalidate" does not
exhibit such slowness. This leads to me to suspect that the MMU state might
not be same between a normal bootup and a kexec soft reboot.

I may overlooked, but it looks to me that after a 1:1 mapping of ther user
space area (from 0x0000_0000 to TASK_SIZE, which I guess will cause some
other issue if the kexec kernel start entry starts beyond TASK_SIZE?), the
MMU is NOT actually turned off through the reset. This might cause weird
behavior with the original sequence of __armv7_mmu_cache_on ??
