From: will.deacon@arm.com (Will Deacon)
Date: Thu, 2 Aug 2012 19:50:33 +0100
Subject: [PATCH] ARM: makefile: work around toolchain bug in recent
 versions of binutils
In-Reply-To: <20120802181810.GW6802@n2100.arm.linux.org.uk>
References: <1343910206-3684-1-git-send-email-will.deacon@arm.com>
 <20120802130411.GU6802@n2100.arm.linux.org.uk>
 <20120802150123.GE9838@mudshark.cambridge.arm.com>
 <20120802153030.GV6802@n2100.arm.linux.org.uk>
 <20120802155140.GF9838@mudshark.cambridge.arm.com>
 <20120802181810.GW6802@n2100.arm.linux.org.uk>
Message-ID: <20120802185033.GA2725@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 02, 2012 at 07:18:10PM +0100, Russell King - ARM Linux wrote:
> On Thu, Aug 02, 2012 at 04:51:41PM +0100, Will Deacon wrote:
> > On Thu, Aug 02, 2012 at 04:30:30PM +0100, Russell King - ARM Linux wrote:
> > > It might just be easier to specify something like -march=armv4 or
> > > something like that, and then use .arch armv6 where required.
> > 
> > We could do that, but I worry that it will become very messy if/when people
> > start adding things like virtualisation instructions (hvc and co) to the
> > entry code. Using the same march flag for kernel and decompressor also keeps
> > everything consistent.
> 
> But you're missing a fundamental point: the decompressor is not designed
> to be built like that, it is designed to be built in such a way that it
> works unmodified on any CPU type we have to date, whether you're building
> a kernel for ARMv4 or ARMv7.
> 
> So, the code sequences which are architecture specific are only executed
> after we've checked the ID registers to determine what we should be doing
> for a particular CPU.

That's fine, *if* we can persuade the tools to build the thing for us. With
march=all, we got what we wanted but now that doesn't seem to work anymore.

> Hence, even if you're building for ARMv4, the decompressor will _still_
> contain all the support code for ARMv7 - and the assembler better accept
> those instructions too.

With recent tools, it looks like that's really hard to do... simply passing
the lowest common denominator of march=armv4 will cause the assembler to
barf on all the non-v4 code, which includes Thumb ("Error: selected processor
does not support THUMB opcodes"). It sounds like we want to pass the march
option corresponding to the highest architecture version supported by the
kernel being compiled (assuming we don't use anything that gets deprecated
by a later version of the architecture(!)).

Yuck.

> The alternative is we scatter various places with lots of yucky ifdefs,
> and it won't be pretty because quite a number of CPUs share the same code
> (which leads to long #if defined(CPU_A) || defined(CPU_B) etc).

That'll work, but let's keep it as a last resort. This is still a toolchain
issue we're dealing with here.

Will
