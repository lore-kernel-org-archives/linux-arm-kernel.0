From: geoff@infradead.org (Geoff Levand)
Date: Tue, 09 Sep 2014 22:49:04 +0000
Subject: [PATCH 02/13] arm64/kvm: Fix assembler compatibility of macros
In-Reply-To: <cover.1410302383.git.geoff@infradead.org>
References: <cover.1410302383.git.geoff@infradead.org>
Message-ID: <bc4abc340eaa4da448f62326a134fabfb5a2a875.1410302383.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some of the macros defined in kvm_arm.h are useful in the exception vector
routines, but they are not compatible with the assembler.  Change the
definition of ESR_EL2_ISS to be compatible.

Fixes build errors like these when using kvm_arm.h in assembly
source files:

  Error: unexpected characters following instruction at operand 3 -- `add x0,x1,#((1U<<25)-1)'

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/arm64/include/asm/kvm_arm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index cc83520..e0e7e64 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -176,7 +176,7 @@
 #define ESR_EL2_EC_SHIFT	(26)
 #define ESR_EL2_EC		(0x3fU << ESR_EL2_EC_SHIFT)
 #define ESR_EL2_IL		(1U << 25)
-#define ESR_EL2_ISS		(ESR_EL2_IL - 1)
+#define ESR_EL2_ISS		(0xffff)
 #define ESR_EL2_ISV_SHIFT	(24)
 #define ESR_EL2_ISV		(1U << ESR_EL2_ISV_SHIFT)
 #define ESR_EL2_SAS_SHIFT	(22)
-- 
1.9.1
