From: robh@kernel.org (Rob Herring)
Date: Sun, 11 Jan 2015 22:25:49 -0600
Subject: [PATCH] ARM: fix v7M build for !CONFIG_PRINTK
Message-ID: <1421036749-5308-1-git-send-email-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Minimal builds for v7M are broken when printk is disabled. The caller is
assembly so add the necessary ifdef around the call.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/kernel/entry-v7m.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/kernel/entry-v7m.S b/arch/arm/kernel/entry-v7m.S
index 2260f18..8944f49 100644
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
2.1.0
