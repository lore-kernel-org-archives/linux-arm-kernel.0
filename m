From: drjones@redhat.com (Andrew Jones)
Date: Thu, 22 Feb 2018 10:49:06 +0100
Subject: [PATCH v4 03/40] KVM: arm64: Avoid storing the vcpu pointer on
 the stack
In-Reply-To: <20180222090248.GC29376@cbox>
References: <20180215210332.8648-1-christoffer.dall@linaro.org>
 <20180215210332.8648-4-christoffer.dall@linaro.org>
 <86fu5ulgpc.wl-marc.zyngier@arm.com> <20180222090248.GC29376@cbox>
Message-ID: <20180222094906.6k2tr5cgxpvgtdxb@kamzik.brq.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 22, 2018 at 10:02:48AM +0100, Christoffer Dall wrote:
> On Wed, Feb 21, 2018 at 11:34:07AM +0000, Marc Zyngier wrote:
> > On Thu, 15 Feb 2018 21:02:55 +0000,
> > Christoffer Dall wrote:
> > > @@ -138,13 +138,15 @@ alternative_else_nop_endif
> > >  
> > >  el1_irq:
> > >  	stp     x0, x1, [sp, #-16]!
> > > -	ldr	x1, [sp, #16 + 8]
> > > +	get_host_ctxt	x0, x1
> > > +	get_vcpu	x1, x0
> > >  	mov	x0, #ARM_EXCEPTION_IRQ
> > >  	b	__guest_exit
> > >  
> > >  el1_error:
> > >  	stp     x0, x1, [sp, #-16]!
> > > -	ldr	x1, [sp, #16 + 8]
> > > +	get_host_ctxt	x0, x1
> > > +	get_vcpu	x1, x0
> > 
> > Given how frequent this construct is, would there be a benefit in
> > having something like "get_vcpu_ptr" that conflates the two macros? We
> > don't seem to have a single case of using get_vcpu on its own.
> > 
> 
> I think my intention was to make it obvious how we get to the vcpu
> pointer, but looking at it now I don't think this adds anything, so I'm
> happy to adjust.  How about adding a get_vcpu_ptr macro which calls the
> other two macros?
>

Do we really need three macros, if get_vcpu is never used independently?
In the first round of reviews I suggested redefining get_vcpu like this

"""
 .macro get_vcpu vcpu, tmp
     get_host_ctxt \tmp, \vcpu
     ldr     \vcpu, [\tmp, #HOST_CONTEXT_VCPU]
     kern_hyp_va     \vcpu
 .endm

 which also has the side-effect of tmp being ctxt after the call.
"""

Thanks,
drew
