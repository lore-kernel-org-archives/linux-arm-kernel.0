From: joel.schopp@amd.com (Joel Schopp)
Date: Wed, 9 Jul 2014 11:17:04 -0500
Subject: [PATCH] arm64: fix VTTBR_BADDR_MASK
Message-ID: <20140709161704.9623.92358.stgit@joelaarch64.amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current calculation for VTTBR_BADDR_MASK masks only 39 bits and not
all 40 bits.  That last bit is important as some systems allocate
from near the top of the available address space.

This patch is necessary to run KVM on an aarch64 SOC I have been testing.

Signed-off-by: Joel Schopp <joel.schopp@amd.com>
---
 arch/arm64/include/asm/kvm_arm.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index 3d69030..b39e93f 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -148,7 +148,7 @@
 #endif
 
 #define VTTBR_BADDR_SHIFT (VTTBR_X - 1)
-#define VTTBR_BADDR_MASK  (((1LLU << (40 - VTTBR_X)) - 1) << VTTBR_BADDR_SHIFT)
+#define VTTBR_BADDR_MASK  (0xffffffffffLLU)              /* bits 0-39 */
 #define VTTBR_VMID_SHIFT  (48LLU)
 #define VTTBR_VMID_MASK	  (0xffLLU << VTTBR_VMID_SHIFT)
 
