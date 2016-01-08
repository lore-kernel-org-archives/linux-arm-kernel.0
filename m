From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 7 Jan 2016 18:44:29 -0800
Subject: [PATCH] ARM: Runtime patch udiv/sdiv instructions into
 __aeabi_{u}idiv()
In-Reply-To: <alpine.LFD.2.20.1601042035190.3603@knanqh.ubzr>
References: <alpine.LFD.2.20.1512110105450.26920@knanqh.ubzr>
 <alpine.LFD.2.20.1512111125330.26920@knanqh.ubzr>
 <alpine.LFD.2.20.1512111216350.26920@knanqh.ubzr>
 <1941958.3p422lB7Mz@wuerfel>
 <alpine.LFD.2.20.1512111842280.26920@knanqh.ubzr>
 <20160105012319.GC22188@codeaurora.org>
 <alpine.LFD.2.20.1601042035190.3603@knanqh.ubzr>
Message-ID: <20160108024429.GF22188@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/04, Nicolas Pitre wrote:
> On Mon, 4 Jan 2016, Stephen Boyd wrote:
> > 
> > I can update the patches to be based on this patch here and
> > handle the conditional branches and tail call optimization cases
> > by adding some safety checks like we have for the ftrace branch
> > patching. But I'd rather not do that work unless we all agree
> > that it's worthwhile pursuing it.
> > 
> > Is there still any concern about the benefit of patching each
> > call site vs. patching the functions? The micro benchmark seems
> > to show some theoretical improvement on cortex-a7 and I can run
> > it on Scorpion and Krait processors to look for any potential
> > benefits there, but I'm not sure of any good kernel benchmark for
> > this. If it will be rejected due to complexity vs. benefit
> > arguments I'd rather work on something else.
> 
> You could run the benchmark on Scorpion and Krait to start with. If 
> there is no improvement what so ever like on A15's then the answer might 
> be rather simple.
> 

So running the benchmark on Scorpion is not useful because we
don't have the idiv instruction there. On Krait I get the
following results. I ran this on a dragonboard apq8074 with
maxcpus=1 on the kernel command line.

Testing INLINE_DIV ...
real    0m 13.56s
user    0m 13.56s
sys     0m 0.00s

Testing PATCHED_DIV ...
real    0m 15.15s
user    0m 15.14s
sys     0m 0.00s

Testing OUTOFLINE_DIV ...
real    0m 18.09s
user    0m 18.09s
sys     0m 0.00s

Testing LIBGCC_DIV ...
real    0m 24.26s
user    0m 24.25s
sys     0m 0.00s

It looks like the branch actually costs us some time here.
Patching isn't as good as the compiler inserting the instruction
itself, but it is better than branching to the division routine.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
