From: tixy@yxit.co.uk (Tixy)
Date: Thu, 24 Nov 2011 19:40:25 +0000
Subject: [PATCH 4/4] [RFC] Use generic ARM instruction set condition
 code checks for kprobes.
In-Reply-To: <4ECE78B6.9040408@arm.com>
References: <20111121183046.28964.23829.stgit@localhost6.localdomain6>
 <20111121183104.28964.87120.stgit@localhost6.localdomain6>
 <1321953203.2557.55.camel@computer2>  <4ECE78B6.9040408@arm.com>
Message-ID: <1322163625.2233.53.camel@computer2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-11-24 at 17:02 +0000, Leif Lindholm wrote of kprobes test
failures...
> Actually, it seems it fails explicitly because the SWP emulation is
> enabled (making the Cortex-A9 take an undef on SWP{B}):
> <<<
> .word 0xe0ff1392 @ smlals pc, r1, r2, r3
> .word 0xe0f0f392 @ smlals r0, pc, r2, r3
> .word 0xe0f0139f @ smlals r0, r1, pc, r3
> .word 0xe0f01f92 @ smlals r0, r1, r2, pc
> 
> Synchronization primitives
> ---------------------------------------------------------
> .word 0xe108e097 @ swp  lr, r7, [r8]
> Internal error: Oops - undefined instruction: 0 [#1] SMP
> Modules linked in: test_kprobes(+)
> CPU: 0    Not tainted  (3.2.0-rc3+ #9)
> PC is at kprobe_arm_test_cases+0xe1d0/0x18db9 [test_kprobes]
>  >>>

That would explain things, taking an undef abort in the kprobes handler
(which itself is running in an undef hook) will OOPS. I think that the
test code should not try to test the SWP instruction on ARMv7. It's
deprecated and the GCC compiler won't generate it - hence my need to
encode the instruction as ".word 0xe108e097" rather than get use
assembler syntax. I'll create a patch to update the test code.

> Now, disabling the SWP emulation, it still fails - but at least not as
> an oops this time:
> <<<
> FAIL: test memory differs
> FAIL: Test strd r2, [r3], r4
> FAIL: Scenario 0
> initial_regs:
> r0  21522152 | r1  21522052 | r2  12345678 | r3  b6521d78
> r4  00000030 | r5  21522452 | r6  21522752 | r7  21522652
> r8  21522952 | r9  21522852 | r10 21522b52 | r11 21522a52
> r12 21522d52 | sp  b6521d60 | lr  21522f52 | pc  7f010c34
> cpsr 00000013
> expected_regs:
> r0  21522152 | r1  21522052 | r2  12345678 | r3  b6521da8
> r4  00000030 | r5  21522452 | r6  21522752 | r7  21522652
> r8  21522952 | r9  21522852 | r10 21522b52 | r11 21522a52
> r12 21522d52 | sp  b6521d60 | lr  21522f52 | pc  7f010c38
> cpsr 00000013
> result_regs:
> r0  21522152 | r1  21522052 | r2  12345678 | r3  b6521da8
> r4  00000030 | r5  21522452 | r6  21522752 | r7  21522652
> r8  21522952 | r9  21522852 | r10 21522b52 | r11 21522a52
> 
> r12 21522d52 | sp  b6521d60 | lr  21522f52 | pc  7f010c38
> cpsr 00000013
> current_stack=b6521d60
> expected_memory:
> ba987654 ba987754 ba987854 ba987954
> ba987a54 ba987b54 12345678 b6521da8
> ba987e54 ba987f54 ba988054 ba988154
> ba988254 b6521dd8 ba988454 ba988554
> ba988654 ba988754 ba988854 ba988954
> ba988a54 ba988b54 ba988c54 ba988d54
> ba988e54 ba988f54 ba989054 ba989154
> ba989254 ba989354 ba989454 ba989554
> ba989654 ba989754 ba989854 ba989954
> ba989a54 ba989b54 ba989c54 ba989d54
> ba989e54 ba989f54 ba98a054 ba98a154
> ba98a254 ba98a354 ba98a454 ba98a554
> ba98a654 ba98a754 ba98a854 ba98a954
> ba98aa54 ba98ab54 ba98ac54 ba98ad54
> ba98ae54 ba98af54 ba98b054 ba98b154
> ba98b254 ba98b354 ba98b454 ba98b554
> result_memory:
> ba987654 ba987754 ba987854 ba987954
> ba987a54 ba987b54 12345678 b6521d78
> ba987e54 ba987f54 ba988054 ba988154
> ba988254 b6521dd8 ba988454 ba988554
> ba988654 ba988754 ba988854 ba988954
> ba988a54 ba988b54 ba988c54 ba988d54
> ba988e54 ba988f54 ba989054 ba989154
> ba989254 ba989354 ba989454 ba989554
> ba989654 ba989754 ba989854 ba989954
> ba989a54 ba989b54 ba989c54 ba989d54
> ba989e54 ba989f54 ba98a054 ba98a154
> ba98a254 ba98a354 ba98a454 ba98a554
> ba98a654 ba98a754 ba98a854 ba98a954
> ba98aa54 ba98ab54 ba98ac54 ba98ad54
> ba98ae54 ba98af54 ba98b054 ba98b154
> ba98b254 ba98b354 ba98b454 ba98b554
> kprobe tests failed
> FATAL: Error inserting test_kprobes
> 
The kprobes instruction emulation has stored the original value of r3
into memory, whereas the real instruction has store the updated value of
r3. Either this instruction form is UNPREDICTABLE, in which case the
test code should not be trying to test it, otherwise the instruction
emulation code needs fixing. Either way, a patch is needed. I'll look
into this.

> Should I go back on-list with this?

I've cc'd the list so the problem is archived.
 
-- 
Tixy
