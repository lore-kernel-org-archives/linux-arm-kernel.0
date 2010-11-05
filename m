From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 05 Nov 2010 14:51:42 -0700
Subject: [PATCHv2 2/3] ARM: Allow machines to override __delay()
In-Reply-To: <1288905414.21823.12.camel@c-dwalke-linux.qualcomm.com>
References: <1288300770-18350-1-git-send-email-sboyd@codeaurora.org>	<1288300770-18350-3-git-send-email-sboyd@codeaurora.org>	<1288899002.21823.3.camel@c-dwalke-linux.qualcomm.com>	<4CD31E67.60107@codeaurora.org>
	<1288905414.21823.12.camel@c-dwalke-linux.qualcomm.com>
Message-ID: <4CD47C6E.3050702@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/04/2010 02:16 PM, Daniel Walker wrote:
> On Thu, 2010-11-04 at 13:58 -0700, Stephen Boyd wrote:
>> Wouldn't that mean delay_fn needs to be exposed in the header file too?
>> I like the fact that it's static and scoped to this file.
>
> Yeah you would need to make an extern for that. Why is it better to have
> it static in this file?
>
> If you make it inline you should have smaller code size since all your
> doing is "delay_fn = fn;" and that's not expected to be used much (if at
> all).
>

Ok. Doing that increases the size of my vmlinux.

$ size vmlinux.orig vmlinux.new
   text    data     bss     dec     hex filename
7091426  594512 1244648 8930586  88451a vmlinux.orig
7091514  594512 1244648 8930674  884572 vmlinux.new

Here's the interdiff.

diff --git a/arch/arm/include/asm/delay.h b/arch/arm/include/asm/delay.h
index 5c6b9a3..ef0ea48 100644
--- a/arch/arm/include/asm/delay.h
+++ b/arch/arm/include/asm/delay.h
@@ -8,7 +8,20 @@
 
 #include <asm/param.h>	/* HZ */
 
-extern void __delay(unsigned long loops);
+extern void (*delay_fn)(unsigned long);
+
+static inline void set_delay_fn(void (*fn)(unsigned long))
+{
+	delay_fn = fn;
+}
+
+/*
+ * loops = usecs * HZ * loops_per_jiffy / 1000000
+ */
+static inline void __delay(unsigned long loops)
+{
+	delay_fn(loops);
+}
 
 /*
  * This function intentionally does not exist; if you see references to
@@ -40,7 +53,6 @@ extern void __const_udelay(unsigned long);
 			__const_udelay((n) * ((2199023U*HZ)>>11))) :	\
 	  __udelay(n))
 
-extern void set_delay_fn(void (*fn)(unsigned long));
 extern void read_current_timer_delay_loop(unsigned long loops);
 
 #endif /* defined(_ARM_DELAY_H) */
diff --git a/arch/arm/lib/delay.c b/arch/arm/lib/delay.c
index 59fdf64..a4b1ecd 100644
--- a/arch/arm/lib/delay.c
+++ b/arch/arm/lib/delay.c
@@ -44,20 +44,8 @@ void read_current_timer_delay_loop(unsigned long loops)
 }
 #endif
 
-static void (*delay_fn)(unsigned long) = delay_loop;
+void (*delay_fn)(unsigned long) = delay_loop;
 
-void set_delay_fn(void (*fn)(unsigned long))
-{
-	delay_fn = fn;
-}
-
-/*
- * loops = usecs * HZ * loops_per_jiffy / 1000000
- */
-void __delay(unsigned long loops)
-{
-	delay_fn(loops);
-}
 EXPORT_SYMBOL(__delay);
 
 /*


Do you get similar results?

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
