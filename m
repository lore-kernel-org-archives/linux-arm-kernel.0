From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 20 Jul 2015 10:43:28 +0200
Subject: [PATCH] ARM: zynq: reserve space for jump target in secondary
 trampoline
In-Reply-To: <1437166862-29782-1-git-send-email-nathan_lynch@mentor.com>
References: <1437166862-29782-1-git-send-email-nathan_lynch@mentor.com>
Message-ID: <55ACB4B0.3040906@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/17/2015 11:01 PM, Nathan Lynch wrote:
> Add a zero argument to the .word directive in
> zynq_secondary_trampoline.  Without an expression the assembler emits
> nothing for the .word directive.
> 
> This makes it so that the intended range is communicated to ioremap
> and outer_flush_range in zynq_cpun_start; e.g. for LE
> trampoline_code_size evaluates to 12 now instead of 8.
> 
> Found by inspection.  I'm not aware of any real problem this fixes.
> Tested by doing on online/offline loop on ZC702.
> 
> Signed-off-by: Nathan Lynch <nathan_lynch@mentor.com>
> ---
>  arch/arm/mach-zynq/headsmp.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-zynq/headsmp.S b/arch/arm/mach-zynq/headsmp.S
> index 045c72720a4d..f6d5de073e34 100644
> --- a/arch/arm/mach-zynq/headsmp.S
> +++ b/arch/arm/mach-zynq/headsmp.S
> @@ -18,7 +18,7 @@ ARM_BE8(rev	r0, r0)
>  .globl zynq_secondary_trampoline_jump
>  zynq_secondary_trampoline_jump:
>  	/* Space for jumping address */
> -	.word	/* cpu 1 */
> +	.word	0	/* cpu 1 */
>  .globl zynq_secondary_trampoline_end
>  zynq_secondary_trampoline_end:
>  ENDPROC(zynq_secondary_trampoline)
> 

Tested and applied to zynq/cleanup.

Thanks,
Michal
