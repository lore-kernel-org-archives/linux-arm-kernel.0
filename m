From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 03 Jun 2013 15:33:24 -0400 (EDT)
Subject: [PATCH] ARM: pcpu: ensure __my_cpu_offset cannot be re-ordered
 across barrier()
In-Reply-To: <1370278405-13261-1-git-send-email-will.deacon@arm.com>
References: <1370278405-13261-1-git-send-email-will.deacon@arm.com>
Message-ID: <alpine.LFD.2.03.1306031339010.1200@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 3 Jun 2013, Will Deacon wrote:

> __my_cpu_offset is non-volatile, since we want its value to be cached
> when we access several per-cpu variables in a row with preemption
> disabled. This means that we rely on preempt_{en,dis}able to hazard
> with the operation via the barrier() macro, so that we can't end up
> migrating CPUs without reloading the per-cpu offset.
> 
> Unfortunately, GCC doesn't treat a "memory" clobber on a non-volatile
> asm block as a side-effect, and will happily re-order it before other
> memory clobbers (including those in prempt_disable()) and cache the
> value. This has been observed to break the cmpxchg logic in the slub
> allocator, leading to livelock in kmem_cache_alloc in mainline kernels.
> 
> This patch adds a dummy memory output operand to __my_cpu_offset,
> forcing it to be ordered with respect to the barrier() macro.
> 
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Nicolas Pitre <nico@fluxnic.net>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm/include/asm/percpu.h | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/include/asm/percpu.h b/arch/arm/include/asm/percpu.h
> index 968c0a1..93970eb 100644
> --- a/arch/arm/include/asm/percpu.h
> +++ b/arch/arm/include/asm/percpu.h
> @@ -30,8 +30,12 @@ static inline void set_my_cpu_offset(unsigned long off)
>  static inline unsigned long __my_cpu_offset(void)
>  {
>  	unsigned long off;
> -	/* Read TPIDRPRW */
> -	asm("mrc p15, 0, %0, c13, c0, 4" : "=r" (off) : : "memory");
> +	/*
> +	 * Read TPIDRPRW.
> +	 * We want to allow caching the value, so avoid using volatile and
> +	 * instead use a fake memory access to hazard against barrier().
> +	 */
> +	asm("mrc p15, 0, %0, c13, c0, 4" : "=r" (off), "=Qo" (off));
>  	return off;
>  }

This doesn't work with the little test I wrote to see the compiler 
behavior change.  Here's my test in case it is flawed:

static inline unsigned long __my_cpu_offset(void)
{
       unsigned long off;
       //asm("mrc p15, 0, %0, c13, c0, 4" : "=r" (off) : : "memory");
       asm("mrc p15, 0, %0, c13, c0, 4" : "=r" (off), "=Qo" (off));
       return off;
}

#define barrier() asm volatile ("" : : : "memory")

int foo(int *a, int *b, char *c)
{
	int x, y, z;

	x = a[__my_cpu_offset()];
	barrier();
	y = b[__my_cpu_offset()];
	z = c[__my_cpu_offset()];
	barrier();
	return  x + y + z + a[__my_cpu_offset()];
}

With the original memory clobber (commented out above) the asm output 
is:

foo:
        mrc     p15, 0, r3, c13, c0, 4
        ldr     ip, [r0, r3, asl #2]
        ldr     r1, [r1, r3, asl #2]
        ldrb    r2, [r2, r3]    @ zero_extendqisi2
        ldr     r3, [r0, r3, asl #2]
        add     r0, ip, r1
        add     r0, r0, r2
        add     r0, r0, r3
        bx      lr

So to confirm that no memory barrier is respected in any way.

With your change we get this instead:

foo:
        sub     sp, sp, #8
        mrc     p15, 0, r3, c13, c0, 4
        str     r3, [sp, #4]
        ldr     ip, [r0, r3, asl #2]
        ldr     r1, [r1, r3, asl #2]
        str     r3, [sp, #4]
        ldrb    r2, [r2, r3]    @ zero_extendqisi2
        ldr     r3, [r0, r3, asl #2]
        add     r0, ip, r1
        add     r0, r0, r2
        add     r0, r0, r3
        add     sp, sp, #8
        bx      lr

So not only the barrier is completely ineffective at reloading the CPU 
offset, but it introduces a useless store onto the stack.  Same behavior 
with gcc versions 4.7.3, 4.6.2 and 4.5.1 (yes, that's really what I have 
on my system -- waiting for 4.8.4 now).

So if the preemption count is really what this should be protected 
against, we should simply be adding that as an input dependency to the 
inline asm constraint as follows:

diff --git a/arch/arm/include/asm/percpu.h b/arch/arm/include/asm/percpu.h
index 968c0a14e0..52f9ca33e7 100644
--- a/arch/arm/include/asm/percpu.h
+++ b/arch/arm/include/asm/percpu.h
@@ -31,7 +31,9 @@ static inline unsigned long __my_cpu_offset(void)
 {
 	unsigned long off;
 	/* Read TPIDRPRW */
-	asm("mrc p15, 0, %0, c13, c0, 4" : "=r" (off) : : "memory");
+	asm("mrc p15, 0, %0, c13, c0, 4"
+	    : "=r" (off)
+	    : "m" (current_thread_info()->preempt_count));
 	return off;
 }
 #define __my_cpu_offset __my_cpu_offset()

The problem with this approach is that current_thread_info() is not a 
static location either as it is always derrived from the stack pointer, 
so it needlessly computes it even when nothing else uses it in the same 
function.


Nicolas
