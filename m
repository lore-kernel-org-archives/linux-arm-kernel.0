From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 16 Dec 2015 16:54:34 +0100
Subject: [PATCH v6 09/20] arm64:ilp32: share HWCAP between LP64 and ILP32
In-Reply-To: <1450215766-14765-10-git-send-email-ynorov@caviumnetworks.com>
References: <1450215766-14765-1-git-send-email-ynorov@caviumnetworks.com>
 <1450215766-14765-10-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <2049962.OV4jWs7vGi@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 16 December 2015 00:42:35 Yury Norov wrote:
> 
>  #ifdef CONFIG_COMPAT
> -#define COMPAT_ELF_HWCAP       (compat_elf_hwcap)
> -#define COMPAT_ELF_HWCAP2      (compat_elf_hwcap2)
>  extern unsigned int compat_elf_hwcap, compat_elf_hwcap2;
> +#define COMPAT_ELF_HWCAP       \
> +       (is_a32_compat_task()   \
> +         ? compat_elf_hwcap    \
> +         : elf_hwcap)
> +
> +#define COMPAT_ELF_HWCAP2      \
> +       (is_a32_compat_task()   \
> +         ? compat_elf_hwcap2   \
> +         : 0)
> +
>  #endif
>  
> 

I'm trying to understand how this is used. Are you compiling
fs/compat_binfmt_elf.c twice to handle both 32-bit ELF types?

Would it be easier to use a separate arch/arm64/kernel/binfmt_elf32.c
as a copy of fs/compat_binfmt_elf.c, with all the right macros defined
for ilp32 mode in there?

	Arnd
