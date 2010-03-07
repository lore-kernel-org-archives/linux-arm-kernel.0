From: ryan@bluewatersys.com (Ryan Mallon)
Date: Mon, 08 Mar 2010 09:13:33 +1300
Subject: Compile problem due to compressor changes,	UART referenced in
	section .txt
In-Reply-To: <Prayer.1.3.2.1003071719080.2280@hermes-2.csi.cam.ac.uk>
References: <Prayer.1.3.2.1003071719080.2280@hermes-2.csi.cam.ac.uk>
Message-ID: <4B9408ED.4060901@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

J.I. Cameron wrote:
> Dear  All,
>
> Ran into the following problem on a pxa stargate2 platform (I think it
> will
> effect a number of others).
>
> `UART' referenced in section `.text' of
> arch/arm/boot/compressed/misc.o: defined in discarded section `.data'
> of arch/arm/boot/compressed/misc.o `UART' referenced in section
> `.text' of arch/arm/boot/compressed/misc.o: defined in discarded
> section `.data' of arch/arm/boot/compressed/misc.o
>
> There is a hack in mach-pxa/include/mach/uncompress.h
> that changes the primary uart for some platforms:
>
> static inline void arch_decomp_setup(void)
> {
>     if (machine_is_littleton() || machine_is_intelmote2()
>         || machine_is_csb726() || machine_is_stargate2()
>       || machine_is_cm_x300() || machine_is_balloon3())
>     UART = STUART;
> }
>
> Simply changing the initial assignment of UART and commenting this
> function
> out acts as a work around.  I'm not entirely sure how to fix the problem
> properly.
Perhaps something like this untested patch:

Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
---

diff --git a/arch/arm/mach-pxa/include/mach/uncompress.h b/arch/arm/mach-pxa/include/mach/uncompress.h
index 237734b..efd9c0d 100644
--- a/arch/arm/mach-pxa/include/mach/uncompress.h
+++ b/arch/arm/mach-pxa/include/mach/uncompress.h
@@ -15,7 +15,16 @@
 
 #define __REG(x)       ((volatile unsigned long *)x)
 
+#if defined(CONFIG_MACH_LITTLETON)  ||	\
+    defined(CONFIG_MACH_INTELMOTE2) ||	\
+    defined(CONFIG_MACH_CSB726)     ||	\
+    defined(CONFIG_MACH_STARGATE2)  ||	\
+    defined(CONFIG_MACH_CM_X300)    ||	\
+    defined(CONFIG_MACH_BALLOON3)
+static volatile unsigned long *UART = STUART;
+#else
 static volatile unsigned long *UART = FFUART;
+#endif
 
 static inline void putc(char c)
 {
@@ -35,10 +44,6 @@ static inline void flush(void)
 
 static inline void arch_decomp_setup(void)
 {
-	if (machine_is_littleton() || machine_is_intelmote2()
-	    || machine_is_csb726() || machine_is_stargate2()
-	    || machine_is_cm_x300() || machine_is_balloon3())
-		UART = STUART;
 }
 
 /*
