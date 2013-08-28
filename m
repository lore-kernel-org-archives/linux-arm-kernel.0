From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 28 Aug 2013 10:30:12 +0200
Subject: [PATCH] i2c-pnx: fix error return code in i2c_pnx_probe()
In-Reply-To: <CAPgLHd9W5GtFtt6yCHRJ2mmuy2ha2u_utF9jR3yLY5O_oYpLWg@mail.gmail.com>
References: <CAPgLHd9W5GtFtt6yCHRJ2mmuy2ha2u_utF9jR3yLY5O_oYpLWg@mail.gmail.com>
Message-ID: <20130828083012.GA4086@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 23, 2013 at 10:55:51AM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Fix to return a negative error code in the irq get error handling
> case instead of 0, as done elsewhere in this function.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Moved it to for-next, since...

> ---
>  drivers/i2c/busses/i2c-pnx.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/i2c/busses/i2c-pnx.c b/drivers/i2c/busses/i2c-pnx.c
> index 5f39c6d..d2f02b3 100644
> --- a/drivers/i2c/busses/i2c-pnx.c
> +++ b/drivers/i2c/busses/i2c-pnx.c
> @@ -727,6 +727,7 @@ static int i2c_pnx_probe(struct platform_device *pdev)
>  	alg_data->irq = platform_get_irq(pdev, 0);
>  	if (alg_data->irq < 0) {
>  		dev_err(&pdev->dev, "Failed to get IRQ from platform resource\n");
> +		ret = alg_data->irq;
>  		goto out_irq;

... this surely needs to beu 'out_clock'. Fixed it here. If somebody
wants to convert it to devm_*, much appreciated.

>  	}
>  	ret = request_irq(alg_data->irq, i2c_pnx_interrupt,
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130828/4c2f106b/attachment.sig>
