From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Thu, 20 Jul 2017 10:32:29 +0100
Subject: [PATCH 2/4] ARM: obtain thread info structure later
In-Reply-To: <20170720093144.GV31807@n2100.armlinux.org.uk>
References: <20170720093144.GV31807@n2100.armlinux.org.uk>
Message-ID: <E1dY7or-0004qi-EZ@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Obtain the thread info structure later in the syscall processing, so
that we free up a register for earlier code.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/kernel/entry-common.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 9abe47a206d9..374c28723547 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -152,7 +152,6 @@ ENTRY(vector_swi)
 	alignment_trap r10, ip, __cr_alignment
 	enable_irq
 	ct_user_exit
-	get_thread_info tsk
 
 	/*
 	 * Get the system call number.
@@ -209,6 +208,7 @@ ENTRY(vector_swi)
 	bic	scno, scno, #0xff000000		@ mask off SWI op-code
 	eor	scno, scno, #__NR_SYSCALL_BASE	@ check OS number
 #endif
+	get_thread_info tsk
 
 local_restart:
 	ldr	r10, [tsk, #TI_FLAGS]		@ check for syscall tracing
@@ -240,6 +240,7 @@ ENTRY(vector_swi)
 9001:
 	sub	lr, saved_pc, #4
 	str	lr, [sp, #S_PC]
+	get_thread_info tsk
 	b	ret_fast_syscall
 #endif
 ENDPROC(vector_swi)
-- 
2.7.4
