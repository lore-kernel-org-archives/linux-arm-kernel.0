From: shweta.gulati@ti.com (Gulati, Shweta)
Date: Mon, 31 Jan 2011 10:31:27 +0530
Subject: [PATCH] arm: Fix possible memory leak
In-Reply-To: <1296415587-4524-1-git-send-email-weil@mail.berlios.de>
References: <1296415587-4524-1-git-send-email-weil@mail.berlios.de>
Message-ID: <AANLkTi=iqgCG_ZyzZ-EoPu6OGxtnJc0CRrLDPHOQZ90-@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked. Will make sure there is no Memory Leak issue in Smartreflex Driver.

On Mon, Jan 31, 2011 at 12:56 AM, Stefan Weil <weil@mail.berlios.de> wrote:
> sr_info was allocated and needs a kfree before returning.
>
> This error was reported by cppcheck:
> arch/arm/mach-omap2/smartreflex.c:837: error: Memory leak: sr_info
>
> To: Tony Lindgren <tony@atomide.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: linux-omap at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> Signed-off-by: Stefan Weil <weil@mail.berlios.de>
> ---
> ?arch/arm/mach-omap2/smartreflex.c | ? ?3 ++-
> ?1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
> index af39d17..07324607 100644
> --- a/arch/arm/mach-omap2/smartreflex.c
> +++ b/arch/arm/mach-omap2/smartreflex.c
> @@ -832,7 +832,8 @@ static int __init omap_sr_probe(struct platform_device *pdev)
>
> ? ? ? ?if (!pdata) {
> ? ? ? ? ? ? ? ?dev_err(&pdev->dev, "%s: platform data missing\n", __func__);
> - ? ? ? ? ? ? ? return -EINVAL;
> + ? ? ? ? ? ? ? ret = -EINVAL;
> + ? ? ? ? ? ? ? goto err_free_devinfo;
> ? ? ? ?}
>
> ? ? ? ?mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> --
> 1.7.2.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>


-- 
Thanks,
Regards,
Shweta
