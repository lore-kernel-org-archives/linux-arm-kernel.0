From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 4 Jan 2016 15:18:41 +0000
Subject: [PATCH] arm64: entry.S: add missing trace_hardirqs_off
In-Reply-To: <1451109438-5834-1-git-send-email-zhizhou.zh@gmail.com>
References: <1451109438-5834-1-git-send-email-zhizhou.zh@gmail.com>
Message-ID: <20160104151840.GF6301@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 26, 2015 at 01:57:18PM +0800, Zhi-zhou Zhang wrote:
> Before calling schedule, we should trace hardirqs correctly. If not,
> we get following warning message when enabled CONFIG_DEBUG_LOCKDEP:
> 
> [    9.243073] DEBUG_LOCKS_WARN_ON(current->hardirqs_enabled)
> [ ... ]
> [    9.262681] possible reason: unannotated irqs-off.
> [    9.263018] irq event stamp: 256209
> [    9.263266] hardirqs last  enabled at (256209): [<ffffffc000085a98>] el0_irq_naked+0x1c/0x24
> [    9.263820] hardirqs last disabled at (256207): [<ffffffc0000bad20>] __do_softirq+0x170/0x28c
> [    9.264419] softirqs last  enabled at (256208): [<ffffffc0000bad9c>] __do_softirq+0x1ec/0x28c
> [    9.264976] softirqs last disabled at (256189): [<ffffffc0000bb194>] irq_exit+0x9c/0xec
> 
> Signed-off-by: Zhi-zhou Zhang <zhizhou.zh@gmail.com>
> ---
>  arch/arm64/kernel/entry.S | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index 7ed3d75..4769190 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -634,6 +634,9 @@ work_pending:
>  	bl	do_notify_resume
>  	b	ret_to_user
>  work_resched:
> +#ifdef CONFIG_TRACE_IRQFLAGS
> +	bl	trace_hardirqs_off
> +#endif
>  	bl	schedule

A similar patch is already in -next as commit db3899a6477a (arm64: Add
trace_hardirqs_off annotation in ret_to_user)

-- 
Catalin
