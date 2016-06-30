From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 30 Jun 2016 15:39:36 +0200
Subject: [PULL 1/2] arm64: KVM: fix build with CONFIG_ARM_PMU disabled
In-Reply-To: <20160630133937.2654-1-christoffer.dall@linaro.org>
References: <20160630133937.2654-1-christoffer.dall@linaro.org>
Message-ID: <20160630133937.2654-2-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sudeep Holla <sudeep.holla@arm.com>

When CONFIG_ARM_PMU is disabled, we get the following build error:

arch/arm64/kvm/sys_regs.c: In function 'pmu_counter_idx_valid':
arch/arm64/kvm/sys_regs.c:564:27: error: 'ARMV8_PMU_CYCLE_IDX' undeclared (first use in this function)
  if (idx >= val && idx != ARMV8_PMU_CYCLE_IDX)
                           ^
arch/arm64/kvm/sys_regs.c:564:27: note: each undeclared identifier is reported only once for each function it appears in
arch/arm64/kvm/sys_regs.c: In function 'access_pmu_evcntr':
arch/arm64/kvm/sys_regs.c:592:10: error: 'ARMV8_PMU_CYCLE_IDX' undeclared (first use in this function)
    idx = ARMV8_PMU_CYCLE_IDX;
          ^
arch/arm64/kvm/sys_regs.c: In function 'access_pmu_evtyper':
arch/arm64/kvm/sys_regs.c:638:14: error: 'ARMV8_PMU_CYCLE_IDX' undeclared (first use in this function)
   if (idx == ARMV8_PMU_CYCLE_IDX)
              ^
arch/arm64/kvm/hyp/switch.c:86:15: error: 'ARMV8_PMU_USERENR_MASK' undeclared (first use in this function)
  write_sysreg(ARMV8_PMU_USERENR_MASK, pmuserenr_el0);

This patch fixes the build with CONFIG_ARM_PMU disabled.

Cc: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 include/kvm/arm_pmu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
index fe389ac..92e7e97 100644
--- a/include/kvm/arm_pmu.h
+++ b/include/kvm/arm_pmu.h
@@ -18,13 +18,13 @@
 #ifndef __ASM_ARM_KVM_PMU_H
 #define __ASM_ARM_KVM_PMU_H
 
-#ifdef CONFIG_KVM_ARM_PMU
-
 #include <linux/perf_event.h>
 #include <asm/perf_event.h>
 
 #define ARMV8_PMU_CYCLE_IDX		(ARMV8_PMU_MAX_COUNTERS - 1)
 
+#ifdef CONFIG_KVM_ARM_PMU
+
 struct kvm_pmc {
 	u8 idx;	/* index into the pmu->pmc array */
 	struct perf_event *perf_event;
-- 
2.9.0
