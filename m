From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 6 Aug 2018 14:13:45 +0200
Subject: [PATCH v2 0/7] Stop losing firmware-set DMA masks
In-Reply-To: <20180806121334.GA5340@lst.de>
References: <cover.1532382222.git.robin.murphy@arm.com>
 <CAK8P3a3HDJ6svNN_cwvegxu20yNv8+tvc0D1A6Ooeq8agawbFg@mail.gmail.com>
 <1ccccc4b-7d4c-a3ee-23a2-f108916705e9@arm.com>
 <CAK8P3a3ZcOeHMR_qFnsBdXED+2X8_AEMKoS5MeAQhbapbGmm9w@mail.gmail.com>
 <20180806121334.GA5340@lst.de>
Message-ID: <CAK8P3a0z8K9GHfg_RtPo9fmyJtVuhUpfSVqoxkoTO6ohG=i4UA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 6, 2018 at 2:08 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Aug 06, 2018 at 12:01:34PM +0200, Arnd Bergmann wrote:
> > There are a few subtle corner cases here, in particular in which cases
> > the new dma_set_mask() behavior on arm64 reports success or
> > failure when truncating the mask to the bus_dma_mask.
>
> Going forward my plan was to make dma_set_mask() never fail.  The idea
> is that it sets the mask that the device is capable of, and the core
> dma code is responsible for also looking at bus_dma_mask and otherwise
> make things just work.
>
> Robin brought up the case where a platform can't handle a given limitation
> ever, e.g. a PCI(e) device with a 24-bit dma mask on a device with a dma
> offset that means we'll never have any physical memory reachable in that
> range.  So we'll either still need to allow it to fail for such corner
> cases or delay such error until later, e.g. when dma_alloc_* (or in the
> corner case of the corner case dma_map_*) is called.  I'm still undecided
> which way to go, but not allowing error returns from dma_set_mask and
> its variants sounds very tempting.

Another case that I think can happen in practice are devices that need a
DMA mask smaller than 32-bit wide (either asked for by the driver
or according to bus limitations) on a platform that has no ZONE_DMA.

However, IIRC there was no reason to ever fail a dma_set_mask()
to something wider than 32 bit even if the resulting mask still stays
at the default 32-bit mask or something inbetween.

      Arnd
