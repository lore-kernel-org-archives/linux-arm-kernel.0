From: will.deacon@arm.com (Will Deacon)
Date: Fri,  9 Sep 2016 12:16:05 +0100
Subject: [PATCH 6/6] irqchip/gic-v3: Use nops macro for Cavium ThunderX
 erratum 23154
In-Reply-To: <1473419765-3437-1-git-send-email-will.deacon@arm.com>
References: <1473419765-3437-1-git-send-email-will.deacon@arm.com>
Message-ID: <1473419765-3437-7-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The workaround for Cavium ThunderX erratum 23154 has a homebrew
pipeflush built out of NOP sequences around the read of the IAR.

This patch converts the code to use the new nops macro, which makes it
a little easier to read.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/arch_gicv3.h | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/arch_gicv3.h b/arch/arm64/include/asm/arch_gicv3.h
index 0d41944d965d..258f0e118375 100644
--- a/arch/arm64/include/asm/arch_gicv3.h
+++ b/arch/arm64/include/asm/arch_gicv3.h
@@ -121,14 +121,9 @@ static inline u64 gic_read_iar_cavium_thunderx(void)
 {
 	u64 irqstat;
 
-	asm volatile(
-		"nop;nop;nop;nop\n\t"
-		"nop;nop;nop;nop");
-
+	nops(8);
 	irqstat = read_sysreg_s(ICC_IAR1_EL1);
-
-	asm volatile(
-		"nop;nop;nop;nop");
+	nops(4);
 	mb();
 
 	return irqstat;
-- 
2.1.4
