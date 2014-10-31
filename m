From: mlangsdo@redhat.com (Mark Langsdorf)
Date: Fri, 31 Oct 2014 12:32:47 -0500
Subject: [PATCH 1/2] [usb] make xhci platform driver use 64 bit or 32
 bit DMA
In-Reply-To: <2609633.oChO4mb7il@wuerfel>
References: <1414692989-23128-1-git-send-email-mlangsdo@redhat.com>
 <13596133.Pde5jAKbQO@wuerfel> <54539B22.9010606@redhat.com>
 <2609633.oChO4mb7il@wuerfel>
Message-ID: <5453C7BF.5090403@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/31/2014 10:49 AM, Arnd Bergmann wrote:
> On Friday 31 October 2014 09:22:26 Mark Langsdorf wrote:
>> On 10/30/2014 04:05 PM, Arnd Bergmann wrote:
>>> On Thursday 30 October 2014 15:09:33 Mark Langsdorf wrote:
>>>
>>> You should not access pdev->dev.dma_mask here, that gets set
>>> by the platform code. You should be able to just use
>>> dma_set_mask_and_coherent to set both.
>>
>> So:
>>
>>          if (sizeof(dma_addr_t) < 8 ||
>>                  dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64))) {
>>                  ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
>>                  if (ret)
>>                          return ret;
>>          }
>>
>> This doesn't actually work for me. I experimented a bit on the
>> hardware and I always fail if I don't set the coherent mask
>> first.
>
> Very strange, the code looks right to me. What is the initial value
> of dev->dma_mask?

Did you mean &pdev->dev.dma_mask? It's 0xdc759df8.

--Mark Langsdorf
