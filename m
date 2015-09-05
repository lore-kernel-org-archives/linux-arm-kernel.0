From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 05 Sep 2015 19:10:49 +0200
Subject: [PATCH] ARM: fix alignement of __bug_table section entries
In-Reply-To: <20150905142519.GN21084@n2100.arm.linux.org.uk> (Russell King's
 message of "Sat, 5 Sep 2015 15:25:19 +0100")
References: <1441175009-26730-1-git-send-email-robert.jarzmik@free.fr>
 <20150902103955.GF6281@e103592.cambridge.arm.com>
 <878u8lx9hl.fsf@belgarion.home>
 <20150905142519.GN21084@n2100.arm.linux.org.uk>
Message-ID: <87y4gkx04m.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> On Sat, Sep 05, 2015 at 03:48:38PM +0200, Robert Jarzmik wrote:
>> This time I took my JTAG to have a look at the flow, in arch/arm/mm/alignment.c,
>> where I added the small chunk in [2], which gave in my case :
>>     RJK: fault=4 instr=0x00000000 instrptr=0xc02b37c8 thumb_mode=0 tinstr=0x0000
>
> Right, so as fault is nonzero, this means that we were unable to read the
> instruction.  That seems mad though - the instruction pointer is certainly
> valid, and as we're using probe_kernel_address(), that switches to the
> kernel "segment" before trying to read kernel addresses.  That should
> mean that __copy_from_user_inatomic() is able to read the instruction.
>
> I think this is the root cause of the issue.

And there is more madness to come : I tried to "reread" the instruction [1] a
second time if the first result was 4 :
RJK: fault=4 instr=0x00000000(@c385d72c) instrptr=0xc02b39e8 thumb_mode=0 tinstr=0x0000
RJK: reread instruction: [0xc02b39e8] = 0x10c650b2: 0

Guess what, the second probe_kernel_address() with the same parameters returns
0, and everything works. It's insane.

>> Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> It seems you have SW_DOMAIN_PAN enabled.
That's the default arch/arm/Kconfig implies.
And ... this is what also _is_ the cause of this behavior : removing
SW_DOMAIN_PAN makes all my pxa boards work again !!!

Moreover, this is consistent with the fact that this commit is in linux-next but
not in v4.1 :
    a5e090acbf54 ("ARM: software-based priviledged-no-access support")

So the issue is around this SW_DOMAIN_PAN, at least on PXA.

--
Robert

[1]
@@ -787,6 +798,15 @@ do_alignment(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
                instr = __mem_to_opcode_arm(instr);
        }
 
+       pr_info("RJK: fault=%d instr=0x%08lx(@%p) instrptr=0x%08lx thumb_mode=%lu tinstr=0x%04x\n",
+               fault, instr, &instr, instrptr, thumb_mode(regs), tinstr);
+       if (fault == 4 && !thumb_mode(regs)) {
+               fault = probe_kernel_address(instrptr, instr);
+               pr_info("RJK: reread instruction: [0x%08lx] = 0x%08lx: %u\n",
+                       instrptr, instr, fault);
+               rjk_debug_point(instrptr);
+       }
+
        if (fault) {
                type = TYPE_FAULT;
                goto bad_or_fault;
