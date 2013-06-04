From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 04 Jun 2013 13:39:42 -0400 (EDT)
Subject: [PATCH] ARM: pcpu: ensure __my_cpu_offset cannot be re-ordered
 across barrier()
In-Reply-To: <20130604171506.GZ27516@mudshark.cambridge.arm.com>
References: <1370278405-13261-1-git-send-email-will.deacon@arm.com>
 <alpine.LFD.2.03.1306031339010.1200@syhkavp.arg>
 <20130604103953.GL27516@mudshark.cambridge.arm.com>
 <20130604171506.GZ27516@mudshark.cambridge.arm.com>
Message-ID: <alpine.LFD.2.03.1306041336060.1200@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 4 Jun 2013, Will Deacon wrote:

> On Tue, Jun 04, 2013 at 11:39:53AM +0100, Will Deacon wrote:
> > However, if you instead add a dependency on something that already lives in a
> > register, like __builtin_return_address, you get:
> > 
> > c001cd44:       e92d4010        push    {r4, lr}
> > c001cd48:       ee1dcf90        mrc     15, 0, ip, cr13, cr0, {4}
> > c001cd4c:       e790410c        ldr     r4, [r0, ip, lsl #2]
> > c001cd50:       ee1dcf90        mrc     15, 0, ip, cr13, cr0, {4}
> > c001cd54:       e791110c        ldr     r1, [r1, ip, lsl #2]
> > c001cd58:       e792210c        ldr     r2, [r2, ip, lsl #2]
> > c001cd5c:       ee1d3f90        mrc     15, 0, r3, cr13, cr0, {4}
> > c001cd60:       e7903103        ldr     r3, [r0, r3, lsl #2]
> > c001cd64:       e0840001        add     r0, r4, r1
> > c001cd68:       e0800002        add     r0, r0, r2
> > c001cd6c:       e0800003        add     r0, r0, r3
> > c001cd70:       e8bd8010        pop     {r4, pc}
> 
> Actually, I've managed to improve this further using sp instead (see diff
> below), which also prevents GCC from moving the lr into other registers for
> no reason. The code generated for your test is:
> 
> c001cda4:       ee1d3f90        mrc     15, 0, r3, cr13, cr0, {4}
> c001cda8:       e790c103        ldr     ip, [r0, r3, lsl #2]
> c001cdac:       ee1d3f90        mrc     15, 0, r3, cr13, cr0, {4}
> c001cdb0:       e7911103        ldr     r1, [r1, r3, lsl #2]
> c001cdb4:       e7922103        ldr     r2, [r2, r3, lsl #2]
> c001cdb8:       ee1d3f90        mrc     15, 0, r3, cr13, cr0, {4}
> c001cdbc:       e7903103        ldr     r3, [r0, r3, lsl #2]
> c001cdc0:       e08c0001        add     r0, ip, r1
> c001cdc4:       e0800002        add     r0, r0, r2
> c001cdc8:       e0800003        add     r0, r0, r3
> c001cdcc:       e12fff1e        bx      lr

Excellent.

> I spoke to the tools guys and they'll look into why the original patch
> didn't work, since that could have wider implications on our use of
> barrier().

Good.  However, given the wide range of gcc versions exhibiting the same 
behavior, I think your patch is the best way forward even if gcc were to 
be broken and eventually fixed.

Reviewed-by: Nicolas Pitre <nico@linaro.org>

I'd suggest queuing it for stable as well.

> --->8
> 
> diff --git a/arch/arm/include/asm/percpu.h b/arch/arm/include/asm/percpu.h
> index 968c0a1..209e650 100644
> --- a/arch/arm/include/asm/percpu.h
> +++ b/arch/arm/include/asm/percpu.h
> @@ -30,8 +30,15 @@ static inline void set_my_cpu_offset(unsigned long off)
>  static inline unsigned long __my_cpu_offset(void)
>  {
>         unsigned long off;
> -       /* Read TPIDRPRW */
> -       asm("mrc p15, 0, %0, c13, c0, 4" : "=r" (off) : : "memory");
> +       register unsigned long *sp asm ("sp");
> +
> +       /*
> +        * Read TPIDRPRW.
> +        * We want to allow caching the value, so avoid using volatile and
> +        * instead use a fake stack read to hazard against barrier().
> +        */
> +       asm("mrc p15, 0, %0, c13, c0, 4" : "=r" (off) : "Q" (*sp));
> +
>         return off;
>  }
>  #define __my_cpu_offset __my_cpu_offset()
> 
