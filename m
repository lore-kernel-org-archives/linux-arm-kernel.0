From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 18 Oct 2011 17:28:45 -0400 (EDT)
Subject: [RFC/PATCH v4 6/7] ARM: ARM11 MPCore: DMA_CACHE_RWFO operations
	are not preempt safe
In-Reply-To: <1318945654-548-7-git-send-email-gdavis@mvista.com>
References: <1318004800-6525-1-git-send-email-gdavis@mvista.com>
	<1318945654-548-1-git-send-email-gdavis@mvista.com>
	<1318945654-548-7-git-send-email-gdavis@mvista.com>
Message-ID: <alpine.LFD.2.02.1110181715120.17040@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 18 Oct 2011, gdavis at mvista.com wrote:

> @@ -241,6 +247,13 @@ v6_dma_inv_range:
>  	blo	1b
>  	mov	r0, #0
>  	mcr	p15, 0, r0, c7, c10, 4		@ drain write buffer
> +#if	defined(CONFIG_DMA_CACHE_RWFO) && defined(CONFIG_PREEMPT)
> +	str	r3, [ip, #TI_PREEMPT]		@ restore preempt count
> +	teq	r3, #0				@ preempt count == 0?
> +	ldreq	r3, [ip, #TI_FLAGS]		@ load flags if yes
> +	tst	r3, #_TIF_NEED_RESCHED		@ need resched?
> +	bne	preempt_schedule		@ ret via preempt_schedule

This is buggy.  If the preempt count is _not_ zero, you end up not 
loading the TI_FLAGS bits and testing _TIF_NEED_RESCHED against that 
non-zero preempt count.


Nicolas
