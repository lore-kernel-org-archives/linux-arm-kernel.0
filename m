From: christoffer.dall@arm.com (Christoffer Dall)
Date: Thu, 22 Nov 2018 14:07:18 +0100
Subject: [RFC PATCH v2 11/23] KVM: arm64: Support runtime sysreg
 filtering for KVM_GET_REG_LIST
In-Reply-To: <20181122123235.GQ4719@e103592.cambridge.arm.com>
References: <1538141967-15375-1-git-send-email-Dave.Martin@arm.com>
 <1538141967-15375-12-git-send-email-Dave.Martin@arm.com>
 <20181102081625.GS12057@e113682-lin.lund.arm.com>
 <20181115172711.GQ3505@e103592.cambridge.arm.com>
 <20181122105344.GF17441@e113682-lin.lund.arm.com>
 <87bm6hic7a.fsf@linaro.org>
 <20181122123235.GQ4719@e103592.cambridge.arm.com>
Message-ID: <20181122130717.GH17441@e113682-lin.lund.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 22, 2018 at 01:32:37PM +0100, Dave P Martin wrote:
> On Thu, Nov 22, 2018 at 11:27:53AM +0000, Alex Benn?e wrote:
> > 
> > Christoffer Dall <christoffer.dall@arm.com> writes:
> > 
> > > [Adding Peter and Alex for their view on the QEMU side]
> > >
> > > On Thu, Nov 15, 2018 at 05:27:11PM +0000, Dave Martin wrote:
> > >> On Fri, Nov 02, 2018 at 09:16:25AM +0100, Christoffer Dall wrote:
> > >> > On Fri, Sep 28, 2018 at 02:39:15PM +0100, Dave Martin wrote:
> > >> > > KVM_GET_REG_LIST should only enumerate registers that are actually
> > >> > > accessible, so it is necessary to filter out any register that is
> > >> > > not exposed to the guest.  For features that are configured at
> > >> > > runtime, this will require a dynamic check.
> > >> > >
> > >> > > For example, ZCR_EL1 and ID_AA64ZFR0_EL1 would need to be hidden
> > >> > > if SVE is not enabled for the guest.
> > >> >
> > >> > This implies that userspace can never access this interface for a vcpu
> > >> > before having decided whether such features are enabled for the guest or
> > >> > not, since otherwise userspace will see different states for a VCPU
> > >> > depending on sequencing of the API, which sounds fragile to me.
> > >> >
> > >> > That should probably be documented somewhere, and I hope the
> > >> > enable/disable API for SVE in guests already takes that into account.
> > >> >
> > >> > Not sure if there's an action to take here, but it was the best place I
> > >> > could raise this concern.
> > >>
> > >> Fair point.  I struggled to come up with something better that solves
> > >> all problems.
> > >>
> > >> My expectation is that KVM_ARM_SVE_CONFIG_SET is considered part of
> > >> creating the vcpu, so that if issued at all for a vcpu, it is issued
> > >> very soon after KVM_VCPU_INIT.
> > >>
> > >> I think this worked OK with the current structure of kvmtool and I
> > >> seem to remember discussing this with Peter Maydell re qemu -- but
> > >> it sounds like I should double-check.
> > >
> > > QEMU does some thing around enumerating all the system registers exposed
> > > by KVM and saving/restoring them as part of its startup, but I don't
> > > remember the exact sequence.
> > 
> > QEMU does this for each vCPU as part of it's start-up sequence:
> > 
> >   kvm_init_vcpu
> >     kvm_get_cpu (-> KVM_CREATE_VCPU)
> >     KVM_GET_VCPU_MMAP_SIZE
> >     kvm_arch_init_vcpu
> >       kvm_arm_vcpu_init (-> KVM_ARM_VCPU_INIT)
> >       kvm_get_one_reg(ARM_CPU_ID_MPIDR)
> >       kvm_arm_init_debug (chk for KVM_CAP SET_GUEST_DEBUG/GUEST_DEBUG_HW_WPS/BPS)
> >       kvm_arm_init_serror_injection (chk KVM_CAP_ARM_INJECT_SERROR_ESR)
> >       kvm_arm_init_cpreg_list (KVM_GET_REG_LIST)
> > 
> > At this point we have the register list we need for
> > kvm_arch_get_registers which is what we call every time we want to
> > synchronise state. We only really do this for debug events, crashes and
> > at some point when migrating.
> 
> So we would need to insert KVM_ARM_SVE_CONFIG_SET into this sequence,
> meaning that the new capability is not strictly necessary.
> 
> I sympathise with Christoffer's view though that without the capability
> mechanism it may be too easy for software to make mistakes: code
> refactoring might swap the KVM_GET_REG_LIST and KVM_ARM_SVE_CONFIG ioctls
> over and then things would go wrong with no immediate error indication.
> 
> In effect, the SVE regs would be missing from the list yielded by
> KVM_GET_REG_LIST, possibly leading to silent migration failures.
> 
> I'm a bit uneasy about that.  Am I being too paranoid now?
> 

No, we've made decisions in the past where we didn't enforce ordering
which ended up being a huge pain (vgic lazy init, as a clear example of
something really bad).  Of course, it's a tradeoff.  If it's a huge pain
to implement, maybe things will be ok, but if it's just a read/write
capability handshake, I think it's worth doing.


Thanks,

    Christoffer
