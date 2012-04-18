From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 18 Apr 2012 20:42:24 +0100
Subject: [PATCH 8/8] ARM: omap_hsmmc: remove platform data dma_mask and
 initialization
In-Reply-To: <CANrkHUYvKdBUZh9UmWcE30ywAAiqhN-KcnSAE2T56WJLFPX1gA@mail.gmail.com>
References: <20120418100954.GK25053@n2100.arm.linux.org.uk>
 <E1SKRsg-0004bX-4w@rmk-PC.arm.linux.org.uk>
 <CANrkHUajRzoCp7K8L3cJArWN3xdqpft8L4k-o4gFTRTo8nmhmg@mail.gmail.com>
 <20120418152956.GP25053@n2100.arm.linux.org.uk>
 <CANrkHUYvKdBUZh9UmWcE30ywAAiqhN-KcnSAE2T56WJLFPX1gA@mail.gmail.com>
Message-ID: <20120418194224.GS25053@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 18, 2012 at 09:05:56PM +0530, T Krishnamoorthy, Balaji wrote:
> On Wed, Apr 18, 2012 at 8:59 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Wed, Apr 18, 2012 at 08:53:32PM +0530, T Krishnamoorthy, Balaji wrote:
> >> Hi,
> >>
> >> drivers/mmc/host/omap.c is also using dma_mask should that also be removed
> >
> > Does this driver make use of this platform data?
> >
> > If so, it needs converting to DMA engine _before_ this patch (which is
> > one reason why its a good idea to do these changes as separate patches...
> > as I've done.) ?It means stuff like this can be slotted in as necessary
> > in the patch order.
> >
> > I'm told that driver is OMAP2 only - I don't have any OMAP2 platforms to
> > be able to test it on (I only have OMAP3 and OMAP4.)
> 
> Yes, this driver is for omap2420 and omap1 devices.

Looking at this driver, there seems to be some interaction between how
the DMA is programmed for each part of the scatterlist, and how the
MMC interface is programmed, specifically:

        frame = data->blksz;
        if (cpu_is_omap15xx() && frame > 32)
                frame = 32;
        else if (frame > 64)
                frame = 64;
        frame >>= 1;
        if (!(data->flags & MMC_DATA_WRITE)) {
                buf = 0x800f | ((frame - 1) << 8);
        } else {
                buf = 0x0f80 | ((frame - 1) << 0);
        }
        OMAP_MMC_WRITE(host, BUF, buf);

Does this register have to be written on every scatterlist entry, or can
it be written once@the start of request processing?
