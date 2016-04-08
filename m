From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri,  8 Apr 2016 11:52:12 +0200
Subject: [PULL 1/4] arm64: KVM: Add braces to multi-line if statement in
 virtual PMU code
In-Reply-To: <1460109135-6612-1-git-send-email-christoffer.dall@linaro.org>
References: <1460109135-6612-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1460109135-6612-2-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Will Deacon <will.deacon@arm.com>

The kernel is written in C, not python, so we need braces around
multi-line if statements. GCC 6 actually warns about this, thanks to the
fantastic new "-Wmisleading-indentation" flag:

 | virt/kvm/arm/pmu.c: In function ?kvm_pmu_overflow_status?:
 | virt/kvm/arm/pmu.c:198:3: warning: statement is indented as if it were guarded by... [-Wmisleading-indentation]
 |    reg &= vcpu_sys_reg(vcpu, PMCNTENSET_EL0);
 |    ^~~
 | arch/arm64/kvm/../../../virt/kvm/arm/pmu.c:196:2: note: ...this ?if? clause, but it is not
 |   if ((vcpu_sys_reg(vcpu, PMCR_EL0) & ARMV8_PMU_PMCR_E))
 |   ^~

As it turns out, this particular case is harmless (we just do some &=
operations with 0), but worth fixing nonetheless.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/arm/pmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
index b5754c6..575c7aa 100644
--- a/virt/kvm/arm/pmu.c
+++ b/virt/kvm/arm/pmu.c
@@ -193,11 +193,12 @@ static u64 kvm_pmu_overflow_status(struct kvm_vcpu *vcpu)
 {
 	u64 reg = 0;
 
-	if ((vcpu_sys_reg(vcpu, PMCR_EL0) & ARMV8_PMU_PMCR_E))
+	if ((vcpu_sys_reg(vcpu, PMCR_EL0) & ARMV8_PMU_PMCR_E)) {
 		reg = vcpu_sys_reg(vcpu, PMOVSSET_EL0);
 		reg &= vcpu_sys_reg(vcpu, PMCNTENSET_EL0);
 		reg &= vcpu_sys_reg(vcpu, PMINTENSET_EL1);
 		reg &= kvm_pmu_valid_counter_mask(vcpu);
+	}
 
 	return reg;
 }
-- 
2.1.2.330.g565301e.dirty
