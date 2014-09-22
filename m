From: will.deacon@arm.com (Will Deacon)
Date: Mon, 22 Sep 2014 11:19:04 +0100
Subject: [PATCH] arm64: debug: don't re-enable debug exceptions on return from
 el1_dbg
Message-ID: <1411381144-3528-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When returning from a debug exception taken from EL1, we unmask debug
exceptions after handling the exception. This is crucial for debug
exceptions taken from EL0, so that any kernel work on the ret_to_user
path can be debugged by kgdb.

However, when returning back to EL1 the only thing left to do is to
restore the original register state before the exception return. If
single-step has been enabled by the debug exception handler, we will
get stuck in an infinite debug exception loop, since we will take the
step exception as soon as we unmask debug exceptions.

This patch avoids unmasking debug exceptions on the debug exception
return path when the exception was taken from EL1.

Cc: <stable@vger.kernel.org>
Reported-by: David Long <dave.long@linaro.org>
Reported-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/entry.S | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index f0b5e5120a87..726b910fe6ec 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -324,7 +324,6 @@ el1_dbg:
 	mrs	x0, far_el1
 	mov	x2, sp				// struct pt_regs
 	bl	do_debug_exception
-	enable_dbg
 	kernel_exit 1
 el1_inv:
 	// TODO: add support for undefined instructions in kernel mode
-- 
2.1.0
