From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 6 Jan 2014 18:56:17 +0800
Subject: [PATCH v2] dmaengine: sirf: enable generic dt binding for dma
 channels
In-Reply-To: <52CA8A8F.70707@metafoo.de>
References: <1388992371-7908-1-git-send-email-21cnbao@gmail.com>
 <52CA8A8F.70707@metafoo.de>
Message-ID: <CAGsJ_4zmHyTBWMouJ78bYgt3Mze6Vv5YSJDWg7=FyjA5RochwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014/1/6 Lars-Peter Clausen <lars@metafoo.de>:
> On 01/06/2014 08:12 AM, Barry Song wrote:
>> From: Barry Song <Baohua.Song@csr.com>
>>
>> move to support of_dma_request_slave_channel() and dma_request_slave_channel.
>> we add a xlate() to let dma clients be able to find right dma_chan by generic
>> "dmas" properties in dts.
>>
>> Cc: Lars-Peter Clausen <lars@metafoo.de>
>> Signed-off-by: Barry Song <Baohua.Song@csr.com>
>
> Looks good to me, but ...
>
> [...]
>> @@ -81,6 +82,7 @@ struct sirfsoc_dma_regs {
>>
>>  struct sirfsoc_dma {
>>       struct dma_device               dma;
>> +     dma_cap_mask_t                  cap;
>
> ... the cap field seems to be unused, ...

>>  static int sirfsoc_dma_probe(struct platform_device *op)
>>  {
>>       struct device_node *dn = op->dev.of_node;
>> @@ -744,11 +758,21 @@ static int sirfsoc_dma_probe(struct platform_device *op)
>>       if (ret)
>>               goto free_irq;
>>
>> +     /* Device-tree DMA controller registration */
>> +     ret = of_dma_controller_register(dn, of_dma_sirfsoc_xlate, sdma);
>> +     if (ret) {
>> +             sdma->cap = dma->cap_mask;
>
> ... it is initialized here, but never used again.
>

real. thanks!

-barry
