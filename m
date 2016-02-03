From: tchalamarla@caviumnetworks.com (tchalamarla at caviumnetworks.com)
Date: Wed, 3 Feb 2016 11:43:08 -0800
Subject: [PATCH] irqchip-gicv3: wait for ack from redistributer after read_iar
Message-ID: <1454528588-32721-1-git-send-email-tchalamarla@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tirumalesh Chalamarla <tchalamarla@caviumnetworks.com>

Systems with high number of cores and sufficiently loaded,
there exists a small window where it is possible for re-distributor
to illegally merge two LPI and cuases missing interrupts.

Solution is, wait for ack from the redistributor after read_iar.
A "dsb sy" after IAR read ensures there is no illegal merge windows.

giv3 spec version 32 also warns this, see section 4.4.13

Signed-off-by: Tirumalesh Chalamarla <tchalamarla@caviumnetworks.com>
---
 arch/arm64/include/asm/arch_gicv3.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/include/asm/arch_gicv3.h b/arch/arm64/include/asm/arch_gicv3.h
index 2731d3b..8ec88e5 100644
--- a/arch/arm64/include/asm/arch_gicv3.h
+++ b/arch/arm64/include/asm/arch_gicv3.h
@@ -103,6 +103,7 @@ static inline u64 gic_read_iar_common(void)
 	u64 irqstat;
 
 	asm volatile("mrs_s %0, " __stringify(ICC_IAR1_EL1) : "=r" (irqstat));
+	dsb(sy);
 	return irqstat;
 }
 
-- 
2.1.0
