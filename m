From: will.deacon@arm.com (Will Deacon)
Date: Mon, 26 Mar 2012 13:43:59 +0100
Subject: [PATCH] ARM: ptrace: fix ptrace_read_user for !CONFIG_MMU
 platforms
In-Reply-To: <20120229185237.GO2983@mudshark.cambridge.arm.com>
References: <201202210124.23028.paul@codesourcery.com>
 <20120221083612.GG22562@n2100.arm.linux.org.uk>
 <20120221100041.GA19696@mudshark.cambridge.arm.com>
 <20120221101052.GH22562@n2100.arm.linux.org.uk>
 <20120221105250.GC19696@mudshark.cambridge.arm.com>
 <20120221113548.GK22562@n2100.arm.linux.org.uk>
 <20120221132216.GJ19696@mudshark.cambridge.arm.com>
 <20120224143655.GH13504@mudshark.cambridge.arm.com>
 <20120224181621.GH22562@n2100.arm.linux.org.uk>
 <20120229185237.GO2983@mudshark.cambridge.arm.com>
Message-ID: <20120326124359.GD2475@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 29, 2012 at 06:52:37PM +0000, Will Deacon wrote:
> On Fri, Feb 24, 2012 at 06:16:21PM +0000, Russell King - ARM Linux wrote:
> > On Fri, Feb 24, 2012 at 02:36:55PM +0000, Will Deacon wrote:
> > > It seems as though my ptrace patch makes *no difference* because these
> > > tools don't even use the PT_ADDR_TEXT etc magic offsets! As a result,
> > > trying to set a breakpoint by symbol fails miserably because it tries to
> > > poke the symbol offset directly, without adding on the base address of the
> > > text.
> > > 
> > > Are there any tools available that use these magic numbers or are mine just
> > > too old? Given that the whole thing dies after a while with:
> > > 
> > > [  909.062821] [430] gdbserver: obsolete system call 02b37558.
> > > 
> > > I'm not entirely convinced by the stability of what I'm using (that syscall
> > > number looks like an address to me).
> > 
> > That suggests that this stuff definitely hasn't been tested, and there's
> > no users of it (if there were I'm sure someone - either gdb folk or
> > some kernel people) would've seen a bug report.
> 
> My glancing at the latest GDB sources does suggest that this stuff ought to
> be getting used, so I should probably try building a nommu configuration
> from a more recent codebase. It seems that you're right that nobody is using
> this stuff though.

Ok, I have an update on this now. I had to hack GDB as well as the kernel
(!) since it wasn't picking up our PT_* definitions from asm/ptrace.h. With
that change in place, GDB can be persuaded to add on the offsets correctly
and, with a fixed kernel, breakpoints and symbol resolution start to work.

So now the question is: do I fix GDB or the kernel first? I can imagine the
GDB guys not wanting to merge anything until the kernel has a working ptrace
interface in this regard.

Will
