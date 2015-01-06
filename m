From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 6 Jan 2015 09:39:52 +0000
Subject: [PATCH 2/2] arm64: call early_ioremap_reset() in paging_init()
In-Reply-To: <1420482835-6444-3-git-send-email-leif.lindholm@linaro.org>
References: <1420482835-6444-1-git-send-email-leif.lindholm@linaro.org>
 <1420482835-6444-3-git-send-email-leif.lindholm@linaro.org>
Message-ID: <CAKv+Gu9G8R7CscCBw9Xg1SrJgUMjDtbOCaTSw+3BOAFXBmBVcg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 January 2015 at 18:33, Leif Lindholm <leif.lindholm@linaro.org> wrote:
> arm64 does not support early_memremap/memunmap/ioremap/iounmap after
> paging_init() has been called. The core early_*remap code handles this
> via the after_paging_init variable, which is set by a call to
> early_ioremap_reset().
>
> However, arm64 currently does not call early_ioremap_reset(), which
> has made it possible to poke around in the fixmap region after kmap
> is enabled. Add the required call.
>
> Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Perhaps add 'Fixes' and 'Cc: stable' tags as well?


> ---
>  arch/arm64/mm/mmu.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 6032f3e..506544f 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -348,6 +348,7 @@ void __init paging_init(void)
>  {
>         void *zero_page;
>
> +       early_ioremap_reset();
>         map_mem();
>
>         /*
> --
> 2.1.3
>
