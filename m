From: punit.agrawal@arm.com (Punit Agrawal)
Date: Tue, 10 Jan 2017 11:38:49 +0000
Subject: [PATCH v3 2/9] KVM: Track the pid of the VM process
In-Reply-To: <20170110113856.7183-1-punit.agrawal@arm.com>
References: <20170110113856.7183-1-punit.agrawal@arm.com>
Message-ID: <20170110113856.7183-3-punit.agrawal@arm.com>
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
index 1c5190dab2c1..c666926529ca 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -374,6 +374,7 @@ struct kvm_memslots {
 struct kvm {
 	spinlock_t mmu_lock;
 	struct mutex slots_lock;
+	struct pid *pid;
 	struct mm_struct *mm; /* userspace tied to this vm */
 	struct kvm_memslots *memslots[KVM_ADDRESS_SPACE_NUM];
 	struct srcu_struct srcu;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 482612b4e496..59d8a84da227 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -618,6 +618,7 @@ static struct kvm *kvm_create_vm(unsigned long type)
 	spin_lock_init(&kvm->mmu_lock);
 	atomic_inc(&current->mm->mm_count);
 	kvm->mm = current->mm;
+	kvm->pid = get_task_pid(current->group_leader, PIDTYPE_PID);
 	kvm_eventfd_init(kvm);
 	mutex_init(&kvm->lock);
 	mutex_init(&kvm->irq_lock);
@@ -717,6 +718,7 @@ static void kvm_destroy_vm(struct kvm *kvm)
 	int i;
 	struct mm_struct *mm = kvm->mm;
 
+	put_pid(kvm->pid);
 	kvm_destroy_vm_debugfs(kvm);
 	kvm_arch_sync_events(kvm);
 	spin_lock(&kvm_lock);
-- 
2.11.0
