From: will.deacon@arm.com (Will Deacon)
Date: Tue, 4 Jun 2013 11:39:53 +0100
Subject: [PATCH] ARM: pcpu: ensure __my_cpu_offset cannot be re-ordered
 across barrier()
In-Reply-To: <alpine.LFD.2.03.1306031339010.1200@syhkavp.arg>
References: <1370278405-13261-1-git-send-email-will.deacon@arm.com>
 <alpine.LFD.2.03.1306031339010.1200@syhkavp.arg>
Message-ID: <20130604103953.GL27516@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nico,

Thanks for helping out with this.

On Mon, Jun 03, 2013 at 08:33:24PM +0100, Nicolas Pitre wrote:
> On Mon, 3 Jun 2013, Will Deacon wrote:
> >  static inline unsigned long __my_cpu_offset(void)
> >  {
> >  	unsigned long off;
> > -	/* Read TPIDRPRW */
> > -	asm("mrc p15, 0, %0, c13, c0, 4" : "=r" (off) : : "memory");
> > +	/*
> > +	 * Read TPIDRPRW.
> > +	 * We want to allow caching the value, so avoid using volatile and
> > +	 * instead use a fake memory access to hazard against barrier().
> > +	 */
> > +	asm("mrc p15, 0, %0, c13, c0, 4" : "=r" (off), "=Qo" (off));
> >  	return off;
> >  }
> 
> This doesn't work with the little test I wrote to see the compiler 
> behavior change.  Here's my test in case it is flawed:

[...]

> int foo(int *a, int *b, char *c)
> {
> 	int x, y, z;
> 
> 	x = a[__my_cpu_offset()];
> 	barrier();
> 	y = b[__my_cpu_offset()];
> 	z = c[__my_cpu_offset()];
> 	barrier();
> 	return  x + y + z + a[__my_cpu_offset()];
> }
> 
> With the original memory clobber (commented out above) the asm output 
> is:
> 
> foo:
>         mrc     p15, 0, r3, c13, c0, 4
>         ldr     ip, [r0, r3, asl #2]
>         ldr     r1, [r1, r3, asl #2]
>         ldrb    r2, [r2, r3]    @ zero_extendqisi2
>         ldr     r3, [r0, r3, asl #2]
>         add     r0, ip, r1
>         add     r0, r0, r2
>         add     r0, r0, r3
>         bx      lr
> 
> So to confirm that no memory barrier is respected in any way.
> 
> With your change we get this instead:
> 
> foo:
>         sub     sp, sp, #8
>         mrc     p15, 0, r3, c13, c0, 4
>         str     r3, [sp, #4]
>         ldr     ip, [r0, r3, asl #2]
>         ldr     r1, [r1, r3, asl #2]
>         str     r3, [sp, #4]
>         ldrb    r2, [r2, r3]    @ zero_extendqisi2
>         ldr     r3, [r0, r3, asl #2]
>         add     r0, ip, r1
>         add     r0, r0, r2
>         add     r0, r0, r3
>         add     sp, sp, #8
>         bx      lr

Ah crap, that sucks. Thanks for testing it -- I've just been looking at slub
with my toolchain, but your test case also falls to bits here.

> So not only the barrier is completely ineffective at reloading the CPU 
> offset, but it introduces a useless store onto the stack.  Same behavior 
> with gcc versions 4.7.3, 4.6.2 and 4.5.1 (yes, that's really what I have 
> on my system -- waiting for 4.8.4 now).

Just a heads up: I've had nothing but problems with 4.8-based toolchains
(including those provided by Linaro). Seriously, I had the thing ICE on 5 of
the first 7 files building the kernel!

> So if the preemption count is really what this should be protected 
> against, we should simply be adding that as an input dependency to the 
> inline asm constraint as follows:
> 
> diff --git a/arch/arm/include/asm/percpu.h b/arch/arm/include/asm/percpu.h
> index 968c0a14e0..52f9ca33e7 100644
> --- a/arch/arm/include/asm/percpu.h
> +++ b/arch/arm/include/asm/percpu.h
> @@ -31,7 +31,9 @@ static inline unsigned long __my_cpu_offset(void)
>  {
>  	unsigned long off;
>  	/* Read TPIDRPRW */
> -	asm("mrc p15, 0, %0, c13, c0, 4" : "=r" (off) : : "memory");
> +	asm("mrc p15, 0, %0, c13, c0, 4"
> +	    : "=r" (off)
> +	    : "m" (current_thread_info()->preempt_count));
>  	return off;
>  }
>  #define __my_cpu_offset __my_cpu_offset()
> 
> The problem with this approach is that current_thread_info() is not a 
> static location either as it is always derrived from the stack pointer, 
> so it needlessly computes it even when nothing else uses it in the same 
> function.

Yes, that's going to generate fairly horrible code :(

Actually, I just had a play around and managed to come up with something a
bit better. It seems as though putting the memory constraint as an *input*
clobber is what GCC really wants, but this sucks because you end up
generating prologue code to set things up for the addressing mode which you
never use. For example, you can pretend you have a dependency on *(unsigned
long *)0 and your test case becomes:

c001cd48:       e52d4004        push    {r4}            ; (str r4, [sp, #-4]!)
c001cd4c:       e3a03000        mov     r3, #0
c001cd50:       ee1dcf90        mrc     15, 0, ip, cr13, cr0, {4}
c001cd54:       e790410c        ldr     r4, [r0, ip, lsl #2]
c001cd58:       ee1dcf90        mrc     15, 0, ip, cr13, cr0, {4}
c001cd5c:       e791110c        ldr     r1, [r1, ip, lsl #2]
c001cd60:       e792210c        ldr     r2, [r2, ip, lsl #2]
c001cd64:       ee1d3f90        mrc     15, 0, r3, cr13, cr0, {4}
c001cd68:       e7903103        ldr     r3, [r0, r3, lsl #2]
c001cd6c:       e0840001        add     r0, r4, r1
c001cd70:       e0800002        add     r0, r0, r2
c001cd74:       e0800003        add     r0, r0, r3
c001cd78:       e8bd0010        pop     {r4}
c001cd7c:       e12fff1e        bx      lr

However, if you instead add a dependency on something that already lives in a
register, like __builtin_return_address, you get:

c001cd44:       e92d4010        push    {r4, lr}
c001cd48:       ee1dcf90        mrc     15, 0, ip, cr13, cr0, {4}
c001cd4c:       e790410c        ldr     r4, [r0, ip, lsl #2]
c001cd50:       ee1dcf90        mrc     15, 0, ip, cr13, cr0, {4}
c001cd54:       e791110c        ldr     r1, [r1, ip, lsl #2]
c001cd58:       e792210c        ldr     r2, [r2, ip, lsl #2]
c001cd5c:       ee1d3f90        mrc     15, 0, r3, cr13, cr0, {4}
c001cd60:       e7903103        ldr     r3, [r0, r3, lsl #2]
c001cd64:       e0840001        add     r0, r4, r1
c001cd68:       e0800002        add     r0, r0, r2
c001cd6c:       e0800003        add     r0, r0, r3
c001cd70:       e8bd8010        pop     {r4, pc}

Unfortunately, that builtin has clobber semantics on lr (no idea why) so we
push an extra register. I'm going to have a chat with our tools guys this
afternoon to see if there's anything better we can do, but for the time
being my diff is below.

Cheers,

Will

--->8

diff --git a/arch/arm/include/asm/percpu.h b/arch/arm/include/asm/percpu.h
index 968c0a1..6780990 100644
--- a/arch/arm/include/asm/percpu.h
+++ b/arch/arm/include/asm/percpu.h
@@ -30,8 +30,16 @@ static inline void set_my_cpu_offset(unsigned long off)
 static inline unsigned long __my_cpu_offset(void)
 {
        unsigned long off;
-       /* Read TPIDRPRW */
-       asm("mrc p15, 0, %0, c13, c0, 4" : "=r" (off) : : "memory");
+
+       /*
+        * Read TPIDRPRW.
+        * We want to allow caching the value, so avoid using volatile and
+        * instead use a fake memory access to hazard against barrier().
+        */
+       asm("mrc p15, 0, %0, c13, c0, 4"
+           : "=r" (off)
+           : "Q" (*(unsigned long *)__builtin_return_address(0)));
+
        return off;
 }
 #define __my_cpu_offset __my_cpu_offset()
