From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 17 May 2012 14:22:23 +0100
Subject: [PATCH V3 1/2] of: Add generic device tree DMA helpers
In-Reply-To: <201205161942.20296.arnd@arndb.de>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
 <4FB3D294.4020505@wwwdotorg.org>
 <CAJe_Zhe6uT7u-+0VEx2XCieuynmK5nOO=4DSpDDS_Q=N8-QtPA@mail.gmail.com>
 <201205161942.20296.arnd@arndb.de>
Message-ID: <20120517132223.GB9650@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 16, 2012 at 07:42:20PM +0000, Arnd Bergmann wrote:
> On Wednesday 16 May 2012, Jassi Brar wrote:
> >  The assumed model of the DMAC, in this binding, has P peripheral
> > interfaces (P request signals) that could request a data transfer
> > and C physical channels that actually do the data transfers, hence,
> > at most C out of P peripherals could be served by the DMAC at any
> > point of time. Usually C := P, but not always. Usually, any of the
> > physical channels could be employed by the DMAC driver to serve any
> > client.
> >  The DMAC driver identifies a client by its i/f number, 'peri_id'
> > on the given DMAC. For example, TX for SPI has 7th while RX_TX
> > (half-duplex) for MMC has 10th peripheral interface (request-signal)
> > on a given DMAC. Usually, any of the physical channels could be
> > employed by the DMAC driver to serve a client.
> 
> I'm still anything but convinced by this model. Basically it's the
> exact opposite of what we do for every other subsystem (irq, pinctrl,
> regulator, gpio, ...), where the device using some infrastructure
> contains the information about who provides it, whereas here you
> move all the information into the device that provides the functionality,
> and have no handle in the device using it by which the driver can
> identify it.

I think the biggest difference between DMA and other subsystems is that
other systems have only one provider.

DMA on the other hand seems to have cases where you can make a choice
between two or more providers of the service.  The impression that I'm
getting from this thread is that it's difficult to describe that kind
of relationship in DT - DT is good at describing "A provides X to C"
but not "A _or_ B provides X to C and you can chose either A or B
depending on <something> to satisfy X".
