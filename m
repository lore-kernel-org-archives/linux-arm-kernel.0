From: punit.agrawal@arm.com (Punit Agrawal)
Date: Wed, 26 Oct 2016 18:41:42 +0100
Subject: [PATCH v2 2/8] KVM: Track the pid of the VM process
In-Reply-To: <20161026174148.17172-1-punit.agrawal@arm.com>
References: <20161026174148.17172-1-punit.agrawal@arm.com>
Message-ID: <20161026174148.17172-3-punit.agrawal@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Userspace tools such as perf can be used to profile individual
processes.

Track the PID of the virtual machine process to match profiling requests
targeted at it. This can be used to take appropriate action to enable
the requested profiling operations for the VMs of interest.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Kr?m??" <rkrcmar@redhat.com>
Cc: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 include/linux/kvm_host.h | 1 +
 virt/kvm/kvm_main.c      | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 01c0b9c..4caff20 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -375,6 +375,7 @@ struct kvm_memslots {
 struct kvm {
 	spinlock_t mmu_lock;
 	struct mutex slots_lock;
+	struct pid *pid;
 	struct mm_struct *mm; /* userspace tied to this vm */
 	struct kvm_memslots *memslots[KVM_ADDRESS_SPACE_NUM];
 	struct srcu_struct srcu;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 28510e7..ed3823c 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -615,6 +615,7 @@ static struct kvm *kvm_create_vm(unsigned long type)
 	spin_lock_init(&kvm->mmu_lock);
 	atomic_inc(&current->mm->mm_count);
 	kvm->mm = current->mm;
+	kvm->pid = get_task_pid(current->group_leader, PIDTYPE_PID);
 	kvm_eventfd_init(kvm);
 	mutex_init(&kvm->lock);
 	mutex_init(&kvm->irq_lock);
@@ -714,6 +715,7 @@ static void kvm_destroy_vm(struct kvm *kvm)
 	int i;
 	struct mm_struct *mm = kvm->mm;
 
+	put_pid(kvm->pid);
 	kvm_destroy_vm_debugfs(kvm);
 	kvm_arch_sync_events(kvm);
 	spin_lock(&kvm_lock);
-- 
2.9.3
