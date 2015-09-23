From: robh@kernel.org (Rob Herring)
Date: Wed, 23 Sep 2015 17:59:23 -0500
Subject: [PATCH v2 1/7] of/fdt: make memblock minimum physical address
 arch configurable
In-Reply-To: <1442968663-31843-2-git-send-email-ard.biesheuvel@linaro.org>
References: <1442968663-31843-1-git-send-email-ard.biesheuvel@linaro.org>
 <1442968663-31843-2-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <CAL_JsqJM=hUc5gnZrRO8GoyhE4mh24QtStSAoa5KwV_vYSpRJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 22, 2015 at 7:37 PM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> By default, early_init_dt_add_memory_arch() ignores memory below
> the base of the kernel image since it won't be addressable via the
> linear mapping. However, this is not appropriate anymore once we
> decouple the kernel text mapping from the linear mapping, so archs
> may want to drop the low limit entirely. So allow the minimum to be
> overridden by setting MIN_MEMBLOCK_ADDR.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Acked-by: Rob Herring <robh@kernel.org>

> ---
>  drivers/of/fdt.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 6e82bc42373b..5e7ef800a816 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -967,13 +967,16 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
>  }
>
>  #ifdef CONFIG_HAVE_MEMBLOCK
> +#ifndef MIN_MEMBLOCK_ADDR
> +#define MIN_MEMBLOCK_ADDR      __pa(PAGE_OFFSET)
> +#endif
>  #ifndef MAX_MEMBLOCK_ADDR
>  #define MAX_MEMBLOCK_ADDR      ((phys_addr_t)~0)
>  #endif
>
>  void __init __weak early_init_dt_add_memory_arch(u64 base, u64 size)
>  {
> -       const u64 phys_offset = __pa(PAGE_OFFSET);
> +       const u64 phys_offset = MIN_MEMBLOCK_ADDR;
>
>         if (!PAGE_ALIGNED(base)) {
>                 if (size < PAGE_SIZE - (base & ~PAGE_MASK)) {
> --
> 1.9.1
>
