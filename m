From: kishon@ti.com (kishon)
Date: Thu, 31 Jan 2013 19:44:27 +0530
Subject: [PATCH 1/2] USB mxs-phy: Register phy with framework
In-Reply-To: <1359631937-26646-2-git-send-email-s.hauer@pengutronix.de>
References: <1359631937-26646-1-git-send-email-s.hauer@pengutronix.de>
 <1359631937-26646-2-git-send-email-s.hauer@pengutronix.de>
Message-ID: <510A7C43.1080709@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 31 January 2013 05:02 PM, Sascha Hauer wrote:
> We now have usb_add_phy_dev(), so use it to register with the framework
> to be able to find the phy from the USB driver.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Reviewed-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>   drivers/usb/otg/mxs-phy.c |    9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/drivers/usb/otg/mxs-phy.c b/drivers/usb/otg/mxs-phy.c
> index 5158332..5b39885 100644
> --- a/drivers/usb/otg/mxs-phy.c
> +++ b/drivers/usb/otg/mxs-phy.c
> @@ -127,6 +127,7 @@ static int mxs_phy_probe(struct platform_device *pdev)
>   	void __iomem *base;
>   	struct clk *clk;
>   	struct mxs_phy *mxs_phy;
> +	int ret;
>
>   	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>   	if (!res) {
> @@ -166,11 +167,19 @@ static int mxs_phy_probe(struct platform_device *pdev)
>
>   	platform_set_drvdata(pdev, &mxs_phy->phy);
>
> +	ret = usb_add_phy_dev(&mxs_phy->phy);
> +	if (ret)
> +		return ret;
> +
>   	return 0;
>   }
>
>   static int mxs_phy_remove(struct platform_device *pdev)
>   {
> +	struct mxs_phy *mxs_phy = platform_get_drvdata(pdev);
> +
> +	usb_remove_phy(&mxs_phy->phy);
> +
>   	platform_set_drvdata(pdev, NULL);
>
>   	return 0;
>
