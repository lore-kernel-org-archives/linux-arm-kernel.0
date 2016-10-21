From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 21 Oct 2016 10:22:28 +0200
Subject: [PATCH 1/2] mmc: mediatek: Fix module autoload
In-Reply-To: <1476720825-30442-1-git-send-email-javier@osg.samsung.com>
References: <1476720825-30442-1-git-send-email-javier@osg.samsung.com>
Message-ID: <CAPDyKFpNPdcQnWs59MiVGnv5FMYjfgR9F4OCiCWhnmkh7EcyCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 October 2016 at 18:13, Javier Martinez Canillas
<javier@osg.samsung.com> wrote:
> If the driver is built as a module, autoload won't work because the module
> alias information is not filled. So user-space can't match the registered
> device with the corresponding module.
>
> Export the module alias information using the MODULE_DEVICE_TABLE() macro.
>
> Before this patch:
>
> $ modinfo drivers/mmc/host/mtk-sd.ko | grep alias
> $
>
> After this patch:
>
> $ modinfo drivers/mmc/host/mtk-sd.ko | grep alias
> alias:          of:N*T*Cmediatek,mt8135-mmcC*
> alias:          of:N*T*Cmediatek,mt8135-mmc
>
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>
>  drivers/mmc/host/mtk-sd.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 84e9afcb5c09..86af0b199a54 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -1713,6 +1713,7 @@ static const struct of_device_id msdc_of_ids[] = {
>         {   .compatible = "mediatek,mt8135-mmc", },
>         {}
>  };
> +MODULE_DEVICE_TABLE(of, msdc_of_ids);
>
>  static struct platform_driver mt_msdc_driver = {
>         .probe = msdc_drv_probe,
> --
> 2.7.4
>
