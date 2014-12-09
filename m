From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue,  9 Dec 2014 12:26:06 +0100
Subject: [GIT PULL 7/9] arm/arm64: KVM: avoid unnecessary guest register
 mangling on MMIO read
In-Reply-To: <1418124368-28418-1-git-send-email-christoffer.dall@linaro.org>
References: <1418124368-28418-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1418124368-28418-8-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andre Przywara <andre.przywara@arm.com>

Currently we mangle the endianness of the guest's register even on an
MMIO _read_, where it is completely useless, because we will not use
the value of that register.
Rework the io_mem_abort() function to clearly separate between reads
and writes and only do the endianness mangling on MMIO writes.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kvm/mmio.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm/kvm/mmio.c b/arch/arm/kvm/mmio.c
index 4cb5a93..5d3bfc0 100644
--- a/arch/arm/kvm/mmio.c
+++ b/arch/arm/kvm/mmio.c
@@ -187,15 +187,18 @@ int io_mem_abort(struct kvm_vcpu *vcpu, struct kvm_run *run,
 	}
 
 	rt = vcpu->arch.mmio_decode.rt;
-	data = vcpu_data_guest_to_host(vcpu, *vcpu_reg(vcpu, rt), mmio.len);
 
-	trace_kvm_mmio((mmio.is_write) ? KVM_TRACE_MMIO_WRITE :
-					 KVM_TRACE_MMIO_READ_UNSATISFIED,
-			mmio.len, fault_ipa,
-			(mmio.is_write) ? data : 0);
+	if (mmio.is_write) {
+		data = vcpu_data_guest_to_host(vcpu, *vcpu_reg(vcpu, rt),
+					       mmio.len);
 
-	if (mmio.is_write)
+		trace_kvm_mmio(KVM_TRACE_MMIO_WRITE, mmio.len,
+			       fault_ipa, data);
 		mmio_write_buf(mmio.data, mmio.len, data);
+	} else {
+		trace_kvm_mmio(KVM_TRACE_MMIO_READ_UNSATISFIED, mmio.len,
+			       fault_ipa, 0);
+	}
 
 	if (vgic_handle_mmio(vcpu, run, &mmio))
 		return 1;
-- 
2.1.2.330.g565301e.dirty
