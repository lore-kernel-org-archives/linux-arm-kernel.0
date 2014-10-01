From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 1 Oct 2014 14:12:33 +0100
Subject: [PATCH 13/24] ARM64:ILP32: Use the non compat HWCAP for ILP32
In-Reply-To: <1409779158-30963-14-git-send-email-apinski@cavium.com>
References: <1409779158-30963-1-git-send-email-apinski@cavium.com>
 <1409779158-30963-14-git-send-email-apinski@cavium.com>
Message-ID: <20141001131232.GK12702@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 03, 2014 at 10:19:07PM +0100, Andrew Pinski wrote:
> Signed-off-by: Andrew Pinski <apinski@cavium.com>
> ---
>  arch/arm64/include/asm/compat.h |   10 ++++++++++
>  arch/arm64/include/asm/hwcap.h  |    2 --
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/compat.h b/arch/arm64/include/asm/compat.h
> index eca6eec..2f84d2c 100644
> --- a/arch/arm64/include/asm/compat.h
> +++ b/arch/arm64/include/asm/compat.h
> @@ -296,6 +296,16 @@ struct compat_shmid64_ds {
>  	compat_ulong_t __unused5;
>  };
>  
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
>  static inline int is_compat_task(void)
>  {
>  	return test_thread_flag(TIF_32BIT);
> diff --git a/arch/arm64/include/asm/hwcap.h b/arch/arm64/include/asm/hwcap.h
> index 024c461..31e7e02 100644
> --- a/arch/arm64/include/asm/hwcap.h
> +++ b/arch/arm64/include/asm/hwcap.h
> @@ -46,8 +46,6 @@
>  #define ELF_HWCAP		(elf_hwcap)
>  
>  #ifdef CONFIG_COMPAT
> -#define COMPAT_ELF_HWCAP	(compat_elf_hwcap)
> -#define COMPAT_ELF_HWCAP2	(compat_elf_hwcap2)
>  extern unsigned int compat_elf_hwcap, compat_elf_hwcap2;
>  #endif

Any reason why you are moving the definitions from here? Can you not
include asm/compat.h in asm/hwcap.h? (or move the compat_elf_hwcap
declaration as well).

-- 
Catalin
