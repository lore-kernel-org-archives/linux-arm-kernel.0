From: tchalamarla@caviumnetworks.com (tchalamarla at caviumnetworks.com)
Date: Thu, 4 Feb 2016 10:45:25 -0800
Subject: [PATCH] irqchip-gicv3: Make sure read from ICC_IAR1_EL1 is visible on
 redestributor
Message-ID: <1454611525-18032-1-git-send-email-tchalamarla@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tirumalesh Chalamarla <tchalamarla@caviumnetworks.com>

ARM GIC specification mention the need for dsb after ICC_IAR1_EL1 read.

4.1.1 Physical CPU Interface:
"The effects of reading ICC_IAR0_EL1 and ICC_IAR1_EL1 on the state of a
returned INTID are not guaranteed to be visible until after the
execution of a DSB."

The effect of not having this is, missing interrupts.
this patch address the problem by adding a dsb .

changes form V1:
	- modified subject line and commit message.

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
