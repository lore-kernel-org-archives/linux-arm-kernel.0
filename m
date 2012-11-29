From: linux@prisktech.co.nz (Tony Prisk)
Date: Thu, 29 Nov 2012 16:27:25 +1300
Subject: [PATCH -next] mmc: wmt-sdmmc: fix potential NULL pointer
 dereference in wmt_mci_probe()
In-Reply-To: <CAPgLHd9bKK54pR591ytB1_S3EOw4F177=Ofqf_h_n9_+SFyi2g@mail.gmail.com>
References: <CAPgLHd9bKK54pR591ytB1_S3EOw4F177=Ofqf_h_n9_+SFyi2g@mail.gmail.com>
Message-ID: <1354159645.3008.9.camel@gitbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-11-28 at 21:31 -0500, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> The dereference to 'of_id' should be moved below the NULL test.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>  drivers/mmc/host/wmt-sdmmc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/wmt-sdmmc.c b/drivers/mmc/host/wmt-sdmmc.c
> index 5ba4605..f737b0c 100644
> --- a/drivers/mmc/host/wmt-sdmmc.c
> +++ b/drivers/mmc/host/wmt-sdmmc.c
> @@ -773,7 +773,7 @@ static int __devinit wmt_mci_probe(struct platform_device *pdev)
>  	struct device_node *np = pdev->dev.of_node;
>  	const struct of_device_id *of_id =
>  		of_match_device(wmt_mci_dt_ids, &pdev->dev);
> -	const struct wmt_mci_caps *wmt_caps = of_id->data;
> +	const struct wmt_mci_caps *wmt_caps;
>  	int ret;
>  	int regular_irq, dma_irq;
>  
> @@ -787,6 +787,7 @@ static int __devinit wmt_mci_probe(struct platform_device *pdev)
>  		return -EFAULT;
>  	}
>  
> +	wmt_caps = of_id->data;
>  	regular_irq = irq_of_parse_and_map(np, 0);
>  	dma_irq = irq_of_parse_and_map(np, 1);
>  
> 

Arguable this is unnecessary as of_id can never be NULL unless
of_match_device return's NULL and since it matches against the same
table as the probe that should never happen.

Given that there is a test at the start already for the NULL pointers,
this does make sense however - I'm just not sure how it will ever
happen. You could just remove the test instead.

Either way, this does fix a 'potential' bug, so if everyone else is
happy:

Acked-by: Tony Prisk <linux@prisktech.co.nz>

Regards
Tony P
