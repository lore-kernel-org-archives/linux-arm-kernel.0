From: julien.thierry@arm.com (Julien Thierry)
Date: Tue, 28 Aug 2018 16:51:17 +0100
Subject: [PATCH v5 07/27] arm64: xen: Use existing helper to check interrupt
 status
In-Reply-To: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
References: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
Message-ID: <1535471497-38854-8-git-send-email-julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The status of interrupts might depend on more than just pstate. Use
interrupts_disabled() instead of raw_irqs_disabled_flags() to take the full
context into account.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/xen/events.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/xen/events.h b/arch/arm64/include/asm/xen/events.h
index 4e22b7a..2788e95 100644
--- a/arch/arm64/include/asm/xen/events.h
+++ b/arch/arm64/include/asm/xen/events.h
@@ -14,7 +14,7 @@ enum ipi_vector {
 
 static inline int xen_irqs_disabled(struct pt_regs *regs)
 {
-	return raw_irqs_disabled_flags((unsigned long) regs->pstate);
+	return !interrupts_enabled(regs);
 }
 
 #define xchg_xen_ulong(ptr, val) xchg((ptr), (val))
-- 
1.9.1
