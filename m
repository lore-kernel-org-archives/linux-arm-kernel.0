From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Tue, 29 Jan 2013 15:45:40 +0200
Subject: [PATCH 1/5] dmaengine: dw_dmac: move to generic DMA binding
In-Reply-To: <201301291331.48427.arnd@arndb.de>
References: <1359395857-1235-1-git-send-email-arnd@arndb.de>
 <201301291035.30265.arnd@arndb.de>
 <CAKohpo=rD9=dEaPkKYcj55K4_ebdnU7qjv2TZBUwqHAB+Kk+aw@mail.gmail.com>
 <201301291331.48427.arnd@arndb.de>
Message-ID: <1359467140.31148.41.camel@smile>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-01-29 at 13:31 +0000, Arnd Bergmann wrote: 
> On Tuesday 29 January 2013, Viresh Kumar wrote:
> > You can still keep fargs as is and just fill them as:
> > 
> >        fargs.cfg_lo = 0;
> > 
> > if (DMA_TO_DEV)
> >        // dest is periph
> >        fargs.cfg_hi = be32_to_cpup(dma_spec->args+0) << 11;
> > else if (DEV_TO_DMA)
> >        // src is periph
> >        fargs.cfg_hi = be32_to_cpup(dma_spec->args+0) << 7;
> > 
> > The field size is 4 bits.
> 
> Ah, good. So I guess the "dma-requests" property should actually
> be "16" then.
> 
> Does this mean that an implicit zero request line means memory?

No, it doesn't.
When dma is doing mem2mem transfers the request line field is ignored by
the hw.

> Could we have device-to-device DMAs with this controller, and if
> we can, should we have both 'src' and 'dst' fields?

As far as I know there is no driver under dmaengine that supports
per2per transfers.

>  Are the
> two number ranges sharing the same address space, i.e. is
> request '7' as the destination guaranteed to be the same device
> as request '7' in the source?

Request line should be unique. It means a real wire from slave hw to the
dmac.


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
