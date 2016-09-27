From: panand@redhat.com (Pratyush Anand)
Date: Tue, 27 Sep 2016 20:33:25 +0530
Subject: [PATCH 5/5] arm64: Add uprobe support
In-Reply-To: <20160927135133.GF17336@e104818-lin.cambridge.arm.com>
References: <20160920165946.GA19353@e104818-lin.cambridge.arm.com>
 <20160921110047.GA29470@localhost.localdomain>
 <20160921170403.GE12180@e104818-lin.cambridge.arm.com>
 <20160922032328.GB29470@localhost.localdomain>
 <20160922165030.GA27704@e104818-lin.cambridge.arm.com>
 <20160923041230.GC29470@localhost.localdomain>
 <20160923130528.GE2161@e104818-lin.cambridge.arm.com>
 <CAHB_GupuUYPNFoYQeX8EhAcesvqKVVuphuxneudZ5kL2cxm-7g@mail.gmail.com>
 <20160926110159.GB27498@e104818-lin.cambridge.arm.com>
 <20160926130359.GA9370@localhost.localdomain>
 <20160927135133.GF17336@e104818-lin.cambridge.arm.com>
Message-ID: <c7675b74-982d-d8b6-935f-a74139820174@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Tuesday 27 September 2016 07:21 PM, Catalin Marinas wrote:
>>>>> Looking at prepare_uprobe(), we have a weak is_trap_insn() function.
>>>>> > > > > This check is meaningless without knowing which instruction set we
>>>>> > > > > target. A false positive here, however, is not that bad as we wouldn't
>>>>> > > > > end up inserting the wrong breakpoint in the executable. But it looks to
>>>>> > > > > me like the core uprobe code needs to pass some additional information
>>>>> > > > > like the type of task or ELF format to the arch code to make a useful
>>>>> > > > > choice of breakpoint type.
>>>> > > >
>>>> > > > It seems that 'strtle r0, [r0], #160' would have the closest matching
>>>> > > > aarch32 instruction wrt BRK64_OPCODE_UPROBES(0xd42000A0). But that too
>>>> > > > seems a bad instruction. So, may be we can use still weak
>>>> > > > is_trap_insn().
>>> > >
>>> > > Even if the is_trap_insn() check passes, we would reject the probe in
>>> > > arch_uprobe_analyze_insn() immediately after based on the mm type check,
>>> > > so not too bad.
>> >
>> > OK..I will have an always returning false from arm64 is_trap_insn() in v2.
> For the time being, I think the default is_trap_insn() check is still
> useful on arm64.

I have already sent V2 with arm64 is_trap_insn() :(

> The problem gets trickier when we add AArch32 support
> as it may return 'true' on an AArch32 instruction that matches the
> AArch64 BRK (or vice-versa). That's when we need to either pass the mm
> to is_trap_insn() or simply return false and always perform the check in
> the arch_uprobe_analyze_insn() (which should, in addition, check for the
> trap instruction).

Yes, I agree that we will have to modify is_trap_insn() for supporting 
aarch32 task tracing.

>
> There is also the is_trap_at_addr() function which uses is_trap_insn().
> I haven't checked the call paths here, are there any implications if
> is_trap_insn() always returns false?

I had looked into it and also tested that a tracepoint at an application 
having a same instruction as that of "uprobe break instruction" ie "BRK 
#0x5" is rejected. So, I think a false positive return from 
is_tarp_insn() is still OK.

~Pratyush
