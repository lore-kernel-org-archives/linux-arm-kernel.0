From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 9 Aug 2012 20:01:47 +0800
Subject: imx6q restart is broken
In-Reply-To: <20120809092021.GQ18957@n2100.arm.linux.org.uk>
References: <20120808101817.GA14718@S2101-09.ap.freescale.net>
 <50224547.9020000@de.bosch.com> <50232C17.9000700@gmail.com>
 <20120809092021.GQ18957@n2100.arm.linux.org.uk>
Message-ID: <20120809120144.GA19617@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 09, 2012 at 10:20:21AM +0100, Russell King - ARM Linux wrote:
> I suspect having this dmb inside cpu_relax() is flooding the
> interconnects with traffic, which then prevents other CPUs getting
> a look-in (maybe there's no fairness when it comes to dmb's.
> 
> If I'm right, you'll find is that even converting this to the ARMv7
> DMB instruction won't fix the problem.  It does, however, point
> towards a more serious problem - it means that any tight loop using
> dmb is detremental.  I have heard some people mention that even on
> various ARM SMP platforms, they have see quite an amount of
> interaction between the individual CPU cores, and I'm beginning
> to wonder whether this is why.
> 
> I think a useful test would be to only execute the DMB maybe once
> in 50 or 100 loops - the DMB is there to work around a different
> problem with the temporal locality of stores on the local CPU.  So,
> the only requirement is that we issue a DMB at some point while
> spinning waiting for another CPU to respond to our previous writes.

You got it.

The following change fixed the problem for me.  But I think you only
meant it for testing.  So how should we actually fix the problem?

Regards,
Shawn

--8<---

diff --git a/arch/arm/include/asm/processor.h b/arch/arm/include/asm/processor.h
index 99afa74..1282b61 100644
--- a/arch/arm/include/asm/processor.h
+++ b/arch/arm/include/asm/processor.h
@@ -80,11 +80,18 @@ extern void release_thread(struct task_struct *);
 unsigned long get_wchan(struct task_struct *p);

 #if __LINUX_ARM_ARCH__ == 6 || defined(CONFIG_ARM_ERRATA_754327)
-#define cpu_relax()                    smp_mb()
+#define __cpu_relax()                  smp_mb()
 #else
-#define cpu_relax()                    barrier()
+#define __cpu_relax()                  barrier()
 #endif

+#define cpu_relax()                                                    \
+({                                                                     \
+       static int i;                                                   \
+       if (i++ % 100)                                                  \
+               __cpu_relax();                                          \
+})
+
