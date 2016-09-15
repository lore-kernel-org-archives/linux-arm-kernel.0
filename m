From: mhiramat@kernel.org (Masami Hiramatsu)
Date: Thu, 15 Sep 2016 13:31:33 +0900
Subject: [PATCH v4] arm64: Improve kprobes test for atomic sequence
In-Reply-To: <57D7515C.30704@linaro.org>
References: <1473704487-6069-1-git-send-email-dave.long@linaro.org>
 <20160913094629.6e8ca789f90ee7f2c80f33db@kernel.org>
 <57D7515C.30704@linaro.org>
Message-ID: <20160915133133.950de3aeafdec36c25be4e00@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 12 Sep 2016 21:07:40 -0400
David Long <dave.long@linaro.org> wrote:
> 
> After the patch the function reads as follows:
> 
> > enum kprobe_insn __kprobes
> > arm_kprobe_decode_insn(kprobe_opcode_t *addr, struct arch_specific_insn *asi)
> > {
> > 	enum kprobe_insn decoded;
> > 	kprobe_opcode_t insn = le32_to_cpu(*addr);
> > 	kprobe_opcode_t *scan_end = NULL;
> > 	unsigned long size = 0, offset = 0;
> >
> > 	/*
> > 	 * If there's a symbol defined in front of and near enough to
> > 	 * the probe address assume it is the entry point to this
> > 	 * code and use it to further limit how far back we search
> > 	 * when determining if we're in an atomic sequence. If we could
> > 	 * not find any symbol skip the atomic test altogether as we
> > 	 * could otherwise end up searching irrelevant text/literals.
> > 	 * KPROBES depends on KALLSYMS so this last case should never
> > 	 * happen.
> > 	 */
> > 	if (kallsyms_lookup_size_offset((unsigned long) addr, &size, &offset)) {
> > 		if (offset < (MAX_ATOMIC_CONTEXT_SIZE*sizeof(kprobe_opcode_t)))
> > 			scan_end = addr - (offset / sizeof(kprobe_opcode_t));
> > 		else
> > 			scan_end = addr - MAX_ATOMIC_CONTEXT_SIZE;
> > 	}
> > 	decoded = arm_probe_decode_insn(insn, asi);
> >
> > 	if (decoded != INSN_REJECTED && scan_end)
> > 		if (is_probed_address_atomic(addr - 1, scan_end))
> > 			return INSN_REJECTED;
> >
> > 	return decoded;
> > }
> 
> A failed kallsyms_lookup_size_offset() call means scan_end will be left 
> as NULL, which in turn means arm_kprobe_decode_insn() will simply return 
> the result of the arm_probe_decode_insn() call.  In other words it does 
> the normal analysis of the instruction to be probed, but does not do the 
> atomic sequence search that normally follows that (since it doesn't 
> really know how far back to search).

OK, my idea was just rejecting it when kallsyms_lookup_size_offset() is
failed, because we can not ensure that the address is in the kernel
text. But anyway, that should be tested in general code like kernel/kprobes.c.

OK, now I think it is clear to apply.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks,

> 
> Thanks,
> -dl
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
