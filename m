From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 12 Nov 2013 10:50:07 -0500
Subject: [PATCH 02/12] mtd: nand: davinci: check required ti,
 davinci-chipselect property
In-Reply-To: <4F5844B3A985794BA902E12C070812375F8CEF@DNCE04.ent.ti.com>
References: <1384187188-5776-1-git-send-email-ivan.khoronzhuk@ti.com>,
 <1384187188-5776-3-git-send-email-ivan.khoronzhuk@ti.com>
 <4F5844B3A985794BA902E12C070812375F8CEF@DNCE04.ent.ti.com>
Message-ID: <52824E2F.9090302@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 11 November 2013 11:53 AM, Khoronzhuk, Ivan wrote:
> The property "ti,davinci-chipselect" is required. So we have to check
> if it is set.
> 
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
> ---
>  drivers/mtd/nand/davinci_nand.c |   10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/davinci_nand.c b/drivers/mtd/nand/davinci_nand.c
> index d87213f..8e1c88e 100644
> --- a/drivers/mtd/nand/davinci_nand.c
> +++ b/drivers/mtd/nand/davinci_nand.c
> @@ -541,10 +541,14 @@ static struct davinci_nand_pdata
>                                 GFP_KERNEL);
>                 pdev->dev.platform_data = pdata;
>                 if (!pdata)
> -                       return NULL;
> +                       return ERR_PTR(-ENOMEM);
> +
This change don't follow commit message.

>                 if (!of_property_read_u32(pdev->dev.of_node,
>                         "ti,davinci-chipselect", &prop))
>                         pdev->id = prop;
> +               else
> +                       return ERR_PTR(-EINVAL);
> +
So the check already exist but the error case wasn't handled.
This should be reflected in change log.

>                 if (!of_property_read_u32(pdev->dev.of_node,
>                         "ti,davinci-mask-ale", &prop))
>                         pdata->mask_ale = prop;
> @@ -598,6 +602,10 @@ static int __init nand_davinci_probe(struct platform_device *pdev)
>         nand_ecc_modes_t                ecc_mode;
> 
>         pdata = nand_davinci_get_pdata(pdev);
> +       if (IS_ERR(pdata)) {
> +               return PTR_ERR(pdata);
> +       }
> +
Again not related to commit log. You might want to split this patch
then.

Regards,
Santosh
