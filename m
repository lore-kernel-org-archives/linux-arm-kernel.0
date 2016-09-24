From: zhichang.yuan02@gmail.com (zhichang)
Date: Sat, 24 Sep 2016 16:14:15 +0800
Subject: [PATCH V3 2/4] ARM64 LPC: LPC driver implementation on Hip06
In-Reply-To: <1849232.KJrfRPHGN6@wuerfel>
References: <1473855354-150093-1-git-send-email-yuanzhichang@hisilicon.com>
 <10705430.q2aqv5uYO3@wuerfel>
 <EE11001F9E5DDD47B7634E2F8A612F2E1F8850F2@lhreml507-mbx>
 <1849232.KJrfRPHGN6@wuerfel>
Message-ID: <05a573de-e963-6590-6ed3-55af97067d7a@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Arnd,

On 2016?09?23? 23:55, Arnd Bergmann wrote:
> On Friday, September 23, 2016 2:59:55 PM CEST Gabriele Paoloni wrote:
>>
>>>> From the perspective of the indirect IO function the input parameter
>>>> is an unsigned long addr that (now) can be either:
>>>> 1) an IO token coming from a legacy pci device
>>>> 2) a phys address that lives on the LPC bus
>>>>
>>>> These are conceptually two separate address spaces (and actually they
>>>> both start from 0).
>>>
>>> Why? Any IORESOURCE_IO address always refers to the logical I/O port
>>> range in Linux, not the physical address that is used on a bus.
>>
>> If I read the code correctly when you get an I/O token you just add it
>> to PCI_IOBASE.
>> This is enough since pci_remap_iospace set the virtual address to 
>> PCI_IOBASE + the I/O token offset; so we can read/write to
>> vaddr = PCI_IOBASE + token as pci_remap_iospace has mapped it correctly
>> to the respective PCI cpu address (that is set in the I/O range property
>> of the host controller)
>>
>> In the patchset accessors LPC operates directly on the cpu addresses
>> and the input parameter of the accessors can be either an IO token or
>> a cpu address
>>
>> +static inline void outb(u8 value, unsigned long addr)
>> +{
>> +#ifdef CONFIG_ARM64_INDIRECT_PIO
>> +       if (arm64_extio_ops && arm64_extio_ops->start <= addr &&
>> +                       addr <= arm64_extio_ops->end)
>>
>> Here below we operate on cpu address
>>
>> +               extio_outb(value, addr);
>> +       else
>> +#endif
> 
> I missed this bug earlier, this obviously needs to be
> 
> 		arm64_extio_ops->outb(value, addr - arm64_extio_ops->start);
> 
> or possibly
> 
> 		arm64_extio_ops->outb(arm64_extio_ops, value, addr);
> 
> as the outb function won't know what the offset is, but
> that needed to be fixed regardless.

In V3, the outb is :

void outb(u8 value, unsigned long addr)
{
	if (!arm64_extio_ops || arm64_extio_ops->start > addr ||
			arm64_extio_ops->end < addr)
		writeb(value, PCI_IOBASE + addr);
	else
		if (arm64_extio_ops->pfout)
			arm64_extio_ops->pfout(arm64_extio_ops->devpara,
				addr + arm64_extio_ops->ptoffset, &value,
				sizeof(u8), 1);
}

here, arm64_extio_ops->ptoffset is the offset between the real legacy IO address
and the logical IO address, similar to the offset of primary address and
secondary address in PCI bridge.

But in V3, LPC driver call pci_address_to_pio to request the logical IO as PCI
host bridge during its probing.


cheers,
Zhichang



> 
> 	Arnd
> 
