From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 1 Jun 2012 11:45:24 +0100
Subject: [RFC 04/34] dmaengine: PL08x: remove runtime PM support
In-Reply-To: <CACRpkdbMhTuQSADHJb_0ivyXregbGH1eEhjFk1i-S3Bs5oi0UQ@mail.gmail.com>
References: <20120529093015.GF12217@n2100.arm.linux.org.uk>
 <E1SZIr0-0006yy-98@rmk-PC.arm.linux.org.uk>
 <CACRpkdbMhTuQSADHJb_0ivyXregbGH1eEhjFk1i-S3Bs5oi0UQ@mail.gmail.com>
Message-ID: <20120601104524.GB21245@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 31, 2012 at 08:46:28AM +0800, Linus Walleij wrote:
> On Tue, May 29, 2012 at 5:36 PM, Russell King
> <rmk+kernel@arm.linux.org.uk> wrote:
> 
> > The runtime PM support conflicts with the generic AMBA bus PM, and also
> > causes a potential deadlock with the PL011 driver as it results in
> > interrupts being enabled beneath a spinlock.
> >
> > I don't presently see any solution to this other than by removing the
> > runtime PM support entirely from the DMA engine driver. ?Alternative
> > suggestions welcome.
> 
> I took a look again and cannot see any simple way to do this.
> 
> It basically looks like we need to have job submission put stuff
> in a queue and kick a worker or kthread to have that do the
> get_sync() operation and proceed to submit the descriptors,
> lest we always run the risk of being in irq context.
> 
> Perfectly doable, but can be done at some other time.

It becomes a lot easier towards the end of this series where we end up
separating the completion tasklet from the general management of the
DMA engine (through use of the virt-dma stuff.)

However, please realise that a lot of these problems aren't specific to
one DMA engine implementation, so we _really_ should be thinking about
how to provide libraries for DMA engine implementations to use.
