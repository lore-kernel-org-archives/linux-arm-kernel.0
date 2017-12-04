From: cdall@kernel.org (Christoffer Dall)
Date: Mon,  4 Dec 2017 15:03:42 +0100
Subject: [PULL 13/19] kvm: arm64: handle single-step during SError exceptions
In-Reply-To: <20171204135637.21620-1-cdall@kernel.org>
References: <20171204135637.21620-1-cdall@kernel.org>
Message-ID: <20171204140348.21965-11-cdall@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alex Benn?e <alex.bennee@linaro.org>

When an SError arrives during single-step both the SError and debug
exceptions may be pending when the step is completed, and the
architecture doesn't define the ordering of the two.  This means that we
can observe en SError even though we've just completed a step, without
receiving a debug exception.  In that case the DBG_SPSR_SS bit will have
flipped as the instruction executed. After handling the abort in
handle_exit() we test to see if the bit is clear and we were
single-stepping before deciding if we need to exit to user space.

Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm64/kvm/handle_exit.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index 029c28dd25e9..304203fa9e33 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -28,6 +28,7 @@
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_mmu.h>
 #include <asm/kvm_psci.h>
+#include <asm/debug-monitors.h>
 
 #define CREATE_TRACE_POINTS
 #include "trace.h"
@@ -252,7 +253,12 @@ int handle_exit(struct kvm_vcpu *vcpu, struct kvm_run *run,
 		return 1;
 	case ARM_EXCEPTION_EL1_SERROR:
 		kvm_inject_vabt(vcpu);
-		return 1;
+		/* We may still need to return for single-step */
+		if (!(*vcpu_cpsr(vcpu) & DBG_SPSR_SS)
+			&& kvm_arm_handle_step_debug(vcpu, run))
+			return 0;
+		else
+			return 1;
 	case ARM_EXCEPTION_TRAP:
 		return handle_trap_exceptions(vcpu, run);
 	case ARM_EXCEPTION_HYP_GONE:
-- 
2.14.2
