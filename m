From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 8 Jun 2017 15:09:12 +0100
Subject: [PATCH 05/20] arm64: rename COMPAT to AARCH32_EL0 in Kconfig
In-Reply-To: <20170604120009.342-6-ynorov@caviumnetworks.com>
References: <20170604120009.342-1-ynorov@caviumnetworks.com>
 <20170604120009.342-6-ynorov@caviumnetworks.com>
Message-ID: <20170608140912.56rww67adolr4ytr@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 04, 2017 at 02:59:54PM +0300, Yury Norov wrote:
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -402,7 +402,7 @@ config ARM64_ERRATUM_834220
>  
>  config ARM64_ERRATUM_845719
>  	bool "Cortex-A53: 845719: a load might read incorrect data"
> -	depends on COMPAT
> +	depends on AARCH32_EL0
>  	default y
>  	help
>  	  This option adds an alternative code sequence to work around ARM
> @@ -784,7 +784,7 @@ config FORCE_MAX_ZONEORDER
>  
>  menuconfig ARMV8_DEPRECATED
>  	bool "Emulate deprecated/obsolete ARMv8 instructions"
> -	depends on COMPAT
> +	depends on AARCH32_EL0
>  	help
>  	  Legacy software support may require certain instructions
>  	  that have been deprecated or obsoleted in the architecture.
> @@ -1062,9 +1062,15 @@ menu "Userspace binary formats"
>  source "fs/Kconfig.binfmt"
>  
>  config COMPAT
> +	bool
> +	depends on AARCH32_EL0

You could just use "def_bool y" here

> +
> +config AARCH32_EL0
>  	bool "Kernel support for 32-bit EL0"
> +	def_bool y
>  	depends on ARM64_4K_PAGES || EXPERT
>  	select COMPAT_BINFMT_ELF if BINFMT_ELF
> +	select COMPAT

and avoid the explicit select.

>  	select HAVE_UID16
>  	select OLD_SIGSUSPEND3
>  	select COMPAT_OLD_SIGACTION
[...]
> --- a/arch/arm64/kernel/cpuinfo.c
> +++ b/arch/arm64/kernel/cpuinfo.c
> @@ -139,15 +139,17 @@ static int c_show(struct seq_file *m, void *v)
>  		 */
>  		seq_puts(m, "Features\t:");
>  		if (compat) {
> -#ifdef CONFIG_COMPAT
> -			for (j = 0; compat_hwcap_str[j]; j++)
> -				if (compat_elf_hwcap & (1 << j))
> -					seq_printf(m, " %s", compat_hwcap_str[j]);
> -
> -			for (j = 0; compat_hwcap2_str[j]; j++)
> -				if (compat_elf_hwcap2 & (1 << j))
> -					seq_printf(m, " %s", compat_hwcap2_str[j]);
> -#endif /* CONFIG_COMPAT */
> +#ifdef CONFIG_AARCH32_EL0
> +			if (personality(current->personality) == PER_LINUX32) {
> +				for (j = 0; compat_hwcap_str[j]; j++)
> +					if (compat_elf_hwcap & (1 << j))
> +						seq_printf(m, " %s", compat_hwcap_str[j]);
> +
> +				for (j = 0; compat_hwcap2_str[j]; j++)
> +					if (compat_elf_hwcap2 & (1 << j))
> +						seq_printf(m, " %s", compat_hwcap2_str[j]);
> +			}
> +#endif /* CONFIG_AARCH32_EL0 */

I don't understand this hunk. Why do you need another check on
personality? "compat" is already true if PER_LINUX32.

-- 
Catalin
