From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 04 Jan 2016 12:13:05 +0100
Subject: [PATCH v1 3/3] ARM64 LPC: update binding doc
In-Reply-To: <568912EE.9030009@huawei.com>
References: <1451396032-23708-1-git-send-email-zourongrong@gmail.com>
 <CABTftiT1+AmrNjiAie-T6on-oWA4Zz73+Tj2pQrixMT3o475uw@mail.gmail.com>
 <568912EE.9030009@huawei.com>
Message-ID: <15026471.7nGZ0rWlIf@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 03 January 2016 20:24:14 Rongrong Zou wrote:
> ? 2015/12/31 23:00, Rongrong Zou ??:
> > 2015-12-31 22:40 GMT+08:00 Arnd Bergmann <arnd at arndb.de <mailto:arnd@arndb.de>>:
> >  > On Thursday 31 December 2015 22:12:19 Rongrong Zou wrote:
> >  > > ? 2015/12/30 17:06, Arnd Bergmann ??:
> >  > > > On Tuesday 29 December 2015 21:33:52 Rongrong Zou wrote:
> >  >
> >  > The DT sample above looks good in principle. I believe what you are missing
> >  > here is code in your driver to scan the child nodes to create the platform
> >  > devices. of_bus_isa_translate() should work with your definition here
> >  > and create the correct IORESOURCE_IO resources. You don't have any MMIO
> >  > resources, so the absence of a ranges property is ok. Maybe all you
> >  > are missing is a call to of_platform_populate() or of_platform_bus_probe()?
> >  >
> >
> > You are right. thanks, i'll try on test board .  if i get the correct result , the new patch
> > will be sent later. By the way, it's my another email account use when i at home.
> 
> I tried, and there need some additional changes.
> 
> isa at a01b0000 {
> 
> /*the node name should start with "isa", because of below definition
> * static int of_bus_isa_match(struct device_node *np)
> * {
> *	return !strcmp(np->name, "isa");
> * }

Looks good. It would be nicer to match on device_type than on name,
but this is ancient code and it's probably best not to touch it
so we don't accidentally break some old SPARC or PPC system.

> */
> 	compatible = "low-pin-count";
> 	device_type = "isa";
> 	#address-cells = <2>;
> 	#size-cells = <1>;
> 	reg = <0x0 0xa01b0000 0x0 0x10000>;
> 	ranges = <0x1 0x0 0x0 0x0 0x1000>;
> /*
> *  ranges is required, then i can get the IORESOURCE_IO <0xe4,4> from "reg = <0x1, 0x000000e4, 4>".
> *
> */
> 	ipmi_0:ipmi at 000000e4{
> 		device_type = "ipmi";
> 		compatible = "ipmi-bt";
> 		reg = <0x1 0x000000e4 0x4>;
> };
> 

This looks wrong: the property above says that the I/O port range is
translated to MMIO address 0x00000000 to 0x00010000, which is not
true on your hardware. I think this needs to be changed in the code
so the ranges property is not required for I/O ports.

> drivers\of\address.c
> static int __of_address_to_resource(struct device_node *dev,
>                  const __be32 *addrp, u64 size, unsigned int flags,
>                  const char *name, struct resource *r)
> {
>          u64 taddr;
> 
>          if ((flags & (IORESOURCE_IO | IORESOURCE_MEM)) == 0)
>                  return -EINVAL;
>          taddr = of_translate_address(dev, addrp);
>          if (taddr == OF_BAD_ADDR)
>                  return -EINVAL;
>          memset(r, 0, sizeof(struct resource));
>          if (flags & IORESOURCE_IO) {
>                  unsigned long port;
> 
> /*****************************************************************/
> /*legacy port(< 0x1000) is reserved, and need no translation here*/
> /*****************************************************************/
>                  if(taddr + size < PCIBIOS_MIN_IO){
>                          r->start = taddr;
>                          r->end = taddr + size - 1;
>                  }

I don't like having a special case based on the address here,
the same kind of hack might be needed for PCI I/O spaces in
hardware that uses an indirect method like your LPC bus
does, and the code above will not work on any LPC implementation
that correctly multiplexes its I/O ports with the first PCI domain.

I think it would be better to avoid translating the port into
a physical address to start with just to translate it back into
a port number, what we need instead is the offset between the
bus specific port number and the linux port number. I've added
Liviu to Cc, he wrote this code originally and may have some idea
of how we could do that.

	Arnd
