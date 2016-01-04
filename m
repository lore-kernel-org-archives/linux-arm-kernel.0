From: will.deacon@arm.com (Will Deacon)
Date: Mon, 4 Jan 2016 17:48:29 +0000
Subject: [PATCH] arm64: fix relocation of movz instruction with negative
 immediate
In-Reply-To: <20160104171749.GA4436@e103592.cambridge.arm.com>
References: <1451923762-8387-1-git-send-email-ard.biesheuvel@linaro.org>
 <20160104171749.GA4436@e103592.cambridge.arm.com>
Message-ID: <20160104174829.GJ1616@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 04, 2016 at 05:21:12PM +0000, Dave Martin wrote:
> On Mon, Jan 04, 2016 at 05:09:22PM +0100, Ard Biesheuvel wrote:
> > The test whether a movz instruction with a signed immediate should be
> > turned into a movn instruction (i.e., when the immediate is negative)
> > is flawed, since the value of imm is always positive. So check sval
> > instead.
> > 
> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > ---
> >  arch/arm64/kernel/module.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
> > index f4bc779e62e8..39e4a29cab50 100644
> > --- a/arch/arm64/kernel/module.c
> > +++ b/arch/arm64/kernel/module.c
> > @@ -128,7 +128,7 @@ static int reloc_insn_movw(enum aarch64_reloc_op op, void *place, u64 val,
> 
> #define AARCH64_INSN_IMM_MOVNZ          AARCH64_INSN_IMM_MAX
> #define AARCH64_INSN_IMM_MOVK           AARCH64_INSN_IMM_16
> 
> /* ... */
> 
>         if (imm_type == AARCH64_INSN_IMM_MOVNZ) {
> 
> /* ... */
> 
> >  		 * immediate is less than zero.
> >  		 */
> >  		insn &= ~(3 << 29);
> > -		if ((s64)imm >= 0) {
> > +		if (sval >= 0) {
> >  			/* >=0: Set the instruction to MOVZ (opcode 10b). */
> >  			insn |= 2 << 29;
> >  		} else {
> 
> I _think_ this may be correct, but...

Yeah, I think this is the right thing to do.

> 		}
> 		imm_type = AARCH64_INSN_IMM_MOVK;
> 	} 
> 
>         /* Update the instruction with the new encoding. */
>         insn = aarch64_insn_encode_immediate(imm_type, insn, imm);
> 
> /* ... */
> 
> leaves imm_type as either AARCH64_INSN_IMM_16 or AARCH64_INSN_IMM_MOVK.
> 
> But because AARCH64_INSN_IMM_16 == AARCH64_INSN_IMM_MOVK (required for , the negative
> overflow fudge is never applied, no?
> 
>         if (imm_type != AARCH64_INSN_IMM_16) {
>                 sval++;
>                 limit++;
>         }

Hmm, that's a bug introduced by the refactoring of the insn encoding
stuff in c84fced8d990 ("arm64: move encode_insn_immediate() from module.c
to insn.c"). I've restored the old behaviour below.

> I'm wondering whether there is a less confusing way to do all this...

Patches welcome! I didn't have an ELF spec when I wrote the original
code, so it might be easier now. It would also be handy to have a test
module that uses lots of relocs...

Will

--->8

diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
index 266e7490e85c..6546032bb83b 100644
--- a/arch/arm64/kernel/module.c
+++ b/arch/arm64/kernel/module.c
@@ -140,11 +140,10 @@ static int reloc_insn_movw(enum aarch64_reloc_op op, void *place, u64 val,
 			 */
 			imm = ~imm;
 		}
-		imm_type = AARCH64_INSN_IMM_MOVK;
 	}
 
 	/* Update the instruction with the new encoding. */
-	insn = aarch64_insn_encode_immediate(imm_type, insn, imm);
+	insn = aarch64_insn_encode_immediate(AARCH64_INSN_IMM_16, insn, imm);
 	*(u32 *)place = cpu_to_le32(insn);
 
 	/* Shift out the immediate field. */
