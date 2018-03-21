From: mka@chromium.org (Matthias Kaehlcke)
Date: Tue, 20 Mar 2018 17:20:22 -0700
Subject: [PATCH 5/5] ARM: add support for building ARM kernel with clang
In-Reply-To: <20180320231832.GK2743@n2100.armlinux.org.uk>
References: <20180320230206.25289-1-stefan@agner.ch>
 <20180320230206.25289-6-stefan@agner.ch>
 <20180320231832.GK2743@n2100.armlinux.org.uk>
Message-ID: <20180321002022.GH37438@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

El Tue, Mar 20, 2018 at 11:18:33PM +0000 Russell King - ARM Linux ha dit:

> On Wed, Mar 21, 2018 at 12:02:06AM +0100, Stefan Agner wrote:
> > Use cc-options call for compiler options which are not available
> > in clang. With this patch an ARMv7 multi platform kernel can be
> > successfully build using clang (tested with version 5.0.1).
> > 
> > Based-on-patches-by: Behan Webster <behanw@converseincode.com>
> > Signed-off-by: Stefan Agner <stefan@agner.ch>

Great to see your work on bringing clang support for 32-bit ARM
upstream!

> > ---
> >  arch/arm/Makefile                 | 2 +-
> >  arch/arm/boot/compressed/Makefile | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> > index e9e3fde3c657..20e9fee1ccc5 100644
> > --- a/arch/arm/Makefile
> > +++ b/arch/arm/Makefile
> > @@ -39,7 +39,7 @@ KBUILD_CFLAGS	+= $(call cc-option,-mno-unaligned-access)
> >  endif
> >  
> >  ifeq ($(CONFIG_FRAME_POINTER),y)
> > -KBUILD_CFLAGS	+=-fno-omit-frame-pointer -mapcs -mno-sched-prolog
> > +KBUILD_CFLAGS	+=-fno-omit-frame-pointer $(call cc-option,-mapcs,) $(call cc-option,-mno-sched-prolog,)
> 
> Some of these options here are to ensure that we generate the following
> code, so we can backtrace:
> 
> 	mov	ip, sp
> 	stmfd	sp!, {fp, ip, lr, pc}
> 	sub	fp, ip, #4
> 
> If clang isn't producing that code at the start of functions with
> CONFIG_FRAME_POINTER=y, then backtracing will not work, and arguably
> CONFIG_FRAME_POINTER=y is useless there.  In that circumstance, it's
> probably better to fail so the user can configure something more
> debuggable, rather than having the kernel potentially producing
> undebuggable oopses.

Which option in particular is important to generate the above code for
backstracing?

According to the gcc doc -mapcs(-frame) is deprecated.

For -mno-sched-prolog the doc says:

"Prevent the reordering of instructions in the function prologue, or
the merging of those instruction with the instructions in the
function?s body. This means that all functions start with a
recognizable set of instructions (or in fact one of a choice from a
small set of different function prologues), and this information can
be used to locate the start of functions inside an executable piece of
code. The default is -msched-prolog."

Thanks

Matthias
