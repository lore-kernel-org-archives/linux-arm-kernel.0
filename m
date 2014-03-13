From: khilman@linaro.org (Kevin Hilman)
Date: Thu, 13 Mar 2014 13:46:50 -0700
Subject: [PATCH v5 09/11] arm: add support for reserved memory defined by
 device tree
In-Reply-To: <1392985527-6260-10-git-send-email-m.szyprowski@samsung.com>
References: <1392985527-6260-1-git-send-email-m.szyprowski@samsung.com>
 <1392985527-6260-10-git-send-email-m.szyprowski@samsung.com>
Message-ID: <CAGa+x856+YyJ-vyfGoFAKmsqwKD+=Wh0-TT_mAaPStOXjd8eSQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 21, 2014 at 4:25 AM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> Enable reserved memory initialization from device tree.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

This patch has hit -next and several legacy (non-DT) boot failures
were detected and bisected down to this patch.  A quick scan looks
like there needs to be some sanity checking whether a DT is even
present.

Kevin

[1] http://lists.linaro.org/pipermail/kernel-build-reports/2014-March/002791.html

>  arch/arm/Kconfig   |    1 +
>  arch/arm/mm/init.c |    2 ++
>  2 files changed, 3 insertions(+)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index e25419817791..d0262bea8020 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1918,6 +1918,7 @@ config USE_OF
>         select IRQ_DOMAIN
>         select OF
>         select OF_EARLY_FLATTREE
> +       select OF_RESERVED_MEM
>         help
>           Include support for flattened device tree machine descriptions.
>
> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> index 804d61566a53..2a77ba8796ae 100644
> --- a/arch/arm/mm/init.c
> +++ b/arch/arm/mm/init.c
> @@ -323,6 +323,8 @@ void __init arm_memblock_init(struct meminfo *mi,
>         if (mdesc->reserve)
>                 mdesc->reserve();
>
> +       early_init_fdt_scan_reserved_mem();
> +
>         /*
>          * reserve memory for DMA contigouos allocations,
>          * must come from DMA area inside low memory
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
