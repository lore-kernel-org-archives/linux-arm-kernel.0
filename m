From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 17 Aug 2012 11:48:56 +0800
Subject: imx6q restart is broken
In-Reply-To: <20120816223446.GB15883@n2100.arm.linux.org.uk>
References: <20120808101817.GA14718@S2101-09.ap.freescale.net>
 <50224547.9020000@de.bosch.com> <50232C17.9000700@gmail.com>
 <20120809092021.GQ18957@n2100.arm.linux.org.uk>
 <502BBB43.5010403@gmail.com>
 <20120815214412.GC32560@n2100.arm.linux.org.uk>
 <20120816023109.GH2258@S2101-09.ap.freescale.net>
 <20120816223446.GB15883@n2100.arm.linux.org.uk>
Message-ID: <20120817034854.GE24242@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 16, 2012 at 11:34:46PM +0100, Russell King - ARM Linux wrote:
> This doesn't get around the problem that userspace can still effectively
> issue a DoS against the system by just running a dmb in a tight loop.
> Or maybe this would have a much more dramatic effect:
> 
> 	while (1) {
> 		asm("dmb");
> 		asm("dmb");
> 		asm("dmb");
> 		asm("dmb");
> 		asm("dmb");
> 		asm("dmb");
> 		asm("dmb");
> 		asm("dmb");
> 		asm("dmb");
> 		asm("dmb");
> 		asm("dmb");
> 		asm("dmb");
> 		asm("dmb");
> 		asm("dmb");
> 		asm("dmb");
> 		asm("dmb");
> 		asm("dmb");
> 		asm("dmb");
> 		asm("dmb");
> 		asm("dmb");
> 		asm("dmb");
> 		asm("dmb");
> 		asm("dmb");
> 		asm("dmb");
> 		asm("dmb");
> 		asm("dmb");
> 		asm("dmb");
> 	}
> 
> and make that 3 seconds to get a ps listing turn into something much
> longer?
> 
>From my testing, no, it does not get the thing even worse.

> I think what needs to happen here (while we wait) is someone _with_ the
> problem needs to experiment, and find out how many nops are needed for
> the DMB not to have much effect in cpu_relax().  If it turns out we just
> need to put one nop in, then that's not _too_ bad.

At least, I need to have 5 nops to get rid of the issue, something like
below.

Regards,
Shawn

--8<---

diff --git a/arch/arm/include/asm/processor.h b/arch/arm/include/asm/processor.h
index 99afa74..3e1b099 100644
--- a/arch/arm/include/asm/processor.h
+++ b/arch/arm/include/asm/processor.h
@@ -80,7 +80,14 @@ extern void release_thread(struct task_struct *);
 unsigned long get_wchan(struct task_struct *p);

 #if __LINUX_ARM_ARCH__ == 6 || defined(CONFIG_ARM_ERRATA_754327)
-#define cpu_relax()                    smp_mb()
+#define cpu_relax()    do {                                            \
+                               asm("nop");                             \
+                               asm("nop");                             \
+                               asm("nop");                             \
+                               asm("nop");                             \
+                               asm("nop");                             \
+                               smp_mb();                               \
+                       } while (0)
 #else
 #define cpu_relax()                    barrier()
 #endif
