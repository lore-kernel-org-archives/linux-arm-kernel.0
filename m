From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 29 Jan 2013 14:26:15 +0000
Subject: [PATCH 1/5] dmaengine: dw_dmac: move to generic DMA binding
In-Reply-To: <1359467140.31148.41.camel@smile>
References: <1359395857-1235-1-git-send-email-arnd@arndb.de>
 <201301291035.30265.arnd@arndb.de>
 <CAKohpo=rD9=dEaPkKYcj55K4_ebdnU7qjv2TZBUwqHAB+Kk+aw@mail.gmail.com>
 <201301291331.48427.arnd@arndb.de> <1359467140.31148.41.camel@smile>
Message-ID: <20130129142615.GX23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 29, 2013 at 03:45:40PM +0200, Andy Shevchenko wrote:
> On Tue, 2013-01-29 at 13:31 +0000, Arnd Bergmann wrote: 
> > On Tuesday 29 January 2013, Viresh Kumar wrote:
> > > You can still keep fargs as is and just fill them as:
> > > 
> > >        fargs.cfg_lo = 0;
> > > 
> > > if (DMA_TO_DEV)
> > >        // dest is periph
> > >        fargs.cfg_hi = be32_to_cpup(dma_spec->args+0) << 11;
> > > else if (DEV_TO_DMA)
> > >        // src is periph
> > >        fargs.cfg_hi = be32_to_cpup(dma_spec->args+0) << 7;
> > > 
> > > The field size is 4 bits.
> > 
> > Ah, good. So I guess the "dma-requests" property should actually
> > be "16" then.
> > 
> > Does this mean that an implicit zero request line means memory?
> 
> No, it doesn't.
> When dma is doing mem2mem transfers the request line field is ignored by
> the hw.

Memory to memory transfers are dealt with using a totally different API
to the slave API.  Look at the rest of the DMA engine API to see how it's
used - any channel is selected with a DMA_MEMCPY capability.

(IMHO, the MEM2MEM transfer type against the slave API should never have
been permitted.)
