From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 28 Jun 2010 11:08:19 -0400 (EDT)
Subject: kprobe bug.
In-Reply-To: <AAD1C6EB06EE3649B35B7E026785068D14FCBC756F@SC-VEXCH2.marvell.com>
References: <AAD1C6EB06EE3649B35B7E026785068D14FCBC756F@SC-VEXCH2.marvell.com>
Message-ID: <alpine.LFD.2.00.1006281107270.24097@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 27 Jun 2010, Bin Yang wrote:

> Thanks. 
> It looks "emulate_str" had considered PC register situation already. Only " emulate_ldr" has this problem. 
> 
> Here is my new patch, thanks in advance to review it. 
> 
> ===============================
> From 554a86a94836d5f6c89c1253f2c2d85773cbe5eb Mon Sep 17 00:00:00 2001
> From: Bin Yang <bin.yang@marvell.com>
> Date: Mon, 28 Jun 2010 10:40:56 +0800
> Subject: [PATCH] ARM: fix kprobe ldr instr emulate bug
> 
> Signed-off-by: Bin Yang <bin.yang@marvell.com>

Acked-by: Nicolas Pitre <nico@fluxnic.net>

Please send to RMK's p?tch system.


> ---
>  arch/arm/kernel/kprobes-decode.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/kernel/kprobes-decode.c b/arch/arm/kernel/kprobes-decode.c
> index 81b1737..80511d5 100644
> --- a/arch/arm/kernel/kprobes-decode.c
> +++ b/arch/arm/kernel/kprobes-decode.c
> @@ -583,13 +583,14 @@ static void __kprobes emulate_ldr(struct kprobe *p, struct pt_regs *regs)
>  {
>         insn_llret_3arg_fn_t *i_fn = (insn_llret_3arg_fn_t *)&p->ainsn.insn[0];
>         kprobe_opcode_t insn = p->opcode;
> +       long ppc = (long)p->addr + 8;
>         union reg_pair fnr;
>         int rd = (insn >> 12) & 0xf;
>         int rn = (insn >> 16) & 0xf;
>         int rm = insn & 0xf;
>         long rdv;
> -       long rnv  = regs->uregs[rn];
> -       long rmv  = regs->uregs[rm]; /* rm/rmv may be invalid, don't care. */
> +       long rnv = (rn == 15) ? ppc : regs->uregs[rn];
> +       long rmv = (rm == 15) ? ppc : regs->uregs[rm];
>         long cpsr = regs->ARM_cpsr;
> 
> 
> Bin Yang
> 
> -----Original Message-----
> From: Nicolas Pitre [mailto:nico at fluxnic.net] 
> Sent: 2010?6?26? 4:50
> To: Bin Yang
> Cc: Russell King - ARM Linux; Eric Miao; Haojian Zhuang; linux-arm-kernel
> Subject: Re: kprobe bug.
> 
> On Fri, 25 Jun 2010, Bin Yang wrote:
> 
> > Hi Russell,
> > 
> > 	Thanks in advance for your kind to review my question. 
> > 	I met a kprobe bug while I used it to debug my driver. 
> > 	Here is the scenario:
> > 	I add a probe at function xxx(). And the assembly code of xxx() is as following,
> > =====================
> > 	c035ee48 <xxx >:
> > c035ee48:       e59f3008        ldr     r3, [pc, #8]    ; c035ee58              <xxx+0x10>
> > c035ee4c:       e3a02001        mov     r2, #1  ; 0x1
> > c035ee50:       e5032fff        str     r2, [r3, #-4095]
> > c035ee54:       e12fff1e        bx      lr
> > c035ee58:       fe03dfff        .word   0xfe03dfff 
> > =====================
> > 	The ldr emulate always load e12fff1e to r3 register. 
> > 	After debugging, I found the pc register should be 8 after current instruction. So we should set pc to pc+8 before instruction emulation and set it back to the next instruction after singe step.
> > 	Here is my patch: 
> > =======================
> > diff --git a/arch/arm/kernel/kprobes.c b/arch/arm/kernel/kprobes.c
> > index 60c62c3..6e2567e 100644
> > --- a/arch/arm/kernel/kprobes.c
> > +++ b/arch/arm/kernel/kprobes.c
> > @@ -132,8 +132,9 @@ static void __kprobes set_current_kprobe(struct kprobe *p)
> >  static void __kprobes singlestep(struct kprobe *p, struct pt_regs *regs,
> >  				 struct kprobe_ctlblk *kcb)
> >  {
> > -	regs->ARM_pc += 4;
> > +	regs->ARM_pc += 8;
> >  	p->ainsn.insn_handler(p, regs);
> > +	regs->ARM_pc -= 4;
> >  }
> >  
> >  /*
> > ========================
> 
> This is wrong.  You are breaking all the emulated instructions changing 
> the pc value.
> 
> What needs to be done is to add a special case in emulate_ldr() to fixup 
> rnv when rn is 15.  The same fixup would be needed in emulate_str().
> See emulate_alu_rflags() for example.
> 
> 
> Nicolas
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
