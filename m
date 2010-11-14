From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sun, 14 Nov 2010 10:13:38 +0000
Subject: [PATCH v2 08/20] ARM: LPAE: MMU setup for the 3-level page table
	format
In-Reply-To: <1289584840-18097-9-git-send-email-catalin.marinas@arm.com>
References: <1289584840-18097-1-git-send-email-catalin.marinas@arm.com>
	<1289584840-18097-9-git-send-email-catalin.marinas@arm.com>
Message-ID: <AANLkTinnJZwiiuX4747WSmrjm7j9JhG_CGugqnK1jWEF@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 November 2010 18:00, Catalin Marinas <catalin.marinas@arm.com> wrote:
> This patch adds the MMU initialisation for the LPAE page table format.
> The swapper_pg_dir size with LPAE is 5 rather than 4 pages. The
> __v7_setup function configures the TTBRx split based on the PAGE_OFFSET
> and sets the corresponding TTB control and MAIRx bits (similar to
> PRRR/NMRR for TEX remapping). The 36-bit mappings (supersections) and
> a few other memory types in mmu.c are conditionally compiled.
[...]
> --- a/arch/arm/kernel/head.S
> +++ b/arch/arm/kernel/head.S
> @@ -45,11 +46,20 @@
> ?#error KERNEL_RAM_VADDR must start at 0xXXXX8000
> ?#endif
>
> +#ifdef CONFIG_ARM_LPAE
> + ? ? ? /* LPAE requires an additional page for the PGD */
> +#define PG_DIR_SIZE ? ?0x5000
> +#define PTE_WORDS ? ? ?3
> +#else
> +#define PG_DIR_SIZE ? ?0x4000
> +#define PTE_WORDS ? ? ?2
> +#endif

This should have been called PTE_ORDER, the PTE_WORDS naming is misleading.

-- 
Catalin
