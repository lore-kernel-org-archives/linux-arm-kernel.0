From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Wed, 21 Jun 2017 11:43:05 +0900
Subject: [PATCH v3 2/4] arm64: kgdb: disable interrupts while a software
 step is enabled
In-Reply-To: <20170620170659.GB28035@arm.com>
References: <20170523043058.5463-1-takahiro.akashi@linaro.org>
 <20170523043058.5463-3-takahiro.akashi@linaro.org>
 <20170605162919.GN21944@arm.com>
 <20170607053449.GE26483@linaro.org> <20170607165018.GD2669@arm.com>
 <20170620024333.GE4820@linaro.org> <20170620170659.GB28035@arm.com>
Message-ID: <20170621024304.GI4820@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 20, 2017 at 06:07:00PM +0100, Will Deacon wrote:
> On Tue, Jun 20, 2017 at 11:43:34AM +0900, AKASHI Takahiro wrote:
> > On Wed, Jun 07, 2017 at 05:50:18PM +0100, Will Deacon wrote:
> > > On Wed, Jun 07, 2017 at 02:34:50PM +0900, AKASHI Takahiro wrote:
>
> > > Ok, but don't we need to re-enable interrupts, otherwise we can't safely
> > > handle the fault (which might involve blocking)?
> > 
> > I thought a lot, but have got no other way to solve the issue, which
> > totally makes stepi in vain.
> > In theory, you might be right, but in practice, people don't always expect
> > to step through the whole sequence of fault recovery with single stepping.
> > Once we do 'c(ontinue),' interrupts are enabled again and the execution
> > will follow as expected.
> 
> It's not the stepping guarantees I'm worried about. I'm more worried that
> the fault handler panics because it's called with IRQs disabled,

I'm still wondering how it can cause panic.

> so the
> debugger has ended up changing the behaviour of the kernel which is
> absolutely not what you want!

That's what I'm saying, I guess.
As far as we are keeping on single stepping, no interrupts will be
taken but once the execution is continued, any outstanding interrupts
will be served.
Human intervention with a debugger, either software-oriented kgdb or
jtag-based ICE, will inevitably affect the system's behavior somehow.

> > If you want to 'step over' a faulted instruction here, or to break
> > somewhere in a middle of exception handler, you need to manage to set
> > a breakpoint explicitly. But it will, I believe, be much better than
> > useless stepi from day-1 :)
> > 
> > Meanwhile, kprobes also disables interrupts while single stepping.
> > See setup_singlestep().
> 
> Sure, but I don't think those instructions can fault.

Looking into arm_probe_decode_insn() & aarch64_insn_is_steppable(),
I doubt that no instruction to be single stepped by kprobes
will cause any (page) fault.

In addition, a comment in kprobe_fault_handler() says,
                /*
                 * We are here because the instruction being single
                 * stepped caused a page fault. We reset the current
                 * kprobe and the ip points back to the probe address
                 * and allow the page fault handler to continue as a
                 * normal page fault.
                 */
Kprobes seems to redo the instruction with single step disabled
if it has generated a page fault.

> Can KGDB make the same
> guarantees?

Taking a similar approach won't be impossible, but require lots of work,
in particular decoding instructions to be single stepped.
(I'm even not sure that gdb protocol allows this.)
It also raises another question, as you mentioned early, should we
step into or step over exception/interrupt handler?

Thanks,
-Takahiro AKASHI

> Will
