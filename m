From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 27 Sep 2016 20:05:57 +0200
Subject: [PULL 49/50] KVM: arm64: Require in-kernel irqchip for PMU support
In-Reply-To: <20160927180558.14699-1-christoffer.dall@linaro.org>
References: <20160927180558.14699-1-christoffer.dall@linaro.org>
Message-ID: <20160927180558.14699-50-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If userspace creates a PMU for the VCPU, but doesn't create an in-kernel
irqchip, then we end up in a nasty path where we try to take an
uninitialized spinlock, which can lead to all sorts of breakages.

Luckily, QEMU always creates the VGIC before the PMU, so we can
establish this as ABI and check for the VGIC in the PMU init stage.
This can be relaxed at a later time if we want to support PMU with a
userspace irqchip.

Cc: stable at vger.kernel.org
Cc: Shannon Zhao <shannon.zhao@linaro.org>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 Documentation/virtual/kvm/devices/vcpu.txt | 4 +++-
 virt/kvm/arm/pmu.c                         | 8 ++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/virtual/kvm/devices/vcpu.txt b/Documentation/virtual/kvm/devices/vcpu.txt
index c041658..02f5068 100644
--- a/Documentation/virtual/kvm/devices/vcpu.txt
+++ b/Documentation/virtual/kvm/devices/vcpu.txt
@@ -30,4 +30,6 @@ Returns: -ENODEV: PMUv3 not supported
                  attribute
          -EBUSY: PMUv3 already initialized
 
-Request the initialization of the PMUv3.
+Request the initialization of the PMUv3.  This must be done after creating the
+in-kernel irqchip.  Creating a PMU with a userspace irqchip is currently not
+supported.
diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
index a027569..6e9c40e 100644
--- a/virt/kvm/arm/pmu.c
+++ b/virt/kvm/arm/pmu.c
@@ -423,6 +423,14 @@ static int kvm_arm_pmu_v3_init(struct kvm_vcpu *vcpu)
 	if (!kvm_arm_support_pmu_v3())
 		return -ENODEV;
 
+	/*
+	 * We currently require an in-kernel VGIC to use the PMU emulation,
+	 * because we do not support forwarding PMU overflow interrupts to
+	 * userspace yet.
+	 */
+	if (!irqchip_in_kernel(vcpu->kvm) || !vgic_initialized(vcpu->kvm))
+		return -ENODEV;
+
 	if (!test_bit(KVM_ARM_VCPU_PMU_V3, vcpu->arch.features) ||
 	    !kvm_arm_pmu_irq_initialized(vcpu))
 		return -ENXIO;
-- 
2.9.0
