From: dave.martin@linaro.org (Dave Martin)
Date: Mon, 1 Oct 2012 13:53:26 +0100
Subject: [PATCH 14/15] KVM: ARM: Handle I/O aborts
In-Reply-To: <CANM98qKFKU98EWNaOepjxab3h5vQypxdt_YoJbKV9kd31XUfaw@mail.gmail.com>
References: <20120915153359.21241.86002.stgit@ubuntu>
 <20120915153559.21241.29970.stgit@ubuntu>
 <20120927151108.GM25916@mudshark.cambridge.arm.com>
 <CANM98qKFKU98EWNaOepjxab3h5vQypxdt_YoJbKV9kd31XUfaw@mail.gmail.com>
Message-ID: <20121001125326.GA2100@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 30, 2012 at 05:49:21PM -0400, Christoffer Dall wrote:
> On Thu, Sep 27, 2012 at 11:11 AM, Will Deacon <will.deacon@arm.com> wrote:
> > On Sat, Sep 15, 2012 at 04:35:59PM +0100, Christoffer Dall wrote:
> >> When the guest accesses I/O memory this will create data abort
> >> exceptions and they are handled by decoding the HSR information
> >> (physical address, read/write, length, register) and forwarding reads
> >> and writes to QEMU which performs the device emulation.
> >>
> >> Certain classes of load/store operations do not support the syndrome
> >> information provided in the HSR and we therefore must be able to fetch
> >> the offending instruction from guest memory and decode it manually.
> >>
> >> We only support instruction decoding for valid reasonable MMIO operations
> >> where trapping them do not provide sufficient information in the HSR (no
> >> 16-bit Thumb instructions provide register writeback that we care about).
> >>
> >> The following instruciton types are NOT supported for MMIO operations
> >> despite the HSR not containing decode info:
> >>  - any Load/Store multiple
> >>  - any load/store exclusive
> >>  - any load/store dual
> >>  - anything with the PC as the dest register
> >
> > [...]
> >
> >> +
> >> +/******************************************************************************
> >> + * Load-Store instruction emulation
> >> + *****************************************************************************/
> >> +
> >> +/*
> >> + * Must be ordered with LOADS first and WRITES afterwards
> >> + * for easy distinction when doing MMIO.
> >> + */
> >> +#define NUM_LD_INSTR  9
> >> +enum INSTR_LS_INDEXES {
> >> +       INSTR_LS_LDRBT, INSTR_LS_LDRT, INSTR_LS_LDR, INSTR_LS_LDRB,
> >> +       INSTR_LS_LDRD, INSTR_LS_LDREX, INSTR_LS_LDRH, INSTR_LS_LDRSB,
> >> +       INSTR_LS_LDRSH,
> >> +       INSTR_LS_STRBT, INSTR_LS_STRT, INSTR_LS_STR, INSTR_LS_STRB,
> >> +       INSTR_LS_STRD, INSTR_LS_STREX, INSTR_LS_STRH,
> >> +       NUM_LS_INSTR
> >> +};
> >> +
> >> +static u32 ls_instr[NUM_LS_INSTR][2] = {
> >> +       {0x04700000, 0x0d700000}, /* LDRBT */
> >> +       {0x04300000, 0x0d700000}, /* LDRT  */
> >> +       {0x04100000, 0x0c500000}, /* LDR   */
> >> +       {0x04500000, 0x0c500000}, /* LDRB  */
> >> +       {0x000000d0, 0x0e1000f0}, /* LDRD  */
> >> +       {0x01900090, 0x0ff000f0}, /* LDREX */
> >> +       {0x001000b0, 0x0e1000f0}, /* LDRH  */
> >> +       {0x001000d0, 0x0e1000f0}, /* LDRSB */
> >> +       {0x001000f0, 0x0e1000f0}, /* LDRSH */
> >> +       {0x04600000, 0x0d700000}, /* STRBT */
> >> +       {0x04200000, 0x0d700000}, /* STRT  */
> >> +       {0x04000000, 0x0c500000}, /* STR   */
> >> +       {0x04400000, 0x0c500000}, /* STRB  */
> >> +       {0x000000f0, 0x0e1000f0}, /* STRD  */
> >> +       {0x01800090, 0x0ff000f0}, /* STREX */
> >> +       {0x000000b0, 0x0e1000f0}  /* STRH  */
> >> +};
> >> +
> >> +static inline int get_arm_ls_instr_index(u32 instr)
> >> +{
> >> +       return kvm_instr_index(instr, ls_instr, NUM_LS_INSTR);
> >> +}
> >> +
> >> +/*
> >> + * Load-Store instruction decoding
> >> + */
> >> +#define INSTR_LS_TYPE_BIT              26
> >> +#define INSTR_LS_RD_MASK               0x0000f000
> >> +#define INSTR_LS_RD_SHIFT              12
> >> +#define INSTR_LS_RN_MASK               0x000f0000
> >> +#define INSTR_LS_RN_SHIFT              16
> >> +#define INSTR_LS_RM_MASK               0x0000000f
> >> +#define INSTR_LS_OFFSET12_MASK         0x00000fff
> >
> > I'm afraid you're not going to thank me much for this, but it's high time we
> > unified the various instruction decoding functions we have under arch/arm/
> > and this seems like a good opportunity for that. For example, look at the
> > following snippets (there is much more in the files I list) in addition to
> > what you have:
> >
> 
> I think it would be great if we had a set of unified decoding functions!
> 
> However, I think it's a shame if we can't merge KVM because we want to
> clean up this code. There would be nothing in the way of breaking API
> or anything like that preventing us from cleaning this up after the
> code has been merged.
> 
> Please consider reviewing the code for correctness and consider if the
> code could be merged as is.
> 
> On the other hand, if you or Dave or anyone else wants to create a set
> of patches that cleans this up in a timely manner, I will be happy to
> merge them for my code as well ;)

The time I would have available to put into this is rather limited, but
I have some initial ideas, as outlined below.

Tixy (who did the kprobes implementation, which is probably the most
sophisticated opcode handling we have in the kernel right now) may have
ideas too.  I would hope that any common framework could reuse a fair
chunk of his implementation and test coverage.



I think that a common framework would have to start out a lot more
generic that the special-purpose code in current subsystems, at least
initially.  We should try to move all the knowledge about how
instructions are encoded out of subsystems and into the common
framework, so far as possible.


We might end up with an interface like this:

Instruction data in memory <-> __arm_mem_to_opcode*() and friends <-> canonical form

canonical form -> __arm_opcode_decode() -> decoded form

decoded form -> __arm_opcode_encode() -> canonical form


The decoded form might look something like this:

struct arm_insn {
	u32			opcode;
	u32			flags;		/* common flags */
	enum arm_insn_type	type;
	u32			insn_flags;	/* insn specific flags */
	enum arm_reg		Rd;
	enum arm_reg		Rn;
	enum arm_reg		Rm;
	enum arm_reg		Rs;
	enum arm_reg		Rt;
	enum arm_reg		Ra;

	/* ... */
};

... and so on.  This just a sketch, and deliberately very incomplete.

The basic principle here is that the client gets the architectural,
encoding-independent view of the instruction: as far as possible, client
code should never need to know anything about how the encoding works.
The client code should not even need to know for most purposes whether
the instruction is ARM or Thumb, once decoded.

Identifying instruction classes (i.e., is this a VFP/NEON instruction,
does this access memory, does this change the PC) etc. should all be
abstracted as helper functions / macros.

All cleverness involving tables and hashes to accelerate decode and
identify instruction classes should move into the framework, but
we can start out with something stupid and simple: if we only need
to distinguish a few instruction types to begin with, a simple switch
statement for decode may be enough to get started.  However, as
things mature, a more sophisticated table-driven approach could be


A good starting point would be load/store emulation as this seems to be a
common theme, and we would need a credible deployment for any new
framework so that we know it's fit for purpose.

So just refactoring the code that appears in the KVM patches could be a
good way of getting such a framework off the ground.

Subsystems could be migrated to the new framework incrementally after
its initial creation, while extending the framework as needed.  This
means that the initial that the initial framework could be pretty simple
-- we don't need all the functionality all at once.


[...]

Cheers
---Dave
