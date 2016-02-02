From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue, 2 Feb 2016 15:53:49 +0900
Subject: [PATCH v4 04/13] arm64: Add new hcall HVC_CALL_FUNC
In-Reply-To: <1453977766-20907-5-git-send-email-james.morse@arm.com>
References: <1453977766-20907-1-git-send-email-james.morse@arm.com>
 <1453977766-20907-5-git-send-email-james.morse@arm.com>
Message-ID: <56B0527D.8060109@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/28/2016 07:42 PM, James Morse wrote:
> From: Geoff Levand <geoff@infradead.org>
>
> Add the new hcall HVC_CALL_FUNC that allows execution of a function at EL2.
> During CPU reset the CPU must be brought to the exception level it had on
> entry to the kernel.  The HVC_CALL_FUNC hcall will provide the mechanism
> needed for this exception level switch.
>
> To allow the HVC_CALL_FUNC exception vector to work without a stack, which
> is needed to support an hcall at CPU reset, this implementation uses
> register x18 to store the link register across the caller provided
> function.  This dictates that the caller provided function must preserve
> the contents of register x18.
>
> Signed-off-by: Geoff Levand <geoff@infradead.org>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> This patch is from v13 of kexec
>
>   arch/arm64/include/asm/virt.h | 13 +++++++++++++
>   arch/arm64/kernel/hyp-stub.S  | 13 ++++++++++++-
>   2 files changed, 25 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
> index eb10368c329e..30700961f28c 100644
> --- a/arch/arm64/include/asm/virt.h
> +++ b/arch/arm64/include/asm/virt.h
> @@ -45,6 +45,19 @@
>
>   #define HVC_SET_VECTORS 2
>
> +/*
> + * HVC_CALL_FUNC - Execute a function at EL2.
> + *
> + * @x0: Physical address of the function to be executed.
> + * @x1: Passed as the first argument to the function.
> + * @x2: Passed as the second argument to the function.
> + * @x3: Passed as the third argument to the function.
> + *
> + * The called function must preserve the contents of register x18.
> + */
> +
> +#define HVC_CALL_FUNC 3
> +
>   #define BOOT_CPU_MODE_EL1	(0xe11)
>   #define BOOT_CPU_MODE_EL2	(0xe12)
>
> diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
> index 017ab519aaf1..e8febe90c036 100644
> --- a/arch/arm64/kernel/hyp-stub.S
> +++ b/arch/arm64/kernel/hyp-stub.S
> @@ -67,8 +67,19 @@ el1_sync:
>   	b	2f
>
>   1:	cmp	x18, #HVC_SET_VECTORS
> -	b.ne	2f
> +	b.ne	1f
>   	msr	vbar_el2, x0
> +	b	2f
> +
> +1:	cmp	x18, #HVC_CALL_FUNC

I think we should avoid duplicated label names ("1") in a short distance.
(I know it's Geoff's code.)

-Takahiro AKASHI

> +	b.ne	2f
> +	mov	x18, lr
> +	mov	lr, x0
> +	mov	x0, x1
> +	mov	x1, x2
> +	mov	x2, x3
> +	blr	lr
> +	mov	lr, x18
>
>   2:	eret
>   ENDPROC(el1_sync)
>
