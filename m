From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 21 Aug 2015 14:48:30 +0100
Subject: [PATCH 4/4] ARM: entry: ensure that IRQs are enabled when calling
 syscall_trace_exit()
In-Reply-To: <20150821134630.GW7557@n2100.arm.linux.org.uk>
References: <20150821134630.GW7557@n2100.arm.linux.org.uk>
Message-ID: <E1ZSmgI-00044i-JK@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The audit code looks like it's been written to cope with being called
with IRQs enabled.  However, it's unclear whether IRQs should be
enabled or disabled when calling the syscall tracing infrastructure.

Right now, sometimes we call this with IRQs enabled, and other times
with IRQs disabled.  Opt for IRQs being enabled for consistency.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/entry-common.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index dd3721d1185e..d83a40d8e055 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -275,7 +275,7 @@ __sys_trace_return:
 	b	ret_slow_syscall
 
 __sys_trace_return_nosave:
-	asm_trace_hardirqs_off save=0
+	enable_irq_notrace
 	mov	r0, sp
 	bl	syscall_trace_exit
 	b	ret_slow_syscall
-- 
2.1.0
