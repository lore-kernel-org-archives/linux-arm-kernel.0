From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 31 Oct 2013 11:35:58 +0900
Subject: [PATCH v3 3/4] AArch64: KGDB: Add step debugging support
In-Reply-To: <1382094469-7971-4-git-send-email-vijay.kilari@gmail.com>
References: <1382094469-7971-1-git-send-email-vijay.kilari@gmail.com>
 <1382094469-7971-4-git-send-email-vijay.kilari@gmail.com>
Message-ID: <5271C20E.4020104@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 10/18/2013 08:07 PM, vijay.kilari at gmail.com wrote:
> From: Vijaya Kumar K <Vijaya.Kumar@caviumnetworks.com>
>
> Add KGDB software step debugging support for EL1 debug
> in AArch64 mode.
>
> diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
> index 50cef79..2b0b987 100644
> --- a/arch/arm64/kernel/kgdb.c
> +++ b/arch/arm64/kernel/kgdb.c
 > ...
>   int kgdb_arch_handle_exception(int exception_vector, int signo,
>   			       int err_code, char *remcom_in_buffer,
>   			       char *remcom_out_buffer,
>   			       struct pt_regs *linux_regs)
>   {
 > ...
> +	case 's':
> +		/*
> +		 * Update step address value with address passed
> +		 * with step packet.
> +		 * On debug exception return PC is copied to ELR
> +		 * So just update PC.
> +		 * If no step address is passed, resume from the address
> +		 * pointed by PC. Do not update PC
> +		 */
> +		kgdb_arch_update_addr(linux_regs, remcom_in_buffer);
>
> +		/*
> +		 * Enable single step handling
> +		 */
> +		if (!kernel_active_single_step())
> +			kernel_enable_single_step(linux_regs);
>   		err = 0;
>   		break;
>   	default:

Other architectures handle the state, by modifying kgdb_single_step or
kgdb_cpu_doing_single_step, when entering into or exiting from single
step mode.

Do you have a good reason that you don't need to do so on arm64?
(I'm just asking because my own kgdb patch follows the way that x86 does.)

-Takahiro AKASHI
