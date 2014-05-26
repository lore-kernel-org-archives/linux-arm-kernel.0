From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 26 May 2014 19:35:44 +0200
Subject: [PATCH v3 12/14] ARM64: KVM: vgic_elrsr and vgic_eisr need to be
 byteswapped in BE case
In-Reply-To: <1399997646-4716-13-git-send-email-victor.kamensky@linaro.org>
References: <1399997646-4716-1-git-send-email-victor.kamensky@linaro.org>
 <1399997646-4716-13-git-send-email-victor.kamensky@linaro.org>
Message-ID: <20140526173544.GE31431@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 13, 2014 at 09:14:04AM -0700, Victor Kamensky wrote:
> On arm64 'u32 vgic_eisr[2];' and 'u32 vgic_elrsr[2]' are accessed as
> one 'unsigned long *' bit fields, which has 64bit size. So we need to
> swap least significant word with most significant word when code reads
> those registers from h/w.
> 
> Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
> ---
>  arch/arm64/kvm/hyp.S | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
> index 0620691..5035b41 100644
> --- a/arch/arm64/kvm/hyp.S
> +++ b/arch/arm64/kvm/hyp.S
> @@ -415,10 +415,17 @@ CPU_BE(	rev	w11, w11 )
>  	str	w4, [x3, #VGIC_CPU_HCR]
>  	str	w5, [x3, #VGIC_CPU_VMCR]
>  	str	w6, [x3, #VGIC_CPU_MISR]
> +#ifndef CONFIG_CPU_BIG_ENDIAN
>  	str	w7, [x3, #VGIC_CPU_EISR]
>  	str	w8, [x3, #(VGIC_CPU_EISR + 4)]
>  	str	w9, [x3, #VGIC_CPU_ELRSR]
>  	str	w10, [x3, #(VGIC_CPU_ELRSR + 4)]
> +#else
> +	str	w7, [x3, #(VGIC_CPU_EISR + 4)]
> +	str	w8, [x3, #VGIC_CPU_EISR]
> +	str	w9, [x3, #(VGIC_CPU_ELRSR + 4)]
> +	str	w10, [x3, #VGIC_CPU_ELRSR]
> +#endif
>  	str	w11, [x3, #VGIC_CPU_APR]
>  
>  	/* Clear GICH_HCR */
> -- 
> 1.8.1.4
> 
Hmm, the data structure doesn't actually clearly define this as bitmap,
but the architecture clearly defines this as two registers.  It feels
like this critical code is getting over complicated to cater for the
fact that we can use a convenient for_each_set_bit() function when we
process a maintenance interrupt.

Marc, what are your thoughts on this?  Change vgic_process_maintenance
and clearly document the array on struct vgic_cpu, or go ahead with this
change?

-Christoffer
