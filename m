From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Tue, 30 Jul 2013 10:08:26 +0530
Subject: [PATCH] ARM: SAMSUNG: fix to support for missing cpu specific
 map_io
In-Reply-To: <190501ce8cdd$2abd6780$80383680$%kim@samsung.com>
References: <190501ce8cdd$2abd6780$80383680$%kim@samsung.com>
Message-ID: <CAK9yfHwMANp2TfQWHQVXGZ2C-t-KrwGHJOpFT+hedDFYTDng6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 July 2013 09:57, Kukjin Kim <kgene.kim@samsung.com> wrote:
>
> Since commit 7ed76e08 (ARM: EXYNOS: Fix low level debug support)
> map_io() is not needed for exynos5440 so need to fix to lookup
> cpu which using map_io(). Without this, kernel boot log complains
> 'CPU EXYNOS5440 support not enabled' on exynos5440 and panic().
>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
>  arch/arm/plat-samsung/init.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/plat-samsung/init.c b/arch/arm/plat-samsung/init.c
> index 3e5c461..50a3ea0 100644
> --- a/arch/arm/plat-samsung/init.c
> +++ b/arch/arm/plat-samsung/init.c
> @@ -55,12 +55,13 @@ void __init s3c_init_cpu(unsigned long idcode,
>
>         printk("CPU %s (id 0x%08lx)\n", cpu->name, idcode);
>
> -       if (cpu->map_io == NULL || cpu->init == NULL) {
> +       if (cpu->init == NULL) {
>                 printk(KERN_ERR "CPU %s support not enabled\n", cpu->name);
>                 panic("Unsupported Samsung CPU");

While at it you could probably remove the printk and have that message
printed by panic instead?

-- 
With warm regards,
Sachin
