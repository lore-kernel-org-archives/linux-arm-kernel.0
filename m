From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Fri, 22 Jun 2012 16:02:10 +0200
Subject: [PATCH v2 07/10] ARM: tegra: pcie: Add device tree support
In-Reply-To: <201206221348.39346.arnd@arndb.de>
References: <20120613081910.GB6528@avionic-0098.mockup.avionic-design.de>
 <20120622110403.GA15710@avionic-0098.mockup.avionic-design.de>
 <20120622132253.GA30704@avionic-0098.mockup.avionic-design.de>
 <201206221348.39346.arnd@arndb.de>
Message-ID: <20120622140210.GA32097@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 22, 2012 at 01:48:39PM +0000, Arnd Bergmann wrote:
> On Friday 22 June 2012, Thierry Reding wrote:
> > > It seems like this isn't working properly. For some reason both the reg
> > > property of pci at 0 and pci at 1 are translated to the same parent address
> > > 0x80000000. I'll have to investigate where exactly this goes wrong.
> > 
> > So it turns out that while of_read_number() can actually read any number
> > of cells, only the two least significant are kept because it returns a
> > u64. Since of_bus_default_map() uses of_read_number() the addresses
> > <0 0 0> and <1 0 0> are in fact the same. I'm not sure how best to solve
> > this. I'm not aware of a 128 bit integer type in the kernel, so I guess
> > the better alternative would be to fix of_bus_default_map() to cope with
> > #address-cells > 2 properly.
> 
> of_translate_address should get it right. Which codes uses of_read_number()?
> Can it be converted to use of_translate_address()?

Actually this is from of_translate_address(). The calling sequence looks
like this:

	of_address_to_resource()
	  __of_address_to_resource()
	    of_translate_address()
	      __of_translate_address()
	        of_translate_one()
	          of_bus_default_map()
	            of_read_number()

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120622/96546a0c/attachment.sig>
