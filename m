From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 10 Mar 2015 11:05:38 +0000
Subject: ARM: OMPA4+: is it expected dma_coerce_mask_and_coherent(dev,
 DMA_BIT_MASK(64)); to fail?
In-Reply-To: <54FA2084.8050803@linaro.org>
References: <54F8A68B.3080709@linaro.org>
 <20150305201753.GG29584@n2100.arm.linux.org.uk>
 <54FA2084.8050803@linaro.org>
Message-ID: <20150310110538.GK29584@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 06, 2015 at 11:47:48PM +0200, Grygorii.Strashko at linaro.org wrote:
> Hi Russell,
> 
> On 03/05/2015 10:17 PM, Russell King - ARM Linux wrote:
> > On Thu, Mar 05, 2015 at 08:55:07PM +0200, Grygorii.Strashko at linaro.org wrote:
> >> The dma_coerce_mask_and_coherent() will fail in case 'Example 3' and succeed in cases 1,2.
> >> dma-mapping.c --> __dma_supported()
> >> 	if (sizeof(mask) != sizeof(dma_addr_t) && <== true for all OMAP4+
> >> 	    mask > (dma_addr_t)~0 &&		<== true for DMA_BIT_MASK(64)
> >> 	    dma_to_pfn(dev, ~0) < max_pfn) {  <== true only for Example 3
> > 
> > Hmm, I think this may make more sense to be "< max_pfn - 1" here, as
> > that would be better suited to our intention.
> > 
> > The result of dma_to_pfn(dev, ~0) is the maximum PFN which we could
> > address via DMA, but we're comparing it with the maximum PFN in the
> > system plus 1 - so we need to subtract one from it.
> 
> Ok. I'll try it.

Any news on this - I think it is a real off-by-one bug which we should
fix in any case.

Thanks.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
