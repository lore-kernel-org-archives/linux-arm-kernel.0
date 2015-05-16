From: 21cnbao@gmail.com (Barry Song)
Date: Sat, 16 May 2015 23:00:45 +0800
Subject: [PATCH v2] dmaengine: sirf: add CSRatlas7 SoC support
In-Reply-To: <2307498.30iKRMPrgR@wuerfel>
References: <1431684903-11219-1-git-send-email-21cnbao@gmail.com>
 <2307498.30iKRMPrgR@wuerfel>
Message-ID: <CAGsJ_4w-unVq01soA24A4X3wh3-cDAm6dG9G63osM10STOugfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-05-15 19:13 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
> On Friday 15 May 2015 10:15:03 Barry Song wrote:
>> @@ -658,8 +849,16 @@ static int sirfsoc_dma_probe(struct platform_device *op)
>>                 return -ENOMEM;
>>         }
>>
>> -       if (of_device_is_compatible(dn, "sirf,marco-dmac"))
>> -               sdma->is_marco = true;
>> +       if (of_device_is_compatible(dn, "sirf,atlas7-dmac")) {
>> +               sdma->ip_ver = SIRFSOC_DMA_VER_A7V1;
>> +               sdma->exec_desc = sirfsoc_dma_execute_hw_a7v1;
>> +       } else if (of_device_is_compatible(dn, "sirf,atlas7-dmac-v2")) {
>> +               sdma->ip_ver = SIRFSOC_DMA_VER_A7V2;
>> +               sdma->exec_desc = sirfsoc_dma_execute_hw_a7v2;
>> +       } else {
>> +               sdma->ip_ver = SIRFSOC_DMA_VER_A6;
>> +               sdma->exec_desc = sirfsoc_dma_execute_hw_a6;
>> +       }
>>
>>         if (of_property_read_u32(dn, "cell-index", &id)) {
>>                 dev_err(dev, "Fail to get DMAC index\n");
>
> Please send a separate patch for the removal of the marco support, it's
> always better to keep those things separate.
Arnd,
i am happy you took a look at this driver.

marco codes should have been moved to atlas7_v1 IP instead of removal.
or i guess the commit log can be refined to mention this.

>
> When you have noticeable differences like this, use the data field of
> the sirfsoc_dma_match[] array to pass a structure with the differences,
> to avoid the chain of 'of_device_is_compatible' calls. You can use
>
>         data = of_match_device(dev->driver->of_match_table, dev)->data;
>
> to get that pointer from the probe function.

it is right. that is what has been done in
drivers/tty/serial/sirfsoc_uart.c,  sirf spi and some other drivers
with atlas6/prima2/atlas7 supports.
e.g.
static const struct of_device_id sirfsoc_uart_ids[] = {
    { .compatible = "sirf,prima2-uart", .data = &sirfsoc_uart,},
    { .compatible = "sirf,atlas7-uart", .data = &sirfsoc_uart},
    { .compatible = "sirf,prima2-usp-uart", .data = &sirfsoc_usp},
    {}
};
MODULE_DEVICE_TABLE(of, sirfsoc_uart_ids);

here in this dma driver,  the data has only two fields, that is why it
is still done by separate assignment not by matching device to get
data since it looks not enough ugly by now.
of course it can also move to a data struct.

BTW, do you have any new reply to the NoC driver we discussed before
in another thread? i have been actually hoping more comments from you
after i replied twice :-)

>
>         Arnd

-barry
