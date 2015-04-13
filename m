From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 13 Apr 2015 16:48:43 +0200
Subject: [PATCH v2 05/10] KVM: arm: introduce kvm_arch_setup/clear_debug()
In-Reply-To: <20150413143623.GP6186@cbox>
References: <1427814488-28467-1-git-send-email-alex.bennee@linaro.org>
 <1427814488-28467-6-git-send-email-alex.bennee@linaro.org>
 <20150413143623.GP6186@cbox>
Message-ID: <20150413144843.GQ6186@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 13, 2015 at 04:36:23PM +0200, Christoffer Dall wrote:

[...]

> > +
> > +/**
> > + * kvm_arch_setup_debug - set-up debug related stuff
> 
> nit: I think you want "set up" when it's a verb.
> 
> > + *
> > + * @vcpu:	the vcpu pointer
> > + *
> > + * This is called before each entry in to the hypervisor to setup any
> 
> s/in to/into/
> s/setup/set up/
> 
> > + * debug related registers. Currently this just ensures we will trap
> > + * access to:
> 
> guest accesses to:
> 
> > + *  - Performance monitors (MDCR_EL2_TPM/MDCR_EL2_TPMCR)
> > + *  - Debug ROM Address (MDCR_EL2_TDRA)
> > + *  - Power down debug registers (MDCR_EL2_TDOSA)
> > + *
> > + * Additionally the hypervisor lazily saves/restores the debug
> > + * register state. If it is not currently doing so (arch.debug_flags)
> > + * then we also need to ensure we trap if the guest messes with them
> > + * so we know we need to save them.
> 
> This paragraph is a little hard to make sense of.  If I understand it
> correctly, the point is that when debugging the guest we need to make
> sure guest accesses to the debug registers traps?  If so, I would
> suggest something like:
> 
>   Additionally, KVM only traps guest accesses to the debug registers if
>   the guest is not actively using them (see the KVM_ARM64_DEBUG_DIRTY
>   flag on vcpu->arch.debug_flags).  Since the guest must not interfere
>   with the hardware state when debugging the guest, we must ensure that
>   trapping is enabled whenever we are debugging the guest.
> 

thinking about this, I don't think we're enforcing this yet, but maybe
that will come in the later patches or I misread the original paragraph.

-Christoffer
