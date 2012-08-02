From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Aug 2012 19:18:10 +0100
Subject: [PATCH] ARM: makefile: work around toolchain bug in recent
 versions of binutils
In-Reply-To: <20120802155140.GF9838@mudshark.cambridge.arm.com>
References: <1343910206-3684-1-git-send-email-will.deacon@arm.com>
 <20120802130411.GU6802@n2100.arm.linux.org.uk>
 <20120802150123.GE9838@mudshark.cambridge.arm.com>
 <20120802153030.GV6802@n2100.arm.linux.org.uk>
 <20120802155140.GF9838@mudshark.cambridge.arm.com>
Message-ID: <20120802181810.GW6802@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 02, 2012 at 04:51:41PM +0100, Will Deacon wrote:
> On Thu, Aug 02, 2012 at 04:30:30PM +0100, Russell King - ARM Linux wrote:
> > On Thu, Aug 02, 2012 at 04:01:23PM +0100, Will Deacon wrote:
> > > On Thu, Aug 02, 2012 at 02:04:11PM +0100, Russell King - ARM Linux wrote:
> > > > Maybe this needs to be a build-time test whether the assembler accepts it?
> > > 
> > > That could be tricky since gas still accepts the option, but fails later
> > > with:
> > > 
> > > arch/arm/boot/compressed/head.S: Assembler messages:
> > > arch/arm/boot/compressed/head.S:127: Error: selected processor does not support requested special purpose register -- `mrs r2,cpsr'
> > > arch/arm/boot/compressed/head.S:134: Error: selected processor does not support requested special purpose register -- `mrs r2,cpsr'
> > > arch/arm/boot/compressed/head.S:136: Error: selected processor does not support requested special purpose register -- `msr cpsr_c,r2'
> > > 
> > > How about grabbing the march from KBUILD_AFLAGS instead (see below)?
> > 
> > It might just be easier to specify something like -march=armv4 or
> > something like that, and then use .arch armv6 where required.
> 
> We could do that, but I worry that it will become very messy if/when people
> start adding things like virtualisation instructions (hvc and co) to the
> entry code. Using the same march flag for kernel and decompressor also keeps
> everything consistent.

But you're missing a fundamental point: the decompressor is not designed
to be built like that, it is designed to be built in such a way that it
works unmodified on any CPU type we have to date, whether you're building
a kernel for ARMv4 or ARMv7.

So, the code sequences which are architecture specific are only executed
after we've checked the ID registers to determine what we should be doing
for a particular CPU.

Hence, even if you're building for ARMv4, the decompressor will _still_
contain all the support code for ARMv7 - and the assembler better accept
those instructions too.

The alternative is we scatter various places with lots of yucky ifdefs,
and it won't be pretty because quite a number of CPUs share the same code
(which leads to long #if defined(CPU_A) || defined(CPU_B) etc).
