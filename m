From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Fri, 27 Apr 2018 09:55:16 +0200
Subject: [PATCH 3/3] can: xilinx: fix xcan_start_xmit()'s return type
In-Reply-To: <79ea4ab6-a12a-21ad-b586-6a1dad176c0a@xilinx.com>
References: <20180426211339.30821-1-luc.vanoostenryck@gmail.com>
 <20180426211339.30821-4-luc.vanoostenryck@gmail.com>
 <79ea4ab6-a12a-21ad-b586-6a1dad176c0a@xilinx.com>
Message-ID: <02e9be66-1345-2af7-c343-9f94d71e1d10@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/27/2018 09:49 AM, Michal Simek wrote:
> On 26.4.2018 23:13, Luc Van Oostenryck wrote:
>> The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
>> which is a typedef for an enum type, but the implementation in this
>> driver returns an 'int'.
>>
>> Fix this by returning 'netdev_tx_t' in this driver too.
>>
>> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
>> ---
>>  drivers/net/can/xilinx_can.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
>> index 89aec07c2..a19648606 100644
>> --- a/drivers/net/can/xilinx_can.c
>> +++ b/drivers/net/can/xilinx_can.c
>> @@ -386,7 +386,7 @@ static int xcan_do_set_mode(struct net_device *ndev, enum can_mode mode)
>>   *
>>   * Return: 0 on success and failure value on error
>>   */
>> -static int xcan_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>> +static netdev_tx_t xcan_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>>  {
>>  	struct xcan_priv *priv = netdev_priv(ndev);
>>  	struct net_device_stats *stats = &ndev->stats;
>>
> 
> It was applied already but there should be also kernel-doc update too to
> use enum values instead of 0.

Like this:

> diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
> index f07ce4945356..d0ad1473f689 100644
> --- a/drivers/net/can/xilinx_can.c
> +++ b/drivers/net/can/xilinx_can.c
> @@ -398,7 +398,7 @@ static int xcan_do_set_mode(struct net_device *ndev, enum can_mode mode)
>   * function uses the next available free txbuff and populates their fields to
>   * start the transmission.
>   *
> - * Return: 0 on success and failure value on error
> + * Return: NETDEV_TX_OK on success and NETDEV_TX_BUSY when the tx queue is full
>   */
>  static netdev_tx_t xcan_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>  {

I can squash in that change.

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
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180427/8df4fed8/attachment-0001.sig>
