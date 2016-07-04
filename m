From: duwe@lst.de (Torsten Duwe)
Date: Mon, 4 Jul 2016 11:18:41 +0200
Subject: [PATCH v2 1/2] arm64: implement FTRACE_WITH_REGS
In-Reply-To: <20160701125344.usuovsvbpilzen4m@treble>
References: <20160627151500.2247A68D20@newverein.lst.de>
 <20160627151717.BD25468D26@newverein.lst.de>
 <20160701125344.usuovsvbpilzen4m@treble>
Message-ID: <20160704091841.GB19960@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 01, 2016 at 07:53:44AM -0500, Josh Poimboeuf wrote:
> On Mon, Jun 27, 2016 at 05:17:17PM +0200, Torsten Duwe wrote:
> > Once gcc is enhanced to optionally generate NOPs at the beginning
> > of each function, like the concept proven in
> > https://gcc.gnu.org/ml/gcc-patches/2016-04/msg01671.html
> > (sans the "fprintf (... pad_size);", which spoils the data structure
> > for kernel use), the generated pads can nicely be used to reroute
> > function calls for tracing/profiling, or live patching.

[...]

> > @@ -35,6 +35,10 @@ KBUILD_CFLAGS	+= -fno-asynchronous-unwind-tables
> >  KBUILD_CFLAGS	+= $(call cc-option, -mpc-relative-literal-loads)
> >  KBUILD_AFLAGS	+= $(lseinstr)
> >  
> > +ifeq ($(CONFIG_DYNAMIC_FTRACE_WITH_REGS), y)
> > +CC_FLAGS_FTRACE := -fprolog-pad=2 -DCC_USING_PROLOG_PAD
> > +endif
> > +
> 
> It would probably be good to print a warning for older gccs which don't
> support this option, so that when the build fails, there's at least a
> warning to indicate why.  Something like:
> 
>   ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
>     CC_FLAGS_FTRACE := -fprolog-pad=2 -DCC_USING_PROLOG_PAD
>     ifeq ($(call cc-option,-fprolog-pad=2),)
>       $(warning Cannot use CONFIG_DYNAMIC_FTRACE_WITH_REGS: \
>                -fprolog-pad not supported by compiler)
>     endif
>   endif

Yes. Ideally, compiler support could be checked even before the option is
offered, but your explicit warning is better than just failing obscurely.

What do you think about prolog-pad in general? If we can convince the
gcc people to include it, it could become the default mechanism for all
architectures that do not require special treatment (e.g. like ABIv2
dual entry on ppc64le).

	Torsten
