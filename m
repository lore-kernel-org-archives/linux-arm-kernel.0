From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Aug 2012 16:30:30 +0100
Subject: [PATCH] ARM: makefile: work around toolchain bug in recent
 versions of binutils
In-Reply-To: <20120802150123.GE9838@mudshark.cambridge.arm.com>
References: <1343910206-3684-1-git-send-email-will.deacon@arm.com>
 <20120802130411.GU6802@n2100.arm.linux.org.uk>
 <20120802150123.GE9838@mudshark.cambridge.arm.com>
Message-ID: <20120802153030.GV6802@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 02, 2012 at 04:01:23PM +0100, Will Deacon wrote:
> Hi Russell,
> 
> On Thu, Aug 02, 2012 at 02:04:11PM +0100, Russell King - ARM Linux wrote:
> > On Thu, Aug 02, 2012 at 01:23:26PM +0100, Will Deacon wrote:
> > > Recent upstream versions of binutils fail to assembler compressed/head.S
> > > when passed the -march=all option:
> > > 
> > > http://lists.gnu.org/archive/html/bug-binutils/2011-04/msg00162.html
> > > 
> > > The recommended workaround from the tools folks is not to pass the
> > > option, and instead let the assembler deduce the CPU type based on the
> > > features used by the code.
> > 
> > That doesn't work for all binutils - binutils historically has had to be
> > told explicitly what architecture its building for and won't "deduce"
> > it from the code.
> 
> Damn. I thought there would be a reason why we passed the option in the
> first place.
> 
> > Maybe this needs to be a build-time test whether the assembler accepts it?
> 
> That could be tricky since gas still accepts the option, but fails later
> with:
> 
> arch/arm/boot/compressed/head.S: Assembler messages:
> arch/arm/boot/compressed/head.S:127: Error: selected processor does not support requested special purpose register -- `mrs r2,cpsr'
> arch/arm/boot/compressed/head.S:134: Error: selected processor does not support requested special purpose register -- `mrs r2,cpsr'
> arch/arm/boot/compressed/head.S:136: Error: selected processor does not support requested special purpose register -- `msr cpsr_c,r2'
> 
> How about grabbing the march from KBUILD_AFLAGS instead (see below)?

It might just be easier to specify something like -march=armv4 or
something like that, and then use .arch armv6 where required.
