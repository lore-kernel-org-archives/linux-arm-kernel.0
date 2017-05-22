From: oza.oza@broadcom.com (Oza Oza)
Date: Mon, 22 May 2017 22:12:43 +0530
Subject: [PATCH v6 1/3] of/pci/dma: fix DMA configuration for PCI masters
In-Reply-To: <CAK8P3a3hoeCET5Z+KUJDCHgGEJUmLF49bDozEE0ra5jcbjvoXQ@mail.gmail.com>
References: <1494912127-12890-1-git-send-email-oza.oza@broadcom.com>
 <1494912127-12890-2-git-send-email-oza.oza@broadcom.com>
 <CAK8P3a3hoeCET5Z+KUJDCHgGEJUmLF49bDozEE0ra5jcbjvoXQ@mail.gmail.com>
Message-ID: <CAMSpPPeF6c5exM5cs2Gr85gWNpMmq2aG33oh81H00Y1n=+XdhA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 18, 2017 at 12:43 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tue, May 16, 2017 at 7:22 AM, Oza Pawandeep <oza.oza@broadcom.com> wrote:
>> current device framework and OF framework integration assumes
>> dma-ranges in a way where memory-mapped devices define their
>> dma-ranges. (child-bus-address, parent-bus-address, length).
>>
>> of_dma_configure is specifically written to take care of memory
>> mapped devices. but no implementation exists for pci to take
>> care of pcie based memory ranges.
>
> Hi Oza,
>
> I'm trying to make sense of this, but am still rather puzzled. I have
> no idea what the distinction between memory-mapped devices and
> pcie based devices is in your description, as PCIe is usually memory
> mapped, and Linux doesn't actually support other kinds of PCIe
> devices on most architectures.
>
>> for e.g. iproc based SOCs and other SOCs(suc as rcar) have PCI
>> world dma-ranges.
>> dma-ranges = <0x43000000 0x00 0x00 0x00 0x00 0x80 0x00>;
>>
>> this patch serves following:
>>
>> 1) exposes interface to the pci host driver for their
>> inbound memory ranges
>>
>> 2) provide an interface to callers such as of_dma_get_ranges.
>> so then the returned size get best possible (largest) dma_mask.
>> because PCI RC drivers do not call APIs such as
>> dma_set_coherent_mask() and hence rather it shows its addressing
>> capabilities based on dma-ranges.
>>
>> for e.g.
>> dma-ranges = <0x43000000 0x00 0x00 0x00 0x00 0x80 0x00>;
>> we should get dev->coherent_dma_mask=0x7fffffffff.
>
> do you mean the coherent_dma_mask of the PCI host bridge
> or an attached device here?
>
> If you require PCI devices to come up with an initial
> coherent_dma_mask other than 0xffffffffff, there are other
> problems involved. In particular, you will need to use
> swiotlb, which is not supported on arm32 at the moment,
> and the dma_set_mask()/dma_set_coherent_mask()
> functions need to be modified.
>
>> +       while (1) {
>> +               dma_ranges = of_get_property(node, "dma-ranges", &rlen);
>> +
>> +               /* Ignore empty ranges, they imply no translation required. */
>> +               if (dma_ranges && rlen > 0)
>> +                       break;
>> +
>> +               /* no dma-ranges, they imply no translation required. */
>> +               if (!dma_ranges)
>> +                       break;
>
> A missing parent dma-ranges property here should really indicate that there
> is no valid translation. If we have existing cases where this happens
> in DT files, we may treat it as allowing only 32-bit DMA (as we already
> do for having no dma-ranges at all), but treating it the same way
> as an empty dma-ranges property sounds wrong.
>
>      Arnd


Hi Arnd and Bjorn,

Can you please have a look at PATCH v7 ?
It addresses problem2 alone.

Regards,
Oza
