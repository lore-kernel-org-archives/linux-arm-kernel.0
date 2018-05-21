From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 21 May 2018 12:45:28 +0100
Subject: [PATCH 13/14] ARM: KVM: Add SMCCC_ARCH_WORKAROUND_1 fast handling
In-Reply-To: <20180521114238.GN17671@n2100.armlinux.org.uk>
References: <20180521114238.GN17671@n2100.armlinux.org.uk>
Message-ID: <E1fKjFo-00064i-Hc@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We want SMCCC_ARCH_WORKAROUND_1 to be fast. As fast as possible.
So let's intercept it as early as we can by testing for the
function call number as soon as we've identified a HVC call
coming from the guest.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/kvm/hyp/hyp-entry.S | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kvm/hyp/hyp-entry.S b/arch/arm/kvm/hyp/hyp-entry.S
index 918a05dd2d63..67de45685e29 100644
--- a/arch/arm/kvm/hyp/hyp-entry.S
+++ b/arch/arm/kvm/hyp/hyp-entry.S
@@ -16,6 +16,7 @@
  * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
  */
 
+#include <linux/arm-smccc.h>
 #include <linux/linkage.h>
 #include <asm/kvm_arm.h>
 #include <asm/kvm_asm.h>
@@ -202,7 +203,7 @@ ENDPROC(__hyp_do_panic)
 	lsr     r2, r2, #16
 	and     r2, r2, #0xff
 	cmp     r2, #0
-	bne	guest_trap		@ Guest called HVC
+	bne	guest_hvc_trap		@ Guest called HVC
 
 	/*
 	 * Getting here means host called HVC, we shift parameters and branch
@@ -253,6 +254,16 @@ THUMB(	orr	lr, #1)
 	pop	{r2, lr}
 	eret
 
+guest_hvc_trap:
+	movw	ip, #:lower16:ARM_SMCCC_ARCH_WORKAROUND_1
+	movt	ip, #:upper16:ARM_SMCCC_ARCH_WORKAROUND_1
+	ldr	r0, [sp]		@ Guest's r0
+	teq	r0, ip
+	bne	guest_trap
+	pop	{r0, r1, r2}
+	mov	r0, #0
+	eret
+
 guest_trap:
 	load_vcpu r0			@ Load VCPU pointer to r0
 
-- 
2.7.4
