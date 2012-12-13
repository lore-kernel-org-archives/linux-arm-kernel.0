From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 13 Dec 2012 10:11:16 +0100
Subject: [PATCH 1/2] amba: create a resource parent registrator
In-Reply-To: <1354141000-22942-1-git-send-email-linus.walleij@linaro.org>
References: <1354141000-22942-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <CAPDyKFpC6OErmbKe2nsvfk4cZW0pMKrZ-tcO5e9uwaQ3RkGuFg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 November 2012 23:16, Linus Walleij <linus.walleij@linaro.org> wrote:
> This creates amba_apb_device_add_res() and
> amba_ahb_device_add_res() respectively, to add devices with
> another parent than iomem_resource. This is needed to specify
> that a device is contained in a specific IO range.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/amba/bus.c       | 32 ++++++++++++++++++++++++++++----
>  include/linux/amba/bus.h | 10 ++++++++++
>  2 files changed, 38 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> index e8eb91b..a2fc56d 100644
> --- a/drivers/amba/bus.c
> +++ b/drivers/amba/bus.c
> @@ -546,7 +546,8 @@ EXPORT_SYMBOL_GPL(amba_device_add);
>  static struct amba_device *
>  amba_aphb_device_add(struct device *parent, const char *name,
>                      resource_size_t base, size_t size, int irq1, int irq2,
> -                    void *pdata, unsigned int periphid, u64 dma_mask)
> +                    void *pdata, unsigned int periphid, u64 dma_mask,
> +                    struct resource *resbase)
>  {
>         struct amba_device *dev;
>         int ret;
> @@ -563,7 +564,7 @@ amba_aphb_device_add(struct device *parent, const char *name,
>         dev->dev.platform_data = pdata;
>         dev->dev.parent = parent;
>
> -       ret = amba_device_add(dev, &iomem_resource);
> +       ret = amba_device_add(dev, resbase);
>         if (ret) {
>                 amba_device_put(dev);
>                 return ERR_PTR(ret);
> @@ -578,7 +579,7 @@ amba_apb_device_add(struct device *parent, const char *name,
>                     void *pdata, unsigned int periphid)
>  {
>         return amba_aphb_device_add(parent, name, base, size, irq1, irq2, pdata,
> -                                   periphid, 0);
> +                                   periphid, 0, &iomem_resource);
>  }
>  EXPORT_SYMBOL_GPL(amba_apb_device_add);
>
> @@ -588,10 +589,33 @@ amba_ahb_device_add(struct device *parent, const char *name,
>                     void *pdata, unsigned int periphid)
>  {
>         return amba_aphb_device_add(parent, name, base, size, irq1, irq2, pdata,
> -                                   periphid, ~0ULL);
> +                                   periphid, ~0ULL, &iomem_resource);
>  }
>  EXPORT_SYMBOL_GPL(amba_ahb_device_add);
>
> +struct amba_device *
> +amba_apb_device_add_res(struct device *parent, const char *name,
> +                       resource_size_t base, size_t size, int irq1,
> +                       int irq2, void *pdata, unsigned int periphid,
> +                       struct resource *resbase)
> +{
> +       return amba_aphb_device_add(parent, name, base, size, irq1, irq2, pdata,
> +                                   periphid, 0, resbase);
> +}
> +EXPORT_SYMBOL_GPL(amba_apb_device_add_res);
> +
> +struct amba_device *
> +amba_ahb_device_add_res(struct device *parent, const char *name,
> +                       resource_size_t base, size_t size, int irq1,
> +                       int irq2, void *pdata, unsigned int periphid,
> +                       struct resource *resbase)
> +{
> +       return amba_aphb_device_add(parent, name, base, size, irq1, irq2, pdata,
> +                                   periphid, ~0ULL, resbase);
> +}
> +EXPORT_SYMBOL_GPL(amba_ahb_device_add_res);
> +
> +
>  static void amba_device_initialize(struct amba_device *dev, const char *name)
>  {
>         device_initialize(&dev->dev);
> diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
> index d364171..43ec7e2 100644
> --- a/include/linux/amba/bus.h
> +++ b/include/linux/amba/bus.h
> @@ -71,6 +71,16 @@ struct amba_device *amba_ahb_device_add(struct device *parent, const char *name,
>                                         resource_size_t base, size_t size,
>                                         int irq1, int irq2, void *pdata,
>                                         unsigned int periphid);
> +struct amba_device *
> +amba_apb_device_add_res(struct device *parent, const char *name,
> +                       resource_size_t base, size_t size, int irq1,
> +                       int irq2, void *pdata, unsigned int periphid,
> +                       struct resource *resbase);
> +struct amba_device *
> +amba_ahb_device_add_res(struct device *parent, const char *name,
> +                       resource_size_t base, size_t size, int irq1,
> +                       int irq2, void *pdata, unsigned int periphid,
> +                       struct resource *resbase);
>  void amba_device_unregister(struct amba_device *);
>  struct amba_device *amba_find_device(const char *, struct device *, unsigned int, unsigned int);
>  int amba_request_regions(struct amba_device *, const char *);
> --
> 1.7.11.7
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
