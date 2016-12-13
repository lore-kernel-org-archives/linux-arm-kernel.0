From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 13 Dec 2016 17:34:58 +0000
Subject: [PATCH v6] arm64: fpsimd: improve stacking logic in
 non-interruptible context
In-Reply-To: <1481632529-24218-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1481632529-24218-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20161213173457.GF23377@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 13, 2016 at 12:35:29PM +0000, Ard Biesheuvel wrote:
> Currently, we allow kernel mode NEON in softirq or hardirq context by
> stacking and unstacking a slice of the NEON register file for each call
> to kernel_neon_begin() and kernel_neon_end(), respectively.
> 
> Given that
> a) a CPU typically spends most of its time in userland, during which time
>    no kernel mode NEON in process context is in progress,
> b) a CPU spends most of its time in the kernel doing other things than
>    kernel mode NEON when it gets interrupted to perform kernel mode NEON
>    in softirq context
> 
> the stacking and subsequent unstacking is only necessary if we are
> interrupting a thread while it is performing kernel mode NEON in process
> context, which means that in all other cases, we can simply preserve the
> userland FPSIMD state once, and only restore it upon return to userland,
> even if we are being invoked from softirq or hardirq context.
> 
> So instead of checking whether we are running in interrupt context, keep
> track of the level of nested kernel mode NEON calls in progress, and only
> perform the eager stack/unstack if the level exceeds 1.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> v6:
> - use a spinlock instead of disabling interrupts

My concern with the spinlock or disabling interrupts is the latency if
we ever get some insanely long SVE vectors.

-- 
Catalin
