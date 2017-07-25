From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 25 Jul 2017 14:58:34 +0100
Subject: [PATCH 3/4] arm64: unwind: reference pt_regs via embedded stack
 frame
In-Reply-To: <20170725131303.GA28815@arm.com>
References: <20170724112623.26109-1-ard.biesheuvel@linaro.org>
 <20170724112623.26109-4-ard.biesheuvel@linaro.org>
 <20170724175446.GE9726@leverpostej>
 <20170725131303.GA28815@arm.com>
Message-ID: <20170725135833.GA8372@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 25, 2017 at 02:13:03PM +0100, Will Deacon wrote:
> On Mon, Jul 24, 2017 at 06:54:46PM +0100, Mark Rutland wrote:
> > On Mon, Jul 24, 2017 at 12:26:22PM +0100, Ard Biesheuvel wrote:

> > So here, we're using information from three records (where the last
> > might have been faked from the current FP + LR). We look at the previous
> > frame's LR value to determine whether the current frame's fp points to a
> > next frame that's associated with some regs:
> > 
> >          +----+----------------+
> >          | fp | interrupted PC | /* embedded in pt_regs */
> >          +----+----------------+
> >            /\
> >            ||
> >          +----+----------------+
> > where => | fp | < entry PC >   |
> >          +----+----------------+
> >            /\
> >            ||
> >          +----+----------------+
> >          | fp | where          | /* "where" is in exception text */
> >          +----+----------------+
> > 
> > Which (IIUC) has three problems, inherited from the existing approach.
> > 
> > 1) Several C functions called from exception entry assembly are missing
> >    __exception annotations. e.g. bad_mode.
> >    
> >    So we can miss exception regs in some cases.
> > 
> > 2) Several functions may be called either from the exception entry
> >    assembly, or from other C code. e.g. do_undefinstr, and any cascaded
> >    irqchip handlers.
> >    
> >    So we can spuriously decide part of the stack is a pt_regs.
> > 
> > 3) The entry assembly can enable exceptions before calling C code, so if
> >    an exception is taken at the right time, these will eb in the
> >    backtrace without a surrounding frame in the exception text.
> > 
> >    So we can miss exception regs in some cases (distinct from (1)).
> > 
> > ... given that, I don't think we can rely on in_exception_text(). I
> > think we have to look at whether the current frame's PC/LR is in
> > .entry.text.
> 
> Looking around, I think most (all?) users of in_exception_text and the
> associated linker script labels suffer from similar problems. AFAICT, these
> are:
> 
>   kprobes	- Used to blacklist probes, but omits entry code
>   ftrace	- For graph tracer backtracing; attempted to hack around the
> 		  problem in 9a5ad7d0e3e1 but still excludes .entry.text
>   kasan		- Duplicates ftrace stuff in core code, but also checks
> 		  against softirqentry
> 
> So it looks like we should either include the entry text in these sections
> or avoid using these functions altogether (eventually removing them). It
> needn't hold this series up, but worth considering.
> 
> What do you think?

Agreed; this is currently a mess, and I don't think it's possible to
make portable inferences based on these sections. This will all need an
audit.

As you say, I think that needn't hold this series up, as those are
orthogonal issues. I'm happy to dig into those in the coming weeks.

The kasan case isn't too problematic. It only affects where an
alloc/free stacktrace gets trimmed for an alloc/free in an IRQ handler,
so in the worst case we just lose a few frames beyond the inner irqchip
handler in the dumped backtrace.

For kprobes/ftrace, I'd need to do some further digging.

I'd looked at cleaning up .irqentry.text in the past (as part of further
arm64/entry-deasm work). It's typically used to find the task->IRQ (or
X->IRQ) transition. That can be cleaned up by having a single
(annotated) arch-specific entry point that invokes (unannotated) irqchip
handlers. This would fix kasan, at least.

Thanks,
Mark.
