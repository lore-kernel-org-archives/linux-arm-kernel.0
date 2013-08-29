From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 29 Aug 2013 12:22:39 +0100
Subject: [PATCH v5 3/5] ARM64: arch_timer: add support to configure and
 enable event stream
In-Reply-To: <1377686689-30828-4-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1377686689-30828-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1377686689-30828-4-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Message-ID: <20130829112239.GE13704@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 28, 2013 at 11:44:47AM +0100, Sudeep KarkadaNagesha wrote:
>  static inline u64 arch_counter_get_cntvct(void)
> diff --git a/arch/arm64/include/asm/hwcap.h b/arch/arm64/include/asm/hwcap.h
> index 6d4482f..530fa879 100644
> --- a/arch/arm64/include/asm/hwcap.h
> +++ b/arch/arm64/include/asm/hwcap.h
> @@ -30,6 +30,7 @@
>  #define COMPAT_HWCAP_IDIVA	(1 << 17)
>  #define COMPAT_HWCAP_IDIVT	(1 << 18)
>  #define COMPAT_HWCAP_IDIV	(COMPAT_HWCAP_IDIVA|COMPAT_HWCAP_IDIVT)
> +#define COMPAT_HWCAP_EVTSTRM	(1 << 21)
>  
>  #ifndef __ASSEMBLY__
>  /*
> @@ -37,11 +38,16 @@
>   * instruction set this cpu supports.
>   */
>  #define ELF_HWCAP		(elf_hwcap)
> -#define COMPAT_ELF_HWCAP	(COMPAT_HWCAP_HALF|COMPAT_HWCAP_THUMB|\
> +#ifdef CONFIG_COMPAT
> +#define COMPAT_ELF_HWCAP	(compat_elf_hwcap)
> +#define COMPAT_ELF_HWCAP_DEFAULT	\
> +				(COMPAT_HWCAP_HALF|COMPAT_HWCAP_THUMB|\
>  				 COMPAT_HWCAP_FAST_MULT|COMPAT_HWCAP_EDSP|\
>  				 COMPAT_HWCAP_TLS|COMPAT_HWCAP_VFP|\
>  				 COMPAT_HWCAP_VFPv3|COMPAT_HWCAP_VFPv4|\
>  				 COMPAT_HWCAP_NEON|COMPAT_HWCAP_IDIV)
> +extern unsigned int compat_elf_hwcap;
> +#endif

I think you can move the default to the setup.c file, it's not of any
use apart from initialisation.

-- 
Catalin
