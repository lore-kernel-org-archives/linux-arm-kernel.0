From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 19 Jun 2014 13:54:08 +0100
Subject: [PATCH 15/24] ARM64:ILP32: Use the non compat HWCAP for ILP32.
In-Reply-To: <1400914939-9708-16-git-send-email-apinski@cavium.com>
References: <1400914939-9708-1-git-send-email-apinski@cavium.com>
 <1400914939-9708-16-git-send-email-apinski@cavium.com>
Message-ID: <20140619125408.GD8476@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 24, 2014 at 12:02:10AM -0700, Andrew Pinski wrote:
> Signed-off-by: Andrew Pinski <apinski@cavium.com>

Please add some commit log, even if minimal.

> ---
>  arch/arm64/include/asm/hwcap.h |   12 ++++++++++--
>  1 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/hwcap.h b/arch/arm64/include/asm/hwcap.h
> index 024c461..cb87f91 100644
> --- a/arch/arm64/include/asm/hwcap.h
> +++ b/arch/arm64/include/asm/hwcap.h
> @@ -46,9 +46,17 @@
>  #define ELF_HWCAP		(elf_hwcap)
>  
>  #ifdef CONFIG_COMPAT
> -#define COMPAT_ELF_HWCAP	(compat_elf_hwcap)
> -#define COMPAT_ELF_HWCAP2	(compat_elf_hwcap2)
>  extern unsigned int compat_elf_hwcap, compat_elf_hwcap2;
> +#define COMPAT_ELF_HWCAP	\
> +	(is_a32_compat_task()	\
> +	  ? compat_elf_hwcap	\
> +	  : elf_hwcap)
> +
> +#define COMPAT_ELF_HWCAP2	\
> +	(is_a32_compat_task()	\
> +	  ? compat_elf_hwcap2	\
> +	  : 0)
> +
>  #endif
>  
>  extern unsigned long elf_hwcap;

Do any extra headers need to be included? It looks like we rely on the
code including hwcap.h to have the correct headers.

-- 
Catalin
