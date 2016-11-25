From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 25 Nov 2016 13:34:36 +0000
Subject: Tearing down DMA transfer setup after DMA client has finished
In-Reply-To: <yw1xtwav9092.fsf@unicorn.mansr.com>
References: <58356EA8.2010806@free.fr> <20161125045549.GC2698@localhost>
 <20161125124528.GJ14217@n2100.armlinux.org.uk>
 <yw1xtwav9092.fsf@unicorn.mansr.com>
Message-ID: <20161125133436.GK14217@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 25, 2016 at 01:07:05PM +0000, M?ns Rullg?rd wrote:
> Russell King - ARM Linux <linux@armlinux.org.uk> writes:
> 
> > On Fri, Nov 25, 2016 at 10:25:49AM +0530, Vinod Koul wrote:
> >> Looking at thread and discussion now, first thinking would be to ensure
> >> the transaction is completed properly and then isr fired. You may need
> >> to talk to your HW designers to find a way for that. It is quite common
> >> that DMA controllers will fire and complete whereas the transaction is
> >> still in flight.
> >> 
> >> If that is not doable, then since you claim this is custom part which
> >> other vendors wont use (hope we are wrong down the line), then we can
> >> have a custom api,
> >> 
> >> foo_sbox_configure(bool enable, ...);
> >> 
> >> This can be invoked from NFC driver when required for configuration and
> >> teardown. For very specific cases where people need some specific
> >> configuration we do allow custom APIs.
> >> 
> >> Only problem with that would be it wont be a generic solution and you
> >> seem to be fine with that.
> >
> > Isn't this just the same problem as PL08x or any other system which
> > has multiple requests from devices, but only a limited number of
> > hardware channels - so you have to route the request signals to the
> > appropriate hardware channels according to the requests queued up?
> >
> > If so, no new "custom" APIs are required, it's already able to be
> > solved within the DMA engine drivers...
> 
> That isn't the problem.  The multiplexing of many devices on a limited
> number of hardware channels is working fine.  The problem is that (some)
> client devices need the routing to remain for some time after the dma
> interrupt signals completion.  I'd characterise this hardware as broken,
> but there's nothing we can do about that.
> 
> The fix has to provide some way for the dma driver to delay reusing a
> hardware channel until the client device indicates completion.  If only
> a short delay (a few bus cycles) is needed, it is probably acceptable to
> rework the driver such that the descriptor completion callback can do
> the necessary waiting (e.g. by busy-polling a device status register).
> If the delay can be longer, some other method needs to be devised.

What I understood from the original mail is:

| The problem is that the DMA driver tears down the sbox setup
| as soon as it receives the IRQ. However, when writing to the
| device, the interrupt only means "I have pushed all data from
| memory to the memory channel". These data have not reached
| the device yet, and may still be "in flight". Thus the sbox
| setup can only be torn down after the NFC is idle.

The interrupt comes in after it's read the the last data from memory,
but the data is still sitting in the engine's buffers and has not yet
been passed to the device.

It sounds like the DMA engine buffers the data on its way to the device,
and it's not clear from the description whether that is done in
response to a request from the device or whether the data is prefetched.
IOW, what the lifetime of the data in the dma engine is.

It seems odd that the DMA engine provides no way to know whether the
channel still contains data that is in-flight to the device, whether
by interrupt (from the descriptions the IRQ is way too early) or by
polling some status register within the DMA engine itself.

If the delay is predictable, why not use a delayed workqueue or a
hrtimer to wait a period after the IRQ before completing the DMA
transaction?  If it's not predictable and you haven't some status
register in the DMA engine hardware that indicates whether there's
remaining data, then the design really is screwed up, and I don't
think there's a reasonable solution to the problem - anything
would be a horrid hack that would be specific to this SoC.

It would be unfair to augment the API and add the burden on everyone
for the new API when 99.999% of the world doesn't require it.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
