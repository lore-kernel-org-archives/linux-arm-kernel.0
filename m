From: tixy@yxit.co.uk (Tixy)
Date: Sat,  9 Jul 2011 11:57:06 +0100
Subject: [PATCH 19/51] ARM: kprobes: Infrastructure for table driven decoding
	of CPU instructions
In-Reply-To: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
References: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1310209058-20980-20-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

The existing ARM instruction decoding functions are a mass of if/else
code. Rather than follow this pattern for Thumb instruction decoding
this patch implements an infrastructure for a new table driven scheme.

This has several advantages:

- Reduces the kernel size by approx 2kB. (The ARM instruction decoding
  will eventually have -3.1kB code, +1.3kB data; with similar or better
  estimated savings for Thumb decoding.)

- Allows programmatic checking of decoding consistency and test case
  coverage.

- Provides more uniform source code and is therefore, arguably, clearer.

For a detailed explanation of how decoding tables work see the in-source
documentation in kprobes.h, and also for kprobe_decode_insn().

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes.h        |  248 ++++++++++++++++++++++++++++++++++++-
 arch/arm/kernel/kprobes-common.c |  258 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 505 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/kprobes.h b/arch/arm/kernel/kprobes.h
index e3803c6..c00681c 100644
--- a/arch/arm/kernel/kprobes.h
+++ b/arch/arm/kernel/kprobes.h
@@ -1,7 +1,9 @@
 /*
  * arch/arm/kernel/kprobes.h
  *
- * Contents moved from arch/arm/include/asm/kprobes.h which is
+ * Copyright (C) 2011 Jon Medhurst <tixy@yxit.co.uk>.
+ *
+ * Some contents moved here from arch/arm/include/asm/kprobes.h which is
  * Copyright (C) 2006, 2007 Motorola Inc.
  *
  * This program is free software; you can redistribute it and/or modify
@@ -99,4 +101,248 @@ static inline unsigned long it_advance(unsigned long cpsr)
  */
 #define is_writeback(insn) ((insn ^ 0x01000000) & 0x01200000)
 
+/*
+ * The following definitions and macros are used to build instruction
+ * decoding tables for use by kprobe_decode_insn.
+ *
+ * These tables are a concatenation of entries each of which consist of one of
+ * the decode_* structs. All of the fields in every type of decode structure
+ * are of the union type decode_item, therefore the entire decode table can be
+ * viewed as an array of these and declared like:
+ *
+ *	static const union decode_item table_name[] = {};
+ *
+ * In order to construct each entry in the table, macros are used to
+ * initialise a number of sequential decode_item values in a layout which
+ * matches the relevant struct. E.g. DECODE_SIMULATE initialise a struct
+ * decode_simulate by initialising four decode_item objects like this...
+ *
+ *	{.bits = _type},
+ *	{.bits = _mask},
+ *	{.bits = _value},
+ *	{.handler = _handler},
+ *
+ * Initialising a specified member of the union means that the compiler
+ * will produce a warning if the argument is of an incorrect type.
+ *
+ * Below is a list of each of the macros used to initialise entries and a
+ * description of the action performed when that entry is matched to an
+ * instruction. A match is found when (instruction & mask) == value.
+ *
+ * DECODE_TABLE(mask, value, table)
+ *	Instruction decoding jumps to parsing the new sub-table 'table'.
+ *
+ * DECODE_CUSTOM(mask, value, decoder)
+ *	The custom function 'decoder' is called to the complete decoding
+ *	of an instruction.
+ *
+ * DECODE_SIMULATE(mask, value, handler)
+ *	Set the probes instruction handler to 'handler', this will be used
+ *	to simulate the instruction when the probe is hit. Decoding returns
+ *	with INSN_GOOD_NO_SLOT.
+ *
+ * DECODE_EMULATE(mask, value, handler)
+ *	Set the probes instruction handler to 'handler', this will be used
+ *	to emulate the instruction when the probe is hit. The modified
+ *	instruction (see below) is placed in the probes instruction slot so it
+ *	may be called by the emulation code. Decoding returns with INSN_GOOD.
+ *
+ * DECODE_REJECT(mask, value)
+ *	Instruction decoding fails with INSN_REJECTED
+ *
+ * DECODE_OR(mask, value)
+ *	This allows the mask/value test of multiple table entries to be
+ *	logically ORed. Once an 'or' entry is matched the decoding action to
+ *	be performed is that of the next entry which isn't an 'or'. E.g.
+ *
+ *		DECODE_OR	(mask1, value1)
+ *		DECODE_OR	(mask2, value2)
+ *		DECODE_SIMULATE	(mask3, value3, simulation_handler)
+ *
+ *	This means that if any of the three mask/value pairs match the
+ *	instruction being decoded, then 'simulation_handler' will be used
+ *	for it.
+ *
+ * Both the SIMULATE and EMULATE macros have a second form which take an
+ * additional 'regs' argument.
+ *
+ *	DECODE_SIMULATEX(mask, value, handler, regs)
+ *	DECODE_EMULATEX	(mask, value, handler, regs)
+ *
+ * These are used to specify what kind of CPU register is encoded in each of the
+ * least significant 5 nibbles of the instruction being decoded. The regs value
+ * is specified using the REGS macro, this takes any of the REG_TYPE_* values
+ * from enum decode_reg_type as arguments; only the '*' part of the name is
+ * given. E.g.
+ *
+ *	REGS(0, ANY, NOPC, 0, ANY)
+ *
+ * This indicates an instruction is encoded like:
+ *
+ *	bits 19..16	ignore
+ *	bits 15..12	any register allowed here
+ *	bits 11.. 8	any register except PC allowed here
+ *	bits  7.. 4	ignore
+ *	bits  3.. 0	any register allowed here
+ *
+ * This register specification is checked after a decode table entry is found to
+ * match an instruction (through the mask/value test). Any invalid register then
+ * found in the instruction will cause decoding to fail with INSN_REJECTED. In
+ * the above example this would happen if bits 11..8 of the instruction were
+ * 1111, indicating R15 or PC.
+ *
+ * As well as checking for legal combinations of registers, this data is also
+ * used to modify the registers encoded in the instructions so that an
+ * emulation routines can use it. (See decode_regs() and INSN_NEW_BITS.)
+ *
+ * Here is a real example which matches ARM instructions of the form
+ * "AND <Rd>,<Rn>,<Rm>,<shift> <Rs>"
+ *
+ *	DECODE_EMULATEX	(0x0e000090, 0x00000010, emulate_rd12rn16rm0rs8_rwflags,
+ *						 REGS(ANY, ANY, NOPC, 0, ANY)),
+ *						      ^    ^    ^        ^
+ *						      Rn   Rd   Rs       Rm
+ *
+ * Decoding the instruction "AND R4, R5, R6, ASL R15" will be rejected because
+ * Rs == R15
+ *
+ * Decoding the instruction "AND R4, R5, R6, ASL R7" will be accepted and the
+ * instruction will be modified to "AND R0, R2, R3, ASL R1" and then placed into
+ * the kprobes instruction slot. This can then be called later by the handler
+ * function emulate_rd12rn16rm0rs8_rwflags in order to simulate the instruction.
+ */
+
+enum decode_type {
+	DECODE_TYPE_END,
+	DECODE_TYPE_TABLE,
+	DECODE_TYPE_CUSTOM,
+	DECODE_TYPE_SIMULATE,
+	DECODE_TYPE_EMULATE,
+	DECODE_TYPE_OR,
+	DECODE_TYPE_REJECT,
+	NUM_DECODE_TYPES /* Must be last enum */
+};
+
+#define DECODE_TYPE_BITS	4
+#define DECODE_TYPE_MASK	((1 << DECODE_TYPE_BITS) - 1)
+
+enum decode_reg_type {
+	REG_TYPE_NONE = 0, /* Not a register, ignore */
+	REG_TYPE_ANY,	   /* Any register allowed */
+	REG_TYPE_SAMEAS16, /* Register should be same as that@bits 19..16 */
+	REG_TYPE_SP,	   /* Register must be SP */
+	REG_TYPE_PC,	   /* Register must be PC */
+	REG_TYPE_NOSP,	   /* Register must not be SP */
+	REG_TYPE_NOSPPC,   /* Register must not be SP or PC */
+	REG_TYPE_NOPC,	   /* Register must not be PC */
+	REG_TYPE_NOPCWB,   /* No PC if load/store write-back flag also set */
+
+	/* The following types are used when the encoding for PC indicates
+	 * another instruction form. This distiction only matters for test
+	 * case coverage checks.
+	 */
+	REG_TYPE_NOPCX,	   /* Register must not be PC */
+	REG_TYPE_NOSPPCX,  /* Register must not be SP or PC */
+
+	/* Alias to allow '0' arg to be used in REGS macro. */
+	REG_TYPE_0 = REG_TYPE_NONE
+};
+
+#define REGS(r16, r12, r8, r4, r0)	\
+	((REG_TYPE_##r16) << 16) +	\
+	((REG_TYPE_##r12) << 12) +	\
+	((REG_TYPE_##r8) << 8) +	\
+	((REG_TYPE_##r4) << 4) +	\
+	(REG_TYPE_##r0)
+
+union decode_item {
+	u32			bits;
+	const union decode_item	*table;
+	kprobe_insn_handler_t	*handler;
+	kprobe_decode_insn_t	*decoder;
+};
+
+
+#define DECODE_END			\
+	{.bits = DECODE_TYPE_END}
+
+
+struct decode_header {
+	union decode_item	type_regs;
+	union decode_item	mask;
+	union decode_item	value;
+};
+
+#define DECODE_HEADER(_type, _mask, _value, _regs)		\
+	{.bits = (_type) | ((_regs) << DECODE_TYPE_BITS)},	\
+	{.bits = (_mask)},					\
+	{.bits = (_value)}
+
+
+struct decode_table {
+	struct decode_header	header;
+	union decode_item	table;
+};
+
+#define DECODE_TABLE(_mask, _value, _table)			\
+	DECODE_HEADER(DECODE_TYPE_TABLE, _mask, _value, 0),	\
+	{.table = (_table)}
+
+
+struct decode_custom {
+	struct decode_header	header;
+	union decode_item	decoder;
+};
+
+#define DECODE_CUSTOM(_mask, _value, _decoder)			\
+	DECODE_HEADER(DECODE_TYPE_CUSTOM, _mask, _value, 0),	\
+	{.decoder = (_decoder)}
+
+
+struct decode_simulate {
+	struct decode_header	header;
+	union decode_item	handler;
+};
+
+#define DECODE_SIMULATEX(_mask, _value, _handler, _regs)		\
+	DECODE_HEADER(DECODE_TYPE_SIMULATE, _mask, _value, _regs),	\
+	{.handler = (_handler)}
+
+#define DECODE_SIMULATE(_mask, _value, _handler)	\
+	DECODE_SIMULATEX(_mask, _value, _handler, 0)
+
+
+struct decode_emulate {
+	struct decode_header	header;
+	union decode_item	handler;
+};
+
+#define DECODE_EMULATEX(_mask, _value, _handler, _regs)			\
+	DECODE_HEADER(DECODE_TYPE_EMULATE, _mask, _value, _regs),	\
+	{.handler = (_handler)}
+
+#define DECODE_EMULATE(_mask, _value, _handler)		\
+	DECODE_EMULATEX(_mask, _value, _handler, 0)
+
+
+struct decode_or {
+	struct decode_header	header;
+};
+
+#define DECODE_OR(_mask, _value)				\
+	DECODE_HEADER(DECODE_TYPE_OR, _mask, _value, 0)
+
+
+struct decode_reject {
+	struct decode_header	header;
+};
+
+#define DECODE_REJECT(_mask, _value)				\
+	DECODE_HEADER(DECODE_TYPE_REJECT, _mask, _value, 0)
+
+
+int kprobe_decode_insn(kprobe_opcode_t insn, struct arch_specific_insn *asi,
+			const union decode_item *table, bool thumb16);
+
+
 #endif /* _ARM_KERNEL_KPROBES_H */
diff --git a/arch/arm/kernel/kprobes-common.c b/arch/arm/kernel/kprobes-common.c
index 87e91ce..4074806 100644
--- a/arch/arm/kernel/kprobes-common.c
+++ b/arch/arm/kernel/kprobes-common.c
@@ -140,3 +140,261 @@ kprobe_check_cc * const kprobe_condition_checks[16] = {
 	&__check_hi, &__check_ls, &__check_ge, &__check_lt,
 	&__check_gt, &__check_le, &__check_al, &__check_al
 };
+
+
+/*
+ * Prepare an instruction slot to receive an instruction for emulating.
+ * This is done by placing a subroutine return after the location where the
+ * instruction will be placed. We also modify ARM instructions to be
+ * unconditional as the condition code will already be checked before any
+ * emulation handler is called.
+ */
+static kprobe_opcode_t __kprobes
+prepare_emulated_insn(kprobe_opcode_t insn, struct arch_specific_insn *asi,
+								bool thumb)
+{
+#ifdef CONFIG_THUMB2_KERNEL
+	if (thumb) {
+		u16* thumb_insn = (u16 *)asi->insn;
+		thumb_insn[1] = 0x4770; /* Thumb bx lr */
+		thumb_insn[2] = 0x4770; /* Thumb bx lr */
+		return insn;
+	}
+	asi->insn[1] = 0xe12fff1e; /* ARM bx lr */
+#else
+	asi->insn[1] = 0xe1a0f00e; /* mov pc, lr */
+#endif
+	/* Make an ARM instructional unconditional */
+	if (insn < 0xe0000000)
+		insn = (insn | 0xe0000000) & ~0x10000000;
+	return insn;
+}
+
+/*
+ * Write a (probably modified) instruction into the slot previously prepared by
+ * prepare_emulated_insn
+ */
+static void  __kprobes
+set_emulated_insn(kprobe_opcode_t insn, struct arch_specific_insn *asi,
+								bool thumb)
+{
+#ifdef CONFIG_THUMB2_KERNEL
+	if (thumb) {
+		u16 *ip = (u16 *)asi->insn;
+		if (is_wide_instruction(insn))
+			*ip++ = insn >> 16;
+		*ip++ = insn;
+		return;
+	}
+#endif
+	asi->insn[0] = insn;
+}
+
+/*
+ * When we modify the register numbers encoded in an instruction to be emulated,
+ * the new values come from this define. For ARM and 32-bit Thumb instructions
+ * this gives...
+ *
+ *	bit position	  16  12   8   4   0
+ *	---------------+---+---+---+---+---+
+ *	register	 r2  r0  r1  --  r3
+ */
+#define INSN_NEW_BITS		0x00020103
+
+/* Each nibble has same value as that at INSN_NEW_BITS bit 16 */
+#define INSN_SAMEAS16_BITS	0x22222222
+
+/*
+ * Validate and modify each of the registers encoded in an instruction.
+ *
+ * Each nibble in regs contains a value from enum decode_reg_type. For each
+ * non-zero value, the corresponding nibble in pinsn is validated and modified
+ * according to the type.
+ */
+static bool __kprobes decode_regs(kprobe_opcode_t* pinsn, u32 regs)
+{
+	kprobe_opcode_t insn = *pinsn;
+	kprobe_opcode_t mask = 0xf; /* Start at least significant nibble */
+
+	for (; regs != 0; regs >>= 4, mask <<= 4) {
+
+		kprobe_opcode_t new_bits = INSN_NEW_BITS;
+
+		switch (regs & 0xf) {
+
+		case REG_TYPE_NONE:
+			/* Nibble not a register, skip to next */
+			continue;
+
+		case REG_TYPE_ANY:
+			/* Any register is allowed */
+			break;
+
+		case REG_TYPE_SAMEAS16:
+			/* Replace register with same as@bit position 16 */
+			new_bits = INSN_SAMEAS16_BITS;
+			break;
+
+		case REG_TYPE_SP:
+			/* Only allow SP (R13) */
+			if ((insn ^ 0xdddddddd) & mask)
+				goto reject;
+			break;
+
+		case REG_TYPE_PC:
+			/* Only allow PC (R15) */
+			if ((insn ^ 0xffffffff) & mask)
+				goto reject;
+			break;
+
+		case REG_TYPE_NOSP:
+			/* Reject SP (R13) */
+			if (((insn ^ 0xdddddddd) & mask) == 0)
+				goto reject;
+			break;
+
+		case REG_TYPE_NOSPPC:
+		case REG_TYPE_NOSPPCX:
+			/* Reject SP and PC (R13 and R15) */
+			if (((insn ^ 0xdddddddd) & 0xdddddddd & mask) == 0)
+				goto reject;
+			break;
+
+		case REG_TYPE_NOPCWB:
+			if (!is_writeback(insn))
+				break; /* No writeback, so any register is OK */
+			/* fall through... */
+		case REG_TYPE_NOPC:
+		case REG_TYPE_NOPCX:
+			/* Reject PC (R15) */
+			if (((insn ^ 0xffffffff) & mask) == 0)
+				goto reject;
+			break;
+		}
+
+		/* Replace value of nibble with new register number... */
+		insn &= ~mask;
+		insn |= new_bits & mask;
+	}
+
+	*pinsn = insn;
+	return true;
+
+reject:
+	return false;
+}
+
+static const int decode_struct_sizes[NUM_DECODE_TYPES] = {
+	[DECODE_TYPE_TABLE]	= sizeof(struct decode_table),
+	[DECODE_TYPE_CUSTOM]	= sizeof(struct decode_custom),
+	[DECODE_TYPE_SIMULATE]	= sizeof(struct decode_simulate),
+	[DECODE_TYPE_EMULATE]	= sizeof(struct decode_emulate),
+	[DECODE_TYPE_OR]	= sizeof(struct decode_or),
+	[DECODE_TYPE_REJECT]	= sizeof(struct decode_reject)
+};
+
+/*
+ * kprobe_decode_insn operates on data tables in order to decode an ARM
+ * architecture instruction onto which a kprobe has been placed.
+ *
+ * These instruction decoding tables are a concatenation of entries each
+ * of which consist of one of the following structs:
+ *
+ *	decode_table
+ *	decode_custom
+ *	decode_simulate
+ *	decode_emulate
+ *	decode_or
+ *	decode_reject
+ *
+ * Each of these starts with a struct decode_header which has the following
+ * fields:
+ *
+ *	type_regs
+ *	mask
+ *	value
+ *
+ * The least significant DECODE_TYPE_BITS of type_regs contains a value
+ * from enum decode_type, this indicates which of the decode_* structs
+ * the entry contains. The value DECODE_TYPE_END indicates the end of the
+ * table.
+ *
+ * When the table is parsed, each entry is checked in turn to see if it
+ * matches the instruction to be decoded using the test:
+ *
+ *	(insn & mask) == value
+ *
+ * If no match is found before the end of the table is reached then decoding
+ * fails with INSN_REJECTED.
+ *
+ * When a match is found, decode_regs() is called to validate and modify each
+ * of the registers encoded in the instruction; the data it uses to do this
+ * is (type_regs >> DECODE_TYPE_BITS). A validation failure will cause decoding
+ * to fail with INSN_REJECTED.
+ *
+ * Once the instruction has passed the above tests, further processing
+ * depends on the type of the table entry's decode struct.
+ *
+ */
+int __kprobes
+kprobe_decode_insn(kprobe_opcode_t insn, struct arch_specific_insn *asi,
+				const union decode_item *table, bool thumb)
+{
+	const struct decode_header *h = (struct decode_header *)table;
+	const struct decode_header *next;
+	bool matched = false;
+
+	insn = prepare_emulated_insn(insn, asi, thumb);
+
+	for (;; h = next) {
+		enum decode_type type = h->type_regs.bits & DECODE_TYPE_MASK;
+		u32 regs = h->type_regs.bits >> DECODE_TYPE_BITS;
+
+		if (type == DECODE_TYPE_END)
+			return INSN_REJECTED;
+
+		next = (struct decode_header *)
+				((uintptr_t)h + decode_struct_sizes[type]);
+
+		if (!matched && (insn & h->mask.bits) != h->value.bits)
+			continue;
+
+		if (!decode_regs(&insn, regs))
+			return INSN_REJECTED;
+
+		switch (type) {
+
+		case DECODE_TYPE_TABLE: {
+			struct decode_table *d = (struct decode_table *)h;
+			next = (struct decode_header *)d->table.table;
+			break;
+		}
+
+		case DECODE_TYPE_CUSTOM: {
+			struct decode_custom *d = (struct decode_custom *)h;
+			return (*d->decoder.decoder)(insn, asi);
+		}
+
+		case DECODE_TYPE_SIMULATE: {
+			struct decode_simulate *d = (struct decode_simulate *)h;
+			asi->insn_handler = d->handler.handler;
+			return INSN_GOOD_NO_SLOT;
+		}
+
+		case DECODE_TYPE_EMULATE: {
+			struct decode_emulate *d = (struct decode_emulate *)h;
+			asi->insn_handler = d->handler.handler;
+			set_emulated_insn(insn, asi, thumb);
+			return INSN_GOOD;
+		}
+
+		case DECODE_TYPE_OR:
+			matched = true;
+			break;
+
+		case DECODE_TYPE_REJECT:
+		default:
+			return INSN_REJECTED;
+		}
+		}
+	}
-- 
1.7.2.5
