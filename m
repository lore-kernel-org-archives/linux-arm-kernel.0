From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 2 Oct 2018 13:57:34 +0100
Subject: [PATCH v3 2/4] arm64: implement ftrace with regs
In-Reply-To: <20181002121817.GB2398@lst.de>
References: <20181001140910.086E768BC7@newverein.lst.de>
 <20181001141648.1DBED68BDF@newverein.lst.de>
 <20181002112741.mvav4ar4v25gj46e@lakrids.cambridge.arm.com>
 <20181002121817.GB2398@lst.de>
Message-ID: <20181002125734.mhkz4o46oxf3mtu6@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 02, 2018 at 02:18:17PM +0200, Torsten Duwe wrote:
> Hi Mark,

Hi,
 
> thank you for your very detailed feedback, I'll incorporate it
> all into the next version, besides one issue:
> 
> On Tue, Oct 02, 2018 at 12:27:41PM +0100, Mark Rutland wrote:
> > 
> > Please use the insn framework, as we do to generate all the other
> > instruction sequences in ftrace.
> > 
> > MOV (register) is an alias of ORR (shifted register), i.e.
> > 
> > 	mov	<xd>, <xm>
> > 
> > ... is:
> > 
> > 	orr	<xd>, xzr, <xm>
> > 
> > ... and we have code to generate ORR, so we can add a trivial wrapper to
> > generate MOV.
> 
> I had something similar in v2; but it was hardly any better to read or
> understand. My main question however is: how do you justify the runtime
> overhead of aarch64_insn_gen_logical_shifted_reg for every function that
> gets its tracing switched on or off?

How do you justify doing something different from the established
pattern? Do you have any numbers indicating that this overhead is a
problem on a real workload?

For the moment at least, please use aarch64_insn_gen_*(), as we do for
all other instructions generated in the ftrace code. It's vastly simpler
for everyone if we have consistency here.

> The result is always the same 4-byte constant, so why not use a macro
> and a comment that says what it does?

I'd rather that we stick to the usual pattern that we have in arm64.

Note that aarch64_insn_gen_nop() also always returns the same 4-byte
constant, but it's an out-of-line function in insn.c. There haven't been
any complaints as to its overhead so far...

Thanks,
Mark.
