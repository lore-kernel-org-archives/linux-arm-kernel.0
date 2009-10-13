From: ben@fluff.org (Ben Dooks)
Date: Tue, 13 Oct 2009 23:41:23 +0100
Subject: [PATCH 07/16] i2c-designware: Set a clock name to DesignWare
	I2C clock source
In-Reply-To: <4AD3EB09.8050304@necel.com>
References: <4AD3E974.8080200@necel.com>
 <4AD3EB09.8050304@necel.com>
Message-ID: <20091013224123.GB13398@fluff.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 13, 2009 at 11:50:49AM +0900, Shinya Kuribayashi wrote:
> This driver is originally prepared for the ARM kernel where rich and
> well-maintained "clkdev" clock framework is available, and clock name
> might not be strictly required.  ARM's clkdev does slightly fuzzy
> matching where it basically gives preference to "struct device" mathing
> over "clock id".  As long as used for ARM machines, there's no problem.
> 
> However, all users of this driver necessarily don't have the same clk
> framework with ARM's, as the clk I/F implementation varies depending on
> ARCHs and machines.
> 
> This patch adds a clock name so that other users with simple/minimum/
> limited clk support could make use of the driver.

You're meant to match with both the device and name, I belive the
clkdev specification has always said this. I'm of the opinion if
the clkdev implementation isn't getting this right, then it is the
clkdev that should be fixed, not this driver.
 
> Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi@necel.com>
> ---
> drivers/i2c/busses/i2c-designware.c |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-designware.c b/drivers/i2c/busses/i2c-designware.c
> index 9d81775..0f8bd4c 100644
> --- a/drivers/i2c/busses/i2c-designware.c
> +++ b/drivers/i2c/busses/i2c-designware.c
> @@ -575,7 +575,7 @@ static int __devinit dw_i2c_probe(struct platform_device *pdev)
> 	dev->irq = irq;
> 	platform_set_drvdata(pdev, dev);
> 
> -	dev->clk = clk_get(&pdev->dev, NULL);
> +	dev->clk = clk_get(&pdev->dev, "dw_i2c_clk");
> 	if (IS_ERR(dev->clk)) {
> 		r = -ENODEV;
> 		goto err_free_mem;

-- 
Ben (ben at fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
