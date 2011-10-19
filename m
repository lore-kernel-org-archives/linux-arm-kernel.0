From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 18 Oct 2011 21:09:34 -0400 (EDT)
Subject: [RFC/PATCH v4 6/7] ARM: ARM11 MPCore: DMA_CACHE_RWFO operations
	are not preempt safe
In-Reply-To: <20111018232602.GA237@mvista.com>
References: <1318004800-6525-1-git-send-email-gdavis@mvista.com>
	<1318945654-548-1-git-send-email-gdavis@mvista.com>
	<1318945654-548-7-git-send-email-gdavis@mvista.com>
	<alpine.LFD.2.02.1110181715120.17040@xanadu.home>
	<20111018232602.GA237@mvista.com>
Message-ID: <alpine.LFD.2.02.1110182049010.17040@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 18 Oct 2011, George G. Davis wrote:
> On Tue, Oct 18, 2011 at 05:28:45PM -0400, Nicolas Pitre wrote:
> > This is buggy.  If the preempt count is _not_ zero, you end up not 
> > loading the TI_FLAGS bits and testing _TIF_NEED_RESCHED against that 
> > non-zero preempt count.
> 
> Sigh, yep.  FWIW, I had the following before submitting this but dropped
> it due to brain failure rereading the code - convinced myself that the
> movne was redundant:
> 
> 
> diff --git a/arch/arm/mm/cache-v6.S b/arch/arm/mm/cache-v6.S
> index af055dc..5c6ce38 100644
> --- a/arch/arm/mm/cache-v6.S
> +++ b/arch/arm/mm/cache-v6.S
> @@ -285,6 +287,7 @@ v6_dma_inv_range:
>  	str	r3, [ip, #TI_PREEMPT]		@ restore preempt count
>  	teq	r3, #0				@ preempt count == 0?
>  	ldreq	r3, [ip, #TI_FLAGS]		@ load flags if yes
> +	movne	r3, #0				@ force flags to 0
>  	tst	r3, #_TIF_NEED_RESCHED		@ need resched?
>  	bne	preempt_schedule		@ ret via preempt_schedule
>  #endif

At this point, especially on ARMv6+, I think it is more efficient to
simply skip over the code:

	teq	r3, #0
	str	r3, [ip, #TI_PREEMPT]
	bne	99f
	ldr	r3, [ip, #TI_FLAGS]
	tst	r3, #_TIF_NEED_RESCHED
	bne	preempt_schedule
99:

> In this case, I think preempt_{disable,enable} is the better option
> (over interrupt disable/enable) due to variable DMA buffer sizes.

Agreed.


Nicolas
