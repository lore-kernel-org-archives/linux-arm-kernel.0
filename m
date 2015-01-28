From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 Jan 2015 20:48:17 +0100
Subject: [PATCH 10/15] ARM: call printk conditonally on armv7-m
In-Reply-To: <1422474502-3097078-1-git-send-email-arnd@arndb.de>
References: <1422474502-3097078-1-git-send-email-arnd@arndb.de>
Message-ID: <1422474502-3097078-11-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The "__invalid_entry" handler in the armv7-m code tries to
use printk to report an error condition. However, that cannot
work if CONFIG_PRINTK is disabled and we don't provide this
function.

This adds an #ifdef to skip the call to prevent a link error
in this case.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/kernel/entry-v7m.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/kernel/entry-v7m.S b/arch/arm/kernel/entry-v7m.S
index 2260f1855820..8944f4991c3c 100644
--- a/arch/arm/kernel/entry-v7m.S
+++ b/arch/arm/kernel/entry-v7m.S
@@ -22,10 +22,12 @@
 
 __invalid_entry:
 	v7m_exception_entry
+#ifdef CONFIG_PRINTK
 	adr	r0, strerr
 	mrs	r1, ipsr
 	mov	r2, lr
 	bl	printk
+#endif
 	mov	r0, sp
 	bl	show_regs
 1:	b	1b
-- 
2.1.0.rc2
