From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 29 May 2012 14:46:32 +0100
Subject: [alsa-devel] [PATCH 2/4] ASoC: mmp: add audio dma support
In-Reply-To: <20120529131410.GB3954@opensource.wolfsonmicro.com>
References: <1337932416.1580.2.camel@vkoul-udesk3>
 <20120525080500.GB24149@n2100.arm.linux.org.uk>
 <CAMj5Bkhc46zqY5AbJkc=-h02taP_esxrqpNu--aYtZZcVcPK6A@mail.gmail.com>
 <20120525094231.GC24149@n2100.arm.linux.org.uk>
 <CAMj5BkjhCakuZdUcA+P_nbETi8tnYK5Ok6HMWTG61whZXwCD6g@mail.gmail.com>
 <1338268734.1580.26.camel@vkoul-udesk3>
 <20120529073334.GA12217@n2100.arm.linux.org.uk>
 <20120529090215.GA3954@opensource.wolfsonmicro.com>
 <20120529092129.GE12217@n2100.arm.linux.org.uk>
 <20120529131410.GB3954@opensource.wolfsonmicro.com>
Message-ID: <20120529134632.GB24623@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 29, 2012 at 02:14:11PM +0100, Mark Brown wrote:
> On Tue, May 29, 2012 at 10:21:29AM +0100, Russell King - ARM Linux wrote:
> > On Tue, May 29, 2012 at 10:02:15AM +0100, Mark Brown wrote:
> 
> > > What is the issue with the current code - it *looks* like you want to
> > > use the component device for the DMA as the struct device with dmaengine
> > > but I don't understand the issue that's created if we don't (and why
> > > things appear to be working for people as they are).
> 
> > Look.  It's very very very very simple.
> 
> > What does the DMA API take?  A struct device.  What struct device?  Some
> > random struct device for something in the system, or what?  No, it takes
> > the struct device for the _device_ in the system which is _performing_
> > the DMA.
> 
> I'm assuming that you mean the client rather than the DMA controller
> itself (which we must already have found)?  That makes sense,

No, I mean the DMA controller *itself*.

DMA engines _can_ (and do - quite common on ARM platforms) have this setup:

                      CPU
                       |
               +-Bus switch matrix-+
     (RAM bus) |                   |
RAM------------+--DMA controller---+
                        |          |
                        |(rq+ack)  |(IO bus)
                        |          |
                        |          +-----------Peripheral 1
                        +--------- | ------------'
                                   +-----------Peripheral 2
                                  ...

So, the _peripherals_ themselves have no direct access to RAM at all.
These are totally and utterly incapable of any kind of DMA on their own.
They can only be _given_ data by some other agent in the system, that
being in the above case the CPU or the DMA controller.

When the DMA controller is setup, and asked to transfer data to a
peripheral device, it first starts by originating an access to RAM via
the RAM bus, and it loads the data into it's FIFO.  It then performs
accesses on the IO bus to _write_ the data into the peripheral just
as a CPU would under PIO.

So, to setup the _peripheral_ struct device with some nebulous "oh this
can access the whole of system memory and is DMA capable, let's allocate
DMA memory against it" is totally the wrong approach.  The peripheral
device can not know what the details are for some random DMA controller
elsewhere in the system.

Indeed, there are systems out there where the same peripheral can be
driven by more than one DMA controller.  What if each DMA controller
has different properties?

So, the struct device in the system representing the device which is
accessing memory is _the_ _DMA_ _controller_.

Why does this matter?  Consider this case:


                      CPU
                       |
     +-----------Bus switch matrix-+
     |                             |
RAM--+--IOMMU-----DMA controller---+
                        |          |
                        |(rq+ack)  |(IO bus)
                        |          |
                        |          +-----------Peripheral 1
                        +--------- | ------------'
                                   +-----------Peripheral 2
                                  ...

Now, for the DMA controller to access RAM, the IOMMU needs to be setup to
create mappings between the address space that the DMA controller can see,
and the RAM.  If there are no mappings setup, the DMA controller can't see
the RAM _at_ _all_ and DMA is not possible.  The IOMMU is managed via the
DMA API on many kernel architectures, x86 included.

If you use the peripheral struct device with the DMA API, how does the DMA
API know that it must setup some unknown DMA controller's IOMMU?

And why should the DMA API code even care about such complexities?

We don't do this on USB.  When a USB device wants to perform DMA, we map
its memory using the _host_ _controller_ struct device, not the USB
peripheral device's struct device.  It's exactly the same principle.
The struct device corresponding with whatever device is _actually_
accessing memory must be the struct device passed into the DMA API.

> Currently we seem to have nobody actually working on this code in
> mainline, as far as I can tell you and Vinod are the only people with
> any active interest at a framework level (with Vinod's mostly being at
> the dmaengine rather than ASoC level; I don't have any hardware with any
> sort of dmaengine support) and because you have this out of tree
> implementation you're working on you're mostly just offering feedback in
> these driver review threads where apparently chunks of it are getting
> missed.  Nobody else seems to be showing much inclination to get
> involved so it seems unlikely to collide with other work.

That's partly because you took in soc-dmaengine.c, after you ridiculed
my version - mainly because it didn't support cyclic DMA at the time.
And so I assumed that you'd made up your mind, and just plain weren't
interested.  You have been very resistive towards discussing issues
coming up in this area, and in other areas I've raised with ASoC such
as the struct device lifetime issues - even when I've created patches
for you.

Moreover, because I don't see any hope for the SA11x0 PCM support going
in (it certainly won't support capture mode due to the need to run the
playback side to receive capture samples) I'm really not pushing it; it's
more my testbed for testing out my DMA engine work than serious ASoC
work.

So please excuse me if I'm not in a rush to post it to the list.  In the
mean time, it's viewable via:

http://ftp.arm.linux.org.uk/git/gitweb.cgi?p=linux-arm.git;a=commitdiff;h=76bc4eb916528ceef2609c22f949429e2322a331
