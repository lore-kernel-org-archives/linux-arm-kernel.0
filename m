From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 28 Oct 2014 09:23:17 +0100
Subject: [PATCHv4 2/7] arm64: Switch to ldr for loading the stub vectors
In-Reply-To: <1414440752-9411-3-git-send-email-lauraa@codeaurora.org>
References: <1414440752-9411-1-git-send-email-lauraa@codeaurora.org>
 <1414440752-9411-3-git-send-email-lauraa@codeaurora.org>
Message-ID: <CAKv+Gu8Jt7NV=zww=PU9KqzpAChdrxuaia_PHpsHM29uAwwgiA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 October 2014 21:12, Laura Abbott <lauraa@codeaurora.org> wrote:
> The hyp stub vectors are currently loaded using adr. This
> instruction has a +/- 1MB range for the loading address. If
> the alignment for sections is changed the address may be more
> than 1MB away, resulting in reclocation errors. Switch to using
> adrp for getting the address to ensure we aren't affected by the
> location of the __hyp_stub_vectors.
>
> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
> ---
> v4: Commit text tweaks

Your subject line still says 'ldr'

Other than that:
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>


> ---
>  arch/arm64/kernel/head.S | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index 0a6e4f9..10f5cc0 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -331,7 +331,8 @@ CPU_LE(     movk    x0, #0x30d0, lsl #16    )       // Clear EE and E0E on LE systems
>         msr     vttbr_el2, xzr
>
>         /* Hypervisor stub */
> -       adr     x0, __hyp_stub_vectors
> +       adrp    x0, __hyp_stub_vectors
> +       add     x0, x0, #:lo12:__hyp_stub_vectors
>         msr     vbar_el2, x0
>
>         /* spsr */
> --
> Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
