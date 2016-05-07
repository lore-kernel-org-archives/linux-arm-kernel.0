From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Sat, 7 May 2016 11:56:50 -0700
Subject: [PATCH net 1/1] net: fec: update dirty_tx even if no skb
In-Reply-To: <VI1PR0401MB18558325A80D252D2EC64A7BFF6F0@VI1PR0401MB1855.eurprd04.prod.outlook.com>
References: <1461290434-18462-1-git-send-email-troy.kisky@boundarydevices.com>
 <VI1PR0401MB18558325A80D252D2EC64A7BFF6F0@VI1PR0401MB1855.eurprd04.prod.outlook.com>
Message-ID: <0288eea6-9669-d763-4bd8-9438ce0c1f94@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/21/2016 10:59 PM, Fugang Duan wrote:
> From: Troy Kisky <troy.kisky@boundarydevices.com> Sent: Friday, April 22, 2016 10:01 AM
>> To: netdev at vger.kernel.org; davem at davemloft.net; Fugang Duan
>> <fugang.duan@nxp.com>; lznuaa at gmail.com
>> Cc: Fabio Estevam <fabio.estevam@nxp.com>; l.stach at pengutronix.de;
>> andrew at lunn.ch; tremyfr at gmail.com; gerg at uclinux.org; linux-arm-
>> kernel at lists.infradead.org; johannes at sipsolutions.net;
>> stillcompiling at gmail.com; sergei.shtylyov at cogentembedded.com;
>> arnd at arndb.de; holgerschurig at gmail.com; Troy Kisky
>> <troy.kisky@boundarydevices.com>
>> Subject: [PATCH net 1/1] net: fec: update dirty_tx even if no skb
>>
>> If dirty_tx isn't updated, then dma_unmap_single will be called twice.
>>
>> This fixes a
>> [   58.420980] ------------[ cut here ]------------
>> [   58.425667] WARNING: CPU: 0 PID: 377 at /home/schurig/d/mkarm/linux-
>> 4.5/lib/dma-debug.c:1096 check_unmap+0x9d0/0xab8()
>> [   58.436405] fec 2188000.ethernet: DMA-API: device driver tries to free DMA
>> memory it has not allocated [device address=0x0000000000000000] [size=66
>> bytes]
>>
>> encountered by Holger
>>
>> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
>> Tested-by: <holgerschurig@gmail.com>
>> ---
>>  drivers/net/ethernet/freescale/fec_main.c | 8 +++-----
>>  1 file changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/freescale/fec_main.c
>> b/drivers/net/ethernet/freescale/fec_main.c
>> index 08243c2..b71654c 100644
>> --- a/drivers/net/ethernet/freescale/fec_main.c
>> +++ b/drivers/net/ethernet/freescale/fec_main.c
>> @@ -1197,10 +1197,8 @@ fec_enet_tx_queue(struct net_device *ndev, u16
>> queue_id)
>>  					 fec16_to_cpu(bdp->cbd_datlen),
>>  					 DMA_TO_DEVICE);
>>  		bdp->cbd_bufaddr = cpu_to_fec32(0);
>> -		if (!skb) {
>> -			bdp = fec_enet_get_nextdesc(bdp, &txq->bd);
>> -			continue;
>> -		}
>> +		if (!skb)
>> +			goto skb_done;
>>
>>  		/* Check for errors. */
>>  		if (status & (BD_ENET_TX_HB | BD_ENET_TX_LC | @@ -1239,7
>> +1237,7 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id)
>>
>>  		/* Free the sk buffer associated with this last transmit */
>>  		dev_kfree_skb_any(skb);
>> -
>> +skb_done:
>>  		/* Make sure the update to bdp and tx_skbuff are performed
>>  		 * before dirty_tx
>>  		 */
>> --
>> 2.5.0
> 
> The patch is fine for me.
> Can you review below patch that also fix the issue. It can take much effort due to less rmb() and READ_ONCE() operation that is very sensitive for duplex Gbps test for i.MX6SX/i.MX7d SOC. (i.MX6SX can reach at 1.4Gbps, i.MX7D can reach at 1.8Gbps.)
> 


Am I supposed to do anything else to get this patch into net ?
