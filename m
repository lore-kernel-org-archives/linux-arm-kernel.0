From: rkrcmar@redhat.com (=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?=)
Date: Mon, 21 Aug 2017 22:35:24 +0200
Subject: [PATCH RFC v3 3/9] KVM: remember position in kvm->vcpus array
In-Reply-To: <20170821203530.9266-1-rkrcmar@redhat.com>
References: <20170821203530.9266-1-rkrcmar@redhat.com>
Message-ID: <20170821203530.9266-4-rkrcmar@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Radim Kr?m?? <rkrcmar@redhat.com>
---
 include/linux/kvm_host.h | 11 +++--------
 virt/kvm/kvm_main.c      |  5 ++++-
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 6882538eda32..a8ff956616d2 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -220,7 +220,8 @@ struct kvm_vcpu {
 	struct preempt_notifier preempt_notifier;
 #endif
 	int cpu;
-	int vcpu_id;
+	int vcpu_id; /* id given by userspace at creation */
+	int vcpus_idx; /* index in kvm->vcpus array */
 	int srcu_idx;
 	int mode;
 	unsigned long requests;
@@ -516,13 +517,7 @@ static inline struct kvm_vcpu *kvm_get_vcpu_by_id(struct kvm *kvm, int id)
 
 static inline int kvm_vcpu_get_idx(struct kvm_vcpu *vcpu)
 {
-	struct kvm_vcpu *tmp;
-	int idx;
-
-	kvm_for_each_vcpu(idx, tmp, vcpu->kvm)
-		if (tmp == vcpu)
-			return idx;
-	BUG();
+	return vcpu->vcpus_idx;
 }
 
 #define kvm_for_each_memslot(memslot, slots)	\
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index e17c40d986f3..caf8323f7df7 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2498,7 +2498,10 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, u32 id)
 		goto unlock_vcpu_destroy;
 	}
 
-	BUG_ON(kvm->vcpus[atomic_read(&kvm->online_vcpus)]);
+	vcpu->vcpus_idx = atomic_read(&kvm->online_vcpus);
+
+	BUG_ON(kvm->vcpus[vcpu->vcpus_idx]);
+
 
 	/* Now it's all set up, let userspace reach it */
 	kvm_get_kvm(kvm);
-- 
2.13.3
