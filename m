From: alex.shi@linaro.org (Alex Shi)
Date: Fri,  9 Mar 2018 17:07:17 +0800
Subject: [PATCH 34/39] arm64: KVM: Add SMCCC_ARCH_WORKAROUND_1 fast handling
In-Reply-To: <20180309090722.26279-1-alex.shi@linaro.org>
References: <20180309090722.26279-1-alex.shi@linaro.org>
Message-ID: <20180309090722.26279-35-alex.shi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

commit f72af90c3783 upstream.

Rewrite the patch on arch/arm64/kvm/hyp.S instead of
arch/arm64/kvm/hyp/hyp-entry.S.

    We want SMCCC_ARCH_WORKAROUND_1 to be fast. As fast as possible.
    So let's intercept it as early as we can by testing for the
    function call number as soon as we've identified a HVC call
    coming from the guest.

    Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
    Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
    Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
    Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
    Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 arch/arm64/kvm/hyp.S      | 20 ++++++++++++++++++--
 include/linux/arm-smccc.h |  6 +++---
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
index 86c289832272..525da4446f1c 100644
--- a/arch/arm64/kvm/hyp.S
+++ b/arch/arm64/kvm/hyp.S
@@ -15,6 +15,7 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <linux/arm-smccc.h>
 #include <linux/linkage.h>
 
 #include <asm/alternative.h>
@@ -974,10 +975,11 @@ el1_sync:					// Guest trapped into EL2
 	lsr	x2, x1, #ESR_ELx_EC_SHIFT
 
 	cmp	x2, #ESR_ELx_EC_HVC64
+	ccmp	x2, #ESR_ELx_EC_HVC32, #4, ne
 	b.ne	el1_trap
 
-	mrs	x3, vttbr_el2			// If vttbr is valid, the 64bit guest
-	cbnz	x3, el1_trap			// called HVC
+	mrs	x3, vttbr_el2		// If vttbr is valid, the guest
+	cbnz	x3, el1_hvc_guest	// called HVC
 
 	/* Here, we're pretty sure the host called HVC. */
 	pop	x2, x3
@@ -1003,6 +1005,20 @@ el1_sync:					// Guest trapped into EL2
 	pop	lr, xzr
 2:	eret
 
+el1_hvc_guest:
+	/*
+	 * Fastest possible path for ARM_SMCCC_ARCH_WORKAROUND_1.
+	 * The workaround has already been applied on the host,
+	 * so let's quickly get back to the guest. We don't bother
+	 * restoring x3, as it can be clobbered anyway.
+	 */
+	ldr	x3, [sp]				// Guest's x0
+	eor	w3, w3, #ARM_SMCCC_ARCH_WORKAROUND_1
+	cbnz	w3, el1_trap
+	mov	x0, x3
+	add	sp, sp, #16
+	eret
+
 el1_trap:
 	/*
 	 * x1: ESR
diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
index a5ed4511af47..e7a439454950 100644
--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -57,9 +57,6 @@
 #define ARM_SMCCC_OWNER_TRUSTED_OS	50
 #define ARM_SMCCC_OWNER_TRUSTED_OS_END	63
 
-#ifndef __ASSEMBLY__
-#include <linux/linkage.h>
-#include <linux/types.h>
 #define ARM_SMCCC_QUIRK_NONE		0
 #define ARM_SMCCC_QUIRK_QCOM_A6		1 /* Save/restore register a6 */
 
@@ -81,6 +78,9 @@
 			   ARM_SMCCC_SMC_32,				\
 			   0, 0x8000)
 
+#ifndef __ASSEMBLY__
+#include <linux/linkage.h>
+#include <linux/types.h>
 /**
  * struct arm_smccc_res - Result from SMC/HVC call
  * @a0-a3 result values from registers 0 to 3
-- 
2.16.2.440.gc6284da
