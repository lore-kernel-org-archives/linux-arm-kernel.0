From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 15 Apr 2016 12:11:21 +0200
Subject: [PATCH] arm64: fix invalidation of wrong __early_cpu_boot_status
 cacheline
Message-ID: <1460715081-16542-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In head.S, the str_l macro, which takes a source register, a symbol name
and a temp register, is used to store a status value to the variable
__early_cpu_boot_status. Subsequently, the value of the temp register is
reused to invalidate any cachelines covering this variable.

However, since str_l resolves to

      adrp    \tmp, \sym
      str     \src, [\tmp, :lo12:\sym]

the temp register never actually holds the address of the variable but
only of the 4 KB window that covers it, and reusing it leads to the
wrong cacheline being invalidated. So instead, take the address
explicitly before doing the store, and reuse that value to perform
the cache invalidation.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---

This deserves a cc stable, since the macro is always invoked for each CPU
at boot.

Alternatively, we could add a writeback to the str_l macro, but I think
in general, making any assumptions about the value of a temp register is
dodgy, so I prefer this approach instead.

 arch/arm64/kernel/head.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 8b8a3d1e23fb..fafe21e49aab 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -693,7 +693,8 @@ ENDPROC(__secondary_switched)
 
 	.macro	update_early_cpu_boot_status status, tmp1, tmp2
 	mov	\tmp2, #\status
-	str_l	\tmp2, __early_cpu_boot_status, \tmp1
+	adr_l	\tmp1, __early_cpu_boot_status
+	str	\tmp2, [\tmp1]
 	dmb	sy
 	dc	ivac, \tmp1			// Invalidate potentially stale cache line
 	.endm
-- 
2.5.0
