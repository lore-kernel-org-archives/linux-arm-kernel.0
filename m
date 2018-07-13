From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 13 Jul 2018 10:32:23 +0000
Subject: [RFC PATCH] ARM: Debug kernel copy by printing
In-Reply-To: <1530022595-6806-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1530022595-6806-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <TY1PR01MB177010920A6FC7FC1B61358BC0580@TY1PR01MB1770.jpnprd01.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear All,

Has anybody had the chance to look into this? Does it make sense? Any feedback at all?
Thanks!

Fab

> Subject: [RFC PATCH] ARM: Debug kernel copy by printing
>
> It may happen that when we relocate the kernel we corrupt other
> sensible memory (e.g. the memory needed by U-Boot for dealing
> with bootm command) while copying the kernel. If we overwrite
> the content of the memory area used by U-Boot's command bootm
> (described by U-Boot's parameters bootm_low and bootm_size),
> the kernel won't be able to boot. Troubleshooting the problem
> then is not straightforward.
>
> This commit allows the user to easily print information on
> where the kernel gets copied from/to in order to help with the
> design of the system memory map (e.g. bootm_low and bootm_size)
> at boot up.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
> Acked-by: Biju Das <biju.das@bp.renesas.com>
> ---
> Dear All,
>
> shmobile_defconfig doesn't use kernel modules, everything gets
> built-in. iwg20d and iwg22d platforms from iWave use uImage
> to boot, DRAM starts at address 0x40000000, the kernel gets
> loaded up in memory at address 0x40007fc0, bootm_low is
> 0x40e00000, and bootm_size is 0x100000.
>
> The kernel is getting larger and larger, so much so that during
> the relocation the kernel is copying itself right where the
> bootm memory area lives, preventing Linux from booting.
> Here is what this patch prints when applied on top of tag
> next-20180625 and running on the iwg22d:
>
> C:0x400080C0-0x404922A0->0x40E90800-0x4131A9E0
>
> The designer then has to pick up a suitable memory range for
> bootm memory area to fix this, but the only way to successfully
> achieve this is by knowing where the kernel is going to copy
> itself in memory, so that he can stay clear of it.
>
> Other platforms that use the same defconfig suffer from the same
> issue (e.g. Koelsch et al.) as they have been designed some time
> ago or the original BSP was based on an LTS kernel.
>
> Debugging this basically requires a JTAG debugger at this stage.
>
> Do you think this patch could be considered acceptable? If not,
> what would be the best way to get useful/sensible/debug
> information out of the kernel when the problem occours?
>
> Comments welcome!
>
> Thanks,
> Fab
>
>  arch/arm/boot/compressed/head.S | 43 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>
> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> index 517e0e1..6c7ccb4 100644
> --- a/arch/arm/boot/compressed/head.S
> +++ b/arch/arm/boot/compressed/head.S
> @@ -114,6 +114,35 @@
>  #endif
>  .endm
>
> +/*
> + * Debug kernel copy by printing the memory addresses involved
> + */
> +.macro dbgkc, begin, end, cbegin, cend
> +#ifdef DEBUG
> +kputc   #'\n'
> +kputc   #'C'
> +kputc   #':'
> +kputc   #'0'
> +kputc   #'x'
> +kphex   \begin, 8/* Start of compressed kernel */
> +kputc#'-'
> +kputc#'0'
> +kputc#'x'
> +kphex\end, 8/* End of compressed kernel */
> +kputc#'-'
> +kputc#'>'
> +kputc   #'0'
> +kputc   #'x'
> +kphex   \cbegin, 8/* Start of kernel copy */
> +kputc#'-'
> +kputc#'0'
> +kputc#'x'
> +kphex\cend, 8/* End of kernel copy */
> +kputc#'\n'
> +kputc#'\r'
> +#endif
> +.endm
> +
>  .section ".start", #alloc, #execinstr
>  /*
>   * sort out different calling conventions
> @@ -450,6 +479,20 @@ dtb_check_done:
>  addr6, r9, r5
>  addr9, r9, r10
>
> +#ifdef DEBUG
> +sub     r10, r6, r5
> +sub     r10, r9, r10
> +/*
> + * We are about to copy the kernel to a new memory area.
> + * The boundaries of the new memory area can be found in
> + * r10 and r9, whilst r5 and r6 contain the boundaries
> + * of the memory we are going to copy.
> + * Calling dbgkc will help with the printing of this
> + * information.
> + */
> +dbgkcr5, r6, r10, r9
> +#endif
> +
>  1:ldmdbr6!, {r0 - r3, r10 - r12, lr}
>  cmpr6, r5
>  stmdbr9!, {r0 - r3, r10 - r12, lr}
> --
> 2.7.4




Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
