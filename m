From: jim2101024@gmail.com (Jim Quinlan)
Date: Fri, 21 Sep 2018 13:40:58 -0400
Subject: [PATCH v5 04/12] PCI: brcmstb: add dma-range mapping for inbound
 traffic
In-Reply-To: <fa285694-c3e1-adf8-032a-202e7598de41@gmail.com>
References: <1537367527-20773-1-git-send-email-jim2101024@gmail.com>
 <1537367527-20773-5-git-send-email-jim2101024@gmail.com>
 <CAKv+Gu_d-r0ubyqZcDzERYd5FVTSpjBk++iACHqVgtHrOK0F7A@mail.gmail.com>
 <7fa897cf-4d58-c63f-afdd-a3ec5a6a56bf@gmail.com>
 <CAKv+Gu8aJRV4nqq1e-5HRLvbrANQsYuMf-pwWB53BhxLgX7iWg@mail.gmail.com>
 <b74d3c16-a512-73dc-c94a-ef6adde5f757@gmail.com>
 <CAKv+Gu8ZbN3BDRyuFzt4o--SSUmhuOh+jnpq8ZR-Ay13DJrAqg@mail.gmail.com>
 <fa285694-c3e1-adf8-032a-202e7598de41@gmail.com>
Message-ID: <CANCKTBsypcVS_iC1+sbW5fMKfj+tTsxbQv9CvDwcO8GV3a8_Yg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 20, 2018 at 5:39 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> On 09/20/2018 02:33 PM, Ard Biesheuvel wrote:
> > On 20 September 2018 at 14:31, Florian Fainelli <f.fainelli@gmail.com> wrote:
> >> On 09/20/2018 02:04 PM, Ard Biesheuvel wrote:
> >>> On 20 September 2018 at 13:55, Florian Fainelli <f.fainelli@gmail.com> wrote:
> >>>> On 09/19/2018 07:19 PM, Ard Biesheuvel wrote:
> >>>>> On 19 September 2018 at 07:31, Jim Quinlan <jim2101024@gmail.com> wrote:
> >>>>>> The Broadcom STB PCIe host controller is intimately related to the
> >>>>>> memory subsystem.  This close relationship adds complexity to how cpu
> >>>>>> system memory is mapped to PCIe memory.  Ideally, this mapping is an
> >>>>>> identity mapping, or an identity mapping off by a constant.  Not so in
> >>>>>> this case.
> >>>>>>
> >>>>>> Consider the Broadcom reference board BCM97445LCC_4X8 which has 6 GB
> >>>>>> of system memory.  Here is how the PCIe controller maps the
> >>>>>> system memory to PCIe memory:
> >>>>>>
> >>>>>>   memc0-a@[        0....3fffffff] <=> pci@[        0....3fffffff]
> >>>>>>   memc0-b@[100000000...13fffffff] <=> pci@[ 40000000....7fffffff]
> >>>>>>   memc1-a@[ 40000000....7fffffff] <=> pci@[ 80000000....bfffffff]
> >>>>>>   memc1-b@[300000000...33fffffff] <=> pci@[ c0000000....ffffffff]
> >>>>>>   memc2-a@[ 80000000....bfffffff] <=> pci@[100000000...13fffffff]
> >>>>>>   memc2-b@[c00000000...c3fffffff] <=> pci@[140000000...17fffffff]
> >>>>>>
> >>>>>
> >>>>> So is describing this as
> >>>>>
> >>>>> dma-ranges = <0x0 0x0 0x0 0x0 0x0 0x40000000>,
> >>>>>              <0x0 0x40000000 0x1 0x0 0x0 0x40000000>,
> >>>>>              <0x0 0x80000000 0x0 0x40000000 0x0 0x40000000>,
> >>>>>              <0x0 0xc0000000 0x3 0x0 0x0 0x40000000>,
> >>>>>              <0x1 0x0 0x0 0x80000000 0x0 0x40000000>,
> >>>>>              <0x1 0x40000000 0x0 0xc0000000 0x0 0x40000000>;
> >>>>>
> >>>>> not working for you? I haven't tried this myself, but since DT permits
> >>>>> describing the inbound mappings this way, we should fix the code if it
> >>>>> doesn't work at the moment.
> >>>>
> >>>> You mean encoding the memory controller index in the first cell? If that
> >>>> works, that's indeed a much cleaner solution, though is it standard
> >>>> compliant in any form?
> >>>
> >>> No those are just memory addresses (although I may have screwed up the
> >>> order). From Documentation/devicetree/booting-without-of.txt:
> >>>
> >>> """
> >>> Optional property:
> >>> - dma-ranges: <prop-encoded-array> encoded as arbitrary number of triplets of
> >>>         (child-bus-address, parent-bus-address, length). Each triplet specified
> >>>         describes a contiguous DMA address range.
> >>> """
> >>>
> >>
> >> Then I am confused by your comment, that's what this patch does, it adds
> >> support for reading "dma-ranges" from Device Tree and setting up inbound
> >> windows using that. The only caveat is that because the PCIe root
> >> complex has some ties with the memory bus architecture it is connected
> >> to (SCB in our case) there is still a requirement to know the
> >> translation between a given physical address and its backing memory
> >> controller/aperture.
> >>
> >
> > Ah ok, apologies for the noise then.
> >
> > I was hoping that having working support for dma-ranges would remove
> > the need for the special phys<->dma conversion routines.
>
> What you describe definitively works with platform devices, but I am not
> sure this is working for PCIe devices, although, conceptually it should,
> yes.
Sorry for my delay in responding.  One problem is that
of_dma_configure() only looks at the first dma-range given and then
converts it to dev->dma_pfn_offset which is respected by the DMA API.
However, we often have multiple dma-ranges, not just one.  This is the
big issue.

There is another issue with of_dma_configure() being invoked by the EP
driver on "bridge->parent->of_node", which is our RC device,
Of_dma_configure() calls of_dma_range() on the of_get_next_parent() of
our RC's device node and this misses the dma-ranges property which is
contained within the RC.  I think I could workaround this but there is
no getting around the first problem.

Thanks,
Jim

> --
> Florian
