From: robherring2@gmail.com (Rob Herring)
Date: Tue, 24 Jul 2012 08:25:37 -0500
Subject: [GIT PULL] io.h clean-up for PCI
In-Reply-To: <201207241243.55640.arnd@arndb.de>
References: <50049285.1060100@gmail.com> <201207191412.00540.arnd@arndb.de>
 <500E962D.2080104@gmail.com> <201207241243.55640.arnd@arndb.de>
Message-ID: <500EA251.1090000@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/24/2012 07:43 AM, Arnd Bergmann wrote:
> On Tuesday 24 July 2012, Rob Herring wrote:
>>> --- a/arch/arm/mach-iop13xx/include/mach/iop13xx.h
>>> +++ b/arch/arm/mach-iop13xx/include/mach/iop13xx.h
>>> @@ -95,7 +95,6 @@ extern unsigned long get_iop_tick_rate(void);
>>>  /* PCI-E ranges */
>>>  #define IOP13XX_PCIE_LOWER_IO_PA              0xfffd0000UL
>>>  #define IOP13XX_PCIE_LOWER_IO_BA              0x0UL  /* OIOTVR */
>>> -#define IOP13XX_PCIE_LOWER_IO_BA              0x10000UL
>>
>> This means we have PCIE and PCIX buses both using i/o bus addresses
>> starting at 0x0. We can't have that, right?
>>
>> The requested resource won't match either as the resource start address
>> is bus_nr * 64K.
> 
> Well, this is the number that gets written into the outbound
> translation window register, which has to be zero AFAICT.
> 
> The PCI device you plug into the bus will always see its io
> ports as being between zero and 65536 -- the part that
> stays at 0x10000UL is the offset address that we use in Linux
> to give it a unique address in the virtual address space
> window we use to cover all the io port ranges.
> 
> The io_offset still gets set to 0x10000, so this number always
> gets added and subtracted when converting between Linux port
> numbers and bus-specific port numbers.

Okay, then this is probably something I need to fix.

How is mem_offset supposed to be set? Generally memory is setup as cpu
base paddr = pci mem addr, so mem_offset should be 0? But integrator is
set to the cpu paddr, and it works.

Rob

> 
> 	Arnd
> 
