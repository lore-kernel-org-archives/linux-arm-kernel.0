From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 2 Dec 2017 23:06:56 +0300
Subject: [PATCH 07/10] net: ethernet: smsc: Handle return value of
 platform_get_irq
In-Reply-To: <1512242782-7134-8-git-send-email-arvind.yadav.cs@gmail.com>
References: <1512242782-7134-1-git-send-email-arvind.yadav.cs@gmail.com>
 <1512242782-7134-8-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <94e0d184-2d35-b6f0-687a-8df8ae67e37a@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/02/2017 10:26 PM, Arvind Yadav wrote:

> platform_get_irq() can fail here and we must check its return value.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>   drivers/net/ethernet/smsc/smc911x.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/ethernet/smsc/smc911x.c b/drivers/net/ethernet/smsc/smc911x.c
> index 0515744..a1cf18c 100644
> --- a/drivers/net/ethernet/smsc/smc911x.c
> +++ b/drivers/net/ethernet/smsc/smc911x.c
> @@ -2088,6 +2088,11 @@ static int smc911x_drv_probe(struct platform_device *pdev)
>   
>   	ndev->dma = (unsigned char)-1;
>   	ndev->irq = platform_get_irq(pdev, 0);
> +	if (ndev->irq <= 0) {
> +		ret = ndev->irq ? ndev->irq : -ENODEV;

    Same comments as the next patch...

> +		goto release_both;
> +	}
> +
>   	lp = netdev_priv(ndev);
>   	lp->netdev = ndev;
>   #ifdef SMC_DYNAMIC_BUS_CONFIG

MBR, Sergei
