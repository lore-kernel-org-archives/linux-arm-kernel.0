From: mlangsdo@redhat.com (Mark Langsdorf)
Date: Thu, 30 Oct 2014 15:09:33 -0500
Subject: [PATCH 1/2] [usb] make xhci platform driver use 64 bit or 32
 bit DMA
In-Reply-To: <8647684.ls9mYF7q68@wuerfel>
References: <1414692989-23128-1-git-send-email-mlangsdo@redhat.com>
 <1414692989-23128-2-git-send-email-mlangsdo@redhat.com>
 <8647684.ls9mYF7q68@wuerfel>
Message-ID: <54529AFD.6040807@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/30/2014 02:05 PM, Arnd Bergmann wrote:
> On Thursday 30 October 2014 13:16:28 Mark Langsdorf wrote:
>> -       /* Initialize dma_mask and coherent_dma_mask to 32-bits */
>> -       ret = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
>> -       if (ret)
>> -               return ret;
>> +       /* Try setting the coherent_dma_mask to 64 bits, then try 32 bits */
>> +       if (sizeof(dma_addr_t) < 8 ||
>> +               dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(64))) {
>> +               ret = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
>> +               if (ret)
>> +                       return ret;
>> +       }
>>          if (!pdev->dev.dma_mask)
>>                  pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
>>          else
>> -               dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
>> +               dma_set_mask(&pdev->dev, pdev->dev.coherent_dma_mask);
>>
>>          hcd = usb_create_hcd(driver, &pdev->dev, dev_name(&pdev->dev));
>>          if (!hcd)
>>
>
> The logic here seems wrong: if dma_set_mask is successful, you
> can rely on on dma_set_coherent_mask suceeding as well, but
> not the other way round.

That's the order in the existing driver. Would you prefer I
switch it to:
	if (sizeof(dma_addr_t) < 8 ||
		dma_set_mask(&pdev->dev, DMA_BIT_MASK(64))) {
			ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
			if (ret)
				return ret;
	}
	dma_set_coherent_mask(&pdev->dev, pdev->dev.dma_mask);

or based on the comment below:
	ret = dma_set_mask(&pdev->dev, pdev->dev.dma_mask);
	if (ret)
		return ret;
	dma_set_coherent_mask(&pdev->dev, pdev->dev.dma_mask);

I prefer this version but I don't know if it would work.

> Also, we should no longer need to worry about the case where
> pdev->dev.dma_mask is NULL, as this now gets initialized from
> the DT setup.

I'm running this on a system with ACPI enabled and no DT. Does
that make a difference?

--Mark Langsdorf
