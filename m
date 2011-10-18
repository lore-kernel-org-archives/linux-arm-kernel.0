From: gdavis@mvista.com (George G. Davis)
Date: Tue, 18 Oct 2011 19:26:02 -0400
Subject: [RFC/PATCH v4 6/7] ARM: ARM11 MPCore: DMA_CACHE_RWFO operations
	are not preempt safe
In-Reply-To: <alpine.LFD.2.02.1110181715120.17040@xanadu.home>
References: <1318004800-6525-1-git-send-email-gdavis@mvista.com>
	<1318945654-548-1-git-send-email-gdavis@mvista.com>
	<1318945654-548-7-git-send-email-gdavis@mvista.com>
	<alpine.LFD.2.02.1110181715120.17040@xanadu.home>
Message-ID: <20111018232602.GA237@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, Oct 18, 2011 at 05:28:45PM -0400, Nicolas Pitre wrote:
> On Tue, 18 Oct 2011, gdavis at mvista.com wrote:
> 
> > @@ -241,6 +247,13 @@ v6_dma_inv_range:
> >  	blo	1b
> >  	mov	r0, #0
> >  	mcr	p15, 0, r0, c7, c10, 4		@ drain write buffer
> > +#if	defined(CONFIG_DMA_CACHE_RWFO) && defined(CONFIG_PREEMPT)
> > +	str	r3, [ip, #TI_PREEMPT]		@ restore preempt count
> > +	teq	r3, #0				@ preempt count == 0?
> > +	ldreq	r3, [ip, #TI_FLAGS]		@ load flags if yes
> > +	tst	r3, #_TIF_NEED_RESCHED		@ need resched?
> > +	bne	preempt_schedule		@ ret via preempt_schedule
> 
> This is buggy.  If the preempt count is _not_ zero, you end up not 
> loading the TI_FLAGS bits and testing _TIF_NEED_RESCHED against that 
> non-zero preempt count.

Sigh, yep.  FWIW, I had the following before submitting this but dropped
it due to brain failure rereading the code - convinced myself that the
movne was redundant:


diff --git a/arch/arm/mm/cache-v6.S b/arch/arm/mm/cache-v6.S
index af055dc..5c6ce38 100644
--- a/arch/arm/mm/cache-v6.S
+++ b/arch/arm/mm/cache-v6.S
@@ -285,6 +287,7 @@ v6_dma_inv_range:
 	str	r3, [ip, #TI_PREEMPT]		@ restore preempt count
 	teq	r3, #0				@ preempt count == 0?
 	ldreq	r3, [ip, #TI_FLAGS]		@ load flags if yes
+	movne	r3, #0				@ force flags to 0
 	tst	r3, #_TIF_NEED_RESCHED		@ need resched?
 	bne	preempt_schedule		@ ret via preempt_schedule
 #endif
@@ -321,6 +324,7 @@ v6_dma_clean_range:
 	str	r3, [ip, #TI_PREEMPT]		@ restore preempt count
 	teq	r3, #0				@ preempt count == 0?
 	ldreq	r3, [ip, #TI_FLAGS]		@ load flags if yes
+	movne	r3, #0				@ force flags to 0
 	tst	r3, #_TIF_NEED_RESCHED		@ need resched?
 	bne	preempt_schedule		@ ret via preempt_schedule
 #endif
@@ -362,6 +366,7 @@ ENTRY(v6_dma_flush_range)
 	str	r3, [ip, #TI_PREEMPT]		@ restore preempt count
 	teq	r3, #0				@ preempt count == 0?
 	ldreq	r3, [ip, #TI_FLAGS]		@ load flags if yes
+	movne	r3, #0				@ force flags to 0
 	tst	r3, #_TIF_NEED_RESCHED		@ need resched?
 	bne	preempt_schedule		@ ret via preempt_schedule
 #endif

In this case, I think preempt_{disable,enable} is the better option
(over interrupt disable/enable) due to variable DMA buffer sizes.

Thanks!

--
Regards,
George

> 
> 
> Nicolas
