From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 16 Mar 2017 10:12:11 +0100
Subject: [PATCH] mtd: nand: orion: fix clk handling
In-Reply-To: <20170313071241.y5ydl274t22awrys@pengutronix.de>
References: <20170312213406.20987-1-gmbnomis@gmail.com>
 <20170313071241.y5ydl274t22awrys@pengutronix.de>
Message-ID: <20170316101211.332a53e0@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 13 Mar 2017 08:12:41 +0100
Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> wrote:

> Hello Simon,
> 
> On Sun, Mar 12, 2017 at 10:34:06PM +0100, Simon Baatz wrote:
> > The clk handling in orion_nand.c had two problems:
> > 
> > - In the probe function, clk_put() was called for an enabled clock,
> >   which violates the API (see documentation for clk_put() in
> >   include/linux/clk.h)
> > 
> > - In the error path of the probe function, clk_put() could be called
> >   twice for the same clock.
> > 
> > In order to clean this up, use the managed function devm_clk_get() and
> > store the pointer to the clk in the driver data.
> > 
> > Fixes: baffab28b13120694fa3ebab08d3e99667a851d2 ('ARM: Orion: fix driver probe error handling with respect to clk')
> > Cc: <stable@vger.kernel.org> # v4.5+
> > Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
> > ---
> >  drivers/mtd/nand/orion_nand.c | 42 +++++++++++++++++++++---------------------
> >  1 file changed, 21 insertions(+), 21 deletions(-)
> > 
> > diff --git a/drivers/mtd/nand/orion_nand.c b/drivers/mtd/nand/orion_nand.c
> > index 4a91c5d000be..b355aa738fae 100644
> > --- a/drivers/mtd/nand/orion_nand.c
> > +++ b/drivers/mtd/nand/orion_nand.c
> > @@ -23,6 +23,11 @@
> >  #include <asm/sizes.h>
> >  #include <linux/platform_data/mtd-orion_nand.h>
> >  
> > +struct orion_nand_info {
> > +	struct nand_chip chip;
> > +	struct clk       *clk;
> > +};
> > +
> >  static void orion_nand_cmd_ctrl(struct mtd_info *mtd, int cmd, unsigned int ctrl)
> >  {
> >  	struct nand_chip *nc = mtd_to_nand(mtd);
> > @@ -75,20 +80,21 @@ static void orion_nand_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
> >  
> >  static int __init orion_nand_probe(struct platform_device *pdev)
> >  {
> > +	struct orion_nand_info *info;
> >  	struct mtd_info *mtd;
> >  	struct nand_chip *nc;
> >  	struct orion_nand_data *board;
> >  	struct resource *res;
> > -	struct clk *clk;
> >  	void __iomem *io_base;
> >  	int ret = 0;
> >  	u32 val = 0;
> >  
> > -	nc = devm_kzalloc(&pdev->dev,
> > -			sizeof(struct nand_chip),
> > +	info = devm_kzalloc(&pdev->dev,
> > +			sizeof(struct orion_nand_info),
> >  			GFP_KERNEL);
> > -	if (!nc)
> > +	if (!info)
> >  		return -ENOMEM;
> > +	nc = &info->chip;
> >  	mtd = nand_to_mtd(nc);
> >  
> >  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > @@ -145,15 +151,13 @@ static int __init orion_nand_probe(struct platform_device *pdev)
> >  	if (board->dev_ready)
> >  		nc->dev_ready = board->dev_ready;
> >  
> > -	platform_set_drvdata(pdev, mtd);
> > +	platform_set_drvdata(pdev, info);
> >  
> >  	/* Not all platforms can gate the clock, so it is not
> >  	   an error if the clock does not exists. */
> > -	clk = clk_get(&pdev->dev, NULL);
> > -	if (!IS_ERR(clk)) {
> > -		clk_prepare_enable(clk);
> > -		clk_put(clk);
> > -	}
> > +	info->clk = devm_clk_get(&pdev->dev, NULL);
> > +	if (!IS_ERR(info->clk))
> > +		clk_prepare_enable(info->clk);  
> 
> Orthogonal to your patch I suggest:
> 
> -	info->clk = devm_clk_get(&pdev->dev, NULL);
> -	if (!IS_ERR(info->clk))
> -		clk_prepare_enable(info->clk);
> +	info->clk = devm_clk_get_optional(&pdev->dev, NULL);
> +	if (IS_ERR(info->clk)) {
> +		ret = PTR_ERR(info->clk);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(...);
> +		return ret;
> +	}
> 

In the meantime, maybe you can do:

	info->clk = devm_clk_get(&pdev->dev, NULL);
	if (IS_ERR(info->clk)) {
		ret = PTR_ERR(info->clk);

		if (ret == -ENOENT) {
			/*
			 * This clk is optional, assign it to NULL when
			 * it's not present.
			 */
			info->clk = NULL;
		} else {
			if (ret == -EPROBE_DEFER)
				dev_err(...);

			return ret;
		}
	}

This way, you won't have to check the info->clk value when you call
clk_prepare_enable() or clk_disable_unprepare().
