From: grinberg@compulab.co.il (Igor Grinberg)
Date: Mon, 27 Jun 2011 16:22:05 +0300
Subject: [PATCH] MTD: pxa3xx_nand: enable multiple chip select support
In-Reply-To: <1309000666-5242-1-git-send-email-leiwen@marvell.com>
References: <4E031900.50108@compulab.co.il>
	<1309000666-5242-1-git-send-email-leiwen@marvell.com>
Message-ID: <4E0883FD.3080707@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/25/11 14:17, Lei Wen wrote:

> Current pxa3xx_nand controller has two chip select which
> both be workable. This patch enable this feature.
>
> Update platform driver to support this feature.
>
> Another notice should be taken that:
> When you want to use this feature, you should not enable the
> keep configuration feature, for two chip select could be
> attached with different nand chip. The different page size
> and timing requirement make the keep configuration impossible.
>
> Signed-off-by: Lei Wen <leiwen@marvell.com>
> ---
>  arch/arm/mach-mmp/aspenite.c                 |    5 +-
>  arch/arm/mach-pxa/cm-x300.c                  |    5 +-
>  arch/arm/mach-pxa/colibri-pxa3xx.c           |    5 +-
>  arch/arm/mach-pxa/littleton.c                |    5 +-
>  arch/arm/mach-pxa/mxm8x10.c                  |    9 +-
>  arch/arm/mach-pxa/raumfeld.c                 |    5 +-
>  arch/arm/mach-pxa/zylonite.c                 |    5 +-
>  arch/arm/plat-pxa/include/plat/pxa3xx_nand.h |   19 +-
>  drivers/mtd/nand/pxa3xx_nand.c               |  512 +++++++++++++++-----------
>  9 files changed, 346 insertions(+), 224 deletions(-)

~100 lines less - nice!

[...]

> diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
> index b7db1b2..0825b7d 100644
> --- a/drivers/mtd/nand/pxa3xx_nand.c
> +++ b/drivers/mtd/nand/pxa3xx_nand.c

[...]

> @@ -616,7 +627,7 @@ static int prepare_command_pool(struct pxa3xx_nand_info *info, int command,
>  
>  	default:
>  		exec_cmd = 0;
> -		printk(KERN_ERR "pxa3xx-nand: non-supported"
> +		dev_err(&info->pdev->dev, "pxa3xx-nand: non-supported"

If you use dev_err(), why do you still need pxa3xx-nand in the message?


-- 
Regards,
Igor.
