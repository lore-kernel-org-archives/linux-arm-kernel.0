From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 5 Nov 2013 13:14:43 +0100
Subject: [RFC PATCH dtc] C-based DT schema checker integrated into dtc
In-Reply-To: <20131104222135.GA10711@obsidianresearch.com>
References: <1382651488-9696-1-git-send-email-swarren@wwwdotorg.org>
 <527814E4.9050204@wwwdotorg.org>
 <20131104222135.GA10711@obsidianresearch.com>
Message-ID: <201311051314.43629.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 04 November 2013, Jason Gunthorpe wrote:
> On Mon, Nov 04, 2013 at 02:43:00PM -0700, Stephen Warren wrote:

> > For DMA, it does look like Arnd's code was requesting it too, but that
> > should also be fine; as long as no transactions are actually issued
> > against that DMA slave channel, then the HW state shouldn't matter?
> 
> TBH, I'm not really familiar with how the DMA slave API works.
> 
> As long as the API and HW guarantees that the channel cannot do any
> DMAs no matter what the connected IP does, it is obviously fine..

Right, to initiate a DMA, you need to at least request a channel,
configure it, and submit a descriptor. This does only the first
step, so I'm pretty it's ok.

> But not all DMA is like that, eg bus master DMA in PCI requires
> drivers to call pci_enable_device only after they disable DMA in the
> device, which is why I mentioned it..

Yes, a DMA bus master device is different here and needs to be
handled as you exlain.

> It would be nice to see a general API like this unambiguously make
> clear the steps required:
> 
> - Gain access to registers
> - Gain control of the device
> - Enable DMA, bind interrupts, etc
> - Finalize device setup
> - Make the device visible to the rest of the system
> 
> I've seen lots of drivers where the above is just not done right.

I agree this would be nice, but it's probably out of scope of what
we're trying to do here, unless you have better ideas for how to
structure it.

	Arnd
