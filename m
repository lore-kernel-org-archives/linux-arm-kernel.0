From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 25 Jan 2011 17:46:36 +0000
Subject: [PATCH 03/14] ARM: v6k: remove CPU_32v6K dependencies in
	asm/spinlock.h
In-Reply-To: <AANLkTimK06nJPtQoym3HxXeDD-s4nUrN0vWjp_JcgTjx@mail.gmail.com>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
	<E1PeueP-0003SR-03@rmk-PC.arm.linux.org.uk>
	<AANLkTinnhivretaRHpYwCYouk-_jWKZQEo7x4sbheJVL@mail.gmail.com>
	<20110125165919.GD17286@n2100.arm.linux.org.uk>
	<AANLkTimK06nJPtQoym3HxXeDD-s4nUrN0vWjp_JcgTjx@mail.gmail.com>
Message-ID: <20110125174636.GE17286@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 25, 2011 at 05:33:14PM +0000, Dave Martin wrote:
> On Tue, Jan 25, 2011 at 4:59 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Tue, Jan 25, 2011 at 04:43:52PM +0000, Dave Martin wrote:
> >> A couple of questions on this:
> >>
> >> 1) I notice these spinlock functions are generally marked inline.
> >>
> >> Is that likely to happen in modules? ?If so, there would be a need to
> >> do SMP_ON_UP fixups at module load time -- I don't think that's
> >> currently implemented.
> >
> > No one should be using the arch_* spinlocks directly. ?The spinlocks
> > are implemented in out of line code in kernel/spinlock.c
> 
> OK--- do think this is something we need a sanity-check for, or does
> this fall into to a category of bad driver implementation which will
> get thrown out during peer review?

Hmm, actually it looks like you can end up with configurations where the
spinlocks are inlined.

That means we'll have to get rid of the link-time discarding of the
.exit sections, and discard them along with the .init sections.
