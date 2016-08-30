From: will.deacon@arm.com (Will Deacon)
Date: Tue, 30 Aug 2016 17:53:40 +0100
Subject: [PATCH] arm64: kernel: Fix unmasked debug exceptions when
 restoring mdscr_el1
In-Reply-To: <1472223822-21059-1-git-send-email-james.morse@arm.com>
References: <1472223822-21059-1-git-send-email-james.morse@arm.com>
Message-ID: <20160830165339.GI24906@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 26, 2016 at 04:03:42PM +0100, James Morse wrote:
> Changes to make the resume from cpu_suspend() code behave more like
> secondary boot caused debug exceptions to be unmasked early by
> __cpu_setup(). We then go on to restore mdscr_el1 in cpu_do_resume(),
> potentially taking break or watch points based on uninitialised registers.
> 
> Mask debug exceptions in cpu_do_resume(), which is specific to resume
> from cpu_suspend(). Debug exceptions will be restored to their original
> state by local_dbg_restore() in cpu_suspend(), which runs after
> hw_breakpoint_restore() has re-initialised the other registers.
> 
> Reported-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Fixes: cabe1c81ea5b ("arm64: Change cpu_resume() to enable mmu early then access sleep_sp by va")
> Cc: <stable@vger.kernel.org> #4.7
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  arch/arm64/mm/proc.S | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> index 5bb61de23201..9d37e967fa19 100644
> --- a/arch/arm64/mm/proc.S
> +++ b/arch/arm64/mm/proc.S
> @@ -100,7 +100,16 @@ ENTRY(cpu_do_resume)
>  
>  	msr	tcr_el1, x8
>  	msr	vbar_el1, x9
> +
> +	/*
> +	 * __cpu_setup() cleared MDSCR_EL1.MDE and friends, before unmasking
> +	 * debug exceptions. By restoring MDSCR_EL1 here, we may take a debug
> +	 * exception. Mask them until local_dbg_restore() in cpu_suspend()
> +	 * resets them.
> +	 */
> +	disable_dbg
>  	msr	mdscr_el1, x10
> +
>  	msr	sctlr_el1, x12

Looks good to me:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
