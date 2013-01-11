From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 10 Jan 2013 22:15:22 -0500 (EST)
Subject: [PATCH 04/16] ARM: b.L: Add baremetal voting mutexes
In-Reply-To: <20130110231825.GE11628@mudshark.cambridge.arm.com>
References: <1357777251-13541-1-git-send-email-nicolas.pitre@linaro.org>
 <1357777251-13541-5-git-send-email-nicolas.pitre@linaro.org>
 <20130110231825.GE11628@mudshark.cambridge.arm.com>
Message-ID: <alpine.LFD.2.02.1301102131010.6300@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 10 Jan 2013, Will Deacon wrote:

> On Thu, Jan 10, 2013 at 12:20:39AM +0000, Nicolas Pitre wrote:
> > From: Dave Martin <dave.martin@linaro.org>
> > 
> > This patch adds a simple low-level voting mutex implementation
> > to be used to arbitrate during first man selection when no load/store
> > exclusive instructions are usable.
> > 
> > For want of a better name, these are called "vlocks".  (I was
> > tempted to call them ballot locks, but "block" is way too confusing
> > an abbreviation...)
> > 
> > There is no function to wait for the lock to be released, and no
> > vlock_lock() function since we don't need these at the moment.
> > These could straightforwardly be added if vlocks get used for other
> > purposes.
> 
> [...]
> 
> > diff --git a/Documentation/arm/big.LITTLE/vlocks.txt b/Documentation/arm/big.LITTLE/vlocks.txt
> > new file mode 100644
> > index 0000000000..90672ddc6a
> > --- /dev/null
> > +++ b/Documentation/arm/big.LITTLE/vlocks.txt
> > @@ -0,0 +1,211 @@
> > +vlocks for Bare-Metal Mutual Exclusion
> > +======================================
> 
> [...]
> 
> > +ARM implementation
> > +------------------
> > +
> > +The current ARM implementation [2] contains a some optimisations beyond
> 
> -a

Fixed.

> 
> > +the basic algorithm:
> > +
> > + * By packing the members of the currently_voting array close together,
> > +   we can read the whole array in one transaction (providing the number
> > +   of CPUs potentially contending the lock is small enough).  This
> > +   reduces the number of round-trips required to external memory.
> > +
> > +   In the ARM implementation, this means that we can use a single load
> > +   and comparison:
> > +
> > +       LDR     Rt, [Rn]
> > +       CMP     Rt, #0
> > +
> > +   ...in place of code equivalent to:
> > +
> > +       LDRB    Rt, [Rn]
> > +       CMP     Rt, #0
> > +       LDRBEQ  Rt, [Rn, #1]
> > +       CMPEQ   Rt, #0
> > +       LDRBEQ  Rt, [Rn, #2]
> > +       CMPEQ   Rt, #0
> > +       LDRBEQ  Rt, [Rn, #3]
> > +       CMPEQ   Rt, #0
> > +
> > +   This cuts down on the fast-path latency, as well as potentially
> > +   reducing bus contention in contended cases.
> > +
> > +   The optimisation relies on the fact that the ARM memory system
> > +   guarantees coherency between overlapping memory accesses of
> > +   different sizes, similarly to many other architectures.  Note that
> > +   we do not care which element of currently_voting appears in which
> > +   bits of Rt, so there is no need to worry about endianness in this
> > +   optimisation.
> > +
> > +   If there are too many CPUs to read the currently_voting array in
> > +   one transaction then multiple transations are still required.  The
> > +   implementation uses a simple loop of word-sized loads for this
> > +   case.  The number of transactions is still fewer than would be
> > +   required if bytes were loaded individually.
> > +
> > +
> > +   In principle, we could aggregate further by using LDRD or LDM, but
> > +   to keep the code simple this was not attempted in the initial
> > +   implementation.
> > +
> > +
> > + * vlocks are currently only used to coordinate between CPUs which are
> > +   unable to enable their caches yet.  This means that the
> > +   implementation removes many of the barriers which would be required
> > +   when executing the algorithm in cached memory.
> 
> I think you need to elaborate on this and clearly identify the
> requirements of the memory behaviour. In reality, these locks are hardly
> ever usable so we don't want them cropping up in driver code and the
> like!

Doesn't the following paragraph make that clear enough?

Maybe we should rip out the C interface to avoid such abuses.  I think 
that was initially added when we weren't sure if the C code had to be 
involved.

> > +   packing of the currently_voting array does not work with cached
> > +   memory unless all CPUs contending the lock are cache-coherent, due
> > +   to cache writebacks from one CPU clobbering values written by other
> > +   CPUs.  (Though if all the CPUs are cache-coherent, you should be
> > +   probably be using proper spinlocks instead anyway).
> > +
> > +
> > + * The "no votes yet" value used for the last_vote variable is 0 (not
> > +   -1 as in the pseudocode).  This allows statically-allocated vlocks
> > +   to be implicitly initialised to an unlocked state simply by putting
> > +   them in .bss.
> 
> You could also put them in their own section and initialise them to -1
> there.

Same argument as for bL_vectors: That is less efficient than using .bss 
which takes no image space.  Plus the transformation for CPU 0 to work 
with this is basically free. 

> > +   An offset is added to each CPU's ID for the purpose of setting this
> > +   variable, so that no CPU uses the value 0 for its ID.
> > +
> > +
> > +Colophon
> > +--------
> > +
> > +Originally created and documented by Dave Martin for Linaro Limited, for
> > +use in ARM-based big.LITTLE platforms, with review and input gratefully
> > +received from Nicolas Pitre and Achin Gupta.  Thanks to Nicolas for
> > +grabbing most of this text out of the relevant mail thread and writing
> > +up the pseudocode.
> > +
> > +Copyright (C) 2012  Linaro Limited
> > +Distributed under the terms of Version 2 of the GNU General Public
> > +License, as defined in linux/COPYING.
> > +
> > +
> > +References
> > +----------
> > +
> > +[1] Lamport, L. "A New Solution of Dijkstra's Concurrent Programming
> > +    Problem", Communications of the ACM 17, 8 (August 1974), 453-455.
> > +
> > +    http://en.wikipedia.org/wiki/Lamport%27s_bakery_algorithm
> > +
> > +[2] linux/arch/arm/common/vlock.S, www.kernel.org.
> > diff --git a/arch/arm/common/vlock.S b/arch/arm/common/vlock.S
> > new file mode 100644
> > index 0000000000..0a1ee3a7f5
> > --- /dev/null
> > +++ b/arch/arm/common/vlock.S
> > @@ -0,0 +1,108 @@
> > +/*
> > + * vlock.S - simple voting lock implementation for ARM
> > + *
> > + * Created by: Dave Martin, 2012-08-16
> > + * Copyright:  (C) 2012  Linaro Limited
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> 
> Your documentation is strictly GPLv2, so there's a strange discrepancy
> here.

Indeed.

@Dave: your call.

> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License along
> > + * with this program; if not, write to the Free Software Foundation, Inc.,
> > + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> > + *
> > + *
> > + * This algorithm is described in more detail in
> > + * Documentation/arm/big.LITTLE/vlocks.txt.
> > + */
> > +
> > +#include <linux/linkage.h>
> > +#include "vlock.h"
> > +
> > +#if VLOCK_VOTING_SIZE > 4
> 
> 4? Maybe a CONFIG option or a #define in an arch vlock.h?

The 4 here is actually related to the number of bytes in a word, to 
decide whether or not a loop is needed for voters enumeration.  That is 
not configurable.

> > +#define FEW(x...)
> > +#define MANY(x...) x
> > +#else
> > +#define FEW(x...) x
> > +#define MANY(x...)
> > +#endif
> > +
> > +@ voting lock for first-man coordination
> > +
> > +.macro voting_begin rbase:req, rcpu:req, rscratch:req
> > +       mov     \rscratch, #1
> > +       strb    \rscratch, [\rbase, \rcpu]
> > +       dsb
> > +.endm
> > +
> > +.macro voting_end rbase:req, rcpu:req, rscratch:req
> > +       mov     \rscratch, #0
> > +       strb    \rscratch, [\rbase, \rcpu]
> > +       dsb
> > +       sev
> > +.endm
> > +
> > +/*
> > + * The vlock structure must reside in Strongly-Ordered or Device memory.
> > + * This implementation deliberately eliminates most of the barriers which
> > + * would be required for other memory types, and assumes that independent
> > + * writes to neighbouring locations within a cacheline do not interfere
> > + * with one another.
> > + */
> > +
> > +@ r0: lock structure base
> > +@ r1: CPU ID (0-based index within cluster)
> > +ENTRY(vlock_trylock)
> > +       add     r1, r1, #VLOCK_VOTING_OFFSET
> > +
> > +       voting_begin    r0, r1, r2
> > +
> > +       ldrb    r2, [r0, #VLOCK_OWNER_OFFSET]   @ check whether lock is held
> > +       cmp     r2, #VLOCK_OWNER_NONE
> > +       bne     trylock_fail                    @ fail if so
> > +
> > +       strb    r1, [r0, #VLOCK_OWNER_OFFSET]   @ submit my vote
> > +
> > +       voting_end      r0, r1, r2
> > +
> > +       @ Wait for the current round of voting to finish:
> > +
> > + MANY( mov     r3, #VLOCK_VOTING_OFFSET                        )
> > +0:
> > + MANY( ldr     r2, [r0, r3]                                    )
> > + FEW(  ldr     r2, [r0, #VLOCK_VOTING_OFFSET]                  )
> > +       cmp     r2, #0
> > +       wfene
> 
> Is there a race here? I wonder if you can end up in a situation where
> everybody enters wfe and then there is nobody left to signal an event
> via voting_end (if, for example the last voter sent the sev when
> everybody else was simultaneously doing the cmp before the wfe)...
> 
> ... actually, that's ok as long as VLOCK_VOTING_OFFSET isn't speculated,
> which it shouldn't be from strongly-ordered memory. Fair enough!
> 
> > +       bne     0b
> > + MANY( add     r3, r3, #4                                      )
> > + MANY( cmp     r3, #VLOCK_VOTING_OFFSET + VLOCK_VOTING_SIZE    )
> > + MANY( bne     0b                                              )
> > +
> > +       @ Check who won:
> > +
> > +       ldrb    r2, [r0, #VLOCK_OWNER_OFFSET]
> > +       eor     r0, r1, r2                      @ zero if I won, else nonzero
> > +       bx      lr
> > +
> > +trylock_fail:
> > +       voting_end      r0, r1, r2
> > +       mov     r0, #1                          @ nonzero indicates that I lost
> > +       bx      lr
> > +ENDPROC(vlock_trylock)
> > +
> > +@ r0: lock structure base
> > +ENTRY(vlock_unlock)
> > +       mov     r1, #VLOCK_OWNER_NONE
> > +       dsb
> > +       strb    r1, [r0, #VLOCK_OWNER_OFFSET]
> > +       dsb
> > +       sev
> > +       bx      lr
> > +ENDPROC(vlock_unlock)
> > diff --git a/arch/arm/common/vlock.h b/arch/arm/common/vlock.h
> > new file mode 100644
> > index 0000000000..94c29a6caf
> > --- /dev/null
> > +++ b/arch/arm/common/vlock.h
> > @@ -0,0 +1,43 @@
> > +/*
> > + * vlock.h - simple voting lock implementation
> > + *
> > + * Created by: Dave Martin, 2012-08-16
> > + * Copyright:  (C) 2012  Linaro Limited
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License along
> > + * with this program; if not, write to the Free Software Foundation, Inc.,
> > + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> > + */
> > +
> > +#ifndef __VLOCK_H
> > +#define __VLOCK_H
> > +
> > +#include <asm/bL_entry.h>
> > +
> > +#define VLOCK_OWNER_OFFSET     0
> > +#define VLOCK_VOTING_OFFSET    4
> 
> asm-offsets again?

Same answer.

> > +#define VLOCK_VOTING_SIZE      ((BL_CPUS_PER_CLUSTER + 3) / 4 * 4)
> 
> Huh?

Each ballot is one byte, and we pack them into words.  So this is the 
size of the required words to hold all ballots.

> > +#define VLOCK_SIZE             (VLOCK_VOTING_OFFSET + VLOCK_VOTING_SIZE)
> > +#define VLOCK_OWNER_NONE       0
> > +
> > +#ifndef __ASSEMBLY__
> > +
> > +struct vlock {
> > +       char data[VLOCK_SIZE];
> > +};
> 
> Does this mean the struct is only single byte aligned? You do word
> accesses to it in your vlock code and rely on atomicity, so I'd feel
> safer if it was aligned to 4 bytes, especially since this isn't being
> accessed via a normal mapping.

The structure size is always a multiple of 4 bytes.  Its alignment is 
actually much larger than 4 as it needs to span a whole cache line not 
to be overwritten by dirty line writeback.

As I mentioned before, given that this structure is allocated and 
accessed only by assembly code, we could simply remove all those unused 
C definitions to avoid potential confusion and misuse.


Nicolas
