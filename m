From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sun, 16 Jan 2011 21:25:00 +0000
Subject: [PATCH] ARM: vfp: Fix up exception location in Thumb mode
In-Reply-To: <20110115154019.GF15996@n2100.arm.linux.org.uk>
References: <1294990949-2729-1-git-send-email-ccross@android.com>
	<AANLkTimqiqABxCejdeOQWZZ62DVUZW2v-yMpdu1aNDQT@mail.gmail.com>
	<20110114120229.GA15996@n2100.arm.linux.org.uk>
	<1295014231.7901.41.camel@e102109-lin.cambridge.arm.com>
	<20110114154919.GE15996@n2100.arm.linux.org.uk>
	<1295022193.7901.56.camel@e102109-lin.cambridge.arm.com>
	<20110114163520.GH15996@n2100.arm.linux.org.uk>
	<1295024327.7901.70.camel@e102109-lin.cambridge.arm.com>
	<20110114173050.GJ15996@n2100.arm.linux.org.uk>
	<AANLkTin_pMzNc-ZL+rVcwaVawer0poyxhatqw5P-A2qW@mail.gmail.com>
	<20110115154019.GF15996@n2100.arm.linux.org.uk>
Message-ID: <AANLkTim8OhAtqADck0Snq-7z7opw=coiQ4=DeO0O7Qa-@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 January 2011 15:40, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sat, Jan 15, 2011 at 03:31:04PM +0000, Catalin Marinas wrote:
>> On 14 January 2011 17:30, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > +@ ?r9 ?= normal "successful" return address
>> > ?@ ?r10 = vfp_state union
>> > ?@ ?r11 = CPU number
>> > -@ ?lr ?= failure return
>> > -
>> > +@ ?lr ?= unrecognised instruction return address
>> > +@ ?IRQs enabled.
>> > ?ENTRY(vfp_support_entry)
>> > ? ? ? ?DBGSTR3 "instr %08x pc %08x state %p", r0, r2, r10
>> >
>> > @@ -138,9 +138,12 @@ check_for_exception:
>> > ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?@ exception before retrying branch
>> > ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?@ out before setting an FPEXC that
>> > ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?@ stops us reading stuff
>> > - ? ? ? VFPFMXR FPEXC, r1 ? ? ? ? ? ? ? @ restore FPEXC last
>> > - ? ? ? sub ? ? r2, r2, #4
>> > - ? ? ? str ? ? r2, [sp, #S_PC] ? ? ? ? @ retry the instruction
>> > + ? ? ? VFPFMXR FPEXC, r1 ? ? ? ? ? ? ? @ Restore FPEXC last
>> > + ? ? ? sub ? ? r2, r2, #4 ? ? ? ? ? ? ?@ Retry current instruction - if Thumb
>> > + ? ? ? str ? ? r2, [sp, #S_PC] ? ? ? ? @ mode it's two 16-bit instructions,
>> > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? @ else it's one 32-bit instruction, so
>> > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? @ always subtract 4 from the following
>> > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? @ instruction address.
>>
>> I would say it's always a 32-bit instruction but made up of two 16-bit
>> values to allow half-word alignment.
>
> Do you have a suggested replacement text?

Maybe something like: Retry the current VFP instruction (32-bit in
both ARM and Thumb modes).

(I was wondering whether we can get on the above code path with
asynchronous VFP exceptions where the interrupted instruction may not
be the VFP one. But I think all Thumb-2 processors these days generate
synchronous exceptions)

-- 
Catalin
