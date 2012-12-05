From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 5 Dec 2012 10:58:22 +0000
Subject: [PATCH v4 12/13] ARM: KVM: vgic: reduce the number of vcpu kick
In-Reply-To: <20121205104358.GC22385@mudshark.cambridge.arm.com>
References: <20121110154358.3061.16338.stgit@chazy-air>
 <20121110154539.3061.82553.stgit@chazy-air>
 <20121205104358.GC22385@mudshark.cambridge.arm.com>
Message-ID: <20121205105822.GL14363@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 05, 2012 at 10:43:58AM +0000, Will Deacon wrote:
> On Sat, Nov 10, 2012 at 03:45:39PM +0000, Christoffer Dall wrote:
> > From: Marc Zyngier <marc.zyngier@arm.com>
> > 
> > If we have level interrupts already programmed to fire on a vcpu,
> > there is no reason to kick it after injecting a new interrupt,
> > as we're guaranteed that we'll exit when the level interrupt will
> > be EOId (VGIC_LR_EOI is set).
> > 
> > The exit will force a reload of the VGIC, injecting the new interrupts.
> > 
> > Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> > Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
> > ---
> >  arch/arm/include/asm/kvm_vgic.h |   10 ++++++++++
> >  arch/arm/kvm/arm.c              |   10 +++++++++-
> >  arch/arm/kvm/vgic.c             |   10 ++++++++--
> >  3 files changed, 27 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm/include/asm/kvm_vgic.h b/arch/arm/include/asm/kvm_vgic.h
> > index a8e7a93..7d2662c 100644
> > --- a/arch/arm/include/asm/kvm_vgic.h
> > +++ b/arch/arm/include/asm/kvm_vgic.h
> > @@ -215,6 +215,9 @@ struct vgic_cpu {
> >  	u32		vgic_elrsr[2];	/* Saved only */
> >  	u32		vgic_apr;
> >  	u32		vgic_lr[64];	/* A15 has only 4... */
> > +
> > +	/* Number of level-triggered interrupt in progress */
> > +	atomic_t	irq_active_count;
> >  #endif
> >  };
> >  
> > @@ -254,6 +257,8 @@ bool vgic_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run,
> >  
> >  #define irqchip_in_kernel(k)	(!!((k)->arch.vgic.vctrl_base))
> >  #define vgic_initialized(k)	((k)->arch.vgic.ready)
> > +#define vgic_active_irq(v)	(atomic_read(&(v)->arch.vgic_cpu.irq_active_count) == 0)
> 
> When is the atomic_t initialised to zero? I can only see increments.

I'd question whether an atomic type is correct for this; the only
protection that it's offering is to ensure that the atomic increment
and decrement occur atomically - there's nothing else that they're doing
in this code.

If those atomic increments and decrements are occuring beneath a common
lock, then using atomic types is just mere code obfuscation.

For example, I'd like to question the correctness of this:

+               if (vgic_active_irq(vcpu) &&
+                   cmpxchg(&vcpu->mode, EXITING_GUEST_MODE, IN_GUEST_MODE) == EXITING_GUEST_MODE)

What if vgic_active_irq() reads the atomic type, immediately after it gets
decremented to zero before the cmpxchg() is executed?  Would that be a
problem?

If yes, yet again this illustrates why the use of atomic types leads people
down the path of believing that their code somehow becomes magically safe
through the use of this smoke-screen.  IMHO, every use of atomic_t must be
questioned and carefully analysed before it gets into the kernel - many
are buggy through assumptions that atomic_t buys you something magic.
