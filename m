From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 03 Dec 2013 21:01:38 +0300
Subject: [PATCH 3/3] usb: ohci-at91: use device managed clk retrieval
In-Reply-To: <1386079669-3995-4-git-send-email-b.brezillon@overkiz.com>
References: <1386079669-3995-1-git-send-email-b.brezillon@overkiz.com>
 <1386079669-3995-4-git-send-email-b.brezillon@overkiz.com>
Message-ID: <529E1C82.8070501@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 12/03/2013 05:07 PM, Boris BREZILLON wrote:

> Replace clk_get calls by devm_clk_get calls.

> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
> Tested-by: Robert Nelson <robertcnelson@gmail.com>
> ---
>   drivers/usb/host/ohci-at91.c |   32 ++++++++------------------------
>   1 file changed, 8 insertions(+), 24 deletions(-)

> diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
> index c406f1e..3652962 100644
> --- a/drivers/usb/host/ohci-at91.c
> +++ b/drivers/usb/host/ohci-at91.c
> @@ -164,30 +164,30 @@ static int usb_hcd_at91_probe(const struct hc_driver *driver,
>   		goto err;
>   	}
>
> -	iclk = clk_get(&pdev->dev, "ohci_clk");
> +	iclk = devm_clk_get(dev, "ohci_clk");
>   	if (IS_ERR(iclk)) {
> -		dev_err(&pdev->dev, "failed to get ohci_clk\n");
> +		dev_err(dev, "failed to get ohci_clk\n");

    You changed this call...

>   		retval = PTR_ERR(iclk);
>   		goto err;
>   	}
> -	fclk = clk_get(&pdev->dev, "uhpck");
> +	fclk = devm_clk_get(dev, "uhpck");
>   	if (IS_ERR(fclk)) {
>   		dev_err(&pdev->dev, "failed to get uhpck\n");

    ... but not this one.

>   		retval = PTR_ERR(fclk);
> -		goto err4;
> +		goto err;
>   	}
> -	hclk = clk_get(&pdev->dev, "hclk");
> +	hclk = devm_clk_get(dev, "hclk");
>   	if (IS_ERR(hclk)) {
>   		dev_err(&pdev->dev, "failed to get hclk\n");

    ... or this one. Actually, I think cganging these calls would be out of 
scope for this patch.

>   		retval = PTR_ERR(hclk);
> -		goto err5;
> +		goto err;
>   	}
>   	if (IS_ENABLED(CONFIG_COMMON_CLK)) {
> -		uclk = clk_get(&pdev->dev, "usb_clk");
> +		uclk = devm_clk_get(&pdev->dev, "usb_clk");

    Hm, why not 'dev' like in all of the above?

>   		if (IS_ERR(uclk)) {
>   			dev_err(&pdev->dev, "failed to get uclk\n");
>   			retval = PTR_ERR(uclk);
> -			goto err6;
> +			goto err;
>   		}
>   	}
>

WBR, Sergei
