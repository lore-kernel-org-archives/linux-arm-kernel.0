From: geoff@infradead.org (Geoff Levand)
Date: Wed, 10 Sep 2014 11:04:46 -0700
Subject: [PATCH V2 02/13] arm64/kvm: Fix assembler compatibility of macros
In-Reply-To: <bc4abc340eaa4da448f62326a134fabfb5a2a875.1410302383.git.geoff@infradead.org>
References: <cover.1410302383.git.geoff@infradead.org>
 <bc4abc340eaa4da448f62326a134fabfb5a2a875.1410302383.git.geoff@infradead.org>
Message-ID: <1410372286.11440.22.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some of the macros defined in kvm_arm.h are useful in the exception vector
routines, but they are not compatible with the assembler.  Change the
definition of ESR_EL2_ISS to be compatible.

Fixes build errors like these when using kvm_arm.h in assembly
source files:

  Error: unexpected characters following instruction at operand 3 -- `and x0,x1,#((1U<<25)-1)'

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/arm64/include/asm/kvm_arm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index cc83520..fb42ab5 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -175,7 +175,7 @@
 /* Exception Syndrome Register (ESR) bits */
 #define ESR_EL2_EC_SHIFT	(26)
 #define ESR_EL2_EC		(0x3fU << ESR_EL2_EC_SHIFT)
-#define ESR_EL2_IL		(1U << 25)
+#define ESR_EL2_IL		(UL(1) << 25)
 #define ESR_EL2_ISS		(ESR_EL2_IL - 1)
 #define ESR_EL2_ISV_SHIFT	(24)
 #define ESR_EL2_ISV		(1U << ESR_EL2_ISV_SHIFT)
-- 
1.9.1
