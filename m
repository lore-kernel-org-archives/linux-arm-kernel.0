From: masami.hiramatsu.pt@hitachi.com (Masami Hiramatsu)
Date: Fri, 08 Aug 2014 16:51:50 +0900
Subject: [RFC PATCH v2] kprobes: arm: enable OPTPROBES for ARM 32
In-Reply-To: <1407469056-53478-1-git-send-email-wangnan0@huawei.com>
References: <1407469056-53478-1-git-send-email-wangnan0@huawei.com>
Message-ID: <53E48196.7090603@hitachi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(2014/08/08 12:37), Wang Nan wrote:
> This patch introduce kprobeopt for ARM 32.
> 
> Limitations:
>  - Currently only kernel compiled with ARM ISA is supported.
> 
>  - Offset between probe point and optinsn slot must not larger than
>    32MiB. Masami Hiramatsu suggests replacing 2 words, it will make
>    things complex. Futher patch can make such optimization.
> 
> Kprobe opt on ARM is relatively simpler than kprobe opt on x86 because
> ARM instruction is always 4 bytes aligned and 4 bytes long. This patch
> replace probed instruction by a 'b', branch to trampoline code and then
> calls optimized_callback(). optimized_callback() calls opt_pre_handler()
> to execute kprobe handler. It also emulate/simulate replaced instruction.
> 
> When unregistering kprobe, the deferred manner of unoptimizer may leave
> branch instruction before optimizer is called. Different from x86_64,
> which only copy the probed insn after optprobe_template_end and
> reexecute them, this patch call singlestep to emulate/simulate the insn
> directly. Futher patch can optimize this behavior.
> 
> v1 -> v2:
> 
>  - Improvement: if replaced instruction is conditional, generate a
>    conditional branch instruction for it;

OK, this seems same as normal kprobe breakpoint does.

>  - Introduces RELATIVEJUMP_OPCODES due to ARM kprobe_opcode_t is 4
>    bytes;

Hmm, this name looks no good because relative-jump itself always one instruction...
You'd better calc the size directly or it should be MAX_COPIED_INSNS.

>  - Removes size field in struct arch_optimized_insn;
> 
>  - Use arm_gen_branch() to generate branch instruction;
> 
>  - Remove all recover logic: ARM doesn't use tail buffer, no need
>    recover replaced instructions like x86;
> 
>  - Remove incorrect CONFIG_THUMB checking;
> 
>  - can_optimize() always returns true if address is well aligned;
> 
>  - Improve optimized_callback: using opt_pre_handler();
> 
>  - Bugfix: correct range checking code and improve comments;
> 
>  - Fix commit message.
> 
> Signed-off-by: Wang Nan <wangnan0@huawei.com>
> Cc: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
> Cc: Jon Medhurst (Tixy) <tixy@linaro.org>
> Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>

Mostly OK for me, and I've tested on my Cyclone-V SoC.
Just have some comment for simplifying the code.

[...]
> +int arch_check_optimized_kprobe(struct optimized_kprobe *op)
> +{
> +	int i;
> +	struct kprobe *p;
> +
> +	for (i = 1; i < RELATIVEJUMP_SIZE; i++) {
> +		p = get_kprobe(op->kp.addr + i);
> +		if (p && !kprobe_disabled(p))
> +			return -EEXIST;
> +	}
> +
> +	return 0;
> +}

Since the kprobes on arm32 is fixed and aligned and the current
arm32-optprobe modifies just ONE instruction, this also can
always return 0(no error). This checking routine is for the archs
which need to overwrite several instructions such as x86(CISC).


> +static int can_optimize(unsigned long paddr)
> +{
> +	/* we can always optimize a arm instruction */
> +	return ((paddr & 3) == 0);
> +}

Here, since the arch_prepare_kprobe() already checks alignment (see
"arch/arm/kernel/kprobes.c" line 83), you can always return 1.

> +
> +/* Free optimized instruction slot */
> +static
> +void __arch_remove_optimized_kprobe(struct optimized_kprobe *op, int dirty)
> +{
> +	if (op->optinsn.insn) {
> +		free_optinsn_slot(op->optinsn.insn, dirty);
> +		op->optinsn.insn = NULL;
> +	}
> +}
> +
> +extern void kprobe_handler(struct pt_regs *regs);
> +
> +static void
> +optimized_callback(struct optimized_kprobe *op, struct pt_regs *regs)
> +{
> +	unsigned long flags;
> +	struct kprobe *p = &op->kp;
> +	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
> +
> +	/* Save skipped registers */
> +	regs->ARM_pc = (unsigned long)op->kp.addr;
> +	regs->ARM_ORIG_r0 = ~0UL;
> +
> +	local_irq_save(flags);
> +
> +	if (kprobe_running()) {
> +		kprobes_inc_nmissed_count(&op->kp);
> +	} else {
> +		__this_cpu_write(current_kprobe, &op->kp);
> +		kcb->kprobe_status = KPROBE_HIT_ACTIVE;
> +		opt_pre_handler(&op->kp, regs);
> +		__this_cpu_write(current_kprobe, NULL);
> +	}
> +
> +	/* In each case, we must singlestep the replaced instruction. */
> +	op->kp.ainsn.insn_singlestep(p->opcode, &p->ainsn, regs);
> +
> +	local_irq_restore(flags);
> +}
> +
> +int arch_prepare_optimized_kprobe(struct optimized_kprobe *op)
> +{
> +	u8 *buf;
> +	unsigned long rel_chk;
> +	unsigned long val;
> +
> +	if (!can_optimize((unsigned long)op->kp.addr))
> +		return -EILSEQ;
> +
> +	op->optinsn.insn = get_optinsn_slot();
> +	if (!op->optinsn.insn)
> +		return -ENOMEM;
> +
> +	/*
> +	 * Verify if the address gap is in 32MiB range, because this uses
> +	 * a relative jump.
> +	 *
> +	 * kprobe opt use a 'b' instruction to branch to optinsn.insn.
> +	 * According to ARM manual, branch instruction is:
> +	 *
> +	 *   31  28 27           24 23             0
> +	 *  +------+---+---+---+---+----------------+
> +	 *  | cond | 1 | 0 | 1 | 0 |      imm24     |
> +	 *  +------+---+---+---+---+----------------+
> +	 *
> +	 * imm24 is a signed 24 bits integer. The real branch offset is computed
> +	 * by: imm32 = SignExtend(imm24:'00', 32);
> +	 *
> +	 * So the maximum forward branch should be:
> +	 *   (0x007fffff << 2) = 0x01fffffc =  0x1fffffc
> +	 * The maximum backword branch should be:
> +	 *   (0xff800000 << 2) = 0xfe000000 = -0x2000000
> +	 *
> +	 * We can simply check (rel & 0xfe000003):
> +	 *  if rel is positive, (rel & 0xfe000000) shoule be 0
> +	 *  if rel is negitive, (rel & 0xfe000000) should be 0xfe000000
> +	 *  the last '3' is used for alignment checking.
> +	 */
> +	rel_chk = (unsigned long)((long)op->optinsn.insn -
> +			(long)op->kp.addr + 8) & 0xfe000003;
> +
> +	if ((rel_chk != 0) && (rel_chk != 0xfe000000)) {
> +		__arch_remove_optimized_kprobe(op, 0);
> +		return -ERANGE;
> +	}
> +
> +	buf = (u8 *)op->optinsn.insn;
> +
> +	/* Copy arch-dep-instance from template */
> +	memcpy(buf, &optprobe_template_entry, TMPL_END_IDX);
> +
> +	/* Set probe information */
> +	val = (unsigned long)op;
> +	memcpy(buf + TMPL_VAL_IDX, &val, sizeof(val));
> +
> +	/* Set probe function call */
> +	val = (unsigned long)optimized_callback;
> +	memcpy(buf + TMPL_CALL_IDX, &val, sizeof(val));

Here, you must flush icache on buffer (this buffer can be reused) as below.

        flush_icache_range((unsigned long) buf,
                           (unsigned long) buf + TMPL_END_IDX);

Since the arm32-optprobe emulates copied instruction, it doesn't have a
tail buffer, but the body should be cared.

> +	return 0;
> +}
> +
> +void arch_optimize_kprobes(struct list_head *oplist)
> +{
> +	struct optimized_kprobe *op, *tmp;
> +
> +	list_for_each_entry_safe(op, tmp, oplist, list) {
> +		unsigned long insn;
> +		WARN_ON(kprobe_disabled(&op->kp));
> +
> +		/*
> +		 * Backup instructions which will be replaced
> +		 * by jump address
> +		 */
> +		memcpy(op->optinsn.copied_insn, op->kp.addr,
> +				RELATIVEJUMP_SIZE);
> +
> +		insn = arm_gen_branch((unsigned long)op->kp.addr,
> +				(unsigned long)op->optinsn.insn);
> +		BUG_ON(insn == 0);
> +
> +		/*
> +		 * Make it a conditional branch if replaced insn
> +		 * is consitional
> +		 */
> +		insn = (op->optinsn.copied_insn[0] & 0xf0000000) |
> +			(insn & 0x0fffffff);
> +
> +		patch_text(op->kp.addr, insn);
> +
> +		list_del_init(&op->list);
> +	}
> +	return;

You don't need this return; for void functions.

> +}
> +
> +void arch_unoptimize_kprobe(struct optimized_kprobe *op)
> +{
> +	arch_arm_kprobe(&op->kp);
> +	return;

Here too. :)

> +}
> +
> +/*
> + * Recover original instructions and breakpoints from relative jumps.
> + * Caller must call with locking kprobe_mutex.
> + */
> +void arch_unoptimize_kprobes(struct list_head *oplist,
> + 			    struct list_head *done_list)
> +{
> +	struct optimized_kprobe *op, *tmp;
> +
> +	list_for_each_entry_safe(op, tmp, oplist, list) {
> +		arch_unoptimize_kprobe(op);
> +		list_move(&op->list, done_list);
> +	}
> +}
> +
> +int arch_within_optimized_kprobe(struct optimized_kprobe *op,
> + 				unsigned long addr)
> +{
> +	return ((unsigned long)op->kp.addr <= addr &&
> +		(unsigned long)op->kp.addr + RELATIVEJUMP_SIZE > addr);
> +}
> +
> +void arch_remove_optimized_kprobe(struct optimized_kprobe *op)
> +{
> +	__arch_remove_optimized_kprobe(op, 1);
> +}
> 

Thank you!


-- 
Masami HIRAMATSU
Software Platform Research Dept. Linux Technology Research Center
Hitachi, Ltd., Yokohama Research Laboratory
E-mail: masami.hiramatsu.pt at hitachi.com
