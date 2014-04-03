From: davem@davemloft.net (David Miller)
Date: Thu, 03 Apr 2014 11:22:33 -0400 (EDT)
Subject: [PATCH 3/3] net: hisilicon: new hip04 ethernet driver
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D0F6EE729@AcuExch.aculab.com>
References: <1396358832-15828-4-git-send-email-zhangfei.gao@linaro.org>
 <9532591.5yuCbpL4pV@wuerfel>
 <063D6719AE5E284EB5DD2968C1650D6D0F6EE729@AcuExch.aculab.com>
Message-ID: <20140403.112233.2042790497591275140.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Laight <David.Laight@ACULAB.COM>
Date: Wed, 2 Apr 2014 10:04:34 +0000

> From: Arnd Bergmann
>> On Tuesday 01 April 2014 21:27:12 Zhangfei Gao wrote:
>> > +static int hip04_mac_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>> 
>> While it looks like there are no serious functionality bugs left, this
>> function is rather inefficient, as has been pointed out before:
>> 
>> > +{
>> > +       struct hip04_priv *priv = netdev_priv(ndev);
>> > +       struct net_device_stats *stats = &ndev->stats;
>> > +       unsigned int tx_head = priv->tx_head;
>> > +       struct tx_desc *desc = &priv->tx_desc[tx_head];
>> > +       dma_addr_t phys;
>> > +
>> > +       hip04_tx_reclaim(ndev, false);
>> > +       mod_timer(&priv->txtimer, jiffies + RECLAIM_PERIOD);
>> > +
>> > +       if (priv->tx_count >= TX_DESC_NUM) {
>> > +               netif_stop_queue(ndev);
>> > +               return NETDEV_TX_BUSY;
>> > +       }
>> 
>> This is where you have two problems:
>> 
>> - if the descriptor ring is full, you wait for RECLAIM_PERIOD,
>>   which is far too long at 500ms, because during that time you
>>   are not able to add further data to the stopped queue.
> 
> Best to have some idea how long it will take for the ring to empty.
> IIRC you need a count of the bytes in the tx ring anyway.
> There isn't much point waking up until most of the queued
> transmits have had time to complete.

There is absolutely no doubt in my mind that you cannot use timers
for this, it simply will never work properly.

There needs to be a real notification from the device of some
sort, and I don't care what form that comes in.
