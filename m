From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 18 Jan 2012 16:24:23 +0000
Subject: [RFC PATCH 0/5] ARM: introducing DT topology
In-Reply-To: <1326897408-11204-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1326897408-11204-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <20120118162423.GK1068@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 18, 2012 at 02:36:43PM +0000, Lorenzo Pieralisi wrote:
> Current code in the kernel, in particular the boot sequence, hinges upon a
> sequential mapping of MPIDR values for cpus and related interrupt
> controller CPU interfaces to logical cpu indexing. 

I don't believe it does.  What it does rely upon is having cpu_logical_map()
correctly setup for the logical-to-hardware mapping - which, if it's
different, should be done in smp_init_cpus(), taking note that logical
CPU 0 is _always_ the boot CPU.  (That's a restriction caused by the
way suspend/resume unplugs all but the lowest numbered logical online
CPU.)

So, with the code today, there's nothing in the code which prevents this
from happening:

a) you boot on h/w CPU 1, which becomes logical CPU 0.
b) you boot h/w CPU 3 as logical CPU 1.
c) you boot h/w CPU 0 as logical CPU 2.
d) you boot h/w CPU 2 as logical CPU 3.

You just need to ensure that cpu_logical_map() contains the array
{1, 3, 0, 2} instead of the default (because we _have_ to have a
default) of {1, 0, 2, 3}.

> This hypothesis is not valid when the concept of cluster is introduced since
> the MPIDR cannot be represented as a single index and interrupt controller
> CPU interfaces might be wired with a numbering scheme following per-SoC
> design parameters which cannot be extrapolated easily through generic functions
> by the primary CPU.

So what you're saying is that the GIC CPU index may not be the CPU number
given by MPIDR?

> Furthermore, relying on the MPIDR to be wired according to real topology
> levels might turn out to be an unreliable solution, hence a SW
> representation is needed to override possibly incorrect MPIDR register
> values.

This sounds like you're saying that the contents of MPIDR might be buggy
sometime in the future?  Do we actually know of any situations where the
information in there is currently wrong (outside of the development lab)?
If not, it's not something we should cater for until it's actually happened,
and then the pain should be felt by those silly enough to allow the chip
to go out the door.
