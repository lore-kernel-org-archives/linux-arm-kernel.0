From: mike@compulab.co.il (Mike Rapoport)
Date: Mon, 20 Sep 2010 09:15:00 +0200
Subject: [PATCH 0/3] [ARM] tegra: PCI Express support
In-Reply-To: <20100919160103.GF9098@n2100.arm.linux.org.uk>
References: <cover.1284655723.git.mike@compulab.co.il>	<201009161912.12330.arnd@arndb.de>	<4C961906.4040303@compulab.co.il>	<201009191639.44488.arnd@arndb.de>	<4C962DF0.8060209@compulab.co.il>
	<20100919160103.GF9098@n2100.arm.linux.org.uk>
Message-ID: <4C9709F4.9040308@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> On Sun, Sep 19, 2010 at 05:36:16PM +0200, Mike Rapoport wrote:
>> Since ARM doesn't have special IO access instructions and all IO is memory
>> mapped, from the CPU perspective IO window would be at some arbitrary 
>> physical address. For Tegra this address can be anywhere between 
>> 0x80004000 and 0x8fffffff. With sizes and offsets in my implementation 
>> the  IO resources would be defined as follows:
>> struct tegra_pcie_io_res[] = {
>> 	[0] = {
>> 		.start = 0x80400000,
>> 		.end   = 0x804fffff,
>> 		.flags	= IORESOURCE_IO,
>> 	},
>> 	[1] = {
>> 		.start = 0x80500000,
>> 		.end   = 0x805fffff,
>> 		.flags	= IORESOURCE_IO,
>> 	},
>> }
> 
> These aren't IO resources - they're describing an area of physical
> host memory, so they should be IORESOURCE_MEM.
> 
>> And then a call to request_resource(&ioport_resource, &tegra_pcie_io_res) 
>> fails because Tegra IO resources do not fit into the global 
>> ioport_resource definition.
> 
> And therefore they should not be registered against the ioport resource.
> 
> 
> Think about it like this:
> 
> iomem_resource (CPU physical
> address space view):
> +------------+ 0x00000000
> |  RAM etc   |
> /            /
> /            /
> |            |                    ioport_resource
> +------------+ 0x80400000 ------> +-----------------+ 0x00000000
> |            |                    | PCI peripherals |
> |            |                    |                 |
> |            | 0x804003f8         +-----------------+ 0x000003f8
> |            |                    | Eg, PCI serial  |
> |PCI IO space| 0x804003ff         +-----------------+ 0x000003ff
> |            |                    |                 |
> |            |                    |                 |
> |            |                    | PCI peripherals |
> |            |                    |                 |
> |            |                    |                 |
> +------------+ 0x805fffff ------> +-----------------+ 0x001fffff
> |            |
> /other stuff /
> /            /
> |            |
> +------------+ 0xffffffff
> 
> So the iomem resource tree is entirely separate from the ioport resource
> tree, and the two never overlap.  The iomem resource tree represents the
> physical MMIO space, and just contains a reservation for the entire block
> of PCI IO space.  The ioport resource represents the entirely separate
> PCI IO space resource tree.

 From what you are saying I understand that the region reservation should look like:

static struct resource res_mmio = {
	.name	= "PCI IO"
	.start	= 0x80400000,
	.end	= 0x80400000 + IO_SIZE,
	.flags	= IORESOURCE_MEM,
};

static struct resource pcie_res[] = {
	[0] = {
		.name	= "PCIe IO",
		.start	= 0x1000,
		.end	= 0x1000 + IO_SIZE - 1,
		.flags	= IORESOURCE_IO,
	},
	[1] = {
		.name	= "PCIe MEM",
		.start	= MEM_BASE,
		.end	= MEM_BASE + MEM_SIZE - 1,
		.flags	= IORESOURCE_MEM,
	},
};

static int tegra_pcie_setup(int nr, struct pci_sys_data *sys)
{
	request_region(&iomem_resource, &res_mmio);
	request_region(&iomem_resource, &pcie_res[1]);
	request_region(&ioport_resource, &pcie_res[0]);
	sys->resource[0] = &pcie_res[0];
	sys->resource[1] = &pcie_res[1];
}

I've used 0x1000 as IO resources start because having it 0 would cause 
pcibios_enable_device to fail.

Is the above setup reasonable enough or I'm missing something else?

> To illustrate this better, on Footbridge, this is what you see in
> /proc/iomem:
> 00000000-07ffffff : System RAM
>   0002d000-002a9fff : Kernel text
>   002aa000-002e7c77 : Kernel data
> 42000160-4200017f : Footbridge UART
> a0000000-bfffffff : Footbridge prefetch
>   a0000000-a001ffff : 0000:00:07.0
>   a0020000-a003ffff : 0000:00:08.0
>   a0040000-a004ffff : 0000:00:09.0
> c0000000-ffffffff : Footbridge non-prefetch
>   c0000000-c3ffffff : 0000:00:09.0
>   c4000000-c4000fff : 0000:00:06.3
>   c4001000-c400107f : 0000:00:08.0
> 
> Note that 7c000000-7c00ffff is the address range used for PCI IO accesses,
> and isn't requested in the above (mainly because we never registered a
> separate resource for it.)
> 
> and /proc/ioports:
> 0000-000f : dma1
> 0020-003f : pic1
> 0060-006f : i8042
> 0070-0073 : rtc_cmos
>   0070-0073 : rtc0
> 0080-008f : dma low page
> 00a0-00bf : pic2
> 00c0-00df : dma2
> 01f0-01f7 : ide0
> 0213-0213 : ISAPnP
> 02f8-02ff : serial8250.0
>   02f8-02ff : serial
> 03c0-03df : vga+
> 03f6-03f6 : ide0
> 03f8-03ff : serial8250.0
>   03f8-03ff : serial
> 0480-048f : dma high page
> 0a79-0a79 : isapnp write
> 1000-107f : 0000:00:08.0
> 1080-108f : 0000:00:06.1
>   1080-1087 : ide0
> 1090-109f : 0000:00:07.0
>   1090-1097 : ide1
>   1098-109f : ide2
> 10a0-10a7 : 0000:00:07.0
>   10a0-10a7 : ide1
> 10a8-10af : 0000:00:07.0
>   10a8-10af : ide2
> 10b0-10b3 : 0000:00:07.0
>   10b2-10b2 : ide1
> 10b4-10b7 : 0000:00:07.0
>   10b6-10b6 : ide2
> ff00-ff7f : Footbridge
> 
> Note that IO accesses correspond to 0x7c000000 + IO address in iomem space.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


-- 
Sincerely yours,
Mike.
