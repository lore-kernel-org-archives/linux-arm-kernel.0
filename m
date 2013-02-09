From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 08 Feb 2013 22:51:10 -0500 (EST)
Subject: [PATCH 06/17] ARM: fixup head for atag verification
In-Reply-To: <1360365467-25056-7-git-send-email-ben.dooks@codethink.co.uk>
References: <1360365467-25056-1-git-send-email-ben.dooks@codethink.co.uk>
 <1360365467-25056-7-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <alpine.LFD.2.02.1302082246400.6300@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 8 Feb 2013, Ben Dooks wrote:

> If we booted LE but running BE8, ensure we read ATAGs data from head code
> in the correct mode.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

You must be working on some recent platform, right?  Your cover letter 
mention highbank.  Strange that you don't address the DT pointer 
validation as well.

> ---
>  arch/arm/kernel/head-common.S |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/kernel/head-common.S b/arch/arm/kernel/head-common.S
> index 854bd22..4eb53b2 100644
> --- a/arch/arm/kernel/head-common.S
> +++ b/arch/arm/kernel/head-common.S
> @@ -21,6 +21,12 @@
>  #define OF_DT_MAGIC 0xedfe0dd0 /* 0xd00dfeed in big-endian */
>  #endif
>  
> +#ifdef CONFIG_CPU_BE8_BOOT_LE
> +#define BE8_LE(x...)	x
> +#else
> +#define BE8_LE(x...)
> +#endif
> +
>  /*
>   * Exception handling.  Something went wrong and we can't proceed.  We
>   * ought to tell the user, but since we don't have any guarantee that
> @@ -53,10 +59,12 @@ __vet_atags:
>  	cmp	r5, r6
>  	beq	2f
>  #endif
> +BE8_LE(	rev	r5, r5 )
>  	cmp	r5, #ATAG_CORE_SIZE		@ is first tag ATAG_CORE?
>  	cmpne	r5, #ATAG_CORE_SIZE_EMPTY
>  	bne	1f
>  	ldr	r5, [r2, #4]
> +BE8_LE(	rev	r5, r5 )
>  	ldr	r6, =ATAG_CORE
>  	cmp	r5, r6
>  	bne	1f
> -- 
> 1.7.10.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
