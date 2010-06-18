From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 18 Jun 2010 14:13:01 +0100
Subject: Platform data with function pointers
In-Reply-To: <000901cb0ee4$68e19e20$3aa4da60$@Pieralisi@arm.com>
References: <-71663801230973480@unknownmsgid>
	<AANLkTikqONUs722_ev6hqfpJiehUq2qAGWGhmxg6WkTs@mail.gmail.com>
	<000901cb0ee4$68e19e20$3aa4da60$@Pieralisi@arm.com>
Message-ID: <20100618131301.GA21333@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 18, 2010 at 01:47:28PM +0100, Lorenzo Pieralisi wrote:
> I think chip-select addressing should be used if that is the way HW handles it. If the device is described through a memory-mapping,
> ex. snippet follows:
> 
> serial at 101f2000 {
>         compatible = "arm,pl011";
>         reg = <0x101f2000 0x1000 >;
> };

Primecell devices aren't platform devices.  They have no 'id' field as
such.  Instead, modern implementations have PCI-like IDs.

> struct map_desc {
> 	unsigned long virtual;
> 	unsigned long pfn;
> 	unsigned long length;
> 	unsigned int type;
> };
> 
> static struct map_desc realview_eb_io_desc[] __initdata = {
> 	{
> 		.virtual	= IO_ADDRESS(REALVIEW_SYS_BASE),
> 		.pfn		= __phys_to_pfn(REALVIEW_SYS_BASE),
> 		.length		= SZ_4K,
> 		.type		= MT_DEVICE,
> 	}, ...

These mappings are entirely arbitary, and change according to the
implementation of the platform.

Some platforms want to avoid using ioremap() to create 4K page mappings
for their devices, so instead they statically map them and arrange for
ioremap() to know about that static mapping.

Given that PAGE_OFFSET can be changed, it would be absolutely silly to
put this into the device tree.
