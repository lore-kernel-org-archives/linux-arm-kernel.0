From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 07 Dec 2013 20:57:05 +0400
Subject: [PATCH] net: allwinner: emac: Add missing free_irq
In-Reply-To: <1386415902-32697-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1386415902-32697-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <52A35361.8090608@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 07-12-2013 15:31, Maxime Ripard wrote:

> The sun4i-emac driver uses devm_request_irq at .ndo_open time, but relies on
> the managed device mechanism to actually free it. This causes an issue whenever
> someone wants to restart the interface, the interrupt still being held, and not
> yet released.

> Fall back to using the regular request_irq at .ndo_open time, and introduce a
> free_irq during .ndo_stop.

> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
> Hi David,

> It would be great if this patch would be applied to 3.13.

> Thanks,
> Maxime


>   drivers/net/ethernet/allwinner/sun4i-emac.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)

> diff --git a/drivers/net/ethernet/allwinner/sun4i-emac.c b/drivers/net/ethernet/allwinner/sun4i-emac.c
> index 50b853a..38aba50 100644
> --- a/drivers/net/ethernet/allwinner/sun4i-emac.c
> +++ b/drivers/net/ethernet/allwinner/sun4i-emac.c
> @@ -717,8 +717,8 @@ static int emac_open(struct net_device *dev)
>   	if (netif_msg_ifup(db))
>   		dev_dbg(db->dev, "enabling %s\n", dev->name);
>
> -	if (devm_request_irq(db->dev, dev->irq, &emac_interrupt,
> -			     0, dev->name, dev))
> +	if (request_irq(dev->irq, &emac_interrupt,
> +			0, dev->name, dev))

    Doesn't it fit into single line?

WBR, Sergei
