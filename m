From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Sat, 7 Jul 2018 08:58:22 +0200
Subject: [PATCH v3] mtd: nxp-spifi: release flash_np in nxp_spifi_probe()
In-Reply-To: <1525878680-22005-1-git-send-email-khoroshilov@ispras.ru>
References: <20180509170310.65d19c49@bbrezillon>
 <1525878680-22005-1-git-send-email-khoroshilov@ispras.ru>
Message-ID: <20180707085822.0daad388@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed,  9 May 2018 18:11:20 +0300
Alexey Khoroshilov <khoroshilov@ispras.ru> wrote:

> nxp_spifi_probe() increments refcnt of SPI flash device node by
> of_get_next_available_child() and leaves it undecremented on both
> successful and error paths.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>

Applied after fixing the subject prefix.

> ---
> v3: Move of_node_put() before return value check as Boris Brezillon suggested.
> 
>  drivers/mtd/spi-nor/nxp-spifi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mtd/spi-nor/nxp-spifi.c b/drivers/mtd/spi-nor/nxp-spifi.c
> index 15374216d4d9..0c9094ec5966 100644
> --- a/drivers/mtd/spi-nor/nxp-spifi.c
> +++ b/drivers/mtd/spi-nor/nxp-spifi.c
> @@ -436,6 +436,7 @@ static int nxp_spifi_probe(struct platform_device *pdev)
>  	}
>  
>  	ret = nxp_spifi_setup_flash(spifi, flash_np);
> +	of_node_put(flash_np);
>  	if (ret) {
>  		dev_err(&pdev->dev, "unable to setup flash chip\n");
>  		goto dis_clks;
