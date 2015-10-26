From: ezequiel@vanguardiasur.com.ar (Ezequiel Garcia)
Date: Sun, 25 Oct 2015 21:10:52 -0300
Subject: [PATCH] ARM: v7-M: Use ret_to_user_from_irq in PendSV handler
Message-ID: <1445818252-13175-1-git-send-email-ezequiel@vanguardiasur.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PendSV handler calls v7m_exception_entry which
disables IRQs. Therefore, since IRQs are already disabled,
the PendSV handler can return using ret_to_user_from_irq.

Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
---
Tested on a NXP LPC43xx platform.

 arch/arm/kernel/entry-v7m.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/entry-v7m.S b/arch/arm/kernel/entry-v7m.S
index b6c8bb9315e7..907534f97053 100644
--- a/arch/arm/kernel/entry-v7m.S
+++ b/arch/arm/kernel/entry-v7m.S
@@ -88,7 +88,7 @@ __pendsv_entry:
 	@ execute the pending work, including reschedule
 	get_thread_info tsk
 	mov	why, #0
-	b	ret_to_user
+	b	ret_to_user_from_irq
 ENDPROC(__pendsv_entry)
 
 /*
-- 
2.5.2
