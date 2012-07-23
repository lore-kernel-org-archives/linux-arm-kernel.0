From: robherring2@gmail.com (Rob Herring)
Date: Mon, 23 Jul 2012 09:05:57 -0500
Subject: [PATCH v2 05/15] ARM: integrator: use fixed PCI i/o mapping
In-Reply-To: <20120723121920.GE31521@mudshark.cambridge.arm.com>
References: <1342231451-28861-1-git-send-email-robherring2@gmail.com>
 <5005A8A4.6040608@gmail.com>
 <20120721143122.GA26790@mudshark.cambridge.arm.com>
 <201207212156.43941.arnd@arndb.de>
 <CAL_JsqJmN3+1Gb5dF+9eL5c742_-mzg61VcvYhEQpabh5VE=kg@mail.gmail.com>
 <20120722150811.GA29535@mudshark.cambridge.arm.com>
 <CAL_JsqJsepaArV_otTXvt+inK+UtWVabZLkoDkgcVXOH=e58pA@mail.gmail.com>
 <20120723121920.GE31521@mudshark.cambridge.arm.com>
Message-ID: <500D5A45.9070404@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/23/2012 07:19 AM, Will Deacon wrote:
> On Sun, Jul 22, 2012 at 05:21:33PM +0100, Rob Herring wrote:
>> On Jul 22, 2012 11:08 AM, "Will Deacon" <will.deacon at arm.com<mailto:will.deacon@arm.com>> wrote:
>>> Now, the next line is usually when the VGA text console is poked. Sure
>>> enough, disabling that (CONFIG_VGA_CONSOLE) is enough to boot with your
>>> patches and PCI appears to work correctly (I can do basic networking).
>>>
>>> I guess there's some mapping race with the VGA code since vga_base =
>>> PCI_MEMORY_VADDR, but you left the static mapping alone for that region,
>>> so I'm not sure. Any ideas?
>>
>> Perhaps pcibios_min_io changing from 6000 to default of 1000 causes probing for vga?
> 
> I can try changing it back and see it makes a difference sometime this week.
> It certainly smells like some probing is going on before the PCI stuff is up
> and running and I suspect that the static mapping just leads to a hang rather
> than an abort.

Now that I have looked at the code. I think it is simply vgacon is
postcore_init and pci setup of the i/o mapping is in subsys_init. It
curious that you don't get an abort and backtrace though.

vgacon is only enabled for footbridge and integrator. I guess the only
way this worked before is if the bootloader has already setup the bus.
So I can add back an early mapping function that these 2 platforms can
call from .map_io. Something like this:

static inline void __init pci_map_io_early(unsigned long pfn)
{
	struct map_desc pci_io_desc = {
		.virtual	= PCI_IO_VIRT_BASE,
		.type		= MT_DEVICE,
		.length		= SZ_64K,
	};
	
	pci_io_desc.pfn = pfn;
	create_mapping(&pci_io_desc);
}

Rob
