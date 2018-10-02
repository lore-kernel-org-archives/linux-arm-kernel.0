From: duwe@lst.de (Torsten Duwe)
Date: Tue, 2 Oct 2018 14:18:17 +0200
Subject: [PATCH v3 2/4] arm64: implement ftrace with regs
In-Reply-To: <20181002112741.mvav4ar4v25gj46e@lakrids.cambridge.arm.com>
References: <20181001140910.086E768BC7@newverein.lst.de>
 <20181001141648.1DBED68BDF@newverein.lst.de>
 <20181002112741.mvav4ar4v25gj46e@lakrids.cambridge.arm.com>
Message-ID: <20181002121817.GB2398@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

thank you for your very detailed feedback, I'll incorporate it
all into the next version, besides one issue:

On Tue, Oct 02, 2018 at 12:27:41PM +0100, Mark Rutland wrote:
> 
> Please use the insn framework, as we do to generate all the other
> instruction sequences in ftrace.
> 
> MOV (register) is an alias of ORR (shifted register), i.e.
> 
> 	mov	<xd>, <xm>
> 
> ... is:
> 
> 	orr	<xd>, xzr, <xm>
> 
> ... and we have code to generate ORR, so we can add a trivial wrapper to
> generate MOV.

I had something similar in v2; but it was hardly any better to read or
understand. My main question however is: how do you justify the runtime
overhead of aarch64_insn_gen_logical_shifted_reg for every function that
gets its tracing switched on or off? The result is always the same 4-byte
constant, so why not use a macro and a comment that says what it does?

	Torsten
