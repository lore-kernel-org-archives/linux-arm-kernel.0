From: cdall@linaro.org (Christoffer Dall)
Date: Wed, 22 Nov 2017 21:28:51 +0100
Subject: [PATCH 05/37] KVM: Record the executing ioctl number on the vcpu
 struct
In-Reply-To: <20171107104501.74enxcrv762jui4i@kamzik.brq.redhat.com>
References: <20171012104141.26902-1-christoffer.dall@linaro.org>
 <20171012104141.26902-6-christoffer.dall@linaro.org>
 <20171107104501.74enxcrv762jui4i@kamzik.brq.redhat.com>
Message-ID: <20171122202851.GU28855@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 07, 2017 at 11:45:01AM +0100, Andrew Jones wrote:
> On Thu, Oct 12, 2017 at 12:41:09PM +0200, Christoffer Dall wrote:
> > Some architectures may decide to do different things during
> > kvm_arch_vcpu_load depending on the ioctl being executed.  For example,
> > arm64 is about to do significant work in vcpu load/put when running a
> > vcpu, but not when doing things like KVM_SET_ONE_REG or
> > KVM_SET_MP_STATE.
> > 
> > Therefore, store the ioctl number that we are executing on the VCPU
> > during the first vcpu_load() which succeeds in getting the vcpu->mutex
> > and set the ioctl number to 0 when exiting kvm_vcpu_ioctl() after
> > successfully loading the vcpu.
> > 
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Radim Kr?m?? <rkrcmar@redhat.com>
> > Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> > ---
> >  arch/x86/kvm/vmx.c       | 2 +-
> >  arch/x86/kvm/x86.c       | 8 ++++----
> >  include/linux/kvm_host.h | 3 ++-
> >  virt/kvm/kvm_main.c      | 6 ++++--
> >  4 files changed, 11 insertions(+), 8 deletions(-)
> >
> 
> I wonder if enough other architectures would be able to benefit from this
> for most/all of their non-RUN VCPU ioctls. If so, then maybe we should
> consider doing something like
> 
>  int __vcpu_load(struct kvm_vcpu *vcpu)
>  {
>     int cpu;
> 
>     cpu = get_cpu();
>     preempt_notifier_register(&vcpu->preempt_notifier);
>     kvm_arch_vcpu_load(vcpu, cpu);
>     put_cpu();
>     return 0;
>  }
>  int vcpu_load(struct kvm_vcpu *vcpu)
>  {
>     if (mutex_lock_killable(&vcpu->mutex))
>         return -EINTR;
>     return __vcpu_load(vcpu);
>  }
> 
> and the equivalent for vcpu_put.
> 
> Then just take the lock in kvm_vcpu_ioctl and leave it to the
> kvm_arch_vcpu_ioctl_* functions to call __vcpu_load/__vcpu_put
> if necessary.
> 
That seems like it would be a pretty invasive change, because we change
the semantics of when kvm_arch_vcpu_load() is called, and I'm not really
sure when it then does/doesn't make sense to call __vcpu_load/__vcpu_put
for each architecture.

But on ARM we only need preempt_notifiers for KVM_RUN, so if it's
similar on other architectures, it might not be that bad.

Was your intention about vcpu_load() then that x86 could remain
unmodified?

Thanks,
-Christoffer
