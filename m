From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 5 Jan 2015 23:09:00 -0500 (EST)
Subject: [PATCH] Revert 9fc2105aeaaf56b0cf75296a84702d0f9e64437b to fix
 pyaudio (and probably more)
In-Reply-To: <20150105121126.GA10116@arm.com>
References: <20150104190123.GA20153@amd>
 <alpine.LFD.2.11.1501041438130.18844@knanqh.ubzr>
 <20150104201026.GA23427@amd>
 <alpine.LFD.2.11.1501041512440.18844@knanqh.ubzr>
 <20150104203724.GA16372@amd>
 <alpine.LFD.2.11.1501041547050.18844@knanqh.ubzr>
 <CA+55aFy5yB2d-1iXEUtU+puua4TAmV0kZF_7TBhXO1Y4Khqb9Q@mail.gmail.com>
 <alpine.LFD.2.11.1501041609290.18844@knanqh.ubzr>
 <20150104212659.GC12302@n2100.arm.linux.org.uk>
 <alpine.LFD.2.11.1501042343240.18844@knanqh.ubzr>
 <20150105121126.GA10116@arm.com>
Message-ID: <alpine.LFD.2.11.1501052259230.18844@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 5 Jan 2015, Will Deacon wrote:

> On Mon, Jan 05, 2015 at 04:51:31AM +0000, Nicolas Pitre wrote:
> > Because the reported bogomips is orders of magnitude away from the
> > traditionally expected value for a given CPU when timer based delays are
> > in use, and because lumping bogomips and timer based delay loops is rather
> > senseless anyway, let's calibrate bogomips using a CPU loop all the time
> > even when timer based delays are available.  Timer based delays don't
> > need any calibration and /proc/cpuinfo will provide somewhat sensible
> > values again.
> > 
> > In practice, calls to __delay() will now always use the CPU based loop.
> > Things remain unchanged for udelay() and its derivatives.
> 
> Given that we have a hard limit of 3355 bogomips in our calibration code,
> could we not just report that instead? We already have all of the issues I
> highlighted above and the systems that are going to be hit by this are the
> more recent (more performant) cores that will be approaching this maximum
> value anyway.

I already replied to the other issues in my previous email.

Now here's the bogomips hard limit gone:

----- >8
From: Nicolas Pitre <nicolas.pitre@linaro.org>
Date: Mon, 5 Jan 2015 22:43:56 -0500
Subject: [PATCH] ARM: loop_udelay: remove bogomips value limitation

Now that we don't support ARMv3 anymore, the loop based delay code can
convert microsecs into number of loops using a 64-bit multiplication.
This allows us to lift the hard limit of 3355 on the bogomips value with
loops_per_jiffy that can safely span the full 32-bit range.

Signed-off-by: Nicolas Pitre <nico@linaro.org>

diff --git a/arch/arm/include/asm/delay.h b/arch/arm/include/asm/delay.h
index 7feeb163f5..287c96ad93 100644
--- a/arch/arm/include/asm/delay.h
+++ b/arch/arm/include/asm/delay.h
@@ -10,8 +10,8 @@
 #include <asm/param.h>	/* HZ */
 
 #define MAX_UDELAY_MS	2
-#define UDELAY_MULT	((UL(2199023) * HZ) >> 11)
-#define UDELAY_SHIFT	30
+#define UDELAY_MULT	UL(2047 * HZ + 483648 * HZ / 1000000)
+#define UDELAY_SHIFT	31
 
 #ifndef __ASSEMBLY__
 
@@ -33,7 +33,7 @@ extern struct arm_delay_ops {
  * it, it means that you're calling udelay() with an out of range value.
  *
  * With currently imposed limits, this means that we support a max delay
- * of 2000us. Further limits: HZ<=1000 and bogomips<=3355
+ * of 2000us. Further limits: HZ<=1000
  */
 extern void __bad_udelay(void);
 
diff --git a/arch/arm/lib/delay-loop.S b/arch/arm/lib/delay-loop.S
index 518bf6e93f..bcc23c5760 100644
--- a/arch/arm/lib/delay-loop.S
+++ b/arch/arm/lib/delay-loop.S
@@ -17,7 +17,6 @@
 
 /*
  * r0  <= 2000
- * lpj <= 0x01ffffff (max. 3355 bogomips)
  * HZ  <= 1000
  */
 
@@ -25,16 +24,11 @@ ENTRY(__loop_udelay)
 		ldr	r2, .LC1
 		mul	r0, r2, r0
 ENTRY(__loop_const_udelay)			@ 0 <= r0 <= 0x7fffff06
-		mov	r1, #-1
 		ldr	r2, .LC0
-		ldr	r2, [r2]		@ max = 0x01ffffff
-		add	r0, r0, r1, lsr #32-14
-		mov	r0, r0, lsr #14		@ max = 0x0001ffff
-		add	r2, r2, r1, lsr #32-10
-		mov	r2, r2, lsr #10		@ max = 0x00007fff
-		mul	r0, r2, r0		@ max = 2^32-1
-		add	r0, r0, r1, lsr #32-6
-		movs	r0, r0, lsr #6
+		ldr	r2, [r2]
+		umull	r1, r0, r2, r0
+		adds	r1, r1, #0xffffffff
+		adcs	r0, r0, r0
 		reteq	lr
 
 /*
