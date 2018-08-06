From: hch@lst.de (Christoph Hellwig)
Date: Mon, 6 Aug 2018 14:13:34 +0200
Subject: [PATCH v2 0/7] Stop losing firmware-set DMA masks
In-Reply-To: <CAK8P3a3ZcOeHMR_qFnsBdXED+2X8_AEMKoS5MeAQhbapbGmm9w@mail.gmail.com>
References: <cover.1532382222.git.robin.murphy@arm.com>
 <CAK8P3a3HDJ6svNN_cwvegxu20yNv8+tvc0D1A6Ooeq8agawbFg@mail.gmail.com>
 <1ccccc4b-7d4c-a3ee-23a2-f108916705e9@arm.com>
 <CAK8P3a3ZcOeHMR_qFnsBdXED+2X8_AEMKoS5MeAQhbapbGmm9w@mail.gmail.com>
Message-ID: <20180806121334.GA5340@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 06, 2018 at 12:01:34PM +0200, Arnd Bergmann wrote:
> There are a few subtle corner cases here, in particular in which cases
> the new dma_set_mask() behavior on arm64 reports success or
> failure when truncating the mask to the bus_dma_mask.

Going forward my plan was to make dma_set_mask() never fail.  The idea
is that it sets the mask that the device is capable of, and the core
dma code is responsible for also looking at bus_dma_mask and otherwise
make things just work.

Robin brought up the case where a platform can't handle a given limitation
ever, e.g. a PCI(e) device with a 24-bit dma mask on a device with a dma
offset that means we'll never have any physical memory reachable in that
range.  So we'll either still need to allow it to fail for such corner
cases or delay such error until later, e.g. when dma_alloc_* (or in the
corner case of the corner case dma_map_*) is called.  I'm still undecided
which way to go, but not allowing error returns from dma_set_mask and
its variants sounds very tempting.
