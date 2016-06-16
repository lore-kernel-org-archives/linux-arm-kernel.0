From: keescook@chromium.org (Kees Cook)
Date: Thu, 16 Jun 2016 10:20:07 -0700
Subject: [PATCH 1/2] ARM: drop kernel segment resources from /proc/iomem
In-Reply-To: <1466080138-12193-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1466080138-12193-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <CAGXu5jLvcSv_GjAB3PKObcBHNX6B45RaO6D0sCj7zSRqdCSFFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 16, 2016 at 5:28 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> By the same reasoning as commit c4004b02f8e5 ("x86: remove the kernel
> code/data/bss resources from /proc/iomem"), the kernel code and kernel
> data entries in /proc/iomem probably do more harm than good on ARM as
> well. So remove them.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm/kernel/setup.c | 26 --------------------------
>  1 file changed, 26 deletions(-)
>
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index 7b5350060612..839797c4b454 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -171,24 +171,10 @@ static struct resource mem_res[] = {
>                 .start = 0,
>                 .end = 0,
>                 .flags = IORESOURCE_MEM
> -       },
> -       {
> -               .name = "Kernel code",
> -               .start = 0,
> -               .end = 0,
> -               .flags = IORESOURCE_SYSTEM_RAM
> -       },
> -       {
> -               .name = "Kernel data",
> -               .start = 0,
> -               .end = 0,
> -               .flags = IORESOURCE_SYSTEM_RAM
>         }
>  };
>
>  #define video_ram   mem_res[0]
> -#define kernel_code mem_res[1]
> -#define kernel_data mem_res[2]
>
>  static struct resource io_res[] = {
>         {
> @@ -843,11 +829,6 @@ static void __init request_standard_resources(const struct machine_desc *mdesc)
>         struct memblock_region *region;
>         struct resource *res;
>
> -       kernel_code.start   = virt_to_phys(_text);
> -       kernel_code.end     = virt_to_phys(_etext - 1);
> -       kernel_data.start   = virt_to_phys(_sdata);
> -       kernel_data.end     = virt_to_phys(_end - 1);
> -
>         for_each_memblock(memory, region) {
>                 res = memblock_virt_alloc(sizeof(*res), 0);
>                 res->name  = "System RAM";
> @@ -856,13 +837,6 @@ static void __init request_standard_resources(const struct machine_desc *mdesc)
>                 res->flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
>
>                 request_resource(&iomem_resource, res);
> -
> -               if (kernel_code.start >= res->start &&
> -                   kernel_code.end <= res->end)
> -                       request_resource(res, &kernel_code);
> -               if (kernel_data.start >= res->start &&
> -                   kernel_data.end <= res->end)
> -                       request_resource(res, &kernel_data);
>         }
>
>         if (mdesc->video_start) {
> --
> 1.9.1
>

NAK, this is needed by kexec among other things.
c4004b02f8e5b9ce357a0bb1641756cc86962664 was reverted in
4046d6e81f33b7ef50d6668b78076d54c5e066b6.

-Kees

-- 
Kees Cook
Chrome OS & Brillo Security
