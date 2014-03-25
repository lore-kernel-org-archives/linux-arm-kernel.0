From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 25 Mar 2014 10:00:30 -0700
Subject: [PATCH 3/3] net: hisilicon: new hip04 ethernet driver
In-Reply-To: <17142825.cN9DfpvuLc@wuerfel>
References: <1395670496-17381-1-git-send-email-zhangfei.gao@linaro.org>
 <13743364.WZtdi2BZb3@wuerfel>
 <CAMj5BkjbrHevQhf4kbFhN5THHLw4nQwdpt2h6WJH02mKhdq8oQ@mail.gmail.com>
 <17142825.cN9DfpvuLc@wuerfel>
Message-ID: <CAGVrzcbNbc1fyq1cuox8SVZHq1ADNah3CfyXSR--4ZWkf2EtTw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-03-25 1:12 GMT-07:00 Arnd Bergmann <arnd@arndb.de>:
> On Tuesday 25 March 2014 12:06:31 Zhangfei Gao wrote:
>> Dear Arnd
>>
>> On Mon, Mar 24, 2014 at 11:18 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Monday 24 March 2014 22:14:56 Zhangfei Gao wrote:
>> >
>> >> +
>> >> +static void hip04_tx_reclaim(struct net_device *ndev, bool force)
>> >> +{
>> >> +     struct hip04_priv *priv = netdev_priv(ndev);
>> >> +     unsigned tx_head = priv->tx_head;
>> >> +     unsigned tx_tail = priv->tx_tail;
>> >> +     struct tx_desc *desc = &priv->tx_desc[priv->tx_tail];
>> >> +
>> >> +     while (tx_tail != tx_head) {
>> >> +             if (desc->send_addr != 0) {
>> >> +                     if (force)
>> >> +                             desc->send_addr = 0;
>> >> +                     else
>> >> +                             break;
>> >> +             }
>> >> +             if (priv->tx_phys[tx_tail]) {
>> >> +                     dma_unmap_single(&ndev->dev, priv->tx_phys[tx_tail],
>> >> +                             priv->tx_skb[tx_tail]->len, DMA_TO_DEVICE);
>> >> +                     priv->tx_phys[tx_tail] = 0;
>> >> +             }
>> >> +             dev_kfree_skb_irq(priv->tx_skb[tx_tail]);
>> >> +             priv->tx_skb[tx_tail] = NULL;
>> >> +             tx_tail = TX_NEXT(tx_tail);
>> >> +             priv->tx_count--;
>> >> +     }
>> >> +     priv->tx_tail = tx_tail;
>> >> +}
>> >
>> > I think you still need to find a solution to ensure that the tx reclaim is
>> > called eventually through a method other than start_xmit.
>>
>> In the iperf stress test, if move reclaim to poll, there is some
>> error, sometimes sending zero packets.
>> While keep reclaim in the xmit to reclaim transmitted packets looks
>> stable in the test,
>> There TX_DESC_NUM desc can be used.
>
> What I meant is that you need a correct implementation, presumably
> you added a bug when you moved the function to poll(), and also you
> forgot to add a timer.

Using a timer to ensure completion of TX packets is a trick that
worked in the past, but now that the networking stack got smarter,
this might artificially increase the processing time of packets in the
transmit path, and this will defeat features like TCP small queues
etc.. as could be seen with the mvneta driver [1]. The best way really
is to rely on TX completion interrupts when those exist as they cannot
lie about the hardware status (in theory) and they should provide the
fastest way to complete TX packets.
-- 
Florian
