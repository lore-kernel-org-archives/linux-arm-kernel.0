From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 28 Mar 2014 10:37:21 +0000
Subject: [PATCHv2 1/3] arm64: Implement custom mmap functions for dma
 mapping
In-Reply-To: <CALk7dXr3cZSkQ6dTUyCjUDStOd6=ghGN9-iO5RQiTfHCciGxLg@mail.gmail.com>
References: <1394732716-11507-2-git-send-email-lauraa@codeaurora.org>
 <1394826745-24191-1-git-send-email-lauraa@codeaurora.org>
 <CALk7dXr3cZSkQ6dTUyCjUDStOd6=ghGN9-iO5RQiTfHCciGxLg@mail.gmail.com>
Message-ID: <20140328103721.GF21330@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 28, 2014 at 09:45:08AM +0000, Ritesh Harjani wrote:
> On Sat, Mar 15, 2014 at 1:22 AM, Laura Abbott <lauraa@codeaurora.org> wrote:
> > +static int __dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
> > +                            void *cpu_addr, dma_addr_t dma_addr, size_t size)
> > +{
> > +       int ret = -ENXIO;
> > +       unsigned long nr_vma_pages = (vma->vm_end - vma->vm_start) >>
> > +                                       PAGE_SHIFT;
> > +       unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
> > +       unsigned long pfn = dma_to_phys(dev, dma_addr) >> PAGE_SHIFT;
> 
> Why not __phys_to_pfn here ?? just asking, I know there is nothing wrong in
> this too..

Because dma_addr is a DMA address (as seen by the device from the other
side of the bus) rather than a CPU physical address. In many cases they
are the same but not always.

-- 
Catalin
