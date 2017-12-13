From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 13 Dec 2017 17:11:01 +0000
Subject: [RFC v2] arm64: KVM: KVM API extensions for SVE
In-Reply-To: <CAFEAcA-Rogf9m7GMPD3PKs7miEpx-bMMn72Y+2=eF4oiCdLqqw@mail.gmail.com>
References: <20171213165543.GO22781@e103592.cambridge.arm.com>
 <CAFEAcA-Rogf9m7GMPD3PKs7miEpx-bMMn72Y+2=eF4oiCdLqqw@mail.gmail.com>
Message-ID: <20171213171101.GP22781@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 13, 2017 at 04:58:16PM +0000, Peter Maydell wrote:
> On 13 December 2017 at 16:55, Dave Martin <Dave.Martin@arm.com> wrote:
> > Vector length control:
> >
> > Some means is needed to determine the set of vector lengths visible
> > to guest software running on a vcpu.
> >
> > When a vcpu is created, the set would be defaulted to the maximal set
> > that can be supported while permitting each vcpu to run on any host
> > CPU.  SVE has some virtualisation quirks which mean that this set may
> > exclude some vector lengths that are available for host userspace
> > applications.  The common case should be that the sets are the same
> > however.
> >
> >  * New ioctl KVM_ARM_VCPU_{SET,GET}_SVE_VLS to set or retrieve the set of
> >    vector lengths available to the guest.
> >
> >    Adding random vcpu ioctls
> >
> >    To configure a non-default set of vector lengths,
> >    KVM_ARM_VCPU_SET_SVE_VLS can be called: this would only be permitted
> >    before the vcpu is first run.
> >
> >    This is primarily intended for supporting migration, by providing a
> >    robust check that the destination node will run the vcpu correctly.
> >    In a cluster with non-uniform SVE implementation across nodes, this
> >    also allows a specific set of VLs to be requested that the caller
> >    knows is usable across the whole cluster.
> >
> >    For migration purposes, userspace would need to do
> >    KVM_ARM_VCPU_GET_SVE_VLS at the origin node and store the returned
> >    set as VM metadata: on the destination node,
> >    KVM_ARM_VCPU_SET_SVE_VLS should be used to request that exact set of
> >    VLs: if the destination node can't support that set of VLs, the call
> >    will fail.
> 
> Can we just do this with the existing ONE_REG APIs? If you
> expose this via those, then QEMU doesn't need to do anything
> for migration at all. This is the same way we (intend to)
> check any optional-feature compatibility at each end, for
> instance features exposed in guest-visible ID registers.
> It's just that the "register" for the SVE vector-lengths case
> is one that's not visible to the guest.

Probably, but there are some things that are a bit nasty.
For now, I suggested an ioctl as being minimally invasive on the
kernel side, but I'm not committed to it.


The set of vector lengths is a not guest register in the usual sense,
and modifying it at runtime makes no sense, so I would rather forbid
it.  Do we have precedent for that?  I was getting pushback from
Marc and/or Christoffer on exposing "ZCR_EL2" via the reg interface for
similar reasons -- that turned out to be too simplistic for other
reasons anyway.

Also, arranging things so that it doesn't matter which order the
SVE regs and VL set are written with respect to one another may
add significant complexity to KVM which I'd rather avoid.

Cheers
---Dave
