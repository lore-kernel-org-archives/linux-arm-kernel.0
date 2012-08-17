From: jason77.wang@gmail.com (Hui Wang)
Date: Fri, 17 Aug 2012 16:11:32 +0800
Subject: imx6q restart is broken
In-Reply-To: <20120817034854.GE24242@S2101-09.ap.freescale.net>
References: <20120808101817.GA14718@S2101-09.ap.freescale.net>
 <50224547.9020000@de.bosch.com> <50232C17.9000700@gmail.com>
 <20120809092021.GQ18957@n2100.arm.linux.org.uk> <502BBB43.5010403@gmail.com>
 <20120815214412.GC32560@n2100.arm.linux.org.uk>
 <20120816023109.GH2258@S2101-09.ap.freescale.net>
 <20120816223446.GB15883@n2100.arm.linux.org.uk>
 <20120817034854.GE24242@S2101-09.ap.freescale.net>
Message-ID: <502DFCB4.9050502@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn Guo wrote:
> On Thu, Aug 16, 2012 at 11:34:46PM +0100, Russell King - ARM Linux wrote:
>   
>> This doesn't get around the problem that userspace can still effectively
>> issue a DoS against the system by just running a dmb in a tight loop.
>> Or maybe this would have a much more dramatic effect:
>>
>> 	while (1) {
>> 		asm("dmb");
>> 		asm("dmb");
>> 		asm("dmb");
>> 		asm("dmb");
>> 		asm("dmb");
>> 		asm("dmb");
>> 		asm("dmb");
>> 		asm("dmb");
>> 		asm("dmb");
>> 		asm("dmb");
>> 		asm("dmb");
>> 		asm("dmb");
>> 		asm("dmb");
>> 		asm("dmb");
>> 		asm("dmb");
>> 		asm("dmb");
>> 		asm("dmb");
>> 		asm("dmb");
>> 		asm("dmb");
>> 		asm("dmb");
>> 		asm("dmb");
>> 		asm("dmb");
>> 		asm("dmb");
>> 		asm("dmb");
>> 		asm("dmb");
>> 		asm("dmb");
>> 		asm("dmb");
>> 	}
>>
>> and make that 3 seconds to get a ps listing turn into something much
>> longer?
>>
>>     
> >From my testing, no, it does not get the thing even worse.
>
>   
>> I think what needs to happen here (while we wait) is someone _with_ the
>> problem needs to experiment, and find out how many nops are needed for
>> the DMB not to have much effect in cpu_relax().  If it turns out we just
>> need to put one nop in, then that's not _too_ bad.
>>     
>
> At least, I need to have 5 nops to get rid of the issue, something like
> below.
>
> Regards,
> Shawn
>
> --8<---
>
> diff --git a/arch/arm/include/asm/processor.h b/arch/arm/include/asm/processor.h
> index 99afa74..3e1b099 100644
> --- a/arch/arm/include/asm/processor.h
> +++ b/arch/arm/include/asm/processor.h
> @@ -80,7 +80,14 @@ extern void release_thread(struct task_struct *);
>  unsigned long get_wchan(struct task_struct *p);
>
>  #if __LINUX_ARM_ARCH__ == 6 || defined(CONFIG_ARM_ERRATA_754327)
> -#define cpu_relax()                    smp_mb()
> +#define cpu_relax()    do {                                            \
> +                               asm("nop");                             \
> +                               asm("nop");                             \
> +                               asm("nop");                             \
> +                               asm("nop");                             \
> +                               asm("nop");                             \
> +                               smp_mb();                               \
> +                       } while (0)
>  #else
>  #define cpu_relax()                    barrier()
>  #endif
>
>
>   
In my test, if the number of nops is equal or more than 4, the reset can 
work fine.

diff --git a/arch/arm/include/asm/barrier.h b/arch/arm/include/asm/barrier.h
index 0511238..3ad4258 100644
--- a/arch/arm/include/asm/barrier.h
+++ b/arch/arm/include/asm/barrier.h
@@ -22,7 +22,11 @@
: : "r" (0) : "memory")
#define dsb() __asm__ __volatile__ ("mcr p15, 0, %0, c7, c10, 4" \
: : "r" (0) : "memory")
-#define dmb() __asm__ __volatile__ ("mcr p15, 0, %0, c7, c10, 5" \
+#define dmb() __asm__ __volatile__ ("mcr p15, 0, %0, c7, c10, 5\n" \
+ "nop\n" \
+ "nop\n" \
+ "nop\n" \
+ "nop\n" \
: : "r" (0) : "memory")
