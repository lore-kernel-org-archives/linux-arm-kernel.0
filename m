From: andy@greyhouse.net (Andy Gospodarek)
Date: Fri, 10 Mar 2017 14:35:06 -0500
Subject: [RFC arm64] samples/bpf: explicitly exclude sysreg sections with
 asm macros
In-Reply-To: <20170310181329.GD24571@leverpostej>
References: <1489101492-15653-1-git-send-email-andy@greyhouse.net>
 <20170310181329.GD24571@leverpostej>
Message-ID: <20170310193506.GB13928@C02RW35GFVH8>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 10, 2017 at 06:13:30PM +0000, Mark Rutland wrote:
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
> > 
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
> These examples have nothing to do with sysreg.h, so that implies more of
> this is going to be necessary...

Sorry I included this bit of information -- it appears this is causing
some confusion.  You are correct this is unrelated to sysreg.h -- it is
just the warnings still generated when compiling the tools.  I'll drop
this from the final changelog.

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
> >  
> >  asm(
> >  "	.irp	num,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30\n"
> > @@ -302,7 +303,7 @@ asm(
> >  	__emit_inst(0xd5000000|(\\sreg)|(.L__reg_num_\\rt))
> >  "	.endm\n"
> >  );
> > -
> > +#endif
> 
> ... and this is stupidly messy.
> 
> From my PoV, NAK to having to sprinkle this in headers.

That's fine with me, but I'm hopeful that if enough heads get together
we can come up with a solution to deal with this.  Check out my reply to
Will and see if those other options seem like less maintenance-heavy
options.

Ultimately it seems to me like movement of some of those code out of
sysregs.h feels like the correct answer -- just hoping for some help
from those who may have more responsibiliy for long term maint.
