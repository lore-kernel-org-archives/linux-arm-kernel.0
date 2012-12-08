From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 8 Dec 2012 10:38:12 +0000
Subject: Question: Multiple board support is broken
In-Reply-To: <20121208135845.707d9f50ba9b2aaaef66bb3a@mail.ru>
References: <20121207193143.2d2029daf2041683bc7b2474@mail.ru>
 <20121207161754.GV14363@n2100.arm.linux.org.uk>
 <20121208122811.31c7b9b3a57b898c25204252@mail.ru>
 <20121208092618.GB14363@n2100.arm.linux.org.uk>
 <20121208135845.707d9f50ba9b2aaaef66bb3a@mail.ru>
Message-ID: <20121208103812.GC14363@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 08, 2012 at 01:58:45PM +0400, Alexander Shiyan wrote:
> On Sat, 8 Dec 2012 09:26:18 +0000
> Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> 
> > On Sat, Dec 08, 2012 at 12:28:11PM +0400, Alexander Shiyan wrote:
> > > On Fri, 7 Dec 2012 16:17:54 +0000
> > > Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> > > 
> > > > > Today I was tested multiple boards (not multiplatform) in the kernel
> > > > > and found problems with booting.
> > > > 
> > > > Err, I test this almost constantly and it works, and it's been working
> > > > 100% correctly for about the last 12 years.  There is no problem here.
> > > > 
> > > > > Exacly, if multiple boards defined
> > > > > in. config, we can proceed to boot only the last (determined by mach number).
> > > > 
> > > > The mach-types file doesn't have anything to do with which board gets chosen.
> > > > That file just provides the IDs, and a bunch of _optimized_ macros to
> > > > allow the compiler to perform optimizations.
> > > > 
> > > > Let's look at how this works today - let me pull out two entries:
> > > > 
> > > > #ifdef CONFIG_ARCH_EBSA285
> > > > # ifdef machine_arch_type
> > > > #  undef machine_arch_type
> > > > #  define machine_arch_type     __machine_arch_type
> > > > # else
> > > > #  define machine_arch_type     MACH_TYPE_EBSA285
> > > > # endif
> > > > # define machine_is_ebsa285()   (machine_arch_type == MACH_TYPE_EBSA285)
> > > > #else
> > > > # define machine_is_ebsa285()   (0)
> > > > #endif
> > > > 
> > > > #ifdef CONFIG_ARCH_NETWINDER
> > > > # ifdef machine_arch_type
> > > > #  undef machine_arch_type
> > > > #  define machine_arch_type     __machine_arch_type
> > > > # else
> > > > #  define machine_arch_type     MACH_TYPE_NETWINDER
> > > > # endif
> > > > # define machine_is_netwinder() (machine_arch_type == MACH_TYPE_NETWINDER)
> > > > #else
> > > > # define machine_is_netwinder() (0)
> > > > #endif
> > > > 
> > > > #ifndef machine_arch_type
> > > > #define machine_arch_type       __machine_arch_type
> > > > #endif
> > > > 
> > > > Now, if CONFIG_ARCH_EBSA285=y and CONFIG_ARCH_NETWINDER=n, then follow
> > > > through what the preprocessor does.  In the first case, machine_arch_type
> > > > is _not_ defined as a pre-processor symbol, so the "ifdef" is false.
> > > > That means machine_arch_type gets defined as MACH_TYPE_EBSA285.
> > > > 
> > > > machine_is_ebsa285() gets defined as (machine_arch_type == MACH_TYPE_EBSA285)
> > > > and when all the macro subsitutions occur (which happens where it's used)
> > > > this ends up becoming (MACH_TYPE_EBSA285 == MACH_TYPE_EBSA285).  This is
> > > > always true, so any code inside an if (machine_is_ebsa285()) {} block will
> > > > be compiled into the kernel and will be executed unconditionally - which
> > > > is exactly what we want.
> > > > 
> > > > Now, machine_is_netwinder() gets defined as constant (0).  This is always
> > > > false, so any code inside an if (machine_is_netwinder()) {} block will
> > > > be optimized away - exactly what we want.  This isn't affected by the
> > > > machine_arch_type definition.
> > > > 
> > > > Next, you can do the same thing for the CONFIG_ARCH_EBSA285=n and
> > > > CONFIG_ARCH_NETWINDER=y case, and you'll end up with similar results.
> > > > 
> > > > Finally for the case where CONFIG_ARCH_EBSA285=y and CONFIG_ARCH_NETWINDER=y.
> > > > In this case, it starts off just like the CONFIG_ARCH_EBSA285=y case above.
> > > > When we hit the CONFIG_ARCH_NETWINDER block a very important change happens.
> > > > This time machine_arch_type is already defined.
> > > > 
> > > > So, what happens is machine_arch_type first gets undefined to avoid any
> > > > compiler warnings about multiple definitions.  We then define
> > > > machine_arch_type to be the C variable __machine_arch_type.
> > > > 
> > > > This makes any references to (machine_arch_type == MACH_TYPE_WHATEVER)
> > > > become a runtime interpreted condition, which occurs for any machine type
> > > > that has its config symbol enabled.  So, machine_is_ebsa285() becomes
> > > > (__machine_arch_type == MACH_TYPE_EBSA285) and machine_is_netwinder()
> > > > becomes (__machine_arch_type == MACH_TYPE_NETWINDER), while other
> > > > platforms machine_is_xxx() macros remain defined to constant 0.
> > > > 
> > > > So, this all works exactly as we want.  There is no bug here.
> > > 
> > > Apparently the problem is that I have a custom symbol for their own board,
> > > but I specify an existing ID in the MACHINE_START. The initial boot is fine,
> > > because support for the ID is in the kernel, but the mach_desc is taken from
> > > a different machine. Below is a test program to demonstrate. In this test I
> > > boot kernel with ID=4 and I have a valid machines with ID=4 and 5, but symbol
>                                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> > > associated with ID=4 is missing. This case will a result boot a machine ID=5.
> > > How to solve the problem, I do not know yet...
> > > 
> > > <<< test.c
> > > #include <stdio.h>
> > > #include <string.h>
> > > #include <stdlib.h>
> > > 
> > > //#define CONFIG_ARCH_EBSA285 1
> > > #define CONFIG_ARCH_NETWINDER 1
> > > 
> > > #define MACH_TYPE_EBSA285 4
> > > #define MACH_TYPE_NETWINDER 5
> > > 
> > > #ifdef CONFIG_ARCH_EBSA285
> > > # ifdef machine_arch_type
> > > # undef machine_arch_type
> > > # define machine_arch_type __machine_arch_type
> > > # else
> > > # define machine_arch_type MACH_TYPE_EBSA285
> > > # endif
> > > # define machine_is_ebsa285() (machine_arch_type == MACH_TYPE_EBSA285)
> > > #else
> > > # define machine_is_ebsa285() (0)
> > > #endif
> > > 
> > > #ifdef CONFIG_ARCH_NETWINDER
> > > # ifdef machine_arch_type
> > > # undef machine_arch_type
> > > # define machine_arch_type __machine_arch_type
> > > # else
> > > # define machine_arch_type MACH_TYPE_NETWINDER
> > > # endif
> > > # define machine_is_netwinder() (machine_arch_type == MACH_TYPE_NETWINDER)
> > > #else
> > > # define machine_is_netwinder() (0)
> > > #endif
> > > 
> > > #ifndef machine_arch_type
> > > #define machine_arch_type __machine_arch_type
> > > #endif
> > > 
> > > unsigned int __machine_arch_type = MACH_TYPE_EBSA285; //From bootloader
> > > 
> > > int main(int argc, char** argv)
> > > {
> > > 	if (machine_is_ebsa285())
> > > 		printf("machine_is_ebsa285()\n");
> > > 	if (machine_is_netwinder())
> > > 		printf("machine_is_netwinder()\n");
> > > 	printf("  machine_arch_type=%u\n", machine_arch_type);
> > > 	printf("__machine_arch_type=%u\n", __machine_arch_type);
> > > 
> > > 	return 0;
> > > }
> > > >>>
> > > 
> > > shc at shc /home/git/test $ ./test 
> > > machine_is_netwinder()
> > >   machine_arch_type=5
> > > __machine_arch_type=4
> > 
> > That is working as designed, nothing wrong there.  You have EBSA285
> > support disabled (you commented out CONFIG_ARCH_EBSA285) and you have
> > Netwinder support enabled (CONFIG_ARCH_NETWINDER).  So,
> > machine_is_ebsa285() is constant false and machine_is_netwinder() is
> > constant true.
> > 
> > However, such a kernel won't boot when passed ID 5 because it won't
> > find the platform record in the kernel, and we explicitly error out
> > in that case.
>
> Why not? As I say before that I have a two valid machines with ID 4 and 5.
> I can boot machine ID 5 by specifying this ID in the bootloader.

If you have two machines with ID 4 and ID 5, and you configure out of the
kernel support for ID 4, then pass ID 4 to the kernel, the kernel should
error out.

> In any case, it's my fault that I do not specify the correct symbol,
> associated with the ID.

That is why we have the machine database, to keep things straight.

> But even such issues can be avoided if we make
> a comparison with the ID passed from the bootloader and not redefine it, ie:
> #ifdef CONFIG_ARCH_NETWINDER
> # define machine_is_netwinder() (__machine_arch_type == MACH_TYPE_NETWINDER)
> #else
> # define machine_is_netwinder() (0)
> #endif

No, you haven't listened to what I've said.  Go back and read my
explanation about how this works, particularly the part where these
macros end up being constant false and constant true.

> In this case, if we pass the ID 4 to bootloader, we will never have a macro
> machine_is_xx() (that's right), but boot the correct machine.

Again, you're not listening to what I've said.

> Look at my solution for "gen_mach_types" in the first message of this thread.
> Fixme, but on my opinion it will not affect the optimization.

You're wrong.  You don't understand what's going on here and why it is
the way that it is.  There is nothing wrong here, at all.  It is all
working as designed.  Your changes make it work sub-optimally by getting
rid of the constant-true optimization.
