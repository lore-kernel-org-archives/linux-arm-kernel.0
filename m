From: mporter@ti.com (Matt Porter)
Date: Fri, 11 Jan 2013 13:33:49 -0500
Subject: [PATCH v4 00/14] DMA Engine support for AM33XX
In-Reply-To: <201301111140.41584.arnd@arndb.de>
References: <1357883330-5364-1-git-send-email-mporter@ti.com>
 <201301111140.41584.arnd@arndb.de>
Message-ID: <20130111183349.GA14660@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 11, 2013 at 11:40:41AM +0000, Arnd Bergmann wrote:
> On Friday 11 January 2013, Matt Porter wrote:
> > The approach taken is similar to how OMAP DMA is being converted to
> > DMA Engine support. With the functional EDMA private API already
> > existing in mach-davinci/dma.c, we first move that to an ARM common
> > area so it can be shared. Adding DT and runtime PM support to the
> > private EDMA API implementation allows it to run on AM33xx. AM33xx
> > only boots using DT so we leverage Jon's generic DT DMA helpers to
> > register EDMA DMAC with the of_dma framework and then add support
> > for calling the dma_request_slave_channel() API to both the mmc
> > and spi drivers.
> 
> I think this looks very good. What I wonder is whether we should
> make the non-DT parts of the dmaengine driver compile-time
> conditional on CONFIG_ATAGS though, so the slave drivers don't
> have a link-time dependency on the dmaengine driver's 
> omap_dma_filter_fn symbol when building without ATAGS support.

We have tightly coupled the link-time dependency for
omap_dma_filter_fn by going down the path of using
dma_request_slave_channel_compat() as Tony suggested to avoid extra
ifdefry.

That dependency will go away naturally if all the "legacy" OMAP platforms
were required to only boot from DT...just as a newly added SoCs are.

Are you suggesting unwinding the _compat() approach?

-Matt
