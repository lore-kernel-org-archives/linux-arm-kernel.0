From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 19 Oct 2018 13:58:55 +0100
Subject: [PATCH 20/26] KVM: arm64: Drop __cpu_init_stage2 on the VHE path
In-Reply-To: <20181019125901.185478-1-marc.zyngier@arm.com>
References: <20181019125901.185478-1-marc.zyngier@arm.com>
Message-ID: <20181019125901.185478-21-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

__cpu_init_stage2 doesn't do anything anymore on arm64, and is
totally non-sensical if running VHE (as VHE is 64bit only).

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/arm/arm.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index 91c464c9cd21..4ce99bb223bc 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -1310,16 +1310,10 @@ static void cpu_hyp_reinit(void)
 {
 	cpu_hyp_reset();
 
-	if (is_kernel_in_hyp_mode()) {
-		/*
-		 * __cpu_init_stage2() is safe to call even if the PM
-		 * event was cancelled before the CPU was reset.
-		 */
-		__cpu_init_stage2();
+	if (is_kernel_in_hyp_mode())
 		kvm_timer_init_vhe();
-	} else {
+	else
 		cpu_init_hyp_mode(NULL);
-	}
 
 	if (vgic_present)
 		kvm_vgic_init_cpu_hardware();
-- 
2.19.1
