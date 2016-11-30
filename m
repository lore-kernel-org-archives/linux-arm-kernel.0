From: mathias.nyman@linux.intel.com (Mathias Nyman)
Date: Wed, 30 Nov 2016 16:05:59 +0200
Subject: [PATCH 1/1] usb: return error code when platform_get_irq fails
In-Reply-To: <52a774c0-9bca-6d1b-a470-f07caefa5d3a@gmail.com>
References: <1480424255-25059-1-git-send-email-bianpan2016@163.com>
 <52a774c0-9bca-6d1b-a470-f07caefa5d3a@gmail.com>
Message-ID: <583EDCC7.20702@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30.11.2016 15:41, Matthias Brugger wrote:
>
>
> On 29/11/16 13:57, Pan Bian wrote:
>> In function xhci_mtk_probe(), variable ret takes the return value. Its
>> value should be negative on failures. However, when the call to function
>> platform_get_irq() fails, it does not set the error code, and 0 will be
>> returned. 0 indicates no error. As a result, the callers of function
>> xhci_mtk_probe() will not be able to detect the error. This patch fixes
>> the bug by assigning the return value of platform_get_irq() to variable
>> ret if it fails.
>>
>> Signed-off-by: Pan Bian <bianpan2016@163.com>
>> ---
>>  drivers/usb/host/xhci-mtk.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
>> index 79959f1..f2365a4 100644
>> --- a/drivers/usb/host/xhci-mtk.c
>> +++ b/drivers/usb/host/xhci-mtk.c
>> @@ -560,8 +560,10 @@ static int xhci_mtk_probe(struct platform_device *pdev)
>>          goto disable_ldos;
>>
>>      irq = platform_get_irq(pdev, 0);
>> -    if (irq < 0)
>> +    if (irq < 0) {
>> +        ret = irq;
>>          goto disable_clk;
>> +    }
>>
>>      /* Initialize dma_mask and coherent_dma_mask to 32-bits */
>>      ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
>>
>
>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
>

Thanks, Added to queue

-Mathias
