From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 5 Nov 2014 15:52:08 +0000
Subject: [PATCHv3 5/5] arm64: Trace emulation of AArch32 legacy
 instructions
In-Reply-To: <20141105100511.2daef605@gandalf.local.home>
References: <1414435207-30240-1-git-send-email-punit.agrawal@arm.com>
 <1414435207-30240-7-git-send-email-punit.agrawal@arm.com>
 <20141105144619.GI32700@e104818-lin.cambridge.arm.com>
 <20141105100511.2daef605@gandalf.local.home>
Message-ID: <20141105155207.GK32700@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 05, 2014 at 03:05:11PM +0000, Steven Rostedt wrote:
> On Wed, 5 Nov 2014 14:46:19 +0000
> Catalin Marinas <catalin.marinas@arm.com> wrote:
> 
> > On Mon, Oct 27, 2014 at 06:40:07PM +0000, Punit Agrawal wrote:
> > > --- a/arch/arm64/kernel/Makefile
> > > +++ b/arch/arm64/kernel/Makefile
> > > @@ -5,6 +5,7 @@
> > >  CPPFLAGS_vmlinux.lds	:= -DTEXT_OFFSET=$(TEXT_OFFSET)
> > >  AFLAGS_head.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
> > >  CFLAGS_efi-stub.o 	:= -DTEXT_OFFSET=$(TEXT_OFFSET)
> > > +CFLAGS_armv8_deprecated.o := -I$(src)
> > 
> > Why do you need this?
> 
> It has to do with the TRACE_EVENT magic.
> 
> Read samples/trace_events/Makefile
> 
> > 
> > >  CFLAGS_REMOVE_ftrace.o = -pg
> > >  CFLAGS_REMOVE_insn.o = -pg
> > > diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
> > > index fded15f..d376fe2 100644
> > > --- a/arch/arm64/kernel/armv8_deprecated.c
> > > +++ b/arch/arm64/kernel/armv8_deprecated.c
> > > @@ -15,6 +15,9 @@
> > >  #include <linux/slab.h>
> > >  #include <linux/sysctl.h>
> > >  
> > > +#define CREATE_TRACE_POINTS
> > > +#include "trace-events-emulation.h"
> > 
> > Using double quotes should be fine for the current directory.
> 
> No it is not enough. It not only gets included by this file, but also
> gets included by include/trace/ftrace.h with:
> 
> #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
> 
> Without that -I$(src) added, this include will fail.

Ah, thanks for clarification.

-- 
Catalin
