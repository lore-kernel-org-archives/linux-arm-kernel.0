From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 31 Jul 2017 18:28:40 +0200
Subject: [PATCH] mtd: nand: sunxi: fix potential divide-by-zero error
In-Reply-To: <1501248177-575-1-git-send-email-pure.logic@nexus-software.ie>
References: <1501248177-575-1-git-send-email-pure.logic@nexus-software.ie>
Message-ID: <20170731182840.4cdca90d@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 28 Jul 2017 14:22:57 +0100
Bryan O'Donoghue <pure.logic@nexus-software.ie> wrote:

> clk_round_rate() can return <= 0. Currently the value returned by
> clk_round_rate() is used directly for a division. This patch introduces a
> guard to ensure a divide-by-zero or a divide by a negative number for that
> matter can't happen by bugging out returning -EINVAL if clk_round_rate()
> returns <= 0.

Applied to nand/fixes.

Thanks,

Boris

> 
> Fixes: 2d43457f79e4 ("mtd: nand: sunxi: fix EDO mode selection")
> 
> Signed-off-by: Bryan O'Donoghue <pure.logic@nexus-software.ie>
> ---
>  drivers/mtd/nand/sunxi_nand.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
> index d0b6f8f..6abd142 100644
> --- a/drivers/mtd/nand/sunxi_nand.c
> +++ b/drivers/mtd/nand/sunxi_nand.c
> @@ -1728,6 +1728,10 @@ static int sunxi_nfc_setup_data_interface(struct mtd_info *mtd, int csline,
>  	 */
>  	chip->clk_rate = NSEC_PER_SEC / min_clk_period;
>  	real_clk_rate = clk_round_rate(nfc->mod_clk, chip->clk_rate);
> +	if (real_clk_rate <= 0) {
> +		dev_err(nfc->dev, "Unable to round clk %lu\n", chip->clk_rate);
> +		return -EINVAL;
> +	}
>  
>  	/*
>  	 * ONFI specification 3.1, paragraph 4.15.2 dictates that EDO data
