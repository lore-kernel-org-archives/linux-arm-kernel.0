From: ddaney@caviumnetworks.com (David Daney)
Date: Tue, 14 Jul 2015 09:58:20 -0700
Subject: [PATCH] arm64: Define HAVE_ARCH_PIO_SIZE and related symbols.
In-Reply-To: <20150714162955.GR16213@arm.com>
References: <1436823096-24059-1-git-send-email-ddaney.cavm@gmail.com>
 <20150714110039.GC16213@arm.com> <55A53509.4060202@caviumnetworks.com>
 <20150714162955.GR16213@arm.com>
Message-ID: <55A53FAC.30103@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/14/2015 09:29 AM, Will Deacon wrote:
> On Tue, Jul 14, 2015 at 05:12:57PM +0100, David Daney wrote:
>> On 07/14/2015 04:00 AM, Will Deacon wrote:
>>> On Mon, Jul 13, 2015 at 10:31:36PM +0100, David Daney wrote:
>>>> From: David Daney <david.daney@cavium.com>
>>>>
>>>> Needed to make pci_iomap() work.
>>>
>>> Care to elaborate?
>>>
>>
>> I should have explained what I am doing here a little better.
>
> Yeah, thanks.
>
>> Systems based on the Cavium ThunderX processor may have up to 8
>> independent PCIe root complexes.  The I/O space on each bus occupies an
>> independent physical address window.
>
> Hmm, so do you have 64k of I/O space per-bus? That gives 8x256x64k = 128M
> IIUC, so not sure what your 32MB is for.

I don't understand where your 256 came from there.

Actually, my current implementation has 1M per bus(which is overkill). 
For 8 buses I need 8M, which fits within the PCI_IO_SIZE...

>
>> So, in order to be able to map all of these (semi) contiguously, we need
>> a lot more virtual address space than is supplied by the default values
>> for all these constants.
>>
>> The option I chose here was to unconditionally expand the I/O ranges for
>> all arm64 systems.  If you think this breaks existing systems/drivers, I
>> will have to look for other options.
>
> Hmm, but pci_iomap winds up calling __pci_ioport_map, which expands to
> ioport_map which just does:
>
> 	return PCI_IOBASE + (port & IO_SPACE_LIMIT);
>
> so I'm struggling to see what your patch achieves.

Here is ioport_map (from lib/iomap.c):


void __iomem *ioport_map(unsigned long port, unsigned int nr)
{
	if (port > PIO_MASK)
		return NULL;
	return (void __iomem *) (unsigned long) (port + PIO_OFFSET);
}

With the default value of PIO_MASK (64K), I cannot map any I/O ports on 
my PCIe RC 1..7

The values I supplied in my patch may be sub-optimal, but I think 
something is needed.  I will look into this in a little more detail today.

Thanks,
David Daney


>
> Will
>
