From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 7 Dec 2012 16:17:54 +0000
Subject: Question: Multiple board support is broken
In-Reply-To: <20121207193143.2d2029daf2041683bc7b2474@mail.ru>
References: <20121207193143.2d2029daf2041683bc7b2474@mail.ru>
Message-ID: <20121207161754.GV14363@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 07, 2012 at 07:31:43PM +0400, Alexander Shiyan wrote:
> Hello.
> 
> Today I was tested multiple boards (not multiplatform) in the kernel
> and found problems with booting.

Err, I test this almost constantly and it works, and it's been working
100% correctly for about the last 12 years.  There is no problem here.

> Exacly, if multiple boards defined
> in. config, we can proceed to boot only the last (determined by mach number).

The mach-types file doesn't have anything to do with which board gets chosen.
That file just provides the IDs, and a bunch of _optimized_ macros to
allow the compiler to perform optimizations.

Let's look at how this works today - let me pull out two entries:

#ifdef CONFIG_ARCH_EBSA285
# ifdef machine_arch_type
#  undef machine_arch_type
#  define machine_arch_type     __machine_arch_type
# else
#  define machine_arch_type     MACH_TYPE_EBSA285
# endif
# define machine_is_ebsa285()   (machine_arch_type == MACH_TYPE_EBSA285)
#else
# define machine_is_ebsa285()   (0)
#endif

#ifdef CONFIG_ARCH_NETWINDER
# ifdef machine_arch_type
#  undef machine_arch_type
#  define machine_arch_type     __machine_arch_type
# else
#  define machine_arch_type     MACH_TYPE_NETWINDER
# endif
# define machine_is_netwinder() (machine_arch_type == MACH_TYPE_NETWINDER)
#else
# define machine_is_netwinder() (0)
#endif

#ifndef machine_arch_type
#define machine_arch_type       __machine_arch_type
#endif

Now, if CONFIG_ARCH_EBSA285=y and CONFIG_ARCH_NETWINDER=n, then follow
through what the preprocessor does.  In the first case, machine_arch_type
is _not_ defined as a pre-processor symbol, so the "ifdef" is false.
That means machine_arch_type gets defined as MACH_TYPE_EBSA285.

machine_is_ebsa285() gets defined as (machine_arch_type == MACH_TYPE_EBSA285)
and when all the macro subsitutions occur (which happens where it's used)
this ends up becoming (MACH_TYPE_EBSA285 == MACH_TYPE_EBSA285).  This is
always true, so any code inside an if (machine_is_ebsa285()) {} block will
be compiled into the kernel and will be executed unconditionally - which
is exactly what we want.

Now, machine_is_netwinder() gets defined as constant (0).  This is always
false, so any code inside an if (machine_is_netwinder()) {} block will
be optimized away - exactly what we want.  This isn't affected by the
machine_arch_type definition.

Next, you can do the same thing for the CONFIG_ARCH_EBSA285=n and
CONFIG_ARCH_NETWINDER=y case, and you'll end up with similar results.

Finally for the case where CONFIG_ARCH_EBSA285=y and CONFIG_ARCH_NETWINDER=y.
In this case, it starts off just like the CONFIG_ARCH_EBSA285=y case above.
When we hit the CONFIG_ARCH_NETWINDER block a very important change happens.
This time machine_arch_type is already defined.

So, what happens is machine_arch_type first gets undefined to avoid any
compiler warnings about multiple definitions.  We then define
machine_arch_type to be the C variable __machine_arch_type.

This makes any references to (machine_arch_type == MACH_TYPE_WHATEVER)
become a runtime interpreted condition, which occurs for any machine type
that has its config symbol enabled.  So, machine_is_ebsa285() becomes
(__machine_arch_type == MACH_TYPE_EBSA285) and machine_is_netwinder()
becomes (__machine_arch_type == MACH_TYPE_NETWINDER), while other
platforms machine_is_xxx() macros remain defined to constant 0.

So, this all works exactly as we want.  There is no bug here.
