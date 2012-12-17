From: arvid.brodin@xdin.com (Arvid Brodin)
Date: Mon, 17 Dec 2012 16:15:19 +0100
Subject: Do I need to skb_put() Ethernet frames to a minimum of 60 bytes?
In-Reply-To: <50CF216F.2010107@atmel.com>
References: <502A9EC4.4040208@xdin.com>
 <1344976557.2690.43.camel@bwh-desktop.uk.solarflarecom.com>
 <5033C6B0.4060508@xdin.com> <50CF216F.2010107@atmel.com>
Message-ID: <50CF3707.9060502@xdin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2012-12-17 14:43, Nicolas Ferre wrote:
> On 08/21/2012 07:34 PM, Arvid Brodin :
>> On 2012-08-14 22:35, Ben Hutchings wrote:
>>> On Tue, 2012-08-14 at 18:53 +0000, Arvid Brodin wrote:
>>>> Hi,
>>>>
>>>> If I create an sk_buff with a payload of less than 28 bytes (ethheader + data),
>>>> and send it using the cadence/macb (Ethernet) driver, I get
>>>>
>>>> eth0: TX underrun, resetting buffers
>>>>
>>>> Now I know the minimum Ethernet frame size is 64 bytes (including the 4-byte
>>>> FCS), but whose responsibility is it to pad the frame to this size if necessary?
>>>> Mine or the driver's - i.e. should I just skb_put() to the minimum size or
>>>> should I report the underrun as a driver bug?
>>>
>>> If the hardware doesn't pad frames automatically then it's the driver's
>>> reponsibility to do so.
>>>
>>
>> Nicolas, can you take a look at this? At the moment I'm using the following change
>> in macb.c to avoid TX underruns on short packages:
>>
>> --- a/drivers/net/ethernet/cadence/macb.c	2012-05-04 19:14:41.927719667 +0200
>> +++ b/drivers/net/ethernet/cadence/macb.c	2012-08-21 19:22:40.063739049 +0200
>> @@ -618,6 +618,7 @@ static void macb_poll_controller(struct
>>  }
>>  #endif
>>
>> +#define MIN_ETHFRAME_LEN	60
>>  static int macb_start_xmit(struct sk_buff *skb, struct net_device *dev)
>>  {
>>  	struct macb *bp = netdev_priv(dev);
>> @@ -635,6 +636,12 @@ static int macb_start_xmit(struct sk_buf
>>  	printk("\n");
>>  #endif
>>
>> +	if (skb->len < MIN_ETHFRAME_LEN) {
>> +		/* Pad skb to minium Ethernet frame size */
>> +		if (skb_tailroom(skb) >= MIN_ETHFRAME_LEN - skb->len)
>> +			memset(skb_put(skb, MIN_ETHFRAME_LEN - skb->len), 0,
>> +						MIN_ETHFRAME_LEN - skb->len);
>> +	}
>>  	len = skb->len;
>>  	spin_lock_irqsave(&bp->lock, flags);
>>
>>
>> ... but as you can see this is limited to linear skbs which has been allocated with
>> enough tailroom. Perhaps there are better ways to fix the problem? (Maybe the hardware
>> is actually doing the padding already and the problem has to do with the way the DMA
>> transfer is set up?)
> 
> I come back to this issue. It seems to me that the macb Cadence IP is
> padding automatically a too little packet. It is the usual behavior
> unless you specify otherwise in the CTRL register embedded in the tx
> descriptor. I also verified this with wireshark on both ICMP and UDP
> packets.
> 
> The error that you are experiencing is on at91sam9260 or at91sam9263
> SoCs, am I right?

No, this was on an AVR32 AP7000 board.

I believe this is what I did to solve the issue (patch for linux-2.6.37):

diff -Nurp linux-2.6.37-001-bsa400/drivers/net//macb.c
linux-2.6.37-macb-hsr/drivers/net//macb.c
--- linux-2.6.37-orig/drivers/net//macb.c	2012-09-16 22:41:02.746754672 +0200
+++ linux-2.6.37-macb/drivers/net//macb.c	2012-09-17 00:34:35.161389720 +0200
@@ -376,8 +379,9 @@ static void macb_tx(struct macb *bp)

 			rmb();

-			dma_unmap_single(&bp->pdev->dev, rp->mapping, skb->len,
-							 DMA_TO_DEVICE);
+			dma_unmap_single(&bp->pdev->dev, rp->mapping,
+					 max(skb->len, (unsigned int) ETH_ZLEN),
+					 DMA_TO_DEVICE);
 			rp->skb = NULL;
 			dev_kfree_skb_irq(skb);
 		}
@@ -413,7 +417,8 @@ static void macb_tx(struct macb *bp)

 		dev_dbg(&bp->pdev->dev, "skb %u (data %p) TX complete\n",
 			tail, skb->data);
-		dma_unmap_single(&bp->pdev->dev, rp->mapping, skb->len,
+		dma_unmap_single(&bp->pdev->dev, rp->mapping,
+				 max(skb->len, (unsigned int) ETH_ZLEN),
 				 DMA_TO_DEVICE);
 		bp->stats.tx_packets++;
 		bp->stats.tx_bytes += skb->len;
@@ -675,7 +680,10 @@ static int macb_start_xmit(struct sk_buf
 	printk("\n");
 #endif

-	len = skb->len;
+	if (skb_padto(skb, ETH_ZLEN) != 0)
+		return NETDEV_TX_OK; /* There is no NETDEV_TX_FAIL... */
+
+	len = max(skb->len, (unsigned int) ETH_ZLEN);
 	spin_lock_irqsave(&bp->lock, flags);

 	/* This is a hard error, log it. */


-- 
Arvid Brodin | Consultant (Linux)
XDIN AB | Knarrarn?sgatan 7 | SE-164 40 Kista | Sweden | xdin.com
