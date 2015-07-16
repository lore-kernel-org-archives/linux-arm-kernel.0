From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Thu, 16 Jul 2015 18:11:00 +0200
Subject: [PATCH] ARM: socfpga: put back v7_invalidate_l1 in
 socfpga_secondary_startup
In-Reply-To: <55A6B348.4030109@opensource.altera.com>
References: <1436370711-18524-1-git-send-email-dinguyen@opensource.altera.com>
 <20150708165115.GM7557@n2100.arm.linux.org.uk>
 <559D765C.30102@opensource.altera.com>
 <20150708210734.GN7557@n2100.arm.linux.org.uk>
 <55A6B348.4030109@opensource.altera.com>
Message-ID: <20150716161100.GB30696@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Russell!

On Wed, Jul 15, 2015 at 02:23:52PM -0500, Dinh Nguyen wrote:
> On 07/08/2015 04:07 PM, Russell King - ARM Linux wrote:
> > On Wed, Jul 08, 2015 at 02:13:32PM -0500, Dinh Nguyen wrote:
> >> The value of CPACR is 0x00F00000. So cp11 and cp10 are privileged and
> >> user mode access.
> > 
> > Hmm.
> > 
> > I think what you've found is a(nother) latent bug in the CPU bring up
> > code.
> > 
> > For SMP CPUs, the sequence we're following during early initialisation is:
> > 
> > 1. Enable SMP coherency.
> > 2. Invalidate the caches.
> > 
> > If the cache contains rubbish, enabling SMP coherency before invalidating
> > the cache is plainly an absurd thing to do.
> > 
> > Can you try the patch below - not tested in any way, so you may need to
> > tweak it, but it should allow us to prove that point.
> > 
> > diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
> > index 0716bbe19872..db5137fc297d 100644
> > --- a/arch/arm/mm/proc-v7.S
> > +++ b/arch/arm/mm/proc-v7.S
> > @@ -275,6 +275,10 @@ __v7_b15mp_setup:
> >  __v7_ca17mp_setup:
> >  	mov	r10, #0
> >  1:
> > +	adr	r12, __v7_setup_stack		@ the local stack
> > +	stmia	r12, {r0-r5, r7, r9-r11, lr}
> > +	bl      v7_invalidate_l1
> > +	ldmia	r12, {r0-r5, r7, r9-r11, lr}
> >  #ifdef CONFIG_SMP
> >  	ALT_SMP(mrc	p15, 0, r0, c1, c0, 1)
> >  	ALT_UP(mov	r0, #(1 << 6))		@ fake it for UP
> > @@ -283,7 +287,7 @@ __v7_ca17mp_setup:
> >  	orreq	r0, r0, r10			@ Enable CPU-specific SMP bits
> >  	mcreq	p15, 0, r0, c1, c0, 1
> >  #endif
> > -	b	__v7_setup
> > +	b	__v7_setup_cont
> >  
> >  /*
> >   * Errata:
> > @@ -417,6 +421,7 @@ __v7_setup:
> >  	bl      v7_invalidate_l1
> >  	ldmia	r12, {r0-r5, r7, r9, r11, lr}
> >  
> > +__v7_setup_cont:
> >  	and	r0, r9, #0xff000000		@ ARM?
> >  	teq	r0, #0x41000000
> >  	bne	__errata_finish
> > @@ -480,7 +485,7 @@ ENDPROC(__v7_setup)
> >  
> >  	.align	2
> >  __v7_setup_stack:
> > -	.space	4 * 11				@ 11 registers
> > +	.space	4 * 12				@ 12 registers
> >  
> >  	__INITDATA
> >  
> > 
> 
> For this patch, please feel free to add:
> 
> Tested-by: Dinh Nguyen <dinguyen@opensource.altera.com>
> 

I just ran into the same problem as Dinh. This patch fixed it for me, too.
Without it, 4.2-rc2 (at least) is pretty broken for me :-(
So, you may also add

	Tested-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>

When you send a proper patch.

Thanks,
Steffen Trumtrar

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
