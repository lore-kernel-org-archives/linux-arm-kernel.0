From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 9 Dec 2016 18:07:56 +0000
Subject: [PATCH v4] arm64: fpsimd: improve stacking logic in
 non-interruptible context
In-Reply-To: <20161209172407.GC1574@e103592.cambridge.arm.com>
References: <1481301992-2344-1-git-send-email-ard.biesheuvel@linaro.org>
 <20161209172407.GC1574@e103592.cambridge.arm.com>
Message-ID: <20161209180756.GA21051@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 09, 2016 at 05:24:08PM +0000, Dave P Martin wrote:
> On Fri, Dec 09, 2016 at 04:46:32PM +0000, Ard Biesheuvel wrote:
> > Currently, we allow kernel mode NEON in softirq or hardirq context by
> > stacking and unstacking a slice of the NEON register file for each call
> > to kernel_neon_begin() and kernel_neon_end(), respectively.
> > 
> > Given that
> > a) a CPU typically spends most of its time in userland, during which time
> >    no kernel mode NEON in process context is in progress,
> > b) a CPU spends most of its time in the kernel doing other things than
> >    kernel mode NEON when it gets interrupted to perform kernel mode NEON
> >    in softirq context
> > 
> > the stacking and subsequent unstacking is only necessary if we are
> > interrupting a thread while it is performing kernel mode NEON in process
> > context, which means that in all other cases, we can simply preserve the
> > userland FPSIMD state once, and only restore it upon return to userland,
> > even if we are being invoked from softirq or hardirq context.
> > 
> > So instead of checking whether we are running in interrupt context, keep
> > track of the level of nested kernel mode NEON calls in progress, and only
> > perform the eager stack/unstack if the level exceeds 1.
> > 
> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> 
> This looks good to me.
> 
> This should also make the SVE case trivial now: there can only be live
> SVE state when in process context with !TIF_FOREIGN_FPSTATE, and the
> SVE save/restore is then handled by fpsimd_{save,load}_state()
> directly.  For deeper nesting levels, there is already no live SVE
> state, so kernel_neon_{save,load}_partial_state() are enough in that
> case.

That's still tricky for SVE. If you get an interrupt in
kernel_neon_begin_partial() after the level has been incremented to 1
but before fpsimd_save_state() has been called, SVE-unaware
kernel_neon_{save,load}_partial_state() would corrupt the SVE state.

-- 
Catalin
