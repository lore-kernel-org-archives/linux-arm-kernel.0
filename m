From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 24 Oct 2011 13:56:49 +0200
Subject: [RFC 4/4] watchdog: imx2: simplify resource allocation
In-Reply-To: <1319445729-14841-5-git-send-email-w.sang@pengutronix.de>
References: <1319445729-14841-1-git-send-email-w.sang@pengutronix.de>
	<1319445729-14841-5-git-send-email-w.sang@pengutronix.de>
Message-ID: <20111024115649.GM8708@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 24, 2011 at 10:42:09AM +0200, Wolfram Sang wrote:
> Use the new devm_resource_to_mapped_ptr function to simplify the code
> and standardize the error-handling. Silently fixes a wrong type for the
> resource_size variable as well.
> 
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> ---
>  drivers/watchdog/imx2_wdt.c |   22 +++-------------------
>  1 files changed, 3 insertions(+), 19 deletions(-)

w00t!  I can see a lot of drivers simplified by using this.

g.

> 
> diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
> index b8ef2c6..1fc6714 100644
> --- a/drivers/watchdog/imx2_wdt.c
> +++ b/drivers/watchdog/imx2_wdt.c
> @@ -247,28 +247,12 @@ static struct miscdevice imx2_wdt_miscdev = {
>  static int __init imx2_wdt_probe(struct platform_device *pdev)
>  {
>  	int ret;
> -	int res_size;
>  	struct resource *res;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!res) {
> -		dev_err(&pdev->dev, "can't get device resources\n");
> -		return -ENODEV;
> -	}
> -
> -	res_size = resource_size(res);
> -	if (!devm_request_mem_region(&pdev->dev, res->start, res_size,
> -		res->name)) {
> -		dev_err(&pdev->dev, "can't allocate %d bytes at %d address\n",
> -			res_size, res->start);
> -		return -ENOMEM;
> -	}
> -
> -	imx2_wdt.base = devm_ioremap_nocache(&pdev->dev, res->start, res_size);
> -	if (!imx2_wdt.base) {
> -		dev_err(&pdev->dev, "ioremap failed\n");
> -		return -ENOMEM;
> -	}
> +	ret = devm_resource_to_mapped_ptr(&pdev->dev, res, &imx2_wdt.base);
> +	if (ret)
> +		return ret;
>  
>  	imx2_wdt.clk = clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(imx2_wdt.clk)) {
> -- 
> 1.7.6.3
> 
