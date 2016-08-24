From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Wed, 24 Aug 2016 11:24:07 -0700
Subject: [PATCH 1/2] arm64: kernel: Add SMC Session ID to results
In-Reply-To: <1471672274-19317-2-git-send-email-andy.gross@linaro.org>
References: <1471672274-19317-1-git-send-email-andy.gross@linaro.org>
 <1471672274-19317-2-git-send-email-andy.gross@linaro.org>
Message-ID: <20160824182407.GG15161@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 19 Aug 22:51 PDT 2016, Andy Gross wrote:

> This patch adds the SMC Session ID to the results passed back from SMC
> calls.  The Qualcomm SMC implementation provides for interrupted SMC
> functions.  When this occurs, the SMC call will return a session ID that
> is required to be used when resuming the interrupted SMC call.
> 
> Signed-off-by: Andy Gross <andy.gross@linaro.org>

This fixes the spurious remoteproc firmware authentication failures I've
seen lately.

Tested-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  arch/arm64/kernel/asm-offsets.c | 1 +
>  arch/arm64/kernel/smccc-call.S  | 1 +
>  include/linux/arm-smccc.h       | 4 +++-
>  3 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
> index 05070b7..ff38c58 100644
> --- a/arch/arm64/kernel/asm-offsets.c
> +++ b/arch/arm64/kernel/asm-offsets.c
> @@ -141,6 +141,7 @@ int main(void)
>  #endif
>    DEFINE(ARM_SMCCC_RES_X0_OFFS,	offsetof(struct arm_smccc_res, a0));
>    DEFINE(ARM_SMCCC_RES_X2_OFFS,	offsetof(struct arm_smccc_res, a2));
> +  DEFINE(ARM_SMCCC_RES_X6_OFFS,	offsetof(struct arm_smccc_res, a6));
>    BLANK();
>    DEFINE(HIBERN_PBE_ORIG,	offsetof(struct pbe, orig_address));
>    DEFINE(HIBERN_PBE_ADDR,	offsetof(struct pbe, address));
> diff --git a/arch/arm64/kernel/smccc-call.S b/arch/arm64/kernel/smccc-call.S
> index ae0496f..278dc9a 100644
> --- a/arch/arm64/kernel/smccc-call.S
> +++ b/arch/arm64/kernel/smccc-call.S
> @@ -20,6 +20,7 @@
>  	ldr	x4, [sp]
>  	stp	x0, x1, [x4, #ARM_SMCCC_RES_X0_OFFS]
>  	stp	x2, x3, [x4, #ARM_SMCCC_RES_X2_OFFS]
> +	str	x6, [x4, #ARM_SMCCC_RES_X6_OFFS]
>  	ret
>  	.cfi_endproc
>  	.endm
> diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
> index b5abfda..82d919f 100644
> --- a/include/linux/arm-smccc.h
> +++ b/include/linux/arm-smccc.h
> @@ -63,18 +63,20 @@
>  /**
>   * struct arm_smccc_res - Result from SMC/HVC call
>   * @a0-a3 result values from registers 0 to 3
> + * @a6 Session ID register (optional)
>   */
>  struct arm_smccc_res {
>  	unsigned long a0;
>  	unsigned long a1;
>  	unsigned long a2;
>  	unsigned long a3;
> +	unsigned long a6;
>  };
>  
>  /**
>   * arm_smccc_smc() - make SMC calls
>   * @a0-a7: arguments passed in registers 0 to 7
> - * @res: result values from registers 0 to 3
> + * @res: result values from registers 0 to 3 and optional register 6
>   *
>   * This function is used to make SMC calls following SMC Calling Convention.
>   * The content of the supplied param are copied to registers 0 to 7 prior
> -- 
> 1.9.1
> 
