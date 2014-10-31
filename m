From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 31 Oct 2014 20:41:16 +0100
Subject: [PATCH 1/2] [usb] make xhci platform driver use 64 bit or 32 bit
 DMA
In-Reply-To: <5453C7BF.5090403@redhat.com>
References: <1414692989-23128-1-git-send-email-mlangsdo@redhat.com>
 <2609633.oChO4mb7il@wuerfel> <5453C7BF.5090403@redhat.com>
Message-ID: <2029327.CODsGTOYJV@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 31 October 2014 12:32:47 Mark Langsdorf wrote:
> On 10/31/2014 10:49 AM, Arnd Bergmann wrote:
> > On Friday 31 October 2014 09:22:26 Mark Langsdorf wrote:
> >> On 10/30/2014 04:05 PM, Arnd Bergmann wrote:
> >>> On Thursday 30 October 2014 15:09:33 Mark Langsdorf wrote:
> >>>
> >>> You should not access pdev->dev.dma_mask here, that gets set
> >>> by the platform code. You should be able to just use
> >>> dma_set_mask_and_coherent to set both.
> >>
> >> So:
> >>
> >>          if (sizeof(dma_addr_t) < 8 ||
> >>                  dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64))) {
> >>                  ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> >>                  if (ret)
> >>                          return ret;
> >>          }
> >>
> >> This doesn't actually work for me. I experimented a bit on the
> >> hardware and I always fail if I don't set the coherent mask
> >> first.
> >
> > Very strange, the code looks right to me. What is the initial value
> > of dev->dma_mask?
> 
> Did you mean &pdev->dev.dma_mask? It's 0xdc759df8.

No, that would be the pointer to the pointer to the dma mask ;-)

I meant the DMA mask that was set by the platform code in
*pdev->dev.dma_mask. It would also be interesting to know where
pdev->dev.dma_mask points to. Does ACPI allocate memory for that,
or does it point to the coherent mask?

	Arnd
