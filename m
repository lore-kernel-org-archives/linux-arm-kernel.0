From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 25 Mar 2011 22:03:07 -0400 (EDT)
Subject: [PATCH] kprobes/arm: fix emulation of LDR/STR instruction when Rn
	== PC
In-Reply-To: <1301072519-27937-1-git-send-email-viktor.rosendahl@nokia.com>
References: <1301072519-27937-1-git-send-email-viktor.rosendahl@nokia.com>
Message-ID: <alpine.LFD.2.00.1103252202040.11889@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 25 Mar 2011, Viktor Rosendahl wrote:

> The Rn value from the emulation is unconditionally written back; this is fine
> as long as Rn != PC because in that case, even if the instruction isn't a write
> back instruction, it will only result in the same value being written back.
> 
> In case Rn == PC, then the emulated instruction doesn't have the actual PC
> value in Rn but an adjusted value; when this is written back, it will result in
> the PC being incorrectly updated.
> 
> An altenative solution would be to check bits 24 and 22 to see whether the
> instruction actually is a write back instruction or not. I think it's
> enough to check whether Rn != PC,  because:
> - it's looks cheaper than the alternative
> - to my understaning it's not permitted to update the PC with a write back
> instruction, so we don't lose any ability to emulate legal instructions.
> - in case of writing back for non write back instructions where Rn != PC, it
> doesn't matter because the values are the same.
> 
> Regarding the second point above, it would possibly be prudent to add some
> checking to prep_emulate_ldr_str(), so that instructions with write back and
> Rn == PC would be rejected.
> 
> Signed-off-by: Viktor Rosendahl <viktor.rosendahl@nokia.com>

Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>

Please send to RMK's patch system.

> ---
>  arch/arm/kernel/kprobes-decode.c |   10 ++++++----
>  1 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/kernel/kprobes-decode.c b/arch/arm/kernel/kprobes-decode.c
> index 8f6ed43..2389131 100644
> --- a/arch/arm/kernel/kprobes-decode.c
> +++ b/arch/arm/kernel/kprobes-decode.c
> @@ -594,7 +594,8 @@ static void __kprobes emulate_ldr(struct kprobe *p, struct pt_regs *regs)
>  	long cpsr = regs->ARM_cpsr;
>  
>  	fnr.dr = insnslot_llret_3arg_rflags(rnv, 0, rmv, cpsr, i_fn);
> -	regs->uregs[rn] = fnr.r0;  /* Save Rn in case of writeback. */
> +	if (rn != 15)
> +		regs->uregs[rn] = fnr.r0;  /* Save Rn in case of writeback. */
>  	rdv = fnr.r1;
>  
>  	if (rd == 15) {
> @@ -622,10 +623,11 @@ static void __kprobes emulate_str(struct kprobe *p, struct pt_regs *regs)
>  	long rdv = (rd == 15) ? iaddr + str_pc_offset : regs->uregs[rd];
>  	long rnv = (rn == 15) ? iaddr +  8 : regs->uregs[rn];
>  	long rmv = regs->uregs[rm];  /* rm/rmv may be invalid, don't care. */
> +	long rnv_wb;
>  
> -	/* Save Rn in case of writeback. */
> -	regs->uregs[rn] =
> -		insnslot_3arg_rflags(rnv, rdv, rmv, regs->ARM_cpsr, i_fn);
> +	rnv_wb = insnslot_3arg_rflags(rnv, rdv, rmv, regs->ARM_cpsr, i_fn);
> +	if (rn != 15)
> +		regs->uregs[rn] = rnv_wb;  /* Save Rn in case of writeback. */
>  }
>  
>  static void __kprobes emulate_mrrc(struct kprobe *p, struct pt_regs *regs)
> -- 
> 1.7.2.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
