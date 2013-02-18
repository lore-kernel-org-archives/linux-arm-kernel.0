From: srivatsa.bhat@linux.vnet.ibm.com (Srivatsa S. Bhat)
Date: Mon, 18 Feb 2013 18:12:26 +0530
Subject: [PATCH v6 29/46] kvm/vmx: Use get/put_online_cpus_atomic() to prevent
 CPU offline
In-Reply-To: <20130218123714.26245.61816.stgit@srivatsabhat.in.ibm.com>
References: <20130218123714.26245.61816.stgit@srivatsabhat.in.ibm.com>
Message-ID: <20130218124226.26245.11310.stgit@srivatsabhat.in.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Once stop_machine() is gone from the CPU offline path, we won't be able to
depend on preempt_disable() or local_irq_disable() to prevent CPUs from
going offline from under us.

Use the get/put_online_cpus_atomic() APIs to prevent CPUs from going offline,
while invoking from atomic context (in vmx_vcpu_load() to prevent CPUs from
going offline while clearing vmcs).

Reported-by: Michael Wang <wangyun@linux.vnet.ibm.com>
Debugged-by: Xiao Guangrong <xiaoguangrong@linux.vnet.ibm.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Gleb Natapov <gleb@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86 at kernel.org
Cc: kvm at vger.kernel.org
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 arch/x86/kvm/vmx.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 9120ae1..2886ff0 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -1557,10 +1557,14 @@ static void vmx_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	u64 phys_addr = __pa(per_cpu(vmxarea, cpu));
 
-	if (!vmm_exclusive)
+	if (!vmm_exclusive) {
 		kvm_cpu_vmxon(phys_addr);
-	else if (vmx->loaded_vmcs->cpu != cpu)
+	} else if (vmx->loaded_vmcs->cpu != cpu) {
+		/* Prevent any CPU from going offline */
+		get_online_cpus_atomic();
 		loaded_vmcs_clear(vmx->loaded_vmcs);
+		put_online_cpus_atomic();
+	}
 
 	if (per_cpu(current_vmcs, cpu) != vmx->loaded_vmcs->vmcs) {
 		per_cpu(current_vmcs, cpu) = vmx->loaded_vmcs->vmcs;
