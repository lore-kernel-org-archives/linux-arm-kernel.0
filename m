From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 19 Mar 2014 20:42:00 -0700
Subject: [PATCH 4/5] ARM64: KVM: vgic_elrsr and vgic_eisr need to be
 byteswapped in BE case
In-Reply-To: <1392184643-6108-5-git-send-email-victor.kamensky@linaro.org>
References: <1392184643-6108-1-git-send-email-victor.kamensky@linaro.org>
 <1392184643-6108-5-git-send-email-victor.kamensky@linaro.org>
Message-ID: <20140320034200.GT1297@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 11, 2014 at 09:57:22PM -0800, Victor Kamensky wrote:
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
> index 104216c..667293f 100644
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

Isn't it the vgic emulation code that's incorrect then?  The GICv2
hardware defines two registers, GICH_ELRSR0 and GICH_ELRSR1 (and
GICH_EISR0 and GICH_EISR1) and I would find it most logic that
vgic_cpu->elrsr[0] == GICH_ELRSR0, always.

Marc?

-Christoffer
