From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 31 Oct 2014 16:49:38 +0100
Subject: [PATCH 1/2] [usb] make xhci platform driver use 64 bit or 32 bit
 DMA
In-Reply-To: <54539B22.9010606@redhat.com>
References: <1414692989-23128-1-git-send-email-mlangsdo@redhat.com>
 <13596133.Pde5jAKbQO@wuerfel> <54539B22.9010606@redhat.com>
Message-ID: <2609633.oChO4mb7il@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 31 October 2014 09:22:26 Mark Langsdorf wrote:
> On 10/30/2014 04:05 PM, Arnd Bergmann wrote:
> > On Thursday 30 October 2014 15:09:33 Mark Langsdorf wrote:
> >
> > You should not access pdev->dev.dma_mask here, that gets set
> > by the platform code. You should be able to just use
> > dma_set_mask_and_coherent to set both.
> 
> So:
> 
>         if (sizeof(dma_addr_t) < 8 ||
>                 dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64))) {
>                 ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
>                 if (ret)
>                         return ret;
>         }
> 
> This doesn't actually work for me. I experimented a bit on the
> hardware and I always fail if I don't set the coherent mask
> first.

Very strange, the code looks right to me. What is the initial value
of dev->dma_mask?

> >>> Also, we should no longer need to worry about the case where
> >>> pdev->dev.dma_mask is NULL, as this now gets initialized from
> >>> the DT setup.
> >>
> >> I'm running this on a system with ACPI enabled and no DT. Does
> >> that make a difference?
> >
> > I don't know how the DMA mask gets initialized on ACPI, I assume it
> > doesn't at the moment, but that is something that should be fixed
> > in the ACPI code, not worked around in the driver.
> >
> > You should definitely make sure that this also works with DT, as
> > I don't think it's possible to support X-Gene with ACPI. I know
> > that Al Stone has experimented with it in the past, but he never
> > came back with any results, so I assume the experiment failed.
> 
> I'm running my test code on an X-Gene with ACPI. Al Stone, Mark
> Salter, and I got it working.

The question is whether that is in a form that we could merge upstream.
I haven't seen any patches being posted, so I can't know for sure, but
from all I know about the hardware it doesn't seem likely, unless
you leave out all the interesting bits such as power mangement, PCI
and networking.

	Arnd
