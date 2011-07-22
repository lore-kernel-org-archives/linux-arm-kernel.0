From: dave.martin@linaro.org (Dave Martin)
Date: Fri, 22 Jul 2011 19:12:30 +0100
Subject: [PATCH,
	RFC] fix UP futex code to not generate invalid streqt instruction
In-Reply-To: <20009.45690.158286.161591@pilspetsen.it.uu.se>
References: <20009.45690.158286.161591@pilspetsen.it.uu.se>
Message-ID: <CA+wbFdepS+QNL2QzM87ZHw8kruhaLqhahS9-x=PVsz42fjiWuA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 22, 2011 at 6:25 PM, Mikael Pettersson <mikpe@it.uu.se> wrote:
> Compiling kernel 3.0 for UP ARM (ARMv5) I see:
>
> kernel/futex.c: In function 'fixup_pi_state_owner':
> kernel/futex.c:1549: warning: 'curval' may be used uninitialized in this function
> kernel/futex.c: In function 'handle_futex_death':
> kernel/futex.c:2454: warning: 'nval' may be used uninitialized in this function
> /tmp/ccVDjh0q.s: Assembler messages:
> /tmp/ccVDjh0q.s:113: Warning: source register same as write-back base
>
> The corresponding instruction is:
>
> 2: ? ? ?streqt ?r3, [r3]
>
> (same as strteq) which the ARMv5 ARM ARM describes as being UNPREDICTABLE.
>
> This code originates from futex_atomic_cmpxchg_inatomic():
>
> static inline int
> futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?u32 oldval, u32 newval)
> {
> ? ? ? ?int ret = 0;
> ? ? ? ?u32 val;
>
> ? ? ? ?if (!access_ok(VERIFY_WRITE, uaddr, sizeof(u32)))
> ? ? ? ? ? ? ? ?return -EFAULT;
>
> ? ? ? ?__asm__ __volatile__("@futex_atomic_cmpxchg_inatomic\n"
> ? ? ? ?"1: ? ? " T(ldr) " ? ? ?%1, [%4]\n"
> ? ? ? ?" ? ? ? teq ? ? %1, %2\n"
> ? ? ? ?" ? ? ? it ? ? ?eq ? ? ?@ explicit IT needed for the 2b label\n"
> ? ? ? ?"2: ? ? " T(streq) " ? ?%3, [%4]\n"
> ? ? ? ?__futex_atomic_ex_table("%5")
> ? ? ? ?: "+r" (ret), "=&r" (val)
> ? ? ? ?: "r" (oldval), "r" (newval), "r" (uaddr), "Ir" (-EFAULT)
> ? ? ? ?: "cc", "memory");
>
> ? ? ? ?*uval = val;
> ? ? ? ?return ret;
> }
>
> The problem is that in the T(streq) insn, %3 and %4 MUST be different registers,
> but nothing in the asm() constrains them to be different. ?kernel/futex.c:init_futex()
> calls this with uaddr, oldval, and newval all zero, and the compiler may allocate
> all three to the same register. ?That's exactly what happens for me with a gcc-4.4.6
> based compiler and the 2.6.39 and 3.0 kernels. (It didn't happen with 2.6.38.)
>
> One way of fixing this is to make uaddr an input/output register, since that prevents
> it from overlapping any other input or output. ?The patch below does exactly that;
> on the problematic fragment in futex.c it causes the following change:
>
> @@ -104,13 +104,14 @@ futex_init:
> ? ? ? ?mvnne ? r3, #13
> ? ? ? ?bne ? ? .L6
> ? ? ? ?mvn ? ? r2, #13
> + ? ? ? mov ? ? r0, r3
> ?#APP
> ?@ 97 "/tmp/linux-3.0/arch/arm/include/asm/futex.h" 1
> ? ? ? ?@futex_atomic_cmpxchg_inatomic
> -1: ? ? ldrt ? ?r1, [r3]
> +1: ? ? ldrt ? ?r1, [r0]
> ? ? ? ?teq ? ? r1, r3
> ? ? ? ?it ? ? ?eq ? ? ?@ explicit IT needed for the 2b label
> -2: ? ? streqt ?r3, [r3]
> +2: ? ? streqt ?r3, [r0]
> ?3:
> ? ? ? ?.pushsection __ex_table,"a"
> ? ? ? ?.align ?3
>
> which is pretty much what we want.
>
> Lightly tested on an n2100 (UP, ARMv5).
>
> Does this seem like a reasonable solution, or is there a better way to force
> distinct input registers to an asm()?
>
> /Mikael
>
> --- linux-3.0/arch/arm/include/asm/futex.h.~1~ ?2011-07-22 12:01:07.000000000 +0200
> +++ linux-3.0/arch/arm/include/asm/futex.h ? ? ?2011-07-22 18:31:08.000000000 +0200
> @@ -95,13 +95,13 @@ futex_atomic_cmpxchg_inatomic(u32 *uval,
> ? ? ? ? ? ? ? ?return -EFAULT;
>
> ? ? ? ?__asm__ __volatile__("@futex_atomic_cmpxchg_inatomic\n"
> - ? ? ? "1: ? ? " T(ldr) " ? ? ?%1, [%4]\n"
> - ? ? ? " ? ? ? teq ? ? %1, %2\n"
> + ? ? ? "1: ? ? " T(ldr) " ? ? ?%1, [%2]\n"
> + ? ? ? " ? ? ? teq ? ? %1, %3\n"
> ? ? ? ?" ? ? ? it ? ? ?eq ? ? ?@ explicit IT needed for the 2b label\n"
> - ? ? ? "2: ? ? " T(streq) " ? ?%3, [%4]\n"
> + ? ? ? "2: ? ? " T(streq) " ? ?%4, [%2]\n"
> ? ? ? ?__futex_atomic_ex_table("%5")
> - ? ? ? : "+r" (ret), "=&r" (val)
> - ? ? ? : "r" (oldval), "r" (newval), "r" (uaddr), "Ir" (-EFAULT)
> + ? ? ? : "+r" (ret), "=&r" (val), "+r" (uaddr)
> + ? ? ? : "r" (oldval), "r" (newval), "Ir" (-EFAULT)
> ? ? ? ?: "cc", "memory");

This seems reasonable.

For new code, I personally prefer named arguments for inline asm
rather than numbered arguments, since that makes patches like
this much more readable if the arguments need to be shuffled.
Not sure if it's actually worth changing just for this, though...


The two alternative ways of forcing different registers to be used
are both a bit painful; either:

a) declare explicit register int variables with asm("rX"); or
b) use specific registers instead of % substitutions, and mark
those registers as clobbered or save/restore them (ugh)


Do we have the same potential bug for the __put_user functions in
arch/arm/include/asm/uaccess.h? Although cases where the two
relevant arguments could be statically assigned to the same register
by the compiler will be rare, those macros are used all over the place.

Cheers
---Dave
