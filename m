From: zourongrong@gmail.com (Rongrong Zou)
Date: Sun, 10 Jan 2016 21:38:22 +0800
Subject: [PATCH v1 3/3] ARM64 LPC: update binding doc
In-Reply-To: <56922496.3080402@gmail.com>
References: <1451396032-23708-1-git-send-email-zourongrong@gmail.com>
 <6384244.Uhpjfgly6O@wuerfel> <568BB035.1050801@huawei.com>
 <2550495.K9prJVsVEi@wuerfel> <56922496.3080402@gmail.com>
Message-ID: <56925ECE.2060206@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2016/1/10 17:29, Rolland Chau ??:
> On 2016/1/5 20:19, Arnd Bergmann wrote:
>> On Tuesday 05 January 2016 19:59:49 Rongrong Zou wrote:
>>> ? 2016/1/5 0:34, Arnd Bergmann ??:
>>>> On Tuesday 05 January 2016 00:04:19 Rongrong Zou wrote:
>>>>> ? 2016/1/4 19:13, Arnd Bergmann ??:
>>>>>> On Sunday 03 January 2016 20:24:14 Rongrong Zou wrote:
>>>>>>> ? 2015/12/31 23:00, Rongrong Zou ??:
>>>>> Ranges property can set empty, but this means 1:1 translation. the I/O
>>>>> port range is translated to MMIO address 0x00000001 00000000 to
>>>>> 0x00000001 00000004, it looks wrong else. I wonder if anyone get
>>>>> legacy
>>>>> I/O port resource from dts.
>>>>
>>>> As I said, nothing should really require the ranges property here,
>>>> unless
>>>> you have a valid IORESOURCE_MEM translation. The code that requires
>>>> the ranges to be present is wrong.
>>>>
>>>
>>> I think the openfirmware(DT) do not support for those unmapped I/O
>>> ports, because I
>>> must get resource by calling of_address_to_resource(), which have to
>>> call
>>> pci_address_to_pio() when resource type is IORESOURCE_IO. I'm sorry I
>>> have no
>>> better idea for this now. Maybe liviu can give me some opinions.
>>
>> I think on x86 it works (or used to work, few people use open firmware on
>> x86 these days, and it may be broken), and the pci_address_to_pio() call
>> behaves differently when PCI_IOBASE is set. x86 never maps I/O ports into
>> memory mapped I/O addresses, they have their own way of accessing them
>> just like your platform.
>>
>>> /**
>>>    * of_address_to_resource - Translate device tree address and
>>> return as resource
>>>    *
>>>    * Note that if your address is a PIO address, the conversion will
>>> fail if
>>>    * the physical address can't be internally converted to an IO
>>> token with
>>>    * pci_address_to_pio(), that is because it's either called to
>>> early or it
>>>    * can't be matched to any host bridge IO space
>>>    */
>>> int of_address_to_resource(struct device_node *dev, int index,
>>>                struct resource *r)
>>
>> The problem here seems to be that the code assumes that either the I/O
>> ports
>> are always mapped or they are never mapped (no PCI_IOBASE). We need to
>> extend
>> it because now we can have the combination of the two.
>
>
> Arnd , please take a look at the new solution when you have a
> moment,thanks.
> I modify the "drivers/of/address.c" to address the problem above.
>
> There are some assumptions:
>
> 1) ISA(LPC) Like bus must be scanned before PCI.
> 2) a property "unmapped-size" is introduced to ISA bus DT config, it
> means the address
>   range of the bus. if bus-A have a port range(0-99), bus-B have a port
> range(0-199), then
> the cpu port range (0-99) is reserved for bus-A and cpu port range (100, 299) is
> reserved for bus-B.
> 3) It it

I sorry, I made a mistake, please ignore 3). And I added the cpu port 
range(100, 299) for bus-B.

> ---
>   drivers/of/address.c | 76
> +++++++++++++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 70 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/of/address.c b/drivers/of/address.c
> index 9582c57..d3c71e5 100644
> --- a/drivers/of/address.c
> +++ b/drivers/of/address.c
> @@ -682,8 +682,16 @@ struct io_range {
>
>   static LIST_HEAD(io_range_list);
>   static DEFINE_SPINLOCK(io_range_lock);
> +phy_addr_t pci_pio_start = 0;
> +EXPORT_SYMBOL(pci_pio_start)
>   #endif
>
> +int isa_register_unmapped_io_range(resource_size_t size)
> +{
> +       pci_pio_start += size;
> +}
> +
> +
>   /*
>    * Record the PCI IO range (expressed as CPU physical address + size).
>    * Return a negative value if an error has occured, zero otherwise
> @@ -694,7 +702,7 @@ int __weak pci_register_io_range(phys_addr_t addr,
> resource_size_t size)
>
>   #ifdef PCI_IOBASE
>          struct io_range *range;
> -       resource_size_t allocated_size = 0;
> +       resource_size_t allocated_size = pci_pio_start;
>
>          /* check if the range hasn't been previously recorded */
>          spin_lock(&io_range_lock);
> @@ -743,7 +751,7 @@ phys_addr_t pci_pio_to_address(unsigned long pio)
>
>   #ifdef PCI_IOBASE
>          struct io_range *range;
> -       resource_size_t allocated_size = 0;
> +       resource_size_t allocated_size = pci_pio_start;
>
>          if (pio > IO_SPACE_LIMIT)
>                  return address;
> @@ -766,7 +774,7 @@ unsigned long __weak pci_address_to_pio(phys_addr_t
> address)
>   {
>   #ifdef PCI_IOBASE
>          struct io_range *res;
> -       resource_size_t offset = 0;
> +       resource_size_t offset = pci_pio_start;
>          unsigned long addr = -1;
>
>          spin_lock(&io_range_lock);
> @@ -788,21 +796,77 @@ unsigned long __weak
> pci_address_to_pio(phys_addr_t address)
>   #endif
>   }
>
> +static u64 of_get_unmapped_pio(struct device_node *dev, const __be32
> *inaddr)
> +{
> +       struct device_node *np, *parent = NULL;
> +       struct of_bus * bus, *pbus;
> +       struct property *p_property;
> +       int rlen;
> +       u32 size = 0;
> +       u32 port_base = 0;
> +
> +       /*IF NOT I/O port*/
> +       if(*(in_addr) != 0x01)
> +               return OF_BAD_ADDR;
> +       else
> +               *in_addr = 0;
> +
> +       parent = of_get_parent(dev);
> +       if(parent == NULL)
> +               return result;
> +       bus = of_match_bus(parent);
> +       if(!strcmp(bus->name, "isa")) {
> +               p_property = of_find_property(parent, "ranges", &rlen);
> +               /*no ranges property, this is a non-bridged isa bus, and
> the port on it is unmapped*/
> +               if(p_property == NULL) {
> +                       for_each_node_by_name(np, "isa") {
> +                               if((np != parent) &&
> +                                  !of_find_property(parent, "ranges",
> &rlen) &&
> +                                  !of_property_read_u32(parent,
> "unmapped-size", &size)) {
> +                                       port_base += size;
> +                               }
> +                               else if (np == parent) {
> +                                       of_bus_default_translate(in_addr
> + 1, port_base, 1);
> +                                       break;
> +                               }
> +                               else {
> +                                       continue;
> +                               }
> +                       }
> +                       return of_read_number(in_addr, 2);
> +
> +               }
> +
> +       }
> +       return OF_BAD_ADDR;
> +}
> +
>   static int __of_address_to_resource(struct device_node *dev,
>                  const __be32 *addrp, u64 size, unsigned int flags,
>                  const char *name, struct resource *r)
>   {
>          u64 taddr;
> +       u8 addr_type = 0;
>
>          if ((flags & (IORESOURCE_IO | IORESOURCE_MEM)) == 0)
>                  return -EINVAL;
>          taddr = of_translate_address(dev, addrp);
> -       if (taddr == OF_BAD_ADDR)
> -               return -EINVAL;
> +       if (taddr == OF_BAD_ADDR) {
> +
> +               taddr == of_get_unmapped_pio(dev, addrp);
> +               if(taddr == OF_BAD_ADDR)
> +                       return -EINVAL
> +               else    /*we get unmapped I/O port successfully*/
> +                       addr_type = 1;
> +       }
> +
>          memset(r, 0, sizeof(struct resource));
>          if (flags & IORESOURCE_IO) {
>                  unsigned long port;
> -               port = pci_address_to_pio(taddr);
> +               if(!addr_type)
> +                       port = pci_address_to_pio(taddr);
> +               else
> +                       port = (unsigned long)taddr;
>                  if (port == (unsigned long)-1)
>                          return -EINVAL;
>                  r->start = port;
