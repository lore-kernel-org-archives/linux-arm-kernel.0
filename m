From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 20 Jan 2010 14:41:40 +0000
Subject: [PATCH/RFC v1 0/2] Human readable performance event
	description in sysfs
In-Reply-To: <1263996080.4283.1064.camel@laptop>
References: <1263978706-15499-1-git-send-email-t.fujak@samsung.com>
	<1263978999.4283.823.camel@laptop> <op.u6tslipz7p4s8u@pikus>
	<20100120133145.GE4089@wear.picochip.com>
	<1263994779.4283.1057.camel@laptop>
	<20100120135553.GA22897@n2100.arm.linux.org.uk>
	<1263996080.4283.1064.camel@laptop>
Message-ID: <20100120144140.GB22897@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 20, 2010 at 03:01:20PM +0100, Peter Zijlstra wrote:
> On Wed, 2010-01-20 at 13:55 +0000, Russell King - ARM Linux wrote:
> > 
> > Unfortunately, it isn't.  CPU identification has become a fairly murky
> > business on ARM that the information exported from /proc/cpuinfo can
> > no longer precisely identify the CPU itself.
> > 
> > For example, we just treat Cortex A8 and A9 as "ARMv7" because from the
> > kernel's point of view, they're the same. 
> 
> Would it make sense to extend arm's cpuinfo to include enough
> information so that userspace can indeed do this?

The idea that "I'm running on a Cortex A9" is no longer provided by the
new CPU ID scheme.  Instead, what's now provided is a set of registers
which describe various individual features of the CPU:

- ThumbEE ISA level, Jazelle ISA level, Thumb ISA level, ARM ISA level.
- Programmer model (not much here that userspace would be interested in)
- Debug model (memory mapped/co-processor, v6 debug architecture, v7 debug
  architecture.)
- Four 32-bit registers describing the memory model.

Note that pre-ARMv6k does not provide this information.  Plus, the
interpretation of these registers change between ARMv6k and ARMv7 -
and I wouldn't be surprised if the interpretation changes in the
future - just like the 'cache type' register completely changed format
on ARMv7.

> It seems to me userspace might care about the exact platform they're
> running on.

It may wanted to care at one time, but as time goes on, knowing what
the high-level chip is will be come irrelevent, and is actually the
wrong question.

The real questions that userspace needs to ask are the specific ones,
such as "what ARM ISA level is supported?  what Thumb ISA level is
supported?  what debug model is implemented?"

Given that history has shown that identification schemes on ARM change
in extremely annoying ways, I don't think decoding these registers to
some kind of textual representation for /proc/cpuinfo is the right
approach.  It might instead make more sense to just export the entire
set of CPU ID registers to userspace, and let userspace grapple with
the complexities of decoding the information it wants from them.
