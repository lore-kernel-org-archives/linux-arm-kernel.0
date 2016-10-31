From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 31 Oct 2016 14:32:37 -0600
Subject: [PATCH V2 6/6] arm64: Add uprobe support
In-Reply-To: <CAHB_Gup2-yWbKK7QpMjJv7M6oNdV8Mz10wxWaS8ojzR4s8wv=g@mail.gmail.com>
References: <cover.1474960629.git.panand@redhat.com>
 <41cc70043792e65cbc3b4cc4ad7fbf6379afa550.1474960629.git.panand@redhat.com>
 <20161030140901.h6mdxbb4pgqpqs7j@localhost>
 <CAHB_Gup2-yWbKK7QpMjJv7M6oNdV8Mz10wxWaS8ojzR4s8wv=g@mail.gmail.com>
Message-ID: <20161031203237.lof7uzt4ye57y7h3@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pratyush,

On Mon, Oct 31, 2016 at 02:10:43PM +0530, Pratyush Anand wrote:
> On Sun, Oct 30, 2016 at 7:39 PM, Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> > On Tue, Sep 27, 2016 at 01:18:00PM +0530, Pratyush Anand wrote:
> >> --- /dev/null
> >> +++ b/arch/arm64/kernel/probes/uprobes.c
> >> @@ -0,0 +1,221 @@
> >> +/*
> >> + * Copyright (C) 2014-2016 Pratyush Anand <panand@redhat.com>
> >> + *
> >> + * This program is free software; you can redistribute it and/or modify
> >> + * it under the terms of the GNU General Public License version 2 as
> >> + * published by the Free Software Foundation.
> >> + */
> >> +#include <linux/highmem.h>
> >> +#include <linux/ptrace.h>
> >> +#include <linux/uprobes.h>
> >> +#include <asm/cacheflush.h>
> >> +
> >> +#include "decode-insn.h"
> >> +
> >> +#define UPROBE_INV_FAULT_CODE        UINT_MAX
> >> +
> >> +bool is_trap_insn(uprobe_opcode_t *insn)
> >> +{
> >> +     return false;
> >> +}
> >
> > On the previous series, I had a comment left unanswered with regards to
> > always returning false in is_trap_insn():
> >
> > Looking at handle_swbp(), if we hit a breakpoint for which we don't have
> > a valid uprobe, this function currently sends a SIGTRAP. But if
> > is_trap_insn() returns false always, is_trap_at_addr() would return 0 in
> > this case so the SIGTRAP is never issued.
> 
> A agreed on this that the older implementation i.e. the default one of
> is_trap_insn() is better for the time being. I sent out V2 before your
> last comment on it in V1 :(.

Thinking some more about this, the default is_trap_insn() still seems
better. It may return true occasionally for 32-bit tasks but we don't
care anyway because the subsequent arch_uprobe_analyze_insn() would
prevent the installation of the uprobe. However, always returning false
in is_trap_insn() would confuse handle_swbp() if you install uprobes in
an already debugged task.

> probably 'strtle r0, [r0], #160' would have the closest matching
> aarch32 instruction wrt BRK64_OPCODE_UPROBES(0xd42000A0). But that too
> seems a bad aarch32 instruction. So, there might not be any aarch32
> instruction which will match to uprobe BRK instruction.

As I said above, even if it matches, we don't support uprobes for 32-bit
(caught by the subsequent test).

> Therefore, if I send a V3 by removing aacrh64 is_trap_insn(), would
> that be acceptable, or do you see any other issue with this patch
> series? If there is anything else, I would address that in V3 as well.

I think I have one minor comment on arch_uprobe_analyze_insn() and v3
should look ok.

-- 
Catalin
