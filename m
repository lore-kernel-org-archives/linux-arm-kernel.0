From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 28 Mar 2011 18:39:18 -0400 (EDT)
Subject: [PATCH] Fix ldrd/strd emulation for kprobes/ARM
In-Reply-To: <1301327765-6996-1-git-send-email-viktor.rosendahl@nokia.com>
References: <1301087944.2744.85.camel@computer2.home>
	<1301327765-6996-1-git-send-email-viktor.rosendahl@nokia.com>
Message-ID: <alpine.LFD.2.00.1103281822170.11889@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 28 Mar 2011, Viktor Rosendahl wrote:

> On 03/25/2011 11:19 PM, ext Tixy wrote:
> > On Fri, 2011-03-25 at 19:01 +0200, Viktor Rosendahl wrote:
> >> The Rn value from the emulation is unconditionally written back; this is fine
> >> as long as Rn != PC because in that case, even if the instruction isn't a write
> >> back instruction, it will only result in the same value being written back.
> >>
> >> In case Rn == PC, then the emulated instruction doesn't have the actual PC
> >> value in Rn but an adjusted value; when this is written back, it will result in
> >> the PC being incorrectly updated.
> > It looks like we have the same problem with emulate_ldrd and
> > emulate_strd as well.
> 
> Yes, it seems so. Currently emulate_ldrd and emulate_strd don't even have the
> adjustment of the PC value, so in case of Rn == PC, it will not update the PC
> incorrectly but instead load/store from the wrong address. Below is a patch
> that adds both the adjustment of the PC value and the check for PC == PC.
> 
> I haven't tested this code at all and I am not sure of how to test it.
> 
> Signed-off-by: Viktor Rosendahl <viktor.rosendahl@nokia.com>

Looks OK from inspection though.

Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>

Please send to RMK's patch system.

I agree that it might be a better idea to simply reject the dubious 
cases upfront from arm_kprobe_decode_insn() and keep the actual 
emulation code fast and free from odd conditions that might never be 
useful in practice.  I think this is highly unlikely that we would find 
some usage of LDRD/STRD indexed by r15 in the kernel.

Same issue if Rd happens to be odd, or equal to r14.

> ---
>  arch/arm/kernel/kprobes-decode.c |   20 +++++++++++++++-----
>  1 files changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/kernel/kprobes-decode.c b/arch/arm/kernel/kprobes-decode.c
> index 2389131..3b0cf90 100644
> --- a/arch/arm/kernel/kprobes-decode.c
> +++ b/arch/arm/kernel/kprobes-decode.c
> @@ -540,9 +540,12 @@ static void __kprobes emulate_ldrd(struct kprobe *p, struct pt_regs *regs)
>  {
>  	insn_2arg_fn_t *i_fn = (insn_2arg_fn_t *)&p->ainsn.insn[0];
>  	kprobe_opcode_t insn = p->opcode;
> +	long ppc = (long)p->addr + 8;
>  	int rd = (insn >> 12) & 0xf;
>  	int rn = (insn >> 16) & 0xf;
>  	int rm = insn & 0xf;  /* rm may be invalid, don't care. */
> +	long rmv = (rm == 15) ? ppc : regs->uregs[rm];
> +	long rnv = (rn == 15) ? ppc : regs->uregs[rn];
>  
>  	/* Not following the C calling convention here, so need asm(). */
>  	__asm__ __volatile__ (
> @@ -554,29 +557,36 @@ static void __kprobes emulate_ldrd(struct kprobe *p, struct pt_regs *regs)
>  		"str	r0, %[rn]	\n\t"	/* in case of writeback */
>  		"str	r2, %[rd0]	\n\t"
>  		"str	r3, %[rd1]	\n\t"
> -		: [rn]  "+m" (regs->uregs[rn]),
> +		: [rn]  "+m" (rnv),
>  		  [rd0] "=m" (regs->uregs[rd]),
>  		  [rd1] "=m" (regs->uregs[rd+1])
> -		: [rm]   "m" (regs->uregs[rm]),
> +		: [rm]   "m" (rmv),
>  		  [cpsr] "r" (regs->ARM_cpsr),
>  		  [i_fn] "r" (i_fn)
>  		: "r0", "r1", "r2", "r3", "lr", "cc"
>  	);
> +	if (rn != 15)
> +		regs->uregs[rn] = rnv;  /* Save Rn in case of writeback. */
>  }
>  
>  static void __kprobes emulate_strd(struct kprobe *p, struct pt_regs *regs)
>  {
>  	insn_4arg_fn_t *i_fn = (insn_4arg_fn_t *)&p->ainsn.insn[0];
>  	kprobe_opcode_t insn = p->opcode;
> +	long ppc = (long)p->addr + 8;
>  	int rd = (insn >> 12) & 0xf;
>  	int rn = (insn >> 16) & 0xf;
>  	int rm  = insn & 0xf;
> -	long rnv = regs->uregs[rn];
> -	long rmv = regs->uregs[rm];  /* rm/rmv may be invalid, don't care. */
> +	long rnv = (rn == 15) ? ppc : regs->uregs[rn];
> +	/* rm/rmv may be invalid, don't care. */
> +	long rmv = (rm == 15) ? ppc : regs->uregs[rm];
> +	long rnv_wb;
>  
> -	regs->uregs[rn] = insnslot_4arg_rflags(rnv, rmv, regs->uregs[rd],
> +	rnv_wb = insnslot_4arg_rflags(rnv, rmv, regs->uregs[rd],
>  					       regs->uregs[rd+1],
>  					       regs->ARM_cpsr, i_fn);
> +	if (rn != 15)
> +		regs->uregs[rn] = rnv_wb;  /* Save Rn in case of writeback. */
>  }
>  
>  static void __kprobes emulate_ldr(struct kprobe *p, struct pt_regs *regs)
> -- 
> 1.7.2.5
> 
