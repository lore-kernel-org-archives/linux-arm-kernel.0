From: robh@kernel.org (Rob Herring)
Date: Thu, 16 Jan 2014 10:04:34 -0600
Subject: [PATCH REPOST] ARM: Fix incorrect FDT initrd parameter override
In-Reply-To: <deeb5f$5527t1@icp-osb-irony-out2.iinet.net.au>
References: <deeb5f$5527t1@icp-osb-irony-out2.iinet.net.au>
Message-ID: <CAL_JsqJNPbQVKtW0amaOSc1is9oKrGapaHR=YJGJy6TrGQeKYw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 11, 2014 at 6:20 PM,  <klightspeed@killerwolves.net> wrote:
> Commit 65939301acdb (arm: set initrd_start/initrd_end for fdt scan)
> caused the FDT initrd_start and initrd_end to override the
> phys_initrd_start and phys_initrd_size set by the initrd= kernel
> parameter.  With this patch initrd_start and initrd_end will be
> overridden if phys_initrd_start and phys_initrd_size are set by the
> kernel initrd= parameter.
>
> Signed-off-by: Ben Peddell <klightspeed@killerwolves.net>

I'd really like to see phys_initrd_* removed, but that would be more
invasive, so:

Acked-by: Rob Herring <robh@kernel.org>

Please submit to Russell's patch system and mark for stable. I don't
think there is time before 3.13 is released.

Rob

> ---
>  arch/arm/mm/init.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> index 1f7b19a..819c539 100644
> --- a/arch/arm/mm/init.c
> +++ b/arch/arm/mm/init.c
> @@ -345,10 +345,11 @@ void __init arm_memblock_init(struct meminfo *mi,
>  #endif
>  #ifdef CONFIG_BLK_DEV_INITRD
>         /* FDT scan will populate initrd_start */
> -       if (initrd_start) {
> +       if (initrd_start && !phys_initrd_size) {
>                 phys_initrd_start = __virt_to_phys(initrd_start);
>                 phys_initrd_size = initrd_end - initrd_start;
>         }
> +       initrd_start = initrd_end = 0;
>         if (phys_initrd_size &&
>             !memblock_is_region_memory(phys_initrd_start, phys_initrd_size)) {
>                 pr_err("INITRD: 0x%08llx+0x%08lx is not a memory region - disabling initrd\n",
> --
> 1.8.3.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
