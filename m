From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 23 Sep 2014 15:52:41 +0200
Subject: [GIT PULL] arm/arm64: KVM: Fix unaligned access bug on gicv2
 access
In-Reply-To: <54216B1B.2010205@arm.com>
References: <1411420350-368-1-git-send-email-christoffer.dall@linaro.org>
 <1411420350-368-2-git-send-email-christoffer.dall@linaro.org>
 <20140922220710.GA24499@arm.com> <5421310E.9020902@redhat.com>
 <20140923111412.GG12187@cbox> <54215E6D.6090308@redhat.com>
 <54216B1B.2010205@arm.com>
Message-ID: <20140923135241.GI12187@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 23, 2014 at 01:44:11PM +0100, Andre Przywara wrote:
> Hi,
> 
> On 23/09/14 12:50, Paolo Bonzini wrote:
> > Il 23/09/2014 13:14, Christoffer Dall ha scritto:
> >> On Tue, Sep 23, 2014 at 10:36:30AM +0200, Paolo Bonzini wrote:
> >>> Il 23/09/2014 00:07, Will Deacon ha scritto:
> >>>>>>  {
> >>>>>>  	if (!(lr_desc.state & LR_STATE_MASK))
> >>>>>> -		set_bit(lr, (unsigned long *)vcpu->arch.vgic_cpu.vgic_v2.vgic_elrsr);
> >>>>>> +		__set_bit(lr, (unsigned long *)vcpu->arch.vgic_cpu.vgic_v2.vgic_elrsr);
> >>>>>>  }
> >>>> Does this work for big-endian arm64 machines? Surely the bug is due to
> >>>> casting a u32 * to an unsigned long *, and not specifically related to
> >>>> atomics (which is where it happened to explode)?
> >>>
> >> It does look like the whole thing is broken on BE systems, but fixing
> >> that becomes non-trivial.  I don't think this fix is incorrect in
> >> itself, but we do have a larger issue with BE.
> >>
> >> I took a stab at fixing this (untested for BE), which looks something
> >> like the following, but I'm a bit uneasy about having to test and merge
> >> this as a fix given the rush before 3.17 is released.
> >>
> >> Thoughts?
> > 
> > If big-endian is broken anyway, let's apply this only:
> > 
> >> diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
> >> index 35b0c12..c66dc9ed 100644
> >> --- a/include/kvm/arm_vgic.h
> >> +++ b/include/kvm/arm_vgic.h
> >> @@ -168,8 +168,8 @@ struct vgic_v2_cpu_if {
> >>  	u32		vgic_hcr;
> >>  	u32		vgic_vmcr;
> >>  	u32		vgic_misr;	/* Saved only */
> >> -	u32		vgic_eisr[2];	/* Saved only */
> >> -	u32		vgic_elrsr[2];	/* Saved only */
> >> +	u64		vgic_eisr;	/* Saved only */
> >> +	u64		vgic_elrsr;	/* Saved only */
> >>  	u32		vgic_apr;
> >>  	u32		vgic_lr[VGIC_V2_MAX_LRS];
> >>  };
> 
> I think Marc's point on this was not to spoil 32bit code (as this is the
> GIC, which is shared). In the GICv2 spec the register are declared as a
> number of 32 bit registers, so there is some sense in keeping it u32.
> So I came up with the following this morning:
> 
> diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
> index 35b0c12..6f884df 100644
> --- a/include/kvm/arm_vgic.h
> +++ b/include/kvm/arm_vgic.h
> @@ -168,8 +168,14 @@ struct vgic_v2_cpu_if {
>         u32             vgic_hcr;
>         u32             vgic_vmcr;
>         u32             vgic_misr;      /* Saved only */
> -       u32             vgic_eisr[2];   /* Saved only */
> -       u32             vgic_elrsr[2];  /* Saved only */
> +       union {
> +               u32             vgic_eisr[2];   /* Saved only */
> +               unsigned long   vgic_eisr_bm[8 / sizeof(long)];
> +       };
> +       union {
> +               u32             vgic_elrsr[2];  /* Saved only */
> +               unsigned long   vgic_elrsr_bm[8 / sizeof(long)];
> +       };
>         u32             vgic_apr;
>         u32             vgic_lr[VGIC_V2_MAX_LRS];
>  };
> 
> And then use vgic_elrsr_bm in set_bit().
> 
> Admittedly a bit hacky, but fixes the alignment issue while still
> retaining sane code for ARM.
> If anyone knows a good fix for that "8 / sizeof(long)" kludge, I am all
> ears.
> 

I honestly thing this obfuscates what's going on more than it helps.  I
think in general complicating your data structure because of the way you
consume it is the wrong way to go, unless it significantly simplifies a
complicated set of manipulators.

Another thing is that this fix does not address the fact that you're
still returning a u64 from vgic_get_elrsr() and related functions, which
will break with the use of for_each_set_bit() in the callers when the
host is a 32-bit BE system.  You'd have to change the accessor functions
to return an (unsigned long *) as well with your change above and 64-bit
BE systems would have to switch the order of the words when accessing
your vgic_elrsr_bm field.  I tried this, and it doesn't look nice.

Therefore, I think we should really just merge the one-line fix or the
patch I sent before.  Paolo seems fine with it either way.

If anyone feels like reviewing my patch and giving it a quick test on a
BE system with a version of QEMU with the pl011 level-triggered patch,
real soon, like today'ish, then we can use that, but otherwise let's go
with the one-liner.

-Christoffer
