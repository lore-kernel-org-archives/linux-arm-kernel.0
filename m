From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 21 Feb 2012 00:52:51 -0500 (EST)
Subject: [PATCH] ARM: debug: add support for early console output via
 semihosting
Message-ID: <alpine.LFD.2.02.1202210050300.24536@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a very simple method for code running in an emulator, or under
the supervision of a debugger, to use I/O facilities on the controlling
host.

Tested with OpenOCD, and ARM's Fast Models.

Details on semihosting can be found in chapter 8 of
DUI0203I_rvct_developer_guide.pdf from ARM Ltd.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index e0d236d7ff..755d9fbe32 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -100,6 +100,22 @@ choice
 		  Note that the system will appear to hang during boot if there
 		  is nothing connected to read from the DCC.
 
+	config DEBUG_SEMIHOSTING
+		bool "Kernel low-level debug output via semihosting I"
+		help
+		  Semihosting enables code running on an ARM target to use
+		  the I/O facilities on a host debugger/emulator through a
+		  simple SVC calls. The host debugger or emulator must have
+		  semihosting enabled for the special svc call to be trapped
+		  otherwise the kernel will crash.
+
+		  This is known to work with OpenOCD, as wellas
+		  ARM's Fast Models, or any other controlling environment
+		  that implements semihosting.
+
+		  For more details about semihosting, please see
+		  chapter 8 of DUI0203I_rvct_developer_guide.pdf from ARM Ltd.
+
 	config AT91_DEBUG_LL_DBGU0
 		bool "Kernel low-level debugging on rm9200, 9260/9g20, 9261/9g10 and 9rl"
 		depends on HAVE_AT91_DBGU0
diff --git a/arch/arm/kernel/debug.S b/arch/arm/kernel/debug.S
index 204e2160cf..d7c9076be1 100644
--- a/arch/arm/kernel/debug.S
+++ b/arch/arm/kernel/debug.S
@@ -155,6 +155,8 @@ hexbuf:		.space 16
 
 		.ltorg
 
+#ifndef CONFIG_DEBUG_SEMIHOSTING
+
 ENTRY(printascii)
 		addruart_current r3, r1, r2
 		b	2f
@@ -177,3 +179,24 @@ ENTRY(printch)
 		mov	r0, #0
 		b	1b
 ENDPROC(printch)
+
+#else
+
+ENTRY(printascii)
+		mov	r1, r0
+		mov	r0, #0x04		@ SYS_WRITE0
+	ARM(	svc	#0x123456	)
+	THUMB(	svc	#0xab		)
+		mov	pc, lr
+ENDPROC(printascii)
+
+ENTRY(printch)
+		adr	r1, hexbuf
+		strb	r0, [r1]
+		mov	r0, #0x03		@ SYS_WRITEC
+	ARM(	svc	#0x123456	)
+	THUMB(	svc	#0xab		)
+		mov	pc, lr
+ENDPROC(printch)
+
+#endif
diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 6d57911440..565f87d26c 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -265,7 +265,7 @@ __create_page_tables:
 	str	r6, [r3]
 
 #ifdef CONFIG_DEBUG_LL
-#ifndef CONFIG_DEBUG_ICEDCC
+#if !defined(CONFIG_DEBUG_ICEDCC) && !defined(CONFIG_DEBUG_SEMIHOSTING)
 	/*
 	 * Map in IO space for serial debugging.
 	 * This allows debug messages to be output
@@ -297,10 +297,10 @@ __create_page_tables:
 	cmp	r0, r6
 	blo	1b
 
-#else /* CONFIG_DEBUG_ICEDCC */
-	/* we don't need any serial debugging mappings for ICEDCC */
+#else /* CONFIG_DEBUG_ICEDCC || CONFIG_DEBUG_SEMIHOSTING */
+	/* we don't need any serial debugging mappings */
 	ldr	r7, [r10, #PROCINFO_IO_MMUFLAGS] @ io_mmuflags
-#endif /* !CONFIG_DEBUG_ICEDCC */
+#endif
 
 #if defined(CONFIG_ARCH_NETWINDER) || defined(CONFIG_ARCH_CATS)
 	/*
