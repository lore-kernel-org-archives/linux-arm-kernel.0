From: mw@semihalf.com (Marcin Wojtas)
Date: Sat, 7 Jul 2018 16:58:14 +0200
Subject: [PATCH net-next 5/6] net: mvneta: Verify hardware checksum only
 when offload checksum feature is set
In-Reply-To: <20180706131949.2684-6-gregory.clement@bootlin.com>
References: <20180706131949.2684-1-gregory.clement@bootlin.com>
 <20180706131949.2684-6-gregory.clement@bootlin.com>
Message-ID: <CAPv3WKc-h3pJ+OjpLS24=QjiTHKUEZ4ODC57CZ-fr-eoa1DDdg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI Gregory,

2018-07-06 15:19 GMT+02:00 Gregory CLEMENT <gregory.clement@bootlin.com>:
>
> From: Yelena Krivosheev <yelena@marvell.com>
>
> If the checksum offload feature is not set, then there is no point to
> check the status of the hardware.
>
> [gregory: extract from a larger patch]
> Signed-off-by: Yelena Krivosheev <yelena@marvell.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---
>  drivers/net/ethernet/marvell/mvneta.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
> index 12739fb60732..8fc4be238083 100644
> --- a/drivers/net/ethernet/marvell/mvneta.c
> +++ b/drivers/net/ethernet/marvell/mvneta.c
> @@ -1716,11 +1716,13 @@ static void mvneta_rx_error(struct mvneta_port *pp,
>  static void mvneta_rx_csum(struct mvneta_port *pp, u32 status,
>                            struct sk_buff *skb)
>  {
> -       if ((status & MVNETA_RXD_L3_IP4) &&
> -           (status & MVNETA_RXD_L4_CSUM_OK)) {
> -               skb->csum = 0;
> -               skb->ip_summed = CHECKSUM_UNNECESSARY;
> -               return;
> +       if (pp->dev->features & NETIF_F_RXCSUM) {
> +               if ((status & MVNETA_RXD_L3_IP4) &&
> +                   (status & MVNETA_RXD_L4_CSUM_OK)) {

Small nit - wouldn't it be nicer to check conditions in a single 'if':

       if ((pp->dev->features & NETIF_F_RXCSUM) &&
           (status & MVNETA_RXD_L3_IP4) &&
           (status & MVNETA_RXD_L4_CSUM_OK)) {
?

Best regards,
Marcin

> +                       skb->csum = 0;
> +                       skb->ip_summed = CHECKSUM_UNNECESSARY;
> +                       return;
> +               }
>         }
>
>         skb->ip_summed = CHECKSUM_NONE;
> --
> 2.17.1
>
