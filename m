From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 16 Apr 2015 14:22:38 +0200
Subject: [PATCH] usb: gadget: xudc: fix return value check in xudc_probe()
In-Reply-To: <1429186650-20465-1-git-send-email-weiyj_lk@163.com>
References: <1429186650-20465-1-git-send-email-weiyj_lk@163.com>
Message-ID: <f03a06ba-a2e3-41f6-80da-fb376ced9af6@BY2FFO11FD042.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/16/2015 02:17 PM, weiyj_lk at 163.com wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> In case of error, the function devm_ioremap_resource() returns
> ERR_PTR() and never returns NULL. The NULL test in the return
> value check should be replaced with IS_ERR().
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>  drivers/usb/gadget/udc/udc-xilinx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/udc-xilinx.c b/drivers/usb/gadget/udc/udc-xilinx.c
> index dd3e9fd..cfe0349 100644
> --- a/drivers/usb/gadget/udc/udc-xilinx.c
> +++ b/drivers/usb/gadget/udc/udc-xilinx.c
> @@ -2071,8 +2071,8 @@ static int xudc_probe(struct platform_device *pdev)
>  	/* Map the registers */
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	udc->addr = devm_ioremap_resource(&pdev->dev, res);
> -	if (!udc->addr)
> -		return -ENOMEM;
> +	if (IS_ERR(udc->addr))
> +		return PTR_ERR(udc->addr);
>  
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq < 0) {
> 

Reviewed-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
