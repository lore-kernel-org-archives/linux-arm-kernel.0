From: steve.capper@linaro.org (Steve Capper)
Date: Fri, 7 Nov 2014 13:52:06 +0000
Subject: [PATCH] arm64: percpu: Implement this_cpu operations
In-Reply-To: <20141106122753.GC31605@arm.com>
References: <1415272377-5334-1-git-send-email-steve.capper@linaro.org>
 <20141106122753.GC31605@arm.com>
Message-ID: <20141107135205.GA7591@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 06, 2014 at 12:27:53PM +0000, Will Deacon wrote:
> Hi Steve,
> 
> Thanks for looking at this!

Hey Will,
No problem, it's quite beneficial for performance.

> 
> On Thu, Nov 06, 2014 at 11:12:57AM +0000, Steve Capper wrote:
> > The generic this_cpu operations disable interrupts to ensure that the
> > requested operation is protected from pre-emption. For arm64, this is
> > overkill and can hurt throughput and latency.
> > 
> > This patch provides arm64 specific implementations for the this_cpu
> > operations. Rather than disable interrupts, we use the exclusive
> > monitor or atomic operations as appropriate.
> > 
> > The following operations are implemented: add, add_return, and, or,
> > read, write, xchg. We also wire up a cmpxchg implementation from
> > cmpxchg.h.
> > 
> > Testing was performed using the percpu_test module and hackbench on a
> > Juno board running 3.18-rc3.
> 
> [...]
> 
> > diff --git a/arch/arm64/include/asm/cmpxchg.h b/arch/arm64/include/asm/cmpxchg.h
> > index 3e02245..3e51f49 100644
> > --- a/arch/arm64/include/asm/cmpxchg.h
> > +++ b/arch/arm64/include/asm/cmpxchg.h
> > @@ -237,8 +237,10 @@ static inline unsigned long __cmpxchg_mb(volatile void *ptr, unsigned long old,
> >  	__ret; \
> >  })
> >  
> > -#define this_cpu_cmpxchg_8(ptr, o, n) \
> > -	cmpxchg(raw_cpu_ptr(&(ptr)), o, n);
> > +#define this_cpu_cmpxchg_1(ptr, o, n) cmpxchg(raw_cpu_ptr(&(ptr)), o, n)
> > +#define this_cpu_cmpxchg_2(ptr, o, n) cmpxchg(raw_cpu_ptr(&(ptr)), o, n)
> > +#define this_cpu_cmpxchg_4(ptr, o, n) cmpxchg(raw_cpu_ptr(&(ptr)), o, n)
> > +#define this_cpu_cmpxchg_8(ptr, o, n) cmpxchg(raw_cpu_ptr(&(ptr)), o, n)
> 
> You can use cmpxchg_local here, as we don't require barrier semantics.

Agreed, thanks, I will update that.

> 
> >  #define this_cpu_cmpxchg_double_8(ptr1, ptr2, o1, o2, n1, n2) \
> >  	cmpxchg_double(raw_cpu_ptr(&(ptr1)), raw_cpu_ptr(&(ptr2)), \
> > diff --git a/arch/arm64/include/asm/percpu.h b/arch/arm64/include/asm/percpu.h
> > index 5279e57..e751681 100644
> > --- a/arch/arm64/include/asm/percpu.h
> > +++ b/arch/arm64/include/asm/percpu.h
> > @@ -44,6 +44,237 @@ static inline unsigned long __my_cpu_offset(void)
> >  
> >  #endif /* CONFIG_SMP */
> >  
> > +#define PERCPU_OP(op, asm_op)						\
> > +static inline unsigned long __percpu_##op(void *ptr,			\
> > +			unsigned long val, int size)			\
> > +{									\
> > +	unsigned long loop, ret;					\
> > +									\
> > +	switch (size) {							\
> > +	case 1:								\
> > +		do {							\
> > +			asm ("//__per_cpu_" #op "_1\n"			\
> > +			"ldxrb	  %w[ret], %[ptr]\n"			\
> > +			#asm_op " %w[ret], %w[ret], %w[val]\n"		\
> > +			"stxrb	  %w[loop], %w[ret], %[ptr]\n"		\
> > +			: [loop] "=&r" (loop), [ret] "=&r" (ret),	\
> > +			  [ptr] "+Q"(*(u8 *)ptr)			\
> > +			: [val] "Ir" (val));				\
> > +		} while (loop);						\
> > +		break;							\
> 
> Curious, but do you see any difference in code generation over an explicit
> cbnz, like we use in the ATOMIC_OP macro?

I've not noticed any substancial difference in the code paths I've
inspected. Theoretically, a compiler that is extremely averse to
branches could do some unrolling with this.

I decided to give the compiler as much control as possible, so elected
to put the minimum amount of assembler in.

> 
> > +	case 2:								\
> > +		do {							\
> > +			asm ("//__per_cpu_" #op "_2\n"			\
> > +			"ldxrh	  %w[ret], %[ptr]\n"			\
> > +			#asm_op " %w[ret], %w[ret], %w[val]\n"		\
> > +			"stxrh	  %w[loop], %w[ret], %[ptr]\n"		\
> > +			: [loop] "=&r" (loop), [ret] "=&r" (ret),	\
> > +			  [ptr]  "+Q"(*(u16 *)ptr)			\
> > +			: [val] "Ir" (val));				\
> > +		} while (loop);						\
> > +		break;							\
> > +	case 4:								\
> > +		do {							\
> > +			asm ("//__per_cpu_" #op "_4\n"			\
> > +			"ldxr	  %w[ret], %[ptr]\n"			\
> > +			#asm_op " %w[ret], %w[ret], %w[val]\n"		\
> > +			"stxr	  %w[loop], %w[ret], %[ptr]\n"		\
> > +			: [loop] "=&r" (loop), [ret] "=&r" (ret),	\
> > +			  [ptr] "+Q"(*(u32 *)ptr)			\
> > +			: [val] "Ir" (val));				\
> > +		} while (loop);						\
> > +		break;							\
> > +	case 8:								\
> > +		do {							\
> > +			asm ("//__per_cpu_" #op "_8\n"			\
> > +			"ldxr	  %[ret], %[ptr]\n"			\
> > +			#asm_op " %[ret], %[ret], %[val]\n"		\
> > +			"stxr	  %w[loop], %[ret], %[ptr]\n"		\
> > +			: [loop] "=&r" (loop), [ret] "=&r" (ret),	\
> > +			  [ptr] "+Q"(*(u64 *)ptr)			\
> > +			: [val] "Ir" (val));				\
> > +		} while (loop);						\
> > +		break;							\
> > +	default:							\
> > +		BUILD_BUG();						\
> > +	}								\
> > +									\
> > +	return ret;							\
> > +}
> > +
> > +PERCPU_OP(add, add)
> > +PERCPU_OP(and, and)
> > +PERCPU_OP(or, orr)
> 
> Can you use these to generate local_t versions too?

Sure, I forgot about them, I will add them to V3.

Cheers,
-- 
Steve
