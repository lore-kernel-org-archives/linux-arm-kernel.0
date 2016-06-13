From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Mon, 13 Jun 2016 16:03:06 +0100
Subject: [PATCH 07/10] ARM: V7M: fix notrace variant of save_and_disable_irqs
In-Reply-To: <1465830189-20128-1-git-send-email-vladimir.murzin@arm.com>
References: <1465830189-20128-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1465830189-20128-8-git-send-email-vladimir.murzin@arm.com>
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
