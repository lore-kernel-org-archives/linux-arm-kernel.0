From: huangdaode@hisilicon.com (huangdaode)
Date: Sun, 27 Sep 2015 15:19:09 +0800
Subject: [PATCH net-next v3] net: Fix Hisilicon Network Subsystem Support
 Compilation
In-Reply-To: <20150925.214256.1901015223799070196.davem@davemloft.net>
References: <1443169790-54861-1-git-send-email-huangdaode@hisilicon.com>
 <20150925.214256.1901015223799070196.davem@davemloft.net>
Message-ID: <5607986D.7050700@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/9/26 12:42, David Miller wrote:
> From: huangdaode <huangdaode@hisilicon.com>
> Date: Fri, 25 Sep 2015 16:29:50 +0800
>
>> @@ -191,9 +191,12 @@ static void hns_rcb_ring_init(struct ring_pair_cb *ring_pair, int ring_type)
>>   	if (ring_type == RX_RING) {
>>   		dsaf_write_dev(q, RCB_RING_RX_RING_BASEADDR_L_REG,
>>   			       (u32)dma);
>> +#ifdef CONFIG_64BIT
>>   		dsaf_write_dev(q, RCB_RING_RX_RING_BASEADDR_H_REG,
>>   			       (u32)(dma >> 32));
>> -
>> +#else
>> +		dsaf_write_dev(q, RCB_RING_RX_RING_BASEADDR_H_REG, 0);
>> +#endif
>>   		dsaf_write_dev(q, RCB_RING_RX_RING_BD_LEN_REG,
>>   			       bd_size_type);
>>   		dsaf_write_dev(q, RCB_RING_RX_RING_BD_NUM_REG,
> CONFIG_64BIT doesn't tell you if _DMA_ addresses are 64-bit or not.
>
> Furthermore there is a portable way to shift a 32-bit value down
> 32-bits whilst avoiding warnings.
>
> 	(x >> 31) >> 1
>
> So you should definitely use that instead of the CONFIG_64BIT test.
>
> .

agreed.
