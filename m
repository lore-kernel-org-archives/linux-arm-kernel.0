From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 27 Sep 2010 13:01:54 -0400 (EDT)
Subject: [PATCH] ARM: kprobes-decode: add support for MOVW instruction
In-Reply-To: <000201cb5e46$3265b8c0$97312a40$%deacon@arm.com>
References: <1285170122-19823-1-git-send-email-will.deacon@arm.com>
	<000201cb5e46$3265b8c0$97312a40$%deacon@arm.com>
Message-ID: <alpine.LFD.2.00.1009271301050.1146@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 27 Sep 2010, Will Deacon wrote:

> > The MOVW instruction moves a 16-bit immediate into the bottom halfword
> > of the destination register.
> > 
> > This patch ensures that kprobes leaves the 16-bit immediate intact, rather
> > than assume a 12-bit immediate and mask out the upper 4 bits.
> > 
> > Cc: Nicolas Pitre <nico@fluxnic.net>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>

Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>

> > ---
> >  arch/arm/kernel/kprobes-decode.c |    7 ++++---
> >  1 files changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm/kernel/kprobes-decode.c b/arch/arm/kernel/kprobes-decode.c
> > index 8bccbfa..2c1f005 100644
> > --- a/arch/arm/kernel/kprobes-decode.c
> > +++ b/arch/arm/kernel/kprobes-decode.c
> > @@ -1162,11 +1162,12 @@ space_cccc_001x(kprobe_opcode_t insn, struct arch_specific_insn *asi)
> >  {
> >  	/*
> >  	 * MSR   : cccc 0011 0x10 xxxx xxxx xxxx xxxx xxxx
> > -	 * Undef : cccc 0011 0x00 xxxx xxxx xxxx xxxx xxxx
> > +	 * Undef : cccc 0011 0100 xxxx xxxx xxxx xxxx xxxx
> >  	 * ALU op with S bit and Rd == 15 :
> >  	 *	   cccc 001x xxx1 xxxx 1111 xxxx xxxx xxxx
> >  	 */
> > -	if ((insn & 0x0f900000) == 0x03200000 ||	/* MSR & Undef */
> > +	if ((insn & 0x0fb00000) == 0x03200000 ||	/* MSR */
> > +	    (insn & 0x0ff00000) == 0x03400000 ||	/* Undef */
> >  	    (insn & 0x0e10f000) == 0x0210f000)		/* ALU s-bit, R15  */
> >  		return INSN_REJECTED;
> > 
> > @@ -1177,7 +1178,7 @@ space_cccc_001x(kprobe_opcode_t insn, struct arch_specific_insn *asi)
> >  	 * *S (bit 20) updates condition codes
> >  	 * ADC/SBC/RSC reads the C flag
> >  	 */
> > -	insn &= 0xfff00fff;	/* Rn = r0, Rd = r0 */
> > +	insn &= 0xffff0fff;	/* Rd = r0 */
> >  	asi->insn[0] = insn;
> >  	asi->insn_handler = (insn & (1 << 20)) ?  /* S-bit */
> >  			emulate_alu_imm_rwflags : emulate_alu_imm_rflags;
> > --
> > 1.7.0.4
> 
> I forgot to mention; without this patch the kprobes smoke tests
> (CONFIG_KPROBES_SANITY_TEST) fail on ARM. If nobody objects, I'll
> submit this to the patch system this week.
> 
> Thanks,
> 
> Will
> 
> 
