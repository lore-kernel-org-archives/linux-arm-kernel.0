From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 5 Jan 2012 11:01:11 +0000
Subject: [PATCH v2 00/15] Make SMP timers standalone
In-Reply-To: <CACRpkdYjQPoY60XdhTwgLYbTrQMhC=Wxk5Y=hP2Vr0DngUJbxg@mail.gmail.com>
References: <1324574865-5367-1-git-send-email-marc.zyngier@arm.com>
 <20111222193216.GO2577@n2100.arm.linux.org.uk> <4F048EC4.40900@arm.com>
 <20120105011704.GA8870@codeaurora.org>
 <CACRpkdYjQPoY60XdhTwgLYbTrQMhC=Wxk5Y=hP2Vr0DngUJbxg@mail.gmail.com>
Message-ID: <20120105110111.GO11810@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 05, 2012 at 11:26:12AM +0100, Linus Walleij wrote:
> I think this looks like one big misunderstanding. I understood it as
> the SMP TWD block is synthesized also on UP silicon, i.e. same
> hardware, and so it will need to use the driver from
> arch/arm/kernel/smp_twd.c, however there is nothing local
> about that apart from being in close locality of the CPU.

Yes indeed.  The TWD code is architected to plug into the local timer
code via a set of well defined hooks.

It's entirely possible to call the TWD setup function with a non-local
timer clock event structure if you have a TWD which is a global timer.
The percpu stuff for storage will just work on UP systems, so that's
not a concern.  What could be is the percpu IRQ stuff, which presumably
wouldn't be available on non-SMP systems.

Apart from that, I think the current architecture is right - it separates
the hardware timer code from the local-timer specifics, and allows the
hardware timer driver to be re-used if needed.

Trying to make local timers as a general rule work as global timers is,
I think, a big mistake.  I've no problem with making a local timer hardware
_implementation_ work as a global timer though.
