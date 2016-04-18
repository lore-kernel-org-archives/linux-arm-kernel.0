From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 18 Apr 2016 14:08:20 +0100
Subject: [PATCH] arm64: mm: remove the redundant code
In-Reply-To: <1460944196-11780-1-git-send-email-shijie.huang@arm.com>
References: <1460944196-11780-1-git-send-email-shijie.huang@arm.com>
Message-ID: <20160418130820.GD18257@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 18, 2016 at 09:49:56AM +0800, Huang Shijie wrote:
> We already re-enable interrupts where necessary in the entry code, so
> there is no need to do it again in do_page fault. This patch removes
> the redundant code.
> 
> Signed-off-by: Huang Shijie <shijie.huang@arm.com>
> ---
>  arch/arm64/mm/fault.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 95df28b..bdc193c 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -212,10 +212,6 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
>  	tsk = current;
>  	mm  = tsk->mm;
>  
> -	/* Enable interrupts if they were enabled in the parent context. */
> -	if (interrupts_enabled(regs))
> -		local_irq_enable();

We indeed don't have to re-enable interrupts here as they have been
enabled by the calling code in entry.S. But have you run this with
CONFIG_TRACE_IRQFLAGS enabled? I don't think there is any issue, just a
sanity check.

-- 
Catalin
