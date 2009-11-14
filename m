From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Sun, 15 Nov 2009 00:37:14 +0100
Subject: IXP4xx: Indirect PCI MMIO compile failure
In-Reply-To: <20091114231854.GB30027@n2100.arm.linux.org.uk> (Russell King's
	message of "Sat, 14 Nov 2009 23:18:54 +0000")
References: <m3pr7kyi9x.fsf@intrepid.localdomain>
	<20091114210533.GA30027@n2100.arm.linux.org.uk>
	<m34oowyako.fsf@intrepid.localdomain>
	<20091114231854.GB30027@n2100.arm.linux.org.uk>
Message-ID: <m3fx8gwudx.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

>>  static inline void __indirect_iounmap(void __iomem *addr)
>>  {
>> -	if ((__force u32)addr >= VMALLOC_START)
>> +	if (!is_pci_memory(__force u32)addr)
>
> So here you're testing a virtual address against a pci address.

There is 1:1 mapping on IXP4xx with indirect PCI MMIO:

static inline void __iomem *
__ixp4xx_ioremap(unsigned long addr, size_t size, unsigned int mtype)
{
        if((addr < PCIBIOS_MIN_MEM) || (addr > 0x4fffffff))
                return __arm_ioremap(addr, size, mtype);

        return (void __iomem *)addr;
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
}

The __iomem *addr is not really a pointer, it's just a cookie which can
only be passed to the indirect routines.
-- 
Krzysztof Halasa
