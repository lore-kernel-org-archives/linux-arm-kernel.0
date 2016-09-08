From: mark.rutland@arm.com (Mark Rutland)
Date: Thu,  8 Sep 2016 13:55:34 +0100
Subject: [PATCH 1/6] arm64: sysreg: allow write_sysreg to use XZR
In-Reply-To: <1473339339-32334-1-git-send-email-mark.rutland@arm.com>
References: <1473339339-32334-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1473339339-32334-2-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently write_sysreg has to allocate a temporary register to write
zero to a system register, which is unfortunate given that the MSR
instruction accepts XZR as an operand.

Allow XZR to be used when appropriate by fiddling with the assembly
constraints.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/sysreg.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index cc06794..39fed2e 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -273,10 +273,14 @@ static inline void config_sctlr_el1(u32 clear, u32 set)
 	__val;							\
 })
 
+/*
+ * The "Z" constraint normally means a zero immediate, but when combined with
+ * the "%x0" template means XZR.
+ */
 #define write_sysreg(v, r) do {					\
 	u64 __val = (u64)v;					\
-	asm volatile("msr " __stringify(r) ", %0"		\
-		     : : "r" (__val));				\
+	asm volatile("msr " __stringify(r) ", %x0"		\
+		     : : "rZ" (__val));				\
 } while (0)
 
 #endif
-- 
1.9.1
