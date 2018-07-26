From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 26 Jul 2018 13:58:35 +0100
Subject: [RFC PATCH 13/16] KVM: Allow 2048-bit register access via
 KVM_{GET, SET}_ONE_REG
In-Reply-To: <874lgntihl.fsf@linaro.org>
References: <1529593060-542-1-git-send-email-Dave.Martin@arm.com>
 <1529593060-542-14-git-send-email-Dave.Martin@arm.com>
 <874lgntihl.fsf@linaro.org>
Message-ID: <20180726125834.GV4240@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 25, 2018 at 04:58:30PM +0100, Alex Benn?e wrote:
> 
> Dave Martin <Dave.Martin@arm.com> writes:
> 
> > The Arm SVE architecture defines registers that are up to 2048 bits
> > in size (with some possibility of further future expansion).
> >
> > In order to avoid the need for an excessively large number of
> > ioctls when saving and restoring a vcpu's registers, this patch
> > adds a #define to make support for individual 2048-bit registers
> > through the KVM_{GET,SET}_ONE_REG ioctl interface official.  This
> > will allow each SVE register to be accessed in a single call.
> >
> > There are sufficient spare bits in the register id size field for
> > this change, so there is no ABI impact providing that
> > KVM_GET_REG_LIST does not enumerate any 2048-bit register unless
> > userspace explicitly opts in to the relevant architecture-specific
> > features.
> 
> Does it? It's not in this patch and looking at the final tree:
> 
>   unsigned long kvm_arm_num_regs(struct kvm_vcpu *vcpu)
>   {
>           unsigned long res = 0;
> 
>           res += num_core_regs();
>           res += num_sve_regs(vcpu);
>           res += kvm_arm_num_sys_reg_descs(vcpu);
>           res += kvm_arm_get_fw_num_regs(vcpu);
>           res += NUM_TIMER_REGS;
> 
>           return res;
>   }
> 
> 
> which leads to:
> 
>   static int enumerate_sve_regs(const struct kvm_vcpu *vcpu, u64 __user **uind)
>   {
>           unsigned int n, i;
>           int err = 0;
>           int total = 0;
>           unsigned int slices;
> 
>           if (!vcpu_has_sve(&vcpu->arch))
>                   return 0;
> 
> Which enumerates the SVE regs if vcpu_has_sve() which AFAICT is true if
> the host supports it, not if the user has requested it.
> 
> I'll have to check what but given the indirection of kvm_one_reg I
> wonder if existing binaries might end up spamming a badly sized array
> when run on a new SVE supporting kernel?

That shouldn't be the case: vcpu_has_sve() checks for the
KVM_ARM64_GUEST_HAS_SVE flag, which should only be set if userspace asks
for it.

Give me a shout if this doesn't seem to be the case...

Cheers
---Dave
