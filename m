From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 7 Sep 2015 15:56:47 +0100
Subject: [RFC PATCH 1/3] arm64: entry: Remove unnecessary calculation for
 S_SP in EL1h
In-Reply-To: <1441376587-12979-2-git-send-email-jungseoklee85@gmail.com>
References: <1441376587-12979-1-git-send-email-jungseoklee85@gmail.com>
 <1441376587-12979-2-git-send-email-jungseoklee85@gmail.com>
Message-ID: <20150907145646.GB13786@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 04, 2015 at 03:23:05PM +0100, Jungseok Lee wrote:
> Under EL1h, S_SP data is not seen in kernel_exit. Thus, x21 calculation
> is not needed in kernel_entry. Currently, S_SP information is vaild only
> when sp_el0 is used.

I don't think this is true. The generic BUG implementation will grab the
saved SP from the pt_regs, and with this change we'll report whatever
happened to be in x21 instead.

> Signed-off-by: Jungseok Lee <jungseoklee85@gmail.com>
> ---
>  arch/arm64/kernel/entry.S | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index e163518..d23ca0d 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -91,8 +91,6 @@
>  	get_thread_info tsk			// Ensure MDSCR_EL1.SS is clear,
>  	ldr	x19, [tsk, #TI_FLAGS]		// since we can unmask debug
>  	disable_step_tsk x19, x20		// exceptions when scheduling.
> -	.else
> -	add	x21, sp, #S_FRAME_SIZE
>  	.endif
>  	mrs	x22, elr_el1
>  	mrs	x23, spsr_el1

Immediately after this we do:

	stp     lr, x21, [sp, #S_LR]

To store the LR and SP to the pt_regs which bug_handler would use.

Am I missing smoething?

Thanks,
Mark.
