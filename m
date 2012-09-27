From: will.deacon@arm.com (Will Deacon)
Date: Thu, 27 Sep 2012 16:11:08 +0100
Subject: [PATCH 14/15] KVM: ARM: Handle I/O aborts
In-Reply-To: <20120915153559.21241.29970.stgit@ubuntu>
References: <20120915153359.21241.86002.stgit@ubuntu>
 <20120915153559.21241.29970.stgit@ubuntu>
Message-ID: <20120927151108.GM25916@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 15, 2012 at 04:35:59PM +0100, Christoffer Dall wrote:
> When the guest accesses I/O memory this will create data abort
> exceptions and they are handled by decoding the HSR information
> (physical address, read/write, length, register) and forwarding reads
> and writes to QEMU which performs the device emulation.
> 
> Certain classes of load/store operations do not support the syndrome
> information provided in the HSR and we therefore must be able to fetch
> the offending instruction from guest memory and decode it manually.
> 
> We only support instruction decoding for valid reasonable MMIO operations
> where trapping them do not provide sufficient information in the HSR (no
> 16-bit Thumb instructions provide register writeback that we care about).
> 
> The following instruciton types are NOT supported for MMIO operations
> despite the HSR not containing decode info:
>  - any Load/Store multiple
>  - any load/store exclusive
>  - any load/store dual
>  - anything with the PC as the dest register

[...]

> +
> +/******************************************************************************
> + * Load-Store instruction emulation
> + *****************************************************************************/
> +
> +/*
> + * Must be ordered with LOADS first and WRITES afterwards
> + * for easy distinction when doing MMIO.
> + */
> +#define NUM_LD_INSTR  9
> +enum INSTR_LS_INDEXES {
> +       INSTR_LS_LDRBT, INSTR_LS_LDRT, INSTR_LS_LDR, INSTR_LS_LDRB,
> +       INSTR_LS_LDRD, INSTR_LS_LDREX, INSTR_LS_LDRH, INSTR_LS_LDRSB,
> +       INSTR_LS_LDRSH,
> +       INSTR_LS_STRBT, INSTR_LS_STRT, INSTR_LS_STR, INSTR_LS_STRB,
> +       INSTR_LS_STRD, INSTR_LS_STREX, INSTR_LS_STRH,
> +       NUM_LS_INSTR
> +};
> +
> +static u32 ls_instr[NUM_LS_INSTR][2] = {
> +       {0x04700000, 0x0d700000}, /* LDRBT */
> +       {0x04300000, 0x0d700000}, /* LDRT  */
> +       {0x04100000, 0x0c500000}, /* LDR   */
> +       {0x04500000, 0x0c500000}, /* LDRB  */
> +       {0x000000d0, 0x0e1000f0}, /* LDRD  */
> +       {0x01900090, 0x0ff000f0}, /* LDREX */
> +       {0x001000b0, 0x0e1000f0}, /* LDRH  */
> +       {0x001000d0, 0x0e1000f0}, /* LDRSB */
> +       {0x001000f0, 0x0e1000f0}, /* LDRSH */
> +       {0x04600000, 0x0d700000}, /* STRBT */
> +       {0x04200000, 0x0d700000}, /* STRT  */
> +       {0x04000000, 0x0c500000}, /* STR   */
> +       {0x04400000, 0x0c500000}, /* STRB  */
> +       {0x000000f0, 0x0e1000f0}, /* STRD  */
> +       {0x01800090, 0x0ff000f0}, /* STREX */
> +       {0x000000b0, 0x0e1000f0}  /* STRH  */
> +};
> +
> +static inline int get_arm_ls_instr_index(u32 instr)
> +{
> +       return kvm_instr_index(instr, ls_instr, NUM_LS_INSTR);
> +}
> +
> +/*
> + * Load-Store instruction decoding
> + */
> +#define INSTR_LS_TYPE_BIT              26
> +#define INSTR_LS_RD_MASK               0x0000f000
> +#define INSTR_LS_RD_SHIFT              12
> +#define INSTR_LS_RN_MASK               0x000f0000
> +#define INSTR_LS_RN_SHIFT              16
> +#define INSTR_LS_RM_MASK               0x0000000f
> +#define INSTR_LS_OFFSET12_MASK         0x00000fff

I'm afraid you're not going to thank me much for this, but it's high time we
unified the various instruction decoding functions we have under arch/arm/
and this seems like a good opportunity for that. For example, look at the
following snippets (there is much more in the files I list) in addition to
what you have:


asm/ptrace.h
-------------
#define PSR_T_BIT	0x00000020
#define PSR_F_BIT	0x00000040
#define PSR_I_BIT	0x00000080
#define PSR_A_BIT	0x00000100
#define PSR_E_BIT	0x00000200
#define PSR_J_BIT	0x01000000
#define PSR_Q_BIT	0x08000000
#define PSR_V_BIT	0x10000000
#define PSR_C_BIT	0x20000000
#define PSR_Z_BIT	0x40000000
#define PSR_N_BIT	0x80000000

mm/alignment.c
--------------
#define LDST_I_BIT(i)	(i & (1 << 26))		/* Immediate constant	*/
#define LDST_P_BIT(i)	(i & (1 << 24))		/* Preindex		*/
#define LDST_U_BIT(i)	(i & (1 << 23))		/* Add offset		*/
#define LDST_W_BIT(i)	(i & (1 << 21))		/* Writeback		*/
#define LDST_L_BIT(i)	(i & (1 << 20))		/* Load			*/

kernel/kprobes*.c
-----------------
static void __kprobes
emulate_ldr(struct kprobe *p, struct pt_regs *regs)
{
	kprobe_opcode_t insn = p->opcode;
	unsigned long pc = (unsigned long)p->addr + 8;
	int rt = (insn >> 12) & 0xf;
	int rn = (insn >> 16) & 0xf;
	int rm = insn & 0xf;

kernel/opcodes.c
----------------
static const unsigned short cc_map[16] = {
	0xF0F0,			/* EQ == Z set            */
	0x0F0F,			/* NE                     */
	0xCCCC,			/* CS == C set            */
	0x3333,			/* CC                     */
	0xFF00,			/* MI == N set            */
	0x00FF,			/* PL                     */
	0xAAAA,			/* VS == V set            */
	0x5555,			/* VC                     */
	0x0C0C,			/* HI == C set && Z clear */
	0xF3F3,			/* LS == C clear || Z set */
	0xAA55,			/* GE == (N==V)           */
	0x55AA,			/* LT == (N!=V)           */
	0x0A05,			/* GT == (!Z && (N==V))   */
	0xF5FA,			/* LE == (Z || (N!=V))    */
	0xFFFF,			/* AL always              */
	0			/* NV                     */
};

kernel/swp_emulate.c
--------------------
#define EXTRACT_REG_NUM(instruction, offset) \
	(((instruction) & (0xf << (offset))) >> (offset))
#define RN_OFFSET  16
#define RT_OFFSET  12
#define RT2_OFFSET  0


There are also bits and pieces with the patching frameworks and module
relocations that could benefit from some code sharing. Now, I think Dave had
some ideas about moving a load of this code into a common disassembler under
arch/arm/ so it would be great to tie that in here and implement that for
load/store instructions. Then other users can augment the number of
supported instruction classes as and when it is required.

Will
