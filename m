From: robherring2@gmail.com (Rob Herring)
Date: Tue, 14 Feb 2012 17:09:01 -0600
Subject: [PATCH 13/15] ARM: make mach/io.h include optional
In-Reply-To: <20120214174035.GA29765@n2100.arm.linux.org.uk>
References: <1329169408-17253-1-git-send-email-robherring2@gmail.com>
 <201202140804.49026.arnd@arndb.de> <4F3A7158.2080702@gmail.com>
 <201202141716.26930.arnd@arndb.de>
 <20120214174035.GA29765@n2100.arm.linux.org.uk>
Message-ID: <4F3AE98D.7030104@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/14/2012 11:40 AM, Russell King - ARM Linux wrote:
> On Tue, Feb 14, 2012 at 05:16:26PM +0000, Arnd Bergmann wrote:
>> On Tuesday 14 February 2012, Rob Herring wrote:
>>> On 02/14/2012 02:04 AM, Arnd Bergmann wrote:
>>>> On Tuesday 14 February 2012, Rob Herring wrote:
>>>>
>>>>> If we use CONFIG_PCI, then we have to move over all PCI enabled
>>>>> platforms at once. With a separate kconfig option, then we can move
>>>>> platforms one by one. Some are legacy and we may not want to move. This
>>>>> also helped with omap, but Tony has now fixed it.
>>>>
>>>> We could also generalize the implementation from tegra, which seems
>>>> reasonable as a start:
>>>>
>>>>
>>>> #define IO_SPACE_LIMIT 0xffff
>>>>
>>>> #if defined(CONFIG_ISA) || defined(CONFIG_PCCARD)
>>>> #include <mach/io.h>
>>>> #elif defined(CONFIG_PCI)
>>>> extern void __iomem *pci_io_base;
>>>>
>>>> static inline void __iomem *__io(unsigned long addr)
>>>> {
>>>>         return pci_io_base + (addr & IO_SPACE_LIMIT);
>>>
>>> But don't we want a constant pci_io_base? This would certainly be a
>>> quicker conversion, but I don't think we want to do it twice.
>>
>> Yes, at least in the long run. Note that this should make no difference
>> at all from a performance point of view, but it does impact code size a bit.
> 
> That depends whether the additional reloads of pci_io_base can be properly
> scheduled by the compiler, and experience shows that you tend to end up
> with the load delay slot _not_ being filled on older processors.
> 
> Not only that, but the compiler _will_ evaluate the entire:
> 
> 	pci_io_base + (addr & IO_SPACE_LIMIT)
> 
> thing every time.  With a 64K mask, that will include _reloading_ the
> mask every single access.
> 
> So, we'll probably end up with about three additional loads per IO
> operation, none of which would be scheduled particularly well.
> 
> "Yuck" and "not in my kernel" comes to mind.

What about something like this:

io.h:
#define PCI_IO_VIRT_BASE 0xfef00000

arch/arm/common/pci.c (new file):
static struct map_desc pci_io_desc[] __initdata = {
	{
		.virtual	= PCI_IO_VIRT_BASE,
		.pfn		= 0,
		.length		= SZ_1M,
		.type		= MT_DEVICE,
	},
};

void __init pci_map_io(unsigned long paddr)
{
	pci_io_desc[0].pfn = __phys_to_pfn(paddr);
	iotable_init(pci_io_desc, ARRAY_SIZE(pci_io_desc));
}


This is using the last 1MB of vmalloc region. This may require some
adjustment of platform's static memory, but most PCI platforms I've
checked don't use this address, so it shouldn't be too painful.

orion5x maps 2 1MB regions for PCI and PCIE. How would you support 2 io
ranges?

BTW, I noticed some static mappings at 0xffxxxxxx. Are those even a
valid address?

Rob
