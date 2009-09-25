From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 25 Sep 2009 21:34:17 +0100
Subject: [PATCH] make Linux bootable on ARM again
In-Reply-To: <alpine.LFD.2.00.0909251613240.4997@xanadu.home>
References: <200909252039.19789.elendil@planet.nl>
	<alpine.LFD.2.00.0909251613240.4997@xanadu.home>
Message-ID: <20090925203417.GA19662@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 25, 2009 at 04:28:02PM -0400, Nicolas Pitre wrote:
> Commit 200b812d00 "Clear the exclusive monitor when returning from an 
> exception" broke the vast majority of ARM systems in the wild which are 
> still pre ARMv6.  The kernel is crashing on the first occurrence of an 
> exception due to the removal of the actual return instruction for them.  
> Let's add it back.

Catalin, can you please test your changes more thoroughly in future
please?

> 
> Signed-off-by: Nicolas Pitre <nico@marvell.com>
> ---
> 
> diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
> index e17e3c3..ac34c0d 100644
> --- a/arch/arm/kernel/entry-header.S
> +++ b/arch/arm/kernel/entry-header.S
> @@ -83,6 +83,8 @@
>  	ldr	r0, [sp]
>  	strex	r1, r2, [sp]			@ clear the exclusive monitor
>  	ldmib	sp, {r1 - pc}^			@ load r1 - pc, cpsr
> +#else
> +	ldmia	sp, {r0 - pc}^			@ load r0 - pc, cpsr
>  #endif
>  	.endm
>  
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
