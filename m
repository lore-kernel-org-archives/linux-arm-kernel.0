From: rostedt@goodmis.org (Steven Rostedt)
Date: Wed, 5 Nov 2014 10:05:11 -0500
Subject: [PATCHv3 5/5] arm64: Trace emulation of AArch32 legacy
 instructions
In-Reply-To: <20141105144619.GI32700@e104818-lin.cambridge.arm.com>
References: <1414435207-30240-1-git-send-email-punit.agrawal@arm.com>
 <1414435207-30240-7-git-send-email-punit.agrawal@arm.com>
 <20141105144619.GI32700@e104818-lin.cambridge.arm.com>
Message-ID: <20141105100511.2daef605@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 5 Nov 2014 14:46:19 +0000
Catalin Marinas <catalin.marinas@arm.com> wrote:

> On Mon, Oct 27, 2014 at 06:40:07PM +0000, Punit Agrawal wrote:
> > Introduce an event to trace the usage of emulated instructions. The
> > trace event is intended to help identify and encourage the migration
> > of legacy software using the emulation features.
> > 
> > Use this event to trace usage of swp and CP15 barrier emulation.
> > 
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> > ---
> >  arch/arm64/kernel/Makefile                 |  1 +
> >  arch/arm64/kernel/armv8_deprecated.c       | 19 ++++++++++++--
> >  arch/arm64/kernel/trace-events-emulation.h | 40 ++++++++++++++++++++++++++++++
> >  3 files changed, 58 insertions(+), 2 deletions(-)
> >  create mode 100644 arch/arm64/kernel/trace-events-emulation.h
> > 
> > diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> > index 5362578..1fc7abd 100644
> > --- a/arch/arm64/kernel/Makefile
> > +++ b/arch/arm64/kernel/Makefile
> > @@ -5,6 +5,7 @@
> >  CPPFLAGS_vmlinux.lds	:= -DTEXT_OFFSET=$(TEXT_OFFSET)
> >  AFLAGS_head.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
> >  CFLAGS_efi-stub.o 	:= -DTEXT_OFFSET=$(TEXT_OFFSET)
> > +CFLAGS_armv8_deprecated.o := -I$(src)
> 
> Why do you need this?

It has to do with the TRACE_EVENT magic.

Read samples/trace_events/Makefile

> 
> >  CFLAGS_REMOVE_ftrace.o = -pg
> >  CFLAGS_REMOVE_insn.o = -pg
> > diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
> > index fded15f..d376fe2 100644
> > --- a/arch/arm64/kernel/armv8_deprecated.c
> > +++ b/arch/arm64/kernel/armv8_deprecated.c
> > @@ -15,6 +15,9 @@
> >  #include <linux/slab.h>
> >  #include <linux/sysctl.h>
> >  
> > +#define CREATE_TRACE_POINTS
> > +#include "trace-events-emulation.h"
> 
> Using double quotes should be fine for the current directory.
> 

No it is not enough. It not only gets included by this file, but also
gets included by include/trace/ftrace.h with:

#include TRACE_INCLUDE(TRACE_INCLUDE_FILE)

Without that -I$(src) added, this include will fail.

-- Steve
