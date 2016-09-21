From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 21 Sep 2016 22:18:16 +0200
Subject: [PATCH V3 2/4] ARM64 LPC: LPC driver implementation on Hip06
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E1F87D223@lhreml507-mbx>
References: <1473855354-150093-1-git-send-email-yuanzhichang@hisilicon.com>
 <e246c886-e0eb-b635-01ae-f00bbfcfb56b@gmail.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E1F87D223@lhreml507-mbx>
Message-ID: <3538381.vOsx75UXVU@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, September 21, 2016 4:20:55 PM CEST Gabriele Paoloni wrote:
> > -----Original Message-----
> > From: zhichang [mailto:zhichang.yuan02 at gmail.com]
> > On 2016?09?15? 20:24, Arnd Bergmann wrote:
> > > On Thursday, September 15, 2016 12:05:51 PM CEST Gabriele Paoloni
> > wrote:
> > >>> -----Original Message-----
> > >>> On Thursday, September 15, 2016 8:02:27 AM CEST Gabriele Paoloni
> > wrote:
> > >> I think that maybe having the 1:1 range mapping doesn't
> > >> reflect well the reality but it is the less painful
> > >> solution...
> > >>
> > >> What's your view?
> > >
> > > We can check the 'i' bit for I/O space in of_bus_isa_get_flags,
> > > and that should be enough to translate the I/O port number.
> > >
> > > The only part we need to change here is to not go through
> > > the crazy conversion all the way from PCI I/O space to a
> > > physical address and back to a (logical) port number
> > > that we do today with of_translate_address/pci_address_to_pio.
> > >
> > Sorry for the late response! Several days' leave....
> > Do you want to bypass of_translate_address and pci_address_to_pio for
> > the registered specific PIO?
> > I think the bypass for of_translate_address is ok, but worry some new
> > issues will emerge without the
> > conversion between physical address and logical/linux port number.

The same function that handles the non-translated region would
do that conversion.

> > When PCI host bridge which support IO operations is configured and
> > enabled, the pci_address_to_pio will
> > populate the logical IO range from ZERO for the first host bridge. Our
> > LPC will also use part of the IO range
> > started from ZERO. It will make in/out enter the wrong branch possibly.
> > 
> > In V2, the 0 - 0x1000 logical IO range is reserved for LPC use only.
> > But it seems not so good. In this way,
> > PCI has no chance to use low 4K IO range(logical).
> > 
> > So, in V3, applying the conversion from physical/cpu address to
> > logical/linux IO port for any IO ranges,
> > including the LPC, but recorded the logical IO range for LPC. When
> > calling in/out with a logical port address,
> > we can check this port fall into LPC logical IO range and get back the
> > real IO.

Right, and the same translation can be used in __of_address_to_resource()
going the opposite way.

> > Do you have further comments about this??
> 
> I think there are two separate issues to be discussed:
> 
> The first issue is about having of_translate_address failing due to
> "range" missing. About this Arnd suggested that it is not appropriate
> to have a range describing a bridge 1:1 mapping and this was discussed
> before in this thread. Arnd had a suggestion about this (see below) 
> however (looking twice at the code) it seems to me that such solution 
> would lead to quite some duplication from __of_translate_address()
> in order to retrieve the actual addr from dt...

I don't think we need to duplicate much, we can probably safely
assume that there are no nontrivial ranges in devices below the LPC
node, so we just walk up the bus to see if the node is a child
(or possibly grandchild etc) of the LPC bus, and treat any IO port
number under there as a physical port number, which has a known
offset from the Linux I/O port number.

> I think extending of_empty_ranges_quirk() may be a reasonable solution.
> What do you think Arnd?

I don't really like that idea, that quirk is meant to work around
broken DTs, but we can just make the DT valid and implement the
code properly.

> The second issue is a conflict between cpu addresses used by the LPC
> controller and i/o tokens from pci endpoints.
> 
> About this what if we modify armn64_extio_ops to have a list of ranges
> rather than only one range (now we have just start/end); then in the
> LPC driver we can scan the LPC child devices and 
> 1) populate such list of ranges
> 2) call pci_register_io_range for such ranges

Scanning the child devices sounds really wrong, please register just
one range that covers the bus to keep the workaround as simple
as possible.

> Then when calling __of_address_to_resource we retrieve I/O tokens 
> for the devices on top of the LPC driver and in the I/O accessors
> we call pci_pio_to_address to figure out the cpu address and compare
> it to the list of ranges in armn64_extio_ops.
>   
> What about this?

That seems really complex for something that can be quite simple.
The only thing we need to worry about is that the io_range_list
contains an entry for the LPC bus so we don't conflict with the
PCI buses.

	Arnd

	Arnd
