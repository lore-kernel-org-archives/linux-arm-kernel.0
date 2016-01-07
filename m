From: zourongrong@huawei.com (Rongrong Zou)
Date: Thu, 7 Jan 2016 11:37:35 +0800
Subject: [PATCH v1 3/3] ARM64 LPC: update binding doc
In-Reply-To: <568D1861.1070201@huawei.com>
References: <1451396032-23708-1-git-send-email-zourongrong@gmail.com>
 <6384244.Uhpjfgly6O@wuerfel> <568BB035.1050801@huawei.com>
 <2550495.K9prJVsVEi@wuerfel> <568D1861.1070201@huawei.com>
Message-ID: <568DDD7F.5040909@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2016/1/6 21:36, Rongrong Zou ??:
> ? 2016/1/5 20:19, Arnd Bergmann ??:
>> On Tuesday 05 January 2016 19:59:49 Rongrong Zou wrote:
>>> ? 2016/1/5 0:34, Arnd Bergmann ??:
>>>> On Tuesday 05 January 2016 00:04:19 Rongrong Zou wrote:
>>>>> ? 2016/1/4 19:13, Arnd Bergmann ??:
>>>>>> On Sunday 03 January 2016 20:24:14 Rongrong Zou wrote:
>>>>>>> ? 2015/12/31 23:00, Rongrong Zou ??:
>>>>> Ranges property can set empty, but this means 1:1 translation. the I/O
>>>>> port range is translated to MMIO address 0x00000001 00000000 to
>>>>> 0x00000001 00000004, it looks wrong else. I wonder if anyone get legacy
>>>>> I/O port resource from dts.
>>>>
>>>> As I said, nothing should really require the ranges property here, unless
>>>> you have a valid IORESOURCE_MEM translation. The code that requires
>>>> the ranges to be present is wrong.
>>>>
>>>
>>> I think the openfirmware(DT) do not support for those unmapped I/O ports, because I
>>> must get resource by calling of_address_to_resource(), which have to call
>>> pci_address_to_pio() when resource type is IORESOURCE_IO. I'm sorry I have no
>>> better idea for this now. Maybe liviu can give me some opinions.
>>
>> I think on x86 it works (or used to work, few people use open firmware on
>> x86 these days, and it may be broken), and the pci_address_to_pio() call
>> behaves differently when PCI_IOBASE is set. x86 never maps I/O ports into
>> memory mapped I/O addresses, they have their own way of accessing them
>> just like your platform.
>>

The big problem is:

The return value of_translate_address can be only an cpu addr,
there is no map from cpuaddr to I/O port in x86 as you said,
we still can't get io resource.

static int __of_address_to_resource(struct device_node *dev,
const __be32 *addrp, u64 size, unsigned int flags,
const char *name, struct resource *r)
{
...
taddr = of_translate_address(dev, addrp);
...
}


>>> /**
>>>    * of_address_to_resource - Translate device tree address and return as resource
>>>    *
>>>    * Note that if your address is a PIO address, the conversion will fail if
>>>    * the physical address can't be internally converted to an IO token with
>>>    * pci_address_to_pio(), that is because it's either called to early or it
>>>    * can't be matched to any host bridge IO space
>>>    */
>>> int of_address_to_resource(struct device_node *dev, int index,
>>>                struct resource *r)
>>
>> The problem here seems to be that the code assumes that either the I/O ports
>> are always mapped or they are never mapped (no PCI_IOBASE). We need to extend
>> it because now we can have the combination of the two.
>
>
> I am considering the following solution:
>
> Adding unmapped isa io functions in
>
> drivers/of/address.c,
>
> static LIST_HEAD(legacy_io_range_list);
> int isa_register_io_range(phys_addr_t addr, resource_size_t size);
>
> /* before I call isa(LPC) bus driver, the input I/O port must be translated to phys_addr_t
> (the least 16bit means port addr on bus, the second 16bit means bus id)*/
>
> phys_addr_t isa_pio_to_bus_addr(unsigned long pio);
>
> /* the returned PIO do not conflict with PIO get from pci_address_to_pio*/
> unsigned long isa_bus_addr_to_pio(phys_addr_t address);
>
> drivers/bus/lpc.c
>
> lpc_bus_probe()
> {
>      isa_register_io_range(phys_addr_t addr, resource_size_t size);
> }
>
> inb(unsigned long port)
> {
>      unsigned short bus;
>      phys_addr_t addr;
>      /*hit isa port range*/
>      if(addr = isa_pio_to_bus_addr(port))
>      {
>          bus = (addr >> 16) & 0xffff;
>
>          call lpc driver with addr;
>          return lpc_read_byte(bus, addr);
>      }
>      else /*not hit*/
>      {
>          return readb(PCI_IOBASE + port);
>      }
> }
>
>
>
>>
>>>>> For ipmi driver, I can get I/O port resource by DMI rather than dts.
>>>>
>>>> No, the ipmi driver uses the resource that belongs to the platform
>>>> device already, you can't rely on DMI data to be present there.
>>>
>>> Ipmi has a lot of way to be discovered(ACPI, DMI, hardcoded, hot-add,
>>> openfirmware and a few other), I think we just use one of them, not all of them.
>>> It depend on vendor's hardware solution actually.
>>
>> I don't think we should mix multiple methods here: if the bus is described
>> in DT, all its children should be there as well. Otherwise you get into problems
>> e.g. if you have multiple instances of the LPC bus and the Linux I/O addresses
>> for one or more of them have an offset to the bus specific addresses.
>>
>> The bus probe code decides what the Linux I/O port numbers are, but DMI
>> and other methods have no idea of the mapping. As long as there is only
>> one instance, using the first 0x1000 addresses with a 1:1 mapping saves
>> us a bit of trouble, but I'd be worried about relying on that assumption
>> too much.
>>
>>     Arnd
>>
>>
>> .

-- 
Thanks,

Rongrong
