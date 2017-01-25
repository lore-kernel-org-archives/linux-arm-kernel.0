From: mzoran@crowfest.net (Michael Zoran)
Date: Wed, 25 Jan 2017 11:31:08 -0800
Subject: [PATCH v2] arm64: dma-mapping: Fix dma_mapping_error() when
 bypassing SWIOTLB
In-Reply-To: <31a7cdfb-ef74-ba80-cff1-ac2395fc98a9@arm.com>
References: <20170124225200.a7qioswpxzh6agvd@raspberrypi-2.musicnaut.iki.fi>
 <840027acb4750542003dff17b4a8902ba8972754.1485368348.git.robin.murphy@arm.com>
 <31a7cdfb-ef74-ba80-cff1-ac2395fc98a9@arm.com>
Message-ID: <1485372668.5911.3.camel@crowfest.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-01-25 at 19:14 +0000, Robin Murphy wrote:
> [ +Michael - FYI this is straight on top of 4.10-rc5 ]
> 
> On 25/01/17 18:31, Robin Murphy wrote:
> > When bypassing SWIOTLB on small-memory systems, we need to avoid
> > calling
> > into swiotlb_dma_mapping_error() in exactly the same way as we
> > avoid
> > swiotlb_dma_supported(), because the former also relies on SWIOTLB
> > state
> > being initialised.
> > 
> > Under the assumptions for which we skip SWIOTLB,
> > dma_map_{single,page}()
> > will only ever return the DMA-offset-adjusted physical address of
> > the
> > page passed in, thus we can report success unconditionally.
> > 
> > Fixes: b67a8b29df7e ("arm64: mm: only initialize swiotlb when
> > necessary")
> > CC: stable at vger.kernel.org
> > CC: Jisheng Zhang <jszhang@marvell.com>
> > Reported-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> > Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> > ---
> > 
> > v2: Get the return value the right way round this time... After
> > some
> > ????careful reasoning it really is that simple.
> > 
> > ?arch/arm64/mm/dma-mapping.c | 9 ++++++++-
> > ?1 file changed, 8 insertions(+), 1 deletion(-)
> > 

I was able to build it and it works. Cool.
