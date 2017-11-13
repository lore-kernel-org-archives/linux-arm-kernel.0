From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Mon, 13 Nov 2017 17:34:57 +0000
Subject: [RFC 3/7] arm64: alternative: Apply alternatives early in boot
 process
In-Reply-To: <1507726862-11944-4-git-send-email-julien.thierry@arm.com>
References: <1507726862-11944-1-git-send-email-julien.thierry@arm.com>
 <1507726862-11944-4-git-send-email-julien.thierry@arm.com>
Message-ID: <fe6eb133-c8ef-a519-5c6a-82a35f958cc7@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/10/17 14:00, Julien Thierry wrote:
> From: Daniel Thompson <daniel.thompson@linaro.org>
> 
> Currently alternatives are applied very late in the boot process (and
> a long time after we enable scheduling). Some alternative sequences,
> such as those that alter the way CPU context is stored, must be applied
> much earlier in the boot sequence.
> 
> Introduce apply_alternatives_early() to allow some alternatives to be
> applied immediately after we detect the CPU features of the boot CPU.
> 
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>   arch/arm64/include/asm/alternative.h |  1 +
>   arch/arm64/kernel/alternative.c      | 39 +++++++++++++++++++++++++++++++++---
>   arch/arm64/kernel/smp.c              |  6 ++++++
>   3 files changed, 43 insertions(+), 3 deletions(-)
> 


> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 9f7195a..84c6983 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -455,6 +455,12 @@ void __init smp_prepare_boot_cpu(void)
>   	 * cpuinfo_store_boot_cpu() above.
>   	 */
>   	update_cpu_errata_workarounds();
> +	/*
> +	 * We now know enough about the boot CPU to apply the
> +	 * alternatives that cannot wait until interrupt handling
> +	 * and/or scheduling is enabled.
> +	 */
> +	apply_alternatives_early();
>   }

What happens if a secondary CPU, activated at boot doesn't have the "early"
capabilities ?

Suzuki
