From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Sun,  1 Oct 2017 22:06:17 -0400
Subject: [PATCH 2/3] ARM: semihosting: use proper instruction on v7m processors
In-Reply-To: <20171002020618.23924-1-nicolas.pitre@linaro.org>
References: <20171002020618.23924-1-nicolas.pitre@linaro.org>
Message-ID: <20171002020618.23924-3-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The svc instruction doesn't exist on v7m processors. Semihosting ops are
invoked with the bkpt instruction instead.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/boot/compressed/debug.S | 4 ++++
 arch/arm/kernel/debug.S          | 8 ++++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/boot/compressed/debug.S b/arch/arm/boot/compressed/debug.S
index 5392ee6333..8f6e37177d 100644
--- a/arch/arm/boot/compressed/debug.S
+++ b/arch/arm/boot/compressed/debug.S
@@ -23,7 +23,11 @@ ENTRY(putc)
 	strb	r0, [r1]
 	mov	r0, #0x03		@ SYS_WRITEC
    ARM(	svc	#0x123456	)
+#ifdef CONFIG_CPU_V7M
+ THUMB(	bkpt	#0xab		)
+#else
  THUMB(	svc	#0xab		)
+#endif
 	mov	pc, lr
 	.align	2
 1:	.word	_GLOBAL_OFFSET_TABLE_ - .
diff --git a/arch/arm/kernel/debug.S b/arch/arm/kernel/debug.S
index 423f443258..35145b618c 100644
--- a/arch/arm/kernel/debug.S
+++ b/arch/arm/kernel/debug.S
@@ -121,7 +121,11 @@ ENTRY(printascii)
 		mov	r1, r0
 		mov	r0, #0x04		@ SYS_WRITE0
 	ARM(	svc	#0x123456	)
+#ifdef CONFIG_CPU_V7M
+	THUMB(	bkpt	#0xab		)
+#else
 	THUMB(	svc	#0xab		)
+#endif
 		ret	lr
 ENDPROC(printascii)
 
@@ -132,7 +136,11 @@ ENTRY(printch)
 		strb	r0, [r1]
 		mov	r0, #0x03		@ SYS_WRITEC
 	ARM(	svc	#0x123456	)
+#ifdef CONFIG_CPU_V7M
+	THUMB(	bkpt	#0xab		)
+#else
 	THUMB(	svc	#0xab		)
+#endif
 		ret	lr
 ENDPROC(printch)
 
-- 
2.9.5
