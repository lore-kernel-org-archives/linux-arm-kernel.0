From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 8 Nov 2011 14:01:12 +0200
Subject: [PATCH] iMX28 Ethernet driver fix
In-Reply-To: <20111108111749.GA30638@axolotl.localnet>
References: <20111108111749.GA30638@axolotl.localnet>
Message-ID: <20111108120112.GB31518@sapphire.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On Tue, Nov 08, 2011 at 11:17:49AM +0000, Peter Horton wrote:
> Fix driver to correctly handle cloned SKBs. Currently any clones
> of the transmit SKBs get endian-swapped by the driver. This breaks
> the ATA-over-Ethernet driver for example.

Patches for network devices should go to the netdev list.

> Signed-off-by: Peter Horton <phorton@bitbox.co.uk>
> ---
>  drivers/net/fec.c |    8 +++++++-

The driver has moved to drivers/net/ethernet/freescale/fec.c. You should 
rebase on v3.2-rc1.

>  1 files changed, 7 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/net/fec.c b/drivers/net/fec.c
> index c46ccb1..6455483 100644
> --- a/drivers/net/fec.c
> +++ b/drivers/net/fec.c
> @@ -302,8 +302,14 @@ fec_enet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>  	 * On some FEC implementations data must be aligned on
>  	 * 4-byte boundaries. Use bounce buffers to copy data
>  	 * and get it aligned. Ugh.
> +	 *
> +	 * We also have to use the bounce buffers if we need
> +	 * to do the endian swap (see below) on a cloned buffer.
>  	 */
> -	if (((unsigned long) bufaddr) & FEC_ALIGNMENT) {
> +	if ((((unsigned long) bufaddr) & FEC_ALIGNMENT) ||
> +		((id_entry->driver_data & FEC_QUIRK_SWAP_FRAME) &&
> +		skb_cloned(skb)))
> +	{
>  		unsigned int index;
>  		index = bdp - fep->tx_bd_base;
>  		memcpy(fep->tx_bounce[index], skb->data, skb->len);
> -- 

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
