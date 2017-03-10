From: andy@greyhouse.net (Andy Gospodarek)
Date: Fri, 10 Mar 2017 14:26:56 -0500
Subject: [RFC arm64] samples/bpf: explicitly exclude sysreg sections with
 asm macros
In-Reply-To: <20170310175229.GC18894@arm.com>
References: <1489101492-15653-1-git-send-email-andy@greyhouse.net>
 <20170310175229.GC18894@arm.com>
Message-ID: <20170310192656.GA13928@C02RW35GFVH8>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 10, 2017 at 05:52:30PM +0000, Will Deacon wrote:
> Hi Andy,
> 
> On Thu, Mar 09, 2017 at 06:18:12PM -0500, Andy Gospodarek wrote:
> > The previous fix to workaround compilation issues for samples/bpf on arm64 was
> > to prevent inclusion of code in sysregs.h.  This is not sustainable at this
> > point since other header files need access to sysregs.h for multiple
> > defintions.  The fact that the bpf samples cannot be compiled on arm64 is
> > fairly well documented on the iovisor-dev mailing and other places without a
> > clear-cut solution other than waiting for the llvm fix.  This attempts to
> > resolve that by dropping the fix to define _ASM_SYSREG_H on the clang command
> > line, and replace it with one that is wrapped around the offending code.  I
> > recognize this feels a bit fragile, but the current situation is not great
> > either and it seems that we are more likely to see users if the current code
> > actually compiles and runs.
> 
> Why does asm cause compilation to fail?
> 

It isn't the ASM itself that causes the compilation to fail, it's the
ASM macros included inside the new ifdef that are problematic.  Here is
what is seen per object file:

# make M=samples/bpf 
  HOSTCC  samples/bpf/xdp1_user.o
  HOSTLD  samples/bpf/xdp1
  HOSTLD  samples/bpf/xdp2
clang  -nostdinc -isystem /usr/lib/gcc/aarch64-linux-gnu/5/include
-I./arch/arm64/include -I./arch/arm64/include/generated/uapi
-I./arch/arm64/include/generated  -I./include
-I./arch/arm64/include/uapi -I./include/uapi -I./include/generated/uapi
-include ./include/linux/kconfig.h  \
	-D__KERNEL__ -D__AVOID_ASM_MACROS__ -Wno-unused-value
-Wno-pointer-sign \
	-Wno-compare-distinct-pointer-types \
	-Wno-gnu-variable-sized-type-not-at-end \
	-Wno-address-of-packed-member -Wno-tautological-compare \
	-O2 -emit-llvm -c samples/bpf/xdp1_kern.c -o -| llc -march=bpf
-filetype=obj -o samples/bpf/xdp1_kern.o
In file included from samples/bpf/xdp1_kern.c:14:
In file included from ./include/linux/ipv6.h:82:
In file included from ./include/linux/tcp.h:23:
./include/net/sock.h:2319:35: warning: value size does not match
register size specified by the constraint and modifier
[-Wasm-operand-widths]
        smp_store_release(&sk->sk_state, newstate);
                                         ^
./include/net/sock.h:2319:2: note: use constraint modifier "w"
        smp_store_release(&sk->sk_state, newstate);
        ^
./include/asm-generic/barrier.h:157:33: note: expanded from macro
'smp_store_release'
#define smp_store_release(p, v) __smp_store_release(p, v)
                                ^
./arch/arm64/include/asm/barrier.h:62:23: note: expanded from macro
'__smp_store_release'
                asm volatile ("stlr %1, %0"
\
                                    ^
1 warning generated.
LLVM ERROR: Inline asm not supported by this streamer because we don't  <----  THIS LINE
have an asm parser for this target

samples/bpf/Makefile:180: recipe for target 'samples/bpf/xdp1_kern.o'
failed
make[1]: *** [samples/bpf/xdp1_kern.o] Error 1
Makefile:1490: recipe for target '_module_samples/bpf' failed
make: *** [_module_samples/bpf] Error 2

> > Despite now being able to compile and run bpf programs on arm64 there
> > are still known warnings when building:
> > 
> > ./include/net/sock.h:2322:35: warning: value size does not match
> > register size specified by the constraint and modifier
> > [-Wasm-operand-widths]
> >         smp_store_release(&sk->sk_state, newstate);
> >                                          ^
> > ./include/net/sock.h:2322:2: note: use constraint modifier "w"
> >         smp_store_release(&sk->sk_state, newstate);
> >         ^
> > ./include/asm-generic/barrier.h:157:33: note: expanded from macro
> >                                 ^
> > ./arch/arm64/include/asm/barrier.h:62:23: note: expanded from macro
> > '__smp_store_release'
> >                 asm volatile ("stlr %1, %0"                     \
> 
> I don't think this is relevant to the message for this commit.
> 

I'm happy to drop that from the final commit.  Thanks for that feedback.

One of my goals with this RFC was to be excplicit that adding the
functionality to exclude the ASM macros doesn't magically fix
everything.


> > Discussed here: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=63359
> > 
> > Fixes: 30b50aa61201 ("bpf: samples: exclude asm/sysreg.h for arm64")
> > Signed-off-by: Andy Gospodarek <gospo@broadcom.com>
> > ---
> >  arch/arm64/include/asm/sysreg.h | 3 ++-
> >  samples/bpf/Makefile            | 2 +-
> >  2 files changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> > index ac24b6e..91ee2db 100644
> > --- a/arch/arm64/include/asm/sysreg.h
> > +++ b/arch/arm64/include/asm/sysreg.h
> > @@ -287,6 +287,7 @@
> >  #else
> >  
> >  #include <linux/types.h>
> > +#ifndef __AVOID_ASM_MACROS__
> 
> Yeah, this is pretty horrible. It would prefer to have a script that
> generates the header files needed by clang, without adding these ifdefs
> whenever something new fails to compile, but I don't understand why things
> are failing at all at the moment.

I agree it's not great.

I'm not sure I want to see multiple copies of the same file in the tree
(all of these files are in the kernel tree).  We could consider
something like the include/ vs include/uapi split (of course this isn't
a uapi issue but I suspect you know what I mrean).

One other solution would be to move these macros out to another file
(like sysreg-macros.h or similar) and then continue to use a trick
similar to what we are using not to exclude those macros.  It would need
to be clear to ARCH maintainers that these macros would need to be there
for the forseeable future.  
> 
> Will
