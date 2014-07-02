From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 02 Jul 2014 14:30:31 +0200
Subject: [PATCH v8 3/9] pci: Introduce pci_register_io_range() helper
 function.
In-Reply-To: <20140701204508.GA19569@bart.dudau.co.uk>
References: <1404240214-9804-1-git-send-email-Liviu.Dudau@arm.com>
 <8556461.i7qCGvGY5a@wuerfel> <20140701204508.GA19569@bart.dudau.co.uk>
Message-ID: <7343032.WUqPgbXNQS@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 01 July 2014 21:45:09 Liviu Dudau wrote:
> On Tue, Jul 01, 2014 at 09:36:10PM +0200, Arnd Bergmann wrote:
> > On Tuesday 01 July 2014 19:43:28 Liviu Dudau wrote:
> > 
> > This still conflicts with the other allocator you have in patch 9
> > for pci_remap_iospace: nothing guarantees that the mapping is the
> > same for both.
> > 
> > Also, this is a completely pointless exercise at this moment, because
> > nobody cares about the result of pci_address_to_pio on architectures
> > that don't already provide this function. If we ever get a proper
> > Open Firmware implementation that wants to put hardcoded PCI devices
> > into DT, we can add an implementation, but for now this seems overkill.
> > 
> > The allocator in pci_register_io_range seems reasonable, why not merge
> > this function with pci_remap_iospace() as I have asked you multiple
> > times before? Just make it return the io_offset so the caller can
> > put that into the PCI host resources.
> 
> Hi Arnd,
> 
> While I agree with you that at some moment the allocators were inconsistent
> wrt each other, for this version I would respectfully disagree on this.
> The allocator in pci_register_io_range() only makes sure that the ranges
> are not overlapping, it doesn't do any mapping whatsoever, while
> pci_remap_iospace() does only an ioremap_page_range(). The idea is that
> you get the offset out of pci_address_to_pio() and apply it to
> pci_remap_iospace().

Ok, got it now, I'm sorry I didn't read this properly at first.

Your solution looks correct to me, just using different
tradeoffs to what I was expecting: You get a working pci_address_to_pio()
function, which is probably never needed, but in turn you need to
keep the state of each host bridge in a global list.

	Arnd
