From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 24 Mar 2014 10:35:49 -0700
Subject: [PATCH 3/3] net: hisilicon: new hip04 ethernet driver
In-Reply-To: <4644970.WiIKNXNpdP@wuerfel>
References: <1395670496-17381-1-git-send-email-zhangfei.gao@linaro.org>
 <1395670496-17381-4-git-send-email-zhangfei.gao@linaro.org>
 <CAGVrzcaY257MAjjmkXDi_fD5TxSanmx9Jpvx-yg7vT3-GUjz3A@mail.gmail.com>
 <4644970.WiIKNXNpdP@wuerfel>
Message-ID: <CAGVrzcb0=5qUwEPM-9LeMBU1gFL1UaZF5rzi0NXGPjMUfPDeLA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-03-24 10:23 GMT-07:00 Arnd Bergmann <arnd@arndb.de>:
> On Monday 24 March 2014 09:32:17 Florian Fainelli wrote:
>> > +       priv->tx_skb[tx_head] = skb;
>> > +       priv->tx_phys[tx_head] = phys;
>> > +       desc->send_addr = cpu_to_be32(phys);
>> > +       desc->send_size = cpu_to_be16(skb->len);
>> > +       desc->cfg = cpu_to_be32(DESC_DEF_CFG);
>> > +       phys = priv->tx_desc_dma + tx_head * sizeof(struct tx_desc);
>> > +       desc->wb_addr = cpu_to_be32(phys);
>>
>> Don't we need a barrier here to ensure that all stores are completed
>> before we hand this descriptor address to hip40_set_xmit_desc() which
>> should make DMA start processing it?
>
> I would think the writel() in set_xmit_desc() implies the barrier.

Right, which means that this should be properly documented to make
sure that this simplification is well understood and produces the
expected result.
-- 
Florian
