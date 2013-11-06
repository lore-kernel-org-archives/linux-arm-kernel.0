From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 6 Nov 2013 20:00:22 +0100
Subject: address translation for PCIe-to-localbus bridge
In-Reply-To: <20131106182457.GA25879@obsidianresearch.com>
References: <527A1983.6020603@keymile.com>
 <20131106173649.GA25515@obsidianresearch.com>
 <20131106190308.01f7a4a9@skate>
 <20131106182457.GA25879@obsidianresearch.com>
Message-ID: <20131106200022.0008a8b9@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Gunthorpe,

On Wed, 6 Nov 2013 11:24:57 -0700, Jason Gunthorpe wrote:

> > The fact that the bootloader sets this MBus window is more-or-less
> > irrelevant because when the mvebu-mbus driver is initialized, it
> > completely clears *all* existing MBus windows:
> 
> Yes, but it is not irrelevent. In my case this same DT is supporting
> 3.10 and 3.12 kernels - 3.10 doesn't even have a MBUS driver or
> dynamic PEX driver and it relies upon the ranges entry matching the
> static bootloader configuration to work properly.

Ok, I understand.

> > I indeed remember some objections, but I'm not sure what they were
> > precisely. Maybe we didn't had a precise use case back at the time, to
> > really make people objecting realize what the problem was?
> 
> That is about where I am at too..

So maybe we should revive this direction then?

> > On the other hand, I think the of_*() API is quite limited when it
> > comes to updating the DT. If I remember correctly, you can update some
> > nodes, but you can never reclaim the memory that was used for the
> > previous value of the node. So any change to the in-memory DT
> > representation is basically a memory leak for the entire lifetime of
> > the system (of course, I might be wrong on this, I haven't dived into
> > all the hardcore details of DT manipulation in the kernel).
> 
> I'm not clear on that either, but it seems plausible..
> 
> > I'm not sure what would be the alternate mechanism to hook into the
> > address translation. of_translate_one(), where all the translation
> > through ranges takes place is really tied to the DT only, adding
> > another mechanism to hook some custom address translation in there
> > seems a bit weird, no?
> 
> I agree, some kind of callback scheme would really be needed.. Sort of
> like the xlate callback we have for IRQs?
> 
> So the mbus would register an address xlate for its node that is
> called instead of ranges parsing. For the example in my last message
> the FPGA driver would register an xlate that made addresses relative
> to its own BAR0 address.

Interesting. I admit I never had a look how the IRQ ->xlate() stuff was
hooked into the OF code, maybe it's a good starting point. This
discussion is on the DT mailing list, so maybe some DT person will
agree to let us know what they think the good approach is?

> > However, it just works by pure luck: nothing guarantees you that the
> > PCIe 0 memory window will start at 0xe0000000. Of course, since you
> 
> Right, the general case is totally borked here - the dynamic changes
> to the address map by MBUS and PCI are not being reflected to the
> of_address machinery, be they from MBUS or from PCI BAR assignment.

Right.

> However, address assignment is very predicatble, so if you have a
> constrained system it can work.

Indeed.

> In the normal DT use case (eg on a SPARC or something) the DT itself
> would be self-consistent with the addresses assigned from the firmware
> and the PCI machinery should try to respect the bootloader addresses
> if they are workable during address assignment.

So ARM isn't a "normal DT use case" ? :-)

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
