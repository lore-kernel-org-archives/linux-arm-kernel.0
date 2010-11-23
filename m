From: jajones@nvidia.com (James Jones)
Date: Tue, 23 Nov 2010 15:28:25 -0800
Subject: [PATCH] ARM: Fix find_next_zero_bit and related assembly
In-Reply-To: <alpine.LFD.2.00.1011231625380.9313@xanadu.home>
References: <1289524615-22484-1-git-send-email-jajones@nvidia.com>
	<alpine.LFD.2.00.1011231625380.9313@xanadu.home>
Message-ID: <201011231528.25668.jajones@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 23 November 2010 13:26:47 Nicolas Pitre wrote:
> On Thu, 11 Nov 2010, James Jones wrote:
> > The find_next_bit, find_first_bit, find_next_zero_bit
> > and find_first_zero_bit functions were not properly
> > clamping to the maxbit argument at the bit level. They
> > were instead only checking maxbit at the byte level.
> > To fix this, add a compare and a conditional move
> > instruction to the end of the common bit-within-the-
> > byte code used by all the functions and be sure not to
> > clobber the maxbit argument before it is used.
> > 
> > Signed-off-by: James Jones <jajones@nvidia.com>
> > Tested-by: Stephen Warren <swarren@nvidia.com>
> 
> Reviewed-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> 
> Please send to RMK's patch system.

Thanks for the review.  It's already in the patch system, but I updated the 
entry to include your reviewed-by line.

-James

> > ---
> > 
> >  arch/arm/lib/findbit.S |    6 ++++--
> >  1 files changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/lib/findbit.S b/arch/arm/lib/findbit.S
> > index 1e4cbd4..64f6bc1 100644
> > --- a/arch/arm/lib/findbit.S
> > +++ b/arch/arm/lib/findbit.S
> > @@ -174,8 +174,8 @@ ENDPROC(_find_next_bit_be)
> > 
> >   */
> >  
> >  .L_found:
> >  #if __LINUX_ARM_ARCH__ >= 5
> > 
> > -		rsb	r1, r3, #0
> > -		and	r3, r3, r1
> > +		rsb	r0, r3, #0
> > +		and	r3, r3, r0
> > 
> >  		clz	r3, r3
> >  		rsb	r3, r3, #31
> >  		add	r0, r2, r3
> > 
> > @@ -190,5 +190,7 @@ ENDPROC(_find_next_bit_be)
> > 
> >  		addeq	r2, r2, #1
> >  		mov	r0, r2
> >  
> >  #endif
> > 
> > +		cmp	r1, r0			@ Clamp to maxbit
> > +		movlo	r0, r1
> > 
> >  		mov	pc, lr
