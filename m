From: mreimer@sdgsystems.com (Matt Reimer)
Date: Tue, 14 Dec 2010 10:08:01 -0500
Subject: bad pmd
In-Reply-To: <20101208140210.GC9777@n2100.arm.linux.org.uk>
References: <4CF6A7F2.80206@sdgsystems.com>
	<20101201201440.GD29347@n2100.arm.linux.org.uk>
	<4CF70607.1010905@sdgsystems.com> <4CFE6E55.1080308@sdgsystems.com>
	<20101208140210.GC9777@n2100.arm.linux.org.uk>
Message-ID: <AANLkTinP=1opPSDMULHn9DDBMVfT15RaZ0K_WAh7JJuz@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 8, 2010 at 9:02 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Dec 07, 2010 at 12:26:45PM -0500, Aric D. Blumer wrote:
>> Matt Reimer and I believe we have found what is going on here. ?I've put
>> in a fix (no failures yet), but I wanted to bounce it off anyone interested.
>>
>> The PXA platform does not use the "bad pmd" mapping that Russell
>> describes above under normal circumstances, but the PXA resume code
>> (arch/arm/mach-pxa/sleep.S) does on resume:
>
> Good find.
>
>> I'm using the patch below as a fix for now, but it's hard to know what
>> registers are available. ?Might be better to just mask it off the lower
>> bits in r1 again.
>>
>> ? ? ? ? @ Let us ensure we jump to resume_after_mmu only when the mcr above
>> ? ? ? ? @ actually took effect. ?They call it the "cpwait" operation.
>> - ? ? ? mrc ? ? p15, 0, r1, c2, c0, 0 ? ? ? ? ? @ queue a dependency on CP15
>> - ? ? ? sub ? ? pc, r2, r1, lsr #32 ? ? ? ? ? ? @ jump to virtual addr
>> + ? ? ? mrc ? ? p15, 0, r0, c2, c0, 0 ? ? ? ? ? @ queue a dependency on CP15
>> + ? ? ? sub ? ? pc, r2, r0, lsr #32 ? ? ? ? ? ? @ jump to virtual addr
>
> I don't see anything wrong with this. ?Any PXA people want to ack this?

This patch fixes the problem for us. We have yet to see a failure with
this patch applied.

Eric, do you concur that this is a proper fix?

Matt
