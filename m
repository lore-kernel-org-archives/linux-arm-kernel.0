From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Fri, 4 Mar 2016 09:23:05 -0700
Subject: [PATCH net-next V2 03/16] net: fec: pass txq to fec_enet_tx_queue
 instead of queue_id
In-Reply-To: <VI1PR0401MB18557FE58F60E929DF9B6329FFBE0@VI1PR0401MB1855.eurprd04.prod.outlook.com>
References: <1456360619-24390-1-git-send-email-troy.kisky@boundarydevices.com>
 <1456360619-24390-4-git-send-email-troy.kisky@boundarydevices.com>
 <VI1PR0401MB18555F637F86F38461B3442BFFBC0@VI1PR0401MB1855.eurprd04.prod.outlook.com>
 <56D71133.4000708@boundarydevices.com>
 <VI1PR0401MB18557FE58F60E929DF9B6329FFBE0@VI1PR0401MB1855.eurprd04.prod.outlook.com>
Message-ID: <56D9B669.2000404@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/4/2016 12:41 AM, Fugang Duan wrote:
> From: Troy Kisky <troy.kisky@boundarydevices.com> Sent: Thursday, March 03, 2016 12:14 AM
>> To: Fugang Duan <fugang.duan@nxp.com>; netdev at vger.kernel.org;
>> davem at davemloft.net; b38611 at freescale.com
>> Cc: fabio.estevam at freescale.com; l.stach at pengutronix.de; andrew at lunn.ch;
>> tremyfr at gmail.com; linux at arm.linux.org.uk; linux-arm-
>> kernel at lists.infradead.org; laci at boundarydevices.com; shawnguo at kernel.org;
>> johannes at sipsolutions.net; stillcompiling at gmail.com;
>> sergei.shtylyov at cogentembedded.com; arnd at arndb.de
>> Subject: Re: [PATCH net-next V2 03/16] net: fec: pass txq to
>> fec_enet_tx_queue instead of queue_id
>>
>> On 3/2/2016 8:16 AM, Fugang Duan wrote:
>>> From: Troy Kisky <troy.kisky@boundarydevices.com>  Sent: Thursday,
>>> February 25, 2016 8:37 AM
>>>> To: netdev at vger.kernel.org; davem at davemloft.net;
>> b38611 at freescale.com
>>>> Cc: fabio.estevam at freescale.com; l.stach at pengutronix.de;
>>>> andrew at lunn.ch; tremyfr at gmail.com; linux at arm.linux.org.uk; linux-arm-
>>>> kernel at lists.infradead.org; laci at boundarydevices.com;
>>>> shawnguo at kernel.org; johannes at sipsolutions.net;
>>>> stillcompiling at gmail.com; sergei.shtylyov at cogentembedded.com;
>>>> arnd at arndb.de; Troy Kisky <troy.kisky@boundarydevices.com>
>>>> Subject: [PATCH net-next V2 03/16] net: fec: pass txq to
>>>> fec_enet_tx_queue instead of queue_id
>>>>
>>>> queue_id is the qid member of struct bufdesc_prop.
>>>>
>>>> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
>>>> ---
>>>>  drivers/net/ethernet/freescale/fec_main.c | 17 ++++++-----------
>>>>  1 file changed, 6 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/drivers/net/ethernet/freescale/fec_main.c
>>>> b/drivers/net/ethernet/freescale/fec_main.c
>>>> index 9619b9e..c517194 100644
>>>> --- a/drivers/net/ethernet/freescale/fec_main.c
>>>> +++ b/drivers/net/ethernet/freescale/fec_main.c
>>>> @@ -1156,25 +1156,18 @@ fec_enet_hwtstamp(struct fec_enet_private
>>>> *fep, unsigned ts,
>>>>  	hwtstamps->hwtstamp = ns_to_ktime(ns);  }
>>>>
>>>> -static void
>>>> -fec_enet_tx_queue(struct net_device *ndev, u16 queue_id)
>>>> +static void fec_txq(struct net_device *ndev, struct fec_enet_private *fep,
>>>> +		    struct fec_enet_priv_tx_q *txq)
>>>>  {
>>>> -	struct	fec_enet_private *fep;
>>>>  	struct bufdesc *bdp;
>>>>  	unsigned short status;
>>>>  	struct	sk_buff	*skb;
>>>> -	struct fec_enet_priv_tx_q *txq;
>>>>  	struct netdev_queue *nq;
>>>>  	int	index = 0;
>>>>  	int	entries_free;
>>>>
>>>> -	fep = netdev_priv(ndev);
>>>> -
>>>> -	queue_id = FEC_ENET_GET_QUQUE(queue_id);
>>>> -
>>>> -	txq = fep->tx_queue[queue_id];
>>>>  	/* get next bdp of dirty_tx */
>>>> -	nq = netdev_get_tx_queue(ndev, queue_id);
>>>> +	nq = netdev_get_tx_queue(ndev, txq->bd.qid);
>>>>  	bdp = txq->dirty_tx;
>>>>
>>>>  	/* get next bdp of dirty_tx */
>>>> @@ -1268,11 +1261,13 @@ static void
>>>>  fec_enet_tx(struct net_device *ndev)  {
>>>>  	struct fec_enet_private *fep = netdev_priv(ndev);
>>>> +	struct fec_enet_priv_tx_q *txq;
>>>>  	u16 queue_id;
>>>>  	/* First process class A queue, then Class B and Best Effort queue */
>>>>  	for_each_set_bit(queue_id, &fep->work_tx, FEC_ENET_MAX_TX_QS)
>> {
>>>>  		clear_bit(queue_id, &fep->work_tx);
>>>> -		fec_enet_tx_queue(ndev, queue_id);
>>>> +		txq = fep->tx_queue[FEC_ENET_GET_QUQUE(queue_id)];
>>>> +		fec_txq(ndev, fep, txq);
>>>>  	}
>>>>  	return;
>>>>  }
>>>> --
>>>> 2.5.0
>>>
>>> The patch should merge with patch#1.
>>>
>>
>>
>> Why ?  That would only hide the change in patch #1.
> 
> Hi Troy Kisky,
> 
> Sorry, I mean patch#2 net: fec: pass rxq to fec_enet_rx_queue instead of queue_id.  It is not necessary to separate them.
> 



I'll happily squash them together, that is easy, and I will.
I don't agree they should be, but it is just not at all important to me.


Sincere thanks for reviewing this series though.

Troy
