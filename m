From: julien.grall@arm.com (Julien Grall)
Date: Mon, 15 Aug 2016 11:58:15 +0200
Subject: [PATCH 6/7] arm64: xen: Enable user access before a privcmd hvc
 call
In-Reply-To: <1471015666-23125-7-git-send-email-catalin.marinas@arm.com>
References: <1471015666-23125-1-git-send-email-catalin.marinas@arm.com>
 <1471015666-23125-7-git-send-email-catalin.marinas@arm.com>
Message-ID: <1f083bc9-f002-4b13-6638-c7448be0eaaa@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

I have CCed Stefano who is maintaining the Xen ARM code in Linux.

On 12/08/2016 17:27, Catalin Marinas wrote:
> Privcmd calls are issued by the userspace. The kernel needs to enable
> access to TTBR0_EL1 as the hypervisor would issue stage 1 translations
> to user memory via AT instructions. Since AT instructions are not
> affected by the PAN bit (ARMv8.1), we only need the explicit
> uaccess_enable/disable if the TTBR0 PAN option is enabled.
>
> Cc: Julien Grall <julien.grall@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

Reviewed-by: Julien Grall <julien.grall@arm.com>

Regards,

> ---
>  arch/arm64/xen/hypercall.S | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/arch/arm64/xen/hypercall.S b/arch/arm64/xen/hypercall.S
> index 329c8027b0a9..4c509f4f4dcc 100644
> --- a/arch/arm64/xen/hypercall.S
> +++ b/arch/arm64/xen/hypercall.S
> @@ -91,6 +91,24 @@ ENTRY(privcmd_call)
>  	mov x2, x3
>  	mov x3, x4
>  	mov x4, x5
> +#ifdef CONFIG_ARM64_TTBR0_PAN
> +	/*
> +	 * Privcmd calls are issued by the userspace. The kernel needs to
> +	 * enable access to TTBR0_EL1 as the hypervisor would issue stage 1
> +	 * translations to user memory via AT instructions. Since AT
> +	 * instructions are not affected by the PAN bit (ARMv8.1), we only
> +	 * need the explicit uaccess_enable/disable if the TTBR0 PAN option is
> +	 * enabled.
> +	 */
> +	uaccess_enable x6, x7, x8
> +#endif
>  	hvc XEN_IMM
> +
> +#ifdef CONFIG_ARM64_TTBR0_PAN
> +	/*
> +	 * Disable userspace access from kernel once the hyp call completed.
> +	 */
> +	uaccess_disable x6
> +#endif
>  	ret
>  ENDPROC(privcmd_call);
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>

-- 
Julien Grall
