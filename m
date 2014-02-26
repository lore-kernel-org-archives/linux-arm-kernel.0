From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 26 Feb 2014 15:23:37 +0100
Subject: [PATCH] ARM: v7m: only call printk with CONFIG_PRINTK=y
Message-ID: <1393424617-29729-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Otherwise this fails to build (e.g. on efm32_defconfig +
CONFIG_PRINTK=n) with:

	arch/arm/kernel/entry-v7m.S:28: undefined reference to `printk'

.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/kernel/entry-v7m.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/kernel/entry-v7m.S b/arch/arm/kernel/entry-v7m.S
index 2260f1855820..89f902cc5bfe 100644
--- a/arch/arm/kernel/entry-v7m.S
+++ b/arch/arm/kernel/entry-v7m.S
@@ -22,12 +22,14 @@
 
 __invalid_entry:
 	v7m_exception_entry
+#ifdef CONFIG_PRINTK
 	adr	r0, strerr
 	mrs	r1, ipsr
 	mov	r2, lr
 	bl	printk
 	mov	r0, sp
 	bl	show_regs
+#endif
 1:	b	1b
 ENDPROC(__invalid_entry)
 
-- 
1.8.5.3
