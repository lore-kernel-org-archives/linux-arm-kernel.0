From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Mon, 27 Oct 2014 17:17:39 +0000
Subject: [PATCH v6 0/7] ARM: kprobes: enable OPTPROBES for ARM 32.
In-Reply-To: <544B7228.9050200@huawei.com>
References: <1413977525-51480-1-git-send-email-wangnan0@huawei.com>
 <5449A2BB.1020207@hitachi.com> <1414141323.1441.1.camel@linaro.org>
 <544B7228.9050200@huawei.com>
Message-ID: <1414430259.1430.9.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2014-10-25 at 17:49 +0800, Wang Nan wrote:
[...]
> Anyway, I have done the separation. Please refer to:
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-October/297031.html
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-October/297036.html
> 
> There is a big change in checker code in the first thread. Please help me review
> whether checker is acceptable.

I had started reviewing the previous version, I'll switch to the new
one.

I do prefer the new checker code better, and the only obvious
alternative I can think off would be to break down the decoding tables
into a lot more special cases of instruction forms, which I isn't as
scalable, so I don't like that idea.

However, I wonder if there is scope for the checker functions to
recursively call probes_decode_insn rather than decoding instructions in
C code. I don't know if that would be clearer and/or smaller or not.

Below is something I've just thrown together to get a feel of how it
could look. The decode table could possibly incorporate patterns to
cover instructions types that you split up in PATCH 1, e.g. so we might
not need separate PROBES_STORE and PROBES_STORE_EXTRA (depends if that
ends up making things simpler or not)...


int stack_use_none(probes_opcode_t insn,
		       struct arch_probes_insn *asi,
		       const struct decode_header *h)
{
	asi->stack_space = 0;
	return INSN_GOOD_NO_SLOT;
}

int stack_use_unknown(probes_opcode_t insn,
		       struct arch_probes_insn *asi,
		       const struct decode_header *h)
{
	asi->stack_space = -1;
	return INSN_GOOD_NO_SLOT;
}

int stack_use_imm_x0x(probes_opcode_t insn,
		       struct arch_probes_insn *asi,
		       const struct decode_header *h)
{
	asi->stack_space = ((insn & 0xf00) >> 4) + (insn & 0xf);
	return INSN_GOOD_NO_SLOT;
}

int stack_use_imm_xxx(probes_opcode_t insn,
		       struct arch_probes_insn *asi,
		       const struct decode_header *h)
{
	asi->stack_space = insn & 0xfff;
	return INSN_GOOD_NO_SLOT;
}

enum {
	STACK_USE_NONE,
	STACK_USE_UNKNOWN,
	STACK_USE_FIXED_X0X,
	STACK_USE_FIXED_XXX,
	NUM_STACK_USE_TYPES
};

static const union decode_action chk_stack_actions[] = {
	[STACK_USE_NONE] = {.handler = stack_use_none},
	[STACK_USE_UNKNOWN] = {.handler = stack_use_unknown},
	[STACK_USE_FIXED_X0X] = {.handler = stack_use_imm_x0x}
	[STACK_USE_FIXED_XXX] = {.handler = stack_use_imm_xxx}
}

enum probes_insn __kprobes chk_stack_use_arm(probes_opcode_t insn,
		       struct arch_probes_insn *asi,
		       const struct decode_header *h)
{
	static const union decode_item table[] = {
		/* Register indexed addressing modes with SP as index register (!)*/
		DECODE_OR	(0x0040000d, 0x0000000d),
		/* Register indexed addressing modes with SP as base register */
		DECODE_CUSTOM	(0x004f0000, 0x000d0000, STACK_USE_UNKOWN,
							 REGS(0, 0, 0, 0, 0)),

		/* STR{,B} with immediate pre-indexed addressing mode with SP base address */
		DECODE_CUSTOM	(0x05cf0000, 0x054d0000, STACK_USE_FIXED_XXX,
							 REGS(0, 0, 0, 0, 0)),

		/* STR{H,D} with immediate pre-indexed addressing mode with SP base address */
		DECODE_CUSTOM	(0x05cf0000, 0x014d0000, STACK_USE_FIXED_X0X,
							 REGS(0, 0, 0, 0, 0)),

		... other rules here, possibly including ...
		... REGS values like 'NOSP' to reject certain forms ...

		/* Catch all remaining cases */
		DECODE_CUSTOM	(0, 0, STACK_USE_NONE, REGS(0, 0, 0, 0, 0))
	}

	return probes_decode_insn(insn, asi, table, false, false, chk_stack_actions, NULL);
}

And in the dubious case that anyone wants to copy any of the above, it's
Signed-off-by: Jon Medhurst <tixy@linaro.org>

-- 
Tixy
