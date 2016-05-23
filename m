From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 23 May 2016 11:54:20 +0100
Subject: [PATCH] arm: Enable interrupts before calling schedule()
In-Reply-To: <alpine.DEB.2.11.1605201740320.3639@nanos>
References: <alpine.DEB.2.11.1605201740320.3639@nanos>
Message-ID: <20160523105420.GE4892@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Fri, May 20, 2016 at 05:42:17PM +0200, Thomas Gleixner wrote:
> do_work_pending() calls schedule() with interrupts disabled, which is just
> wrong. Fix it.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/arm/kernel/signal.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- a/arch/arm/kernel/signal.c
> +++ b/arch/arm/kernel/signal.c
> @@ -573,6 +573,7 @@ do_work_pending(struct pt_regs *regs, un
>  	trace_hardirqs_off();
>  	do {
>  		if (likely(thread_flags & _TIF_NEED_RESCHED)) {
> +			local_irq_enable();
>  			schedule();
>  		} else {
>  			if (unlikely(!user_mode(regs)))

We may have the same bug on arm64 (arch/arm64/kernel/entry.S). Is there
a more fundamental problem with calling schedule() with IRQs off? The
__schedule() function disables the IRQs shortly after it is entered.

To silence IRQ trace warnings on arm64, we merged commit db3899a6477a
("arm64: Add trace_hardirqs_off annotation in ret_to_user"). But we were
also debating whether enabling the IRQs before calling schedule() in
arch/arm64/kernel/entry.S would make more sense. It looks like we need
to revisit this patch:

https://git.kernel.org/cgit/linux/kernel/git/mark/linux.git/commit/?h=arm64/entry-deasm&id=d244472af6e88c55603dc1ba342fae4e85cde31c

Thanks.

-- 
Catalin
