From: jim2101024@gmail.com (Jim Quinlan)
Date: Fri, 21 Sep 2018 14:29:45 -0400
Subject: [PATCH v5 11/12] ARM64: add dma remap for BrcmSTB PCIe
In-Reply-To: <20180919144119.GB29096@lst.de>
References: <1537367527-20773-1-git-send-email-jim2101024@gmail.com>
 <1537367527-20773-12-git-send-email-jim2101024@gmail.com>
 <20180919144119.GB29096@lst.de>
Message-ID: <CANCKTBuk9KyabrL7u6RvCp4eu+3mT=9Dvo4wvo99KF6iKVwWRw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 19, 2018 at 10:41 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Sep 19, 2018 at 10:32:06AM -0400, Jim Quinlan wrote:
> > +#if defined(CONFIG_ARM64)
>
> Please use plain #ifdef where possible.
>
> > +dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
> > +{
> > +     return brcm_phys_to_dma(dev, paddr);
> > +}
> > +
> > +phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t dev_addr)
> > +{
> > +     return brcm_dma_to_phys(dev, dev_addr);
> > +}
> > +#endif
>
> How is this going to work for a kernel with BrcmSTB built in, but running
> on a more standard arm64 SOC?

Sorry for the delay in my response.  It would work because the
dma_ranges would be empty/null and identity mapping would happen, but
yes, all __dma_to_phys and __phys_to_dma calls would be wasting time
going through the brcm functions.  We would have to take BRCMSTB=y out
of the defconfig.  Florian would probably NAK that idea.

Please remember that the reason for this approach is because in your
response to V4 you suggested that "Override phys_to_dma and
dma_to_phys as mips and x86 [sta2x11] do for similar situations"  and
"Overriding phys_to_dma and dma_to_phys is required if you need to
support swiotlb, and chances are with a broken PCIe controller on
arm64 or mips64 you eventuall will".

>
> I suspect we really just want a set of ranges hanging off struct device
> (conditional on a config option).  Each SoC can then fill it at boot
> time, and if it is non-NULL the DMA code will use it instead of
> calling __phys_to_dma and __dma_to_phys.  In fact the single range
> version could probably just replace the existing dma_pfn_offset
> field.
If this was a config option then BRCMSTB=y in defconfig would set this
for all ARM64, just like the above case, correct?  And would this work
with SWIOTLB?   Also, do you think others would use it, or would I be
adding code in the DMA API only because of one unusual PCIe host
controller design?   Keep in mind that although you didn't like the
approach of V4 --  which intercepted DMA ops to make the appropriate
mapping and was not compatible with SWIOTLB -- at least it kept the
code restricted to oru driver.

Thanks,
Jim
