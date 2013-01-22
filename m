From: srivatsa.bhat@linux.vnet.ibm.com (Srivatsa S. Bhat)
Date: Tue, 22 Jan 2013 13:10:13 +0530
Subject: [PATCH v5 27/45] KVM: Use get/put_online_cpus_atomic() to prevent CPU
 offline from atomic context
In-Reply-To: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
References: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
Message-ID: <20130122074009.13822.3090.stgit@srivatsabhat.in.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Once stop_machine() is gone from the CPU offline path, we won't be able to
depend on preempt_disable() or local_irq_disable() to prevent CPUs from
going offline from under us.

Use the get/put_online_cpus_atomic() APIs to prevent CPUs from going offline,
while invoking from atomic context.

Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Gleb Natapov <gleb@redhat.com>
Cc: kvm at vger.kernel.org
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 virt/kvm/kvm_main.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 1cd693a..47f9c30 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -174,7 +174,8 @@ static bool make_all_cpus_request(struct kvm *kvm, unsigned int req)
 
 	zalloc_cpumask_var(&cpus, GFP_ATOMIC);
 
-	me = get_cpu();
+	get_online_cpus_atomic();
+	me = smp_processor_id();
 	kvm_for_each_vcpu(i, vcpu, kvm) {
 		kvm_make_request(req, vcpu);
 		cpu = vcpu->cpu;
@@ -192,7 +193,7 @@ static bool make_all_cpus_request(struct kvm *kvm, unsigned int req)
 		smp_call_function_many(cpus, ack_flush, NULL, 1);
 	else
 		called = false;
-	put_cpu();
+	put_online_cpus_atomic();
 	free_cpumask_var(cpus);
 	return called;
 }
@@ -1621,11 +1622,12 @@ void kvm_vcpu_kick(struct kvm_vcpu *vcpu)
 		++vcpu->stat.halt_wakeup;
 	}
 
-	me = get_cpu();
+	get_online_cpus_atomic();
+	me = smp_processor_id();
 	if (cpu != me && (unsigned)cpu < nr_cpu_ids && cpu_online(cpu))
 		if (kvm_arch_vcpu_should_kick(vcpu))
 			smp_send_reschedule(cpu);
-	put_cpu();
+	put_online_cpus_atomic();
 }
 #endif /* !CONFIG_S390 */
 
