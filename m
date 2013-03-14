From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Thu, 14 Mar 2013 10:01:20 +0100
Subject: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP systems
In-Reply-To: <20130313222102.GA28336@obsidianresearch.com>
References: <20130312203819.GA23221@avionic-0098.mockup.avionic-design.de>
 <20130312210328.GA22702@obsidianresearch.com>
 <20130312213006.GA23717@avionic-0098.mockup.avionic-design.de>
 <20130312220854.GA23112@obsidianresearch.com>
 <20130313081815.GD25940@avionic-0098.mockup.avionic-design.de>
 <20130313170205.GB24042@obsidianresearch.com>
 <20130313192628.GA28714@avionic-0098.mockup.avionic-design.de>
 <5140E85A.3040900@firmworks.com>
 <20130313220235.GA29895@avionic-0098.mockup.avionic-design.de>
 <20130313222102.GA28336@obsidianresearch.com>
Message-ID: <20130314090120.GA2224@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 13, 2013 at 04:21:02PM -0600, Jason Gunthorpe wrote:
> On Wed, Mar 13, 2013 at 11:02:35PM +0100, Thierry Reding wrote:
>  
> > Does that look about correct?
> 
> By my reading of the spec the entries in ranges should not
> have the b,d,f bits set..
> 
> Although it is not a big stretch to include them..
> 
> > Now the code will actually match the first entry and assume that it
> > represents the non-prefetchable 32-bit memory space and program the
> > controller to forward accesses to the 0x80000000-0x80000fff region
> > as PCI memory write transactions.
> 
> Yah, it makes a mess of determining the host bridge aperture. Require
> the aperture to be first/last?
> 
> Make use of the 2nd dword?
> 
> Go back to the idea of the top level reg?

It turns out that this works with the Tegra driver because it uses the
new of_pci_process_ranges() function and simply overwrites earlier
matches by subsequent ones.

	ranges = <0x82000000 0 0 0x80000000 0 0x00001000   /* port 0 registers */
		  0x82000000 0 0 0x80001000 0 0x00001000   /* port 1 registers */
		  0x81000000 0 0 0x82000000 0 0x00010000   /* downstream I/O */
		  0x82000000 0 0 0xa0000000 0 0x10000000   /* non-prefetchable memory */
		  0xc2000000 0 0 0xb0000000 0 0x10000000>; /* prefetchable memory */

So the second entry would overwrite the non-prefetchable memory region
as established by the first entry. Finally that will also be overwritten
by the fourth entry.

So the above will actually work along with the corresponding root-port
"assigned-addresses" properties. I still don't like it much because I
don't think it accurately reflects the hardware. Furthermore it has the
same kludgy, non-spec conformant smack that my original proposal had
because it uses assigned-addresses for something it wasn't intended to.
Also the mapping is actually not correct, because the first two entries
don't refer to 32-bit memory space. They really map configuration space
and therefore the ss field is wrong IMO (it should be 00, but that won't
work with the OF core). One of the very early versions of my Tegra PCIe
patch series actually introduced an IORESOURCE_CS type to account for
this but it didn't go anywhere and became obsolete when I switched to
the new binding which side-steps this issue by not using the PCI bus'
translation mechanism.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130314/dd760e71/attachment-0001.sig>
