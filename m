From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 19 Sep 2017 22:13:15 +0200
Subject: [PATCH] mtd: nand: lpc32xx_mlc: Fix an error handling path in
 lpc32xx_nand_probe()
In-Reply-To: <20170903115831.1326-1-christophe.jaillet@wanadoo.fr>
References: <20170903115831.1326-1-christophe.jaillet@wanadoo.fr>
Message-ID: <20170919221315.11d94426@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun,  3 Sep 2017 13:58:31 +0200
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> If 'clk_prepare_enable()' fails, we must 'put' the corresponding clock.
> 
> Fixes: 4d26f012ab59 ("mtd: nand: lpc32xx_mlc: Handle return value of clk_prepare_enable.")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied.

Thanks,

Boris

> ---
> Labels in the error handling path could be renamed, but it does not worth
> the effort, IMHO.
> ---
>  drivers/mtd/nand/lpc32xx_mlc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/lpc32xx_mlc.c b/drivers/mtd/nand/lpc32xx_mlc.c
> index c3bb358ef01e..5f72a824e67d 100644
> --- a/drivers/mtd/nand/lpc32xx_mlc.c
> +++ b/drivers/mtd/nand/lpc32xx_mlc.c
> @@ -707,7 +707,7 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
>  	}
>  	res = clk_prepare_enable(host->clk);
>  	if (res)
> -		goto err_exit1;
> +		goto err_put_clk;
>  
>  	nand_chip->cmd_ctrl = lpc32xx_nand_cmd_ctrl;
>  	nand_chip->dev_ready = lpc32xx_nand_device_ready;
> @@ -814,6 +814,7 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
>  		dma_release_channel(host->dma_chan);
>  err_exit2:
>  	clk_disable_unprepare(host->clk);
> +err_put_clk:
>  	clk_put(host->clk);
>  err_exit1:
>  	lpc32xx_wp_enable(host);
