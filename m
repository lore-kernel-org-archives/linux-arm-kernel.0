From: jonathan.austin@arm.com (Jonathan Austin)
Date: Thu, 26 Sep 2013 16:49:26 +0100
Subject: [PATCH 1/3] KVM: ARM: fix the size of TTBCR_{T0SZ,T1SZ} masks
In-Reply-To: <1380210568-23175-1-git-send-email-jonathan.austin@arm.com>
References: <1380210568-23175-1-git-send-email-jonathan.austin@arm.com>
Message-ID: <1380210568-23175-2-git-send-email-jonathan.austin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The T{0,1}SZ fields of TTBCR are 3 bits wide when using the long descriptor
format. Likewise, the T0SZ field of the HTCR is 3-bits. KVM currently
defines TTBCR_T{0,1}SZ as 3, not 7.

The T0SZ mask is used to calculate the value for the HTCR, both to pick out
TTBCR.T0SZ and mask off the equivalent field in the HTCR during
read-modify-write. The incorrect mask size causes the (UNKNOWN) reset value
of HTCR.T0SZ to leak in to the calculated HTCR value. Linux will hang when
initializing KVM if HTCR's reset value has bit 2 set (sometimes the case on
A7/TC2)

Fixing T0SZ allows A7 cores to boot and T1SZ is also fixed for completeness.

Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/kvm_arm.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/kvm_arm.h b/arch/arm/include/asm/kvm_arm.h
index 64e9696..d556f03 100644
--- a/arch/arm/include/asm/kvm_arm.h
+++ b/arch/arm/include/asm/kvm_arm.h
@@ -95,12 +95,12 @@
 #define TTBCR_IRGN1	(3 << 24)
 #define TTBCR_EPD1	(1 << 23)
 #define TTBCR_A1	(1 << 22)
-#define TTBCR_T1SZ	(3 << 16)
+#define TTBCR_T1SZ	(7 << 16)
 #define TTBCR_SH0	(3 << 12)
 #define TTBCR_ORGN0	(3 << 10)
 #define TTBCR_IRGN0	(3 << 8)
 #define TTBCR_EPD0	(1 << 7)
-#define TTBCR_T0SZ	3
+#define TTBCR_T0SZ	(7 << 0)
 #define HTCR_MASK	(TTBCR_T0SZ | TTBCR_IRGN0 | TTBCR_ORGN0 | TTBCR_SH0)
 
 /* Hyp System Trap Register */
-- 
1.7.9.5
