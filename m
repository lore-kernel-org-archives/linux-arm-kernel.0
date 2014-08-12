From: wangnan0@huawei.com (Wang Nan)
Date: Tue, 12 Aug 2014 21:03:02 +0800
Subject: [PATCH v4] kprobes: arm: enable OPTPROBES for ARM 32
In-Reply-To: <1407819388-52145-1-git-send-email-wangnan0@huawei.com>
References: <1407819388-52145-1-git-send-email-wangnan0@huawei.com>
Message-ID: <53EA1086.4010606@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Masami and everyone,

When checking my code I found a problem: if we replace a stack operatinon instruction,
it is possible that the emulate execution of such instruction destroy the stack used
by kprobeopt:

> +
> +asm (
> +			".global optprobe_template_entry\n"
> +			"optprobe_template_entry:\n"
> +			"	sub	sp, sp, #80\n"
> +			"	stmia	sp, {r0 - r14} \n"

Here, trampoline code sub sp with 80 (0x50, I choose this number without much thinking), and then
use stmia to push r0 - r14 (registers except pc) onto the stack. Assume the original sp is
0xd0000050, the stack becomes:

0xd0000000: r0
0xd0000004: r1
0xd0000008: r2
...
0xd0000038: r14
0xd000003c: r15 (place holder)
0xd0000040: cpsr (place holder)
0xd0000044: ?
0xd0000048: ?
0xd000004c: ?
0xd0000050: original stack

If the replaced code operates stack, for example, push {r0 - r10}, it will overwrite our register.
For that reason, sub sp, #80 is not enough, we need at least 64 bytes stack space, so the first instruction
here should be sub sp, #128.

However, it increase stack requirement. Moreover, although rare, there may be sp relative addressing,
such as: str r1, [sp, #-132].

To make every situations safe, do you think we need to alloc a pre-cpu optprobe private stack?

For example:

str sp, [pc, #??]     (store original sp first)
ldr sp, [pc, #??]     (load pre-cpu stack)
sub sp, #68
stmia	sp, {r0 - r12}
...                   (fix sp and pc in stack)
ldmia   sp, {r0 - r15}
optprobe_template_sp:
1: .long 0          (placeholder for saved sp)
optprobe_template_private_stack:
2: .long 0          (placeholder for per-cpu private stack)
optprobe_template_pc:
3: .long 0          (placeholder for pc)

> +			"	add	r3, sp, #80\n"
> +			"	str	r3, [sp, #52]\n"
> +			"	mrs	r4, cpsr\n"
> +			"	str	r4, [sp, #64]\n"
> +			"	mov	r1, sp\n"
> +			"	ldr	r0, 1f\n"
> +			"	ldr	r2, 2f\n"
> +			"	blx	r2\n"
> +			"	ldr	r1, [sp, #64]\n"
> +			"	msr	cpsr_fs, r1\n"
> +			"	ldmia	sp, {r0 - r15}\n"
> +			".global optprobe_template_val\n"
> +			"optprobe_template_val:\n"
> +			"1:	.long 0\n"
> +			".global optprobe_template_call\n"
> +			"optprobe_template_call:\n"
> +			"2:	.long 0\n"
> +			".global optprobe_template_end\n"
> +			"optprobe_template_end:\n");
> +
