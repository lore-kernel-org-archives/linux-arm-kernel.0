From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 13 Jul 2016 17:59:54 +0200
Subject: [PATCH] arm64: Add config to limit user space to 47bits
In-Reply-To: <1468424567-15925-1-git-send-email-agraf@suse.de>
References: <1468424567-15925-1-git-send-email-agraf@suse.de>
Message-ID: <CAKv+Gu_QH=sZi--FVqHebd1P+6UMzEqWQQ1u3Y170B7cND8Kgw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 July 2016 at 17:42, Alexander Graf <agraf@suse.de> wrote:
> Some user space applications are known to break with 48 bits virtual

known by whom? At least I wasn't aware of it, so could you please
share some examples?

> address space. As interim step until the world is healed and everyone
> embraces correct code, this patch allows to only expose 47 bits of
> virtual address space to user space.
>

Is this a code generation/toolchain issue?

> Signed-off-by: Alexander Graf <agraf@suse.de>
> ---
>  arch/arm64/Kconfig              | 9 +++++++++
>  arch/arm64/include/asm/memory.h | 4 ++++
>  2 files changed, 13 insertions(+)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 5a0a691..9ff5a74 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -538,6 +538,15 @@ config ARM64_VA_BITS
>         default 47 if ARM64_VA_BITS_47
>         default 48 if ARM64_VA_BITS_48
>
> +config ARM64_USER_VA_BITS_47
> +       bool "Limit user space to 47 bits address space"
> +       depends on ARM64_VA_BITS_48
> +       help
> +         Some user space applications are known to break with 48 bits virtual
> +         address space. As interim step until the world is healed and everyone
> +         embraces correct code, this option allows to only expose 47 bits of
> +         virtual address space to user space. If unsure say N here.
> +
>  config CPU_BIG_ENDIAN
>         bool "Build big-endian kernel"
>         help
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index 31b7322..ef268c6 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -74,7 +74,11 @@
>  #define PCI_IO_END             (VMEMMAP_START - SZ_2M)
>  #define PCI_IO_START           (PCI_IO_END - PCI_IO_SIZE)
>  #define FIXADDR_TOP            (PCI_IO_START - SZ_2M)
> +#ifdef CONFIG_ARM64_USER_VA_BITS_47
> +#define TASK_SIZE_64           (UL(1) << (VA_BITS - 1))
> +#else
>  #define TASK_SIZE_64           (UL(1) << VA_BITS)
> +#endif
>
>  #ifdef CONFIG_COMPAT
>  #define TASK_SIZE_32           UL(0x100000000)
> --
> 1.8.5.6
>
