From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Thu, 21 Apr 2016 09:18:19 +0100
Subject: [PATCH RFC 07/10] ARM: V7M: fix notrace variant of
 save_and_disable_irqs
In-Reply-To: <1461226702-27160-1-git-send-email-vladimir.murzin@arm.com>
References: <1461226702-27160-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1461226702-27160-8-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 8e43a905 "ARM: 7325/1: fix v7 boot with lockdep enabled"
introduced notrace variant of save_and_disable_irqs to balance notrace
variant of restore_irqs; however V7M case has been missed. It was not
noticed because cache-v7.S the only place where notrace variant is used.
So fix it, since we are going to extend V7 cache routines to handle V7M
case too.

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/include/asm/assembler.h |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index b2bc8e1..310a5e0 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -159,7 +159,11 @@
 	.endm
 
 	.macro	save_and_disable_irqs_notrace, oldcpsr
+#ifdef CONFIG_CPU_V7M
+	mrs	\oldcpsr, primask
+#else
 	mrs	\oldcpsr, cpsr
+#endif
 	disable_irq_notrace
 	.endm
 
-- 
1.7.9.5
