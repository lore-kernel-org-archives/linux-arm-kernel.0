From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Nov 2009 21:04:51 +0000
Subject: [PATCH 1/2] system: mb, wmb and rmb should do a memory barrier
	even for non SMP
In-Reply-To: <1258748951-10548-1-git-send-email-adharmap@codeaurora.org>
References: <1258748951-10548-1-git-send-email-adharmap@codeaurora.org>
Message-ID: <20091120210451.GH16920@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 20, 2009 at 12:29:10PM -0800, Abhijeet Dharmapurikar wrote:
> Russell and Catalin, since you were the original creator of these changes can
> you sign-off on these?
>  
>  arch/arm/include/asm/system.h |   23 +++++++++++++++++------
>  1 files changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
> index ac44fa8..d68e135 100644
> --- a/arch/arm/include/asm/system.h
> +++ b/arch/arm/include/asm/system.h
> @@ -140,20 +140,31 @@ extern unsigned int user_debug;
>  #endif
>  
>  #ifndef CONFIG_SMP
> -#define mb()	do { if (arch_is_coherent()) dmb(); else barrier(); } while (0)
> -#define rmb()	do { if (arch_is_coherent()) dmb(); else barrier(); } while (0)
> -#define wmb()	do { if (arch_is_coherent()) dmb(); else barrier(); } while (0)
> +#if __LINUX_ARM_ARCH__ <=  6
> +#define mb()    do { if (arch_is_coherent()) dmb(); else barrier(); } while (0)
> +#define rmb()   do { if (arch_is_coherent()) dmb(); else barrier(); } while (0)
> +#define wmb()   do { if (arch_is_coherent()) dmb(); else barrier(); } while (0)
> +#else
> +/*
> + * pgprot_noncached() creates Normal uncached mappings, therefore mandatory
> + * barriers are needed.
> + */
> +#define mb()            dmb()
> +#define rmb()           dmb()
> +#define wmb()           dmb()
> +#endif
>  #define smp_mb()	barrier()
>  #define smp_rmb()	barrier()
>  #define smp_wmb()	barrier()
>  #else
> -#define mb()		dmb()
> -#define rmb()		dmb()
> -#define wmb()		dmb()
> +#define mb()            dmb()
> +#define rmb()           dmb()
> +#define wmb()           dmb()
>  #define smp_mb()	dmb()
>  #define smp_rmb()	dmb()
>  #define smp_wmb()	dmb()
>  #endif

That looks far more complicated than it needs to be.  Note that I have a
large pile of DMA API related changes pending (those which I sent this
afternoon are about half of what's to come).

This is what I have queued up for this file:

diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
index d65b2f5..058e7e9 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -138,21 +138,26 @@ extern unsigned int user_debug;
 #define dmb() __asm__ __volatile__ ("" : : : "memory")
 #endif
 
-#ifndef CONFIG_SMP
+#if __LINUX_ARM_ARCH__ >= 7 || defined(CONFIG_SMP)
+#define mb()		dmb()
+#define rmb()		dmb()
+#define wmb()		dmb()
+#else
 #define mb()	do { if (arch_is_coherent()) dmb(); else barrier(); } while (0)
 #define rmb()	do { if (arch_is_coherent()) dmb(); else barrier(); } while (0)
 #define wmb()	do { if (arch_is_coherent()) dmb(); else barrier(); } while (0)
+#endif
+
+#ifndef CONFIG_SMP
 #define smp_mb()	barrier()
 #define smp_rmb()	barrier()
 #define smp_wmb()	barrier()
 #else
-#define mb()		dmb()
-#define rmb()		dmb()
-#define wmb()		dmb()
-#define smp_mb()	dmb()
-#define smp_rmb()	dmb()
-#define smp_wmb()	dmb()
+#define smp_mb()	mb()
+#define smp_rmb()	rmb()
+#define smp_wmb()	wmb()
 #endif
+
 #define read_barrier_depends()		do { } while(0)
 #define smp_read_barrier_depends()	do { } while(0)
 

Basically, what the above is implementing are these statements from
memory-barriers.txt:

  All memory barriers except the data dependency barriers imply a compiler
  barrier. Data dependencies do not impose any additional compiler ordering.

  SMP memory barriers are reduced to compiler barriers on uniprocessor compiled
  systems because it is assumed that a CPU will appear to be self-consistent,
  and will order overlapping accesses correctly with respect to itself.

Or to put it another way, smp barriers are a compiler barrier if !SMP, or
their mandatory versions if SMP.

We then chose the mandatory versions depending on other configuration.
