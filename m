From: will.deacon@arm.com (Will Deacon)
Date: Fri, 11 Jan 2013 11:03:51 +0000
Subject: [PATCH 04/16] ARM: b.L: Add baremetal voting mutexes
In-Reply-To: <alpine.LFD.2.02.1301102131010.6300@xanadu.home>
References: <1357777251-13541-1-git-send-email-nicolas.pitre@linaro.org>
 <1357777251-13541-5-git-send-email-nicolas.pitre@linaro.org>
 <20130110231825.GE11628@mudshark.cambridge.arm.com>
 <alpine.LFD.2.02.1301102131010.6300@xanadu.home>
Message-ID: <20130111110351.GE12977@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 11, 2013 at 03:15:22AM +0000, Nicolas Pitre wrote:
> On Thu, 10 Jan 2013, Will Deacon wrote:
> > On Thu, Jan 10, 2013 at 12:20:39AM +0000, Nicolas Pitre wrote:
> > > + * vlocks are currently only used to coordinate between CPUs which are
> > > +   unable to enable their caches yet.  This means that the
> > > +   implementation removes many of the barriers which would be required
> > > +   when executing the algorithm in cached memory.
> >
> > I think you need to elaborate on this and clearly identify the
> > requirements of the memory behaviour. In reality, these locks are hardly
> > ever usable so we don't want them cropping up in driver code and the
> > like!
> 
> Doesn't the following paragraph make that clear enough?

I think it misses a lot out (e.g. we require single-copy atomicity
guarantees for byte access, we require no speculation etc). Essentially,
it's an imprecise definition of strongly-ordered memory. However, see
below (the bit about removing the C implementation)...

> Maybe we should rip out the C interface to avoid such abuses.  I think
> that was initially added when we weren't sure if the C code had to be
> involved.

[...]

> > > +#include <linux/linkage.h>
> > > +#include "vlock.h"
> > > +
> > > +#if VLOCK_VOTING_SIZE > 4
> >
> > 4? Maybe a CONFIG option or a #define in an arch vlock.h?
> 
> The 4 here is actually related to the number of bytes in a word, to
> decide whether or not a loop is needed for voters enumeration.  That is
> not configurable.

BYTES_PER_LONG then (or suitable shifting of BITS_PER_LONG)?

> > > +#define VLOCK_VOTING_SIZE      ((BL_CPUS_PER_CLUSTER + 3) / 4 * 4)
> >
> > Huh?
> 
> Each ballot is one byte, and we pack them into words.  So this is the
> size of the required words to hold all ballots.

Ok, so this could make use of BYTES_PER_LONG too, just to make the reasoning
more clear.

> > > +#define VLOCK_SIZE             (VLOCK_VOTING_OFFSET + VLOCK_VOTING_SIZE)
> > > +#define VLOCK_OWNER_NONE       0
> > > +
> > > +#ifndef __ASSEMBLY__
> > > +
> > > +struct vlock {
> > > +       char data[VLOCK_SIZE];
> > > +};
> >
> > Does this mean the struct is only single byte aligned? You do word
> > accesses to it in your vlock code and rely on atomicity, so I'd feel
> > safer if it was aligned to 4 bytes, especially since this isn't being
> > accessed via a normal mapping.
> 
> The structure size is always a multiple of 4 bytes.  Its alignment is
> actually much larger than 4 as it needs to span a whole cache line not
> to be overwritten by dirty line writeback.

That's not implied from the structure definition.

> As I mentioned before, given that this structure is allocated and
> accessed only by assembly code, we could simply remove all those unused
> C definitions to avoid potential confusion and misuse.

Yes, I think removing the C definitions is a great idea. Then, we have a
pure-asm implementation which is, as such, tied to ARM. In that case, the
documentation can just refer to ARM memory types instead of loosely defining
the required characteristics (i.e. state that device or strongly-ordered
memory is required).

Cheers,

Will
