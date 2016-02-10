From: will.deacon@arm.com (Will Deacon)
Date: Wed, 10 Feb 2016 18:02:11 +0000
Subject: [PATCH V1 5/6] arm64: exception: handle instruction abort at
 current EL
In-Reply-To: <1454699608-22760-6-git-send-email-tbaicar@codeaurora.org>
References: <1454699608-22760-1-git-send-email-tbaicar@codeaurora.org>
 <1454699608-22760-6-git-send-email-tbaicar@codeaurora.org>
Message-ID: <20160210180210.GT1052@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 05, 2016 at 12:13:27PM -0700, Tyler Baicar wrote:
> Add a handler for instruction aborts at the current EL
> (ESR_ELx_EC_IABT_CUR) so they are no longer handled in el1_inv.
> This allows firmware first handling for possible SEA
> (Synchronous External Abort) caused instruction abort at
> current EL.
> 
> Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
> Signed-off-by: Naveen Kaje <nkaje@codeaurora.org>
> ---
>  arch/arm64/kernel/entry.S | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index 1f7f5a2..6b7fb14 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -336,6 +336,8 @@ el1_sync:
>  	lsr	x24, x1, #ESR_ELx_EC_SHIFT	// exception class
>  	cmp	x24, #ESR_ELx_EC_DABT_CUR	// data abort in EL1
>  	b.eq	el1_da
> +	cmp	x24, #ESR_ELx_EC_IABT_CUR	// instruction abort in EL1
> +	b.eq	el1_ia
>  	cmp	x24, #ESR_ELx_EC_SYS64		// configurable trap
>  	b.eq	el1_undef
>  	cmp	x24, #ESR_ELx_EC_SP_ALIGN	// stack alignment exception
> @@ -363,6 +365,23 @@ el1_da:
>  	// disable interrupts before pulling preserved data off the stack
>  	disable_irq
>  	kernel_exit 1
> +el1_ia:
> +	/*
> +	 * Instruction abort handling
> +	 */
> +	mrs	x0, far_el1
> +	enable_dbg
> +	// re-enable interrupts if they were enabled in the aborted context
> +	tbnz	x23, #7, 1f			// PSR_I_BIT
> +	enable_irq
> +1:
> +	orr	x1, x1, #1 << 24		// use reserved ISS bit for instruction aborts

Do we actually need to set this bit (ESR_LNX_EXEC) for aborts from EL1?
If not, could we just use the same entry code as el1_da?

Will
