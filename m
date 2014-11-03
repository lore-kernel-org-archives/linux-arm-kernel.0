From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Mon, 03 Nov 2014 17:48:17 +0100
Subject: [PATCH 7/7] can: m_can: workaround for transmit data less than
 4 bytes
In-Reply-To: <1414579527-31100-7-git-send-email-b29396@freescale.com>
References: <1414579527-31100-1-git-send-email-b29396@freescale.com>
 <1414579527-31100-7-git-send-email-b29396@freescale.com>
Message-ID: <5457B1D1.6080301@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/29/2014 11:45 AM, Dong Aisheng wrote:
> We meet an IC issue that we have to write the full 8 bytes (whatever
> value for the second word) in Message RAM to avoid bit error for transmit
> data less than 4 bytes.

Is this a SoC or a m_can problem? Are all versions of the SoC/m_can
affected? Is there a m_can version register somewhere?

> Without the workaround, we can easily see the following errors:
> root at imx6qdlsolo:~# ip link set can0 up type can bitrate 1000000
> [   66.882520] IPv6: ADDRCONF(NETDEV_CHANGE): can0: link becomes ready
> root at imx6qdlsolo:~# cansend can0 123#112233
> [   66.935640] m_can 20e8000.can can0: Bit Error Uncorrected
> 
> Signed-off-by: Dong Aisheng <b29396@freescale.com>
> ---
>  drivers/net/can/m_can/m_can.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index 219e0e3..f2d9ebe 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -1058,10 +1058,19 @@ static netdev_tx_t m_can_start_xmit(struct sk_buff *skb,
>  	m_can_fifo_write(priv, 0, M_CAN_FIFO_ID, id);
>  	m_can_fifo_write(priv, 0, M_CAN_FIFO_DLC, can_len2dlc(cf->len) << 16);
>  
> -	for (i = 0; i < cf->len; i += 4)
> +	for (i = 0; i < cf->len; i += 4) {
>  		m_can_fifo_write(priv, 0, M_CAN_FIFO_DATA(i / 4),
>  				 *(u32 *)(cf->data + i));
>  
> +		/* FIXME: we meet an IC issue that we have to write the full 8

FIXME usually indicates that the driver needs some work here. Just
describe your hardware bug, you might add a reference to an errata if
available, though.

> +		 * bytes (whatever value for the second word) in Message RAM to
> +		 * avoid bit error for transmit data less than 4 bytes
> +		 */
> +		if (cf->len <= 4)
> +			m_can_fifo_write(priv, 0, M_CAN_FIFO_DATA(i / 4 + 1),
> +					 0x0);

This workaround doesn't handle the dlc == 0 case, your error description
isn't completely if this is a problem, too.

It should be possible to change the for loop to go always to 8, or
simply unroll the loop:

/* errata description goes here */
m_can_fifo_write(priv, 0, M_CAN_FIFO_DATA(0), *(u32 *)(cf->data + 0));
m_can_fifo_write(priv, 0, M_CAN_FIFO_DATA(1), *(u32 *)(cf->data + 4));

> +	}
> +
>  	can_put_echo_skb(skb, dev, 0);
>  
>  	if (priv->can.ctrlmode & CAN_CTRLMODE_FD) {
> 

Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141103/818246cc/attachment.sig>
