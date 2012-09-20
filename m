From: josh.wu@atmel.com (Josh Wu)
Date: Thu, 20 Sep 2012 10:03:32 +0800
Subject: [PATCH v2] mtd: atmel_nand: fix the compile error which miss
 label "err_ecc_ioremap".
In-Reply-To: <1347347412-24214-1-git-send-email-josh.wu@atmel.com>
References: <1347347412-24214-1-git-send-email-josh.wu@atmel.com>
Message-ID: <505A7974.9060108@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Artem

Do you have any feedback since there is a long time about this patch?

Best Regards,
Josh Wu

On 9/11/2012 3:10 PM, Josh Wu wrote:
> Add err_ecc_ioremap label to fix following errors:
> ---8<---
>    CC      drivers/mtd/nand/atmel_nand.o
> drivers/mtd/nand/atmel_nand.c: In function 'atmel_nand_probe':
> drivers/mtd/nand/atmel_nand.c:1423: error: label 'err_ecc_ioremap' used but not defined
> make[3]: *** [drivers/mtd/nand/atmel_nand.o] Error 1
> make[2]: *** [drivers/mtd/nand] Error 2
> make[1]: *** [drivers/mtd] Error 2
> make: *** [drivers] Error 2
> --->8---
>
> This error was introduced in b654a9a46fc2100b318050483f8c5b5d0f187303 (mtd: atmel nand: fix gpio missing request)
>
> Signed-off-by: Josh Wu <josh.wu@atmel.com>
> ---
> change logs:
>    Add detail information for the commit message.
>
>   drivers/mtd/nand/atmel_nand.c |    3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
> index 6a5a35b..9144557 100644
> --- a/drivers/mtd/nand/atmel_nand.c
> +++ b/drivers/mtd/nand/atmel_nand.c
> @@ -1399,7 +1399,7 @@ static int __init atmel_nand_probe(struct platform_device *pdev)
>   	if (pdev->dev.of_node) {
>   		res = atmel_of_init_port(host, pdev->dev.of_node);
>   		if (res)
> -			goto err_nand_ioremap;
> +			goto err_ecc_ioremap;
>   	} else {
>   		memcpy(&host->board, pdev->dev.platform_data,
>   		       sizeof(struct atmel_nand_data));
> @@ -1560,6 +1560,7 @@ err_no_card:
>   	platform_set_drvdata(pdev, NULL);
>   	if (host->dma_chan)
>   		dma_release_channel(host->dma_chan);
> +err_ecc_ioremap:
>   	iounmap(host->io_base);
>   err_nand_ioremap:
>   	kfree(host);
