From: n.nikolaev@virtualopensystems.com (Nikolay Nikolaev)
Date: Sat, 24 Jan 2015 13:59:40 +0200
Subject: [PATCH v3 2/5] KVM: ARM: on IO mem abort - route the call to KVM
 MMIO bus
In-Reply-To: <20150124115815.11052.20755.stgit@i3820>
References: <20150124115815.11052.20755.stgit@i3820>
Message-ID: <20150124115940.11052.23036.stgit@i3820>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On IO memory abort, try to handle the MMIO access thorugh the KVM
registered read/write callbacks. This is done by invoking the relevant
kvm_io_bus_* API.

Signed-off-by: Nikolay Nikolaev <n.nikolaev@virtualopensystems.com>
---
 arch/arm/kvm/mmio.c |   33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/kvm/mmio.c b/arch/arm/kvm/mmio.c
index 5d3bfc0..d852137 100644
--- a/arch/arm/kvm/mmio.c
+++ b/arch/arm/kvm/mmio.c
@@ -162,6 +162,36 @@ static int decode_hsr(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	return 0;
 }
 
+/**
+ * handle_kernel_mmio - handle an in-kernel MMIO access
+ * @vcpu:	pointer to the vcpu performing the access
+ * @run:	pointer to the kvm_run structure
+ * @mmio:	pointer to the data describing the access
+ *
+ * returns true if the MMIO access has been performed in kernel space,
+ * and false if it needs to be emulated in user space.
+ */
+static bool handle_kernel_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run,
+		struct kvm_exit_mmio *mmio)
+{
+	int ret;
+
+	if (mmio->is_write) {
+		ret = kvm_io_bus_write(vcpu, KVM_MMIO_BUS, mmio->phys_addr,
+				mmio->len, &mmio->data);
+
+	} else {
+		ret = kvm_io_bus_read(vcpu, KVM_MMIO_BUS, mmio->phys_addr,
+				mmio->len, &mmio->data);
+	}
+	if (!ret) {
+		kvm_prepare_mmio(run, mmio);
+		kvm_handle_mmio_return(vcpu, run);
+	}
+
+	return !ret;
+}
+
 int io_mem_abort(struct kvm_vcpu *vcpu, struct kvm_run *run,
 		 phys_addr_t fault_ipa)
 {
@@ -203,6 +233,9 @@ int io_mem_abort(struct kvm_vcpu *vcpu, struct kvm_run *run,
 	if (vgic_handle_mmio(vcpu, run, &mmio))
 		return 1;
 
+	if (handle_kernel_mmio(vcpu, run, &mmio))
+		return 1;
+
 	kvm_prepare_mmio(run, &mmio);
 	return 0;
 }
