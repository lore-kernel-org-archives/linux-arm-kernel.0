From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 31 Oct 2018 12:10:03 +0000
Subject: [PATCH v4 1/3] arm64: implement ftrace with regs
In-Reply-To: <20181026142148.6353A68C94@newverein.lst.de>
References: <20181026142008.D922868C94@newverein.lst.de>
 <20181026142148.6353A68C94@newverein.lst.de>
Message-ID: <20181031121002.hmag2mwvlpzwobvf@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Torsten,

On Fri, Oct 26, 2018 at 04:21:48PM +0200, Torsten Duwe wrote:
> Use -fpatchable-function-entry (gcc8) to add 2 NOPs at the beginning
> of each function. Replace the first NOP thus generated with a quick LR
> saver (move it to scratch reg x9), so the 2nd replacement insn, the call
> to ftrace, does not clobber the value. Ftrace will then generate the
> standard stack frames.

I'd like to understand why you need patchable-function-entry to
implement DYNAMIC_FTRACE_WITH_REGS on arm64. No other architectures with
DYNAMIC_FTRACE_WITH_REGS require this, including arm.

I guess skipping the original function prologue would simplify the
implementation of the replacement function (and would mean that the regs
held the function arguments per the procedure call standard), but AFAICT
other architectures aren't relying on that, so it doesn't seem to be a
strict requirement.

What am I missing?

How does livepatching handle the pre-mcount function preambles on
architectures with existing support?

FWIW, I think that patchable-function-entry would solve an upcoming
problem on arm64. To support in-kernel pointer authentication with the
function graph tracer, we need to snapshot the SP at function entry
(before any preamble), and we can't do that reliably with mcount.

Thanks,
Mark.
