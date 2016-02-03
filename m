From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Wed, 3 Feb 2016 12:38:57 +0000
Subject: [PATCH v1 3/5] arm64: kernel: Add support for User Access Override
In-Reply-To: <1454432611-21333-4-git-send-email-james.morse@arm.com>
References: <1454432611-21333-1-git-send-email-james.morse@arm.com>
 <1454432611-21333-4-git-send-email-james.morse@arm.com>
Message-ID: <56B1F4E1.4050603@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/02/16 17:03, James Morse wrote:
> 'User Access Override' is a new ARMv8.2 feature which allows the
> unprivileged load and store instructions to be overridden to behave in
> the normal way.
>
> This patch converts {get,put}_user() and friends to use ldtr*/sttr*
> instructions - so that they can only access EL0 memory, then enables
> UAO when fs==KERNEL_DS so that these functions can access kernel memory.
>
> This allows user space's read/write permissions to be checked against the
> page tables, instead of testing addr<USER_DS, then using the kernel's
> read/write permissions.
>

> +
> +#ifdef CONFIG_ARM64_UAO
> +/*
> + * Kernel threads have fs=KERNEL_DS by default, and don't need to call
> + * set_fs(), devtmpfs in particular relies on this behaviour.
> + * We need to enable the feature at runtime (instead of adding it to
> + * PSR_MODE_EL1h) as the feature may not be implemented by the cpu.
> + */
> +void cpu_enable_uao(void *__unused)
> +{
> +	asm(SET_PSTATE_UAO(1));
> +}
> +#endif /* CONFIG_ARM64_UAO */

Could this be moved to arch/arm64/mm/fault.c, just like cpu_enable_pan() ?

> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 92ddac1e8ca2..5ce2656b04df 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -192,6 +192,14 @@ out:
>   	return fault;
>   }
>
> +static inline int permission_fault(unsigned int esr)
> +{
> +	unsigned int ec       = (esr & ESR_ELx_EC_MASK)>>ESR_ELx_EC_SHIFT;

nit: space before and after >> ?

Suzuki
