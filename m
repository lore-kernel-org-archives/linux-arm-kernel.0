From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 29 Jun 2011 10:22:55 +0100
Subject: [PATCH 12/23] ARM: entry: instrument svc undefined exception handler
	with irqtrace
In-Reply-To: <20110629091853.GK21898@n2100.arm.linux.org.uk>
References: <20110629091853.GK21898@n2100.arm.linux.org.uk>
Message-ID: <E1Qbqz1-0002Fm-8I@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add irqtrace function calls to the undefined exception handler, so
that we get sane lockdep traces from locking problems in undefined
exception handlers.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/entry-armv.S |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 8048056..474934c 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -268,6 +268,10 @@ __und_svc:
 	svc_entry
 #endif
 
+#ifdef CONFIG_TRACE_IRQFLAGS
+	bl	trace_hardirqs_off
+#endif
+
 	@
 	@ call emulation code, which returns using r9 if it has emulated
 	@ the instruction, or the more conventional lr if we are to treat
@@ -300,6 +304,12 @@ __und_svc:
 	@ restore SPSR and restart the instruction
 	@
 	ldr	r5, [sp, #S_PSR]		@ Get SVC cpsr
+#ifdef CONFIG_TRACE_IRQFLAGS
+	tst	r5, #PSR_I_BIT
+	bleq	trace_hardirqs_on
+	tst	r5, #PSR_I_BIT
+	blne	trace_hardirqs_off
+#endif
 	svc_exit r5				@ return from exception
  UNWIND(.fnend		)
 ENDPROC(__und_svc)
-- 
1.7.4.4
