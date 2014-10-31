From: mlangsdo@redhat.com (Mark Langsdorf)
Date: Fri, 31 Oct 2014 09:22:26 -0500
Subject: [PATCH 1/2] [usb] make xhci platform driver use 64 bit or 32
 bit DMA
In-Reply-To: <13596133.Pde5jAKbQO@wuerfel>
References: <1414692989-23128-1-git-send-email-mlangsdo@redhat.com>
 <8647684.ls9mYF7q68@wuerfel> <54529AFD.6040807@redhat.com>
 <13596133.Pde5jAKbQO@wuerfel>
Message-ID: <54539B22.9010606@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/30/2014 04:05 PM, Arnd Bergmann wrote:
> On Thursday 30 October 2014 15:09:33 Mark Langsdorf wrote:
>> On 10/30/2014 02:05 PM, Arnd Bergmann wrote:
>>> On Thursday 30 October 2014 13:16:28 Mark Langsdorf wrote:
>>>> -       /* Initialize dma_mask and coherent_dma_mask to 32-bits */
>>>> -       ret = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
>>>> -       if (ret)
>>>> -               return ret;
>>>> +       /* Try setting the coherent_dma_mask to 64 bits, then try 32 bits */
>>>> +       if (sizeof(dma_addr_t) < 8 ||
>>>> +               dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(64))) {
>>>> +               ret = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
>>>> +               if (ret)
>>>> +                       return ret;
>>>> +       }
>>>>           if (!pdev->dev.dma_mask)
>>>>                   pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
>>>>           else
>>>> -               dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
>>>> +               dma_set_mask(&pdev->dev, pdev->dev.coherent_dma_mask);
>>>>
>>>>           hcd = usb_create_hcd(driver, &pdev->dev, dev_name(&pdev->dev));
>>>>           if (!hcd)
>>>>
>>>
>>> The logic here seems wrong: if dma_set_mask is successful, you
>>> can rely on on dma_set_coherent_mask suceeding as well, but
>>> not the other way round.
>>
>> That's the order in the existing driver. Would you prefer I
>> switch it to:
>> 	if (sizeof(dma_addr_t) < 8 ||
>> 		dma_set_mask(&pdev->dev, DMA_BIT_MASK(64))) {
>> 			ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
>> 			if (ret)
>> 				return ret;
>> 	}
>> 	dma_set_coherent_mask(&pdev->dev, pdev->dev.dma_mask);
>>
>> or based on the comment below:
>> 	ret = dma_set_mask(&pdev->dev, pdev->dev.dma_mask);
>> 	if (ret)
>> 		return ret;
>> 	dma_set_coherent_mask(&pdev->dev, pdev->dev.dma_mask);
>>
>> I prefer this version but I don't know if it would work.
>
> You should not access pdev->dev.dma_mask here, that gets set
> by the platform code. You should be able to just use
> dma_set_mask_and_coherent to set both.

So:

  	if (sizeof(dma_addr_t) < 8 ||
  		dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64))) {
  		ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
  		if (ret)
  			return ret;
  	}

This doesn't actually work for me. I experimented a bit on the
hardware and I always fail if I don't set the coherent mask
first.

>>> Also, we should no longer need to worry about the case where
>>> pdev->dev.dma_mask is NULL, as this now gets initialized from
>>> the DT setup.
>>
>> I'm running this on a system with ACPI enabled and no DT. Does
>> that make a difference?
>
> I don't know how the DMA mask gets initialized on ACPI, I assume it
> doesn't at the moment, but that is something that should be fixed
> in the ACPI code, not worked around in the driver.
>
> You should definitely make sure that this also works with DT, as
> I don't think it's possible to support X-Gene with ACPI. I know
> that Al Stone has experimented with it in the past, but he never
> came back with any results, so I assume the experiment failed.

I'm running my test code on an X-Gene with ACPI. Al Stone, Mark
Salter, and I got it working.

--Mark Langsdorf
