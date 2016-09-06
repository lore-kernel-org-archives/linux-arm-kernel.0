From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 6 Sep 2016 12:25:42 +0200
Subject: [RFC v2 PATCH 2/7] KVM: Track the pid of the VM process
In-Reply-To: <87poohjqzk.fsf@e105922-lin.cambridge.arm.com>
References: <1473093097-30932-1-git-send-email-punit.agrawal@arm.com>
 <1473093097-30932-3-git-send-email-punit.agrawal@arm.com>
 <20160906062252.GA30513@cbox>
 <87poohjqzk.fsf@e105922-lin.cambridge.arm.com>
Message-ID: <20160906102542.GG30513@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 06, 2016 at 10:51:27AM +0100, Punit Agrawal wrote:
> Hi Christoffer,
> 
> Christoffer Dall <christoffer.dall@linaro.org> writes:
> 
> > On Mon, Sep 05, 2016 at 05:31:32PM +0100, Punit Agrawal wrote:
> >> Userspace tools such as perf can be used to profile individual
> >> processes.
> >> 
> >> Track the PID of the virtual machine process to match profiling requests
> >> targeted at it. This can be used to take appropriate action to enable
> >> the requested profiling operations for the VMs of interest.
> >> 
> >> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> >> Cc: Paolo Bonzini <pbonzini@redhat.com>
> >> Cc: "Radim Kr?m??" <rkrcmar@redhat.com>
> >> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> >> Cc: Marc Zyngier <marc.zyngier@arm.com>
> >> ---
> >>  include/linux/kvm_host.h | 1 +
> >>  virt/kvm/kvm_main.c      | 2 ++
> >>  2 files changed, 3 insertions(+)
> >> 
> >> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> >> index 9c28b4d..7c42c94 100644
> >> --- a/include/linux/kvm_host.h
> >> +++ b/include/linux/kvm_host.h
> >> @@ -374,6 +374,7 @@ struct kvm_memslots {
> >>  struct kvm {
> >>  	spinlock_t mmu_lock;
> >>  	struct mutex slots_lock;
> >> +	struct pid *pid;
> >>  	struct mm_struct *mm; /* userspace tied to this vm */
> >>  	struct kvm_memslots *memslots[KVM_ADDRESS_SPACE_NUM];
> >>  	struct srcu_struct srcu;
> >> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> >> index 1950782..ab2535a 100644
> >> --- a/virt/kvm/kvm_main.c
> >> +++ b/virt/kvm/kvm_main.c
> >> @@ -613,6 +613,7 @@ static struct kvm *kvm_create_vm(unsigned long type)
> >>  	spin_lock_init(&kvm->mmu_lock);
> >>  	atomic_inc(&current->mm->mm_count);
> >>  	kvm->mm = current->mm;
> >> +	kvm->pid = get_task_pid(current, PIDTYPE_PID);
> >
> > How dooes this deal with threading?  Is the idea that the user by
> > specifying the main thread's pid will enable trapping for all vcpu
> > threads belonging to that VM?
> 
> Yes that's correct - specifying the main thread PID will enable trapping
> for the VM (all vcpus).
> 
> I am happy to move to a more suitable identifier if available.
> 

What is the 'main thread' ?

Does something mandate that the VM is created by the thread group
leader?  If not, is it not a bit strange from a user perspective, that
you have to find the specific subthread pid that created the vm to
enable this tracing for all vcpu threads and that the tgid doesn't work
in this case?

Thanks,
-Christoffer
