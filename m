From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 13 Nov 2013 15:26:28 +0900
Subject: address translation for PCIe-to-localbus bridge
In-Reply-To: <5281E2B5.3080701@keymile.com>
References: <527A1983.6020603@keymile.com>
 <20131106173649.GA25515@obsidianresearch.com> <20131106190308.01f7a4a9@skate>
 <20131106182457.GA25879@obsidianresearch.com>
 <20131111155050.96290C41ABB@trevor.secretlab.ca>
 <20131112080512.3992b2e4@skate> <5281E2B5.3080701@keymile.com>
Message-ID: <20131113062628.18272C41F54@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 12 Nov 2013 09:11:33 +0100, Gerlando Falauto <gerlando.falauto@keymile.com> wrote:
> On 11/12/2013 08:05 AM, Thomas Petazzoni wrote:
> > Dear Grant Likely,
> >
> > On Mon, 11 Nov 2013 15:50:50 +0000, Grant Likely wrote:
> >
> >>> So the mbus would register an address xlate for its node that is
> >>> called instead of ranges parsing. For the example in my last message
> >>> the FPGA driver would register an xlate that made addresses relative
> >>> to its own BAR0 address.
> >>
> >> There are already bus-specific transations available. Take a look at
> >> struct of_bus in drivers/of/address.c
> >
> > Hum, right, but unless I'm wrong the of_busses[] array of struct of_bus
> > is fixed in drivers/of/address.c, and as it is, there is no way for a
> > specific bus driver to provide its own struct of_bus.
> 
> That was exactly my understanding as well, and that's where I was 
> expecting some trickery to happen.
> 
> > So that would need to be extended, right?
> 
> The other approach I was foreseeing was to implement a way of 
> dynamically updating the DT when the PCI subsystem enumerates the 
> devices and assigns memory areas (namely, I would expect the ranges 
> property to reflect that). But this would imply a standard way of 
> defining the ranges property (I would expect something like <bar# 
> start_addr length>, with an arguable number of cells). And I could
> not find any such definition in the PCI bus binding document, so I'm 
> probably completely off-track here. Aren't I?

The ranges property is pretty well defined already. The format is
<parent-addr-specifier> <child-addr-specifier> <size-specifier>, and
then use assigned-addresses for each BAR to encode the address it is
assigned to in the PCI address space.

Ranges provides the windows into the parent bus, and assigned-address
is used to map the child into the parent. Using it should make the
of_bus translations work without changes.

Grep the source tree for assigned-addresses to get examples.

> After all, we should expect a driver to behave (and expect) the same of 
> the DT, regardless of whether enumeration was performed by firmware or
> by the OS itself. Or am I wrong on this too?

Yes, that is a reasonable expectation and it is a limitation of the
current implementation. We've got two choices here.  Modify the DT at
boot time, or extend the DT translation code to ask the PCI device for
BAR settings. I'm not going to make a call on which is better until I
see some prototype code.

g.
