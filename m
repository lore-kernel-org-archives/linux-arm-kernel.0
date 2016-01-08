From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 08 Jan 2016 09:58 +0100
Subject: [PATCH v6 12/21] arm64:ilp32: share HWCAP between LP64 and ILP32
In-Reply-To: <1452209679-19445-13-git-send-email-ynorov@caviumnetworks.com>
References: <1452209679-19445-1-git-send-email-ynorov@caviumnetworks.com>
 <1452209679-19445-13-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <4813942.8ZHz91B9Af@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 08 January 2016 02:34:30 Yury Norov wrote:
>  #define ELF_HWCAP              (elf_hwcap)
>  
>  #ifdef CONFIG_COMPAT
> -#define COMPAT_ELF_HWCAP       (compat_elf_hwcap)
> -#define COMPAT_ELF_HWCAP2      (compat_elf_hwcap2)
>  extern unsigned int compat_elf_hwcap, compat_elf_hwcap2;
> +#define COMPAT_ELF_HWCAP       \
> +       (is_a32_compat_task()   \
> +         ? compat_elf_hwcap    \
> +         : (u32) elf_hwcap)
> +
> +#define COMPAT_ELF_HWCAP2      \
> +       (is_a32_compat_task()   \
> +         ? compat_elf_hwcap2   \
> +         : (u32) (elf_hwcap >> 32))
> +
>  #endif
>  
> 

This should no longer be needed after patch 11: just define the ELF_HWCAP
and ELF_HWCAP2 values for the right mode when including fs/binfmt_elf.c.
You know what it should be at build time, so don't bother doing a runtime
check.

	Arnd
