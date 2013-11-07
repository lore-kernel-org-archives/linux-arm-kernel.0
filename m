From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 7 Nov 2013 10:01:47 -0700
Subject: address translation for PCIe-to-localbus bridge
In-Reply-To: <527B5835.3060906@keymile.com>
References: <527A1983.6020603@keymile.com>
 <20131106173649.GA25515@obsidianresearch.com>
 <527A9AB9.2050903@keymile.com>
 <20131106200709.GB26881@obsidianresearch.com>
 <527B5835.3060906@keymile.com>
Message-ID: <20131107170147.GA1057@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 07, 2013 at 10:07:01AM +0100, Gerlando Falauto wrote:
> On 11/06/2013 09:07 PM, Jason Gunthorpe wrote:
> >On Wed, Nov 06, 2013 at 08:38:33PM +0100, Gerlando Falauto wrote:
> >
> [...]
> >Each translation represents something concrete:
> >  0x8 -> 0x82000000 0x00000000 0x00000008
> >     This is the BAR 0 decoder of the PCI device
> >  0x82000000 0x00000000 0x00000008 -> 0x82000000 0x1 8
> >     This is the PCI bridge's memory window decoder
> >   0x82000000 0x1 8 -> MBUS_ID(0x04, 0xe8) 8
> >     This is the MBUS window associated with the PEX
> >  MBUS_ID(0x04, 0xe8) 8 -> 0xe0000008
> >     This is the physical CPU BUS address associated with the MBUS
> >     window
> 
> Uhm, OK, sounds good. Except you must know the whole mapping in
> advance. Fair enough.
> Would that work without the whole mbus driver (I guess Ezequiel's)?
> I'm dealing with 3.10.

Yes, I am using this in 3.10. On 3.10 the ranges at the mbus level has
to match the hardwired address mapping in Linux.

> Where does the 0x82000000 come from?
> What about the 0x1 (second cell)?

0x82000000 is part of the OF PCI spec, it indicates the address space
is memory (vs io, vs prefetchable memory, etc)

The 0x1 is an arbitary unique value that matches the next ranges. It
would probably have been clearer if it was MBUS_ID(0x04, 0xe8)
instead...

> >   ranges = <0x00000000  0x82000000 0x00000000 0x08000000  0x8000000>;
> >
> >It is possible as well to do this in code in the FPGA driver.
> 
> Uhm... why? And how? You mean dynamically upgrading the ranges window?

If you can't predict where your BAR will be assigned when you create
the DT then you could update the ranges value at runtime in your pci
driver before probing the children. A bit hacky.

> >
> >>How would you also deal with a second (let's say identical) device on BAR1?
> >
> >   ranges = <0x00000000  0x82000000 0x00000000 0x08000000  0x8000000  //  BAR 0
> >             0x10000000  0x82000000 0x00000000 0x08000000  0x8000000> // BAR 1
> 
> Aren't in this case the two regions aliased? Shouldn't the fourth
> column on either row be 0x00000000? Like:

Yes, you are right!

>     ranges = <0x00000000  0x82000000 0x00000000 0x00000000
> 0x8000000 //  BAR 0
>               0x10000000  0x82000000 0x00000000 0x08000000
> 0x8000000> // BAR 1
> 
> >Use reg <0x10000abc xxx> to refer to the 2nd BAR. There are other ways
> >to organize things.
>
> Now I completely lost you. According to the above description (BTW,
> I like the double space to separate groups -- it makes this whole
> mess a little messy!) the child address should have a single cell.
> Why use two then?

0x10000abc is the address, xxxx is the size, reg always has address +
size

Jason
