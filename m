From: zourongrong@huawei.com (Rongrong Zou)
Date: Sun, 3 Jan 2016 20:24:14 +0800
Subject: [PATCH v1 3/3] ARM64 LPC: update binding doc
In-Reply-To: <CABTftiT1+AmrNjiAie-T6on-oWA4Zz73+Tj2pQrixMT3o475uw@mail.gmail.com>
References: <1451396032-23708-1-git-send-email-zourongrong@gmail.com>
 <1899302.RWIn6Bg3Dr@wuerfel> <568537C3.3060902@huawei.com>
 <17750582.ajK78gYOFz@wuerfel>
 <CABTftiT1+AmrNjiAie-T6on-oWA4Zz73+Tj2pQrixMT3o475uw@mail.gmail.com>
Message-ID: <568912EE.9030009@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2015/12/31 23:00, Rongrong Zou ??:
>
>
> 2015-12-31 22:40 GMT+08:00 Arnd Bergmann <arnd at arndb.de <mailto:arnd@arndb.de>>:
>  >
>  > On Thursday 31 December 2015 22:12:19 Rongrong Zou wrote:
>  > > ? 2015/12/30 17:06, Arnd Bergmann ??:
>  > > > On Tuesday 29 December 2015 21:33:52 Rongrong Zou wrote:
>  > > >> +Example:
>  > > >> +
>  > > >> +        lpc_0: lpc at a01b0000 {
>  > > >> +          #address-cells = <1>;
>  > > >> +          #size-cells = <1>;
>  > > >> +                compatible = "low-pin-count";
>  > > >> +                reg = <0x0 0xa01b0000 0x0 0x10000>;
>  > > >> +        };
>  > > >
>  > > > One more thought: please try to stick as closely as possible to the existing
>  > > > ISA binding that is documented at
>  > > >
>  > > > http://www.firmware.org/1275/bindings/isa/isa0_4d.ps
>  > >  From the specification, I think I should use 2 32bit integer to describe the isa addr in dts.
>  > > >
>  > > > In particular, this should cover the possibility of describing both memory
>  > > > and I/O spaces in child devices.
>  > > >
>  > >
>  > > I found below config in powerpc dts "arch/powerpc/boot/dts/mpc8544ds.dts"
>  > >
>  > > isa at 1e {
>  > >                                  device_type = "isa";
>  > >                                  #interrupt-cells = <2>;
>  > >                                  #size-cells = <1>;
>  > >                                  #address-cells = <2>;
>  > >                                  reg = <0xf000 0x0 0x0 0x0 0x0>;
>  > >                                  ranges = <0x1 0x0 0x1000000 0x0 0x0
>  > >                                            0x1000>;
>  > >                                  interrupt-parent = <&i8259>;
>  > >
>  > >
>  > >
>  > >                                  rtc at 70 {
>  > >                                          compatible = "pnpPNP,b00";
>  > >                                          reg = <0x1 0x70 0x2>;
>  > >                                  };
>  > >   the isa space in child-node: reg = <0x1 0x70 0x2>;
>  > >   0x1 means IO space, 70 means addr, 0x2 is size.
>  > >   but when i config the following in dts, the ipmi_0 node can't be probed,
>  > >   I think there may be some problems.
>  > >
>  > > lpc_0: lpc at a01b0000 {
>  > >       compatible = "low-pin-count";
>  > >       device_type = "isa";
>  > >       #address-cells = <2>;
>  > >       #size-cells = <1>;
>  > >       reg = <0x0 0xa01b0000 0x0 0x10000>;
>  > >
>  > >       ipmi_0:ipmi at 000000e4{
>  > >               device_type = "ipmi";
>  > >               compatible = "ipmi-bt";
>  > >               reg = <0x1 0x000000e4 0x4>;
>  > > };
>  >
>  > The DT sample above looks good in principle. I believe what you are missing
>  > here is code in your driver to scan the child nodes to create the platform
>  > devices. of_bus_isa_translate() should work with your definition here
>  > and create the correct IORESOURCE_IO resources. You don't have any MMIO
>  > resources, so the absence of a ranges property is ok. Maybe all you
>  > are missing is a call to of_platform_populate() or of_platform_bus_probe()?
>  >
>
> You are right. thanks, i'll try on test board .  if i get the correct result , the new patch
> will be sent later. By the way, it's my another email account use when i at home.

I tried, and there need some additional changes.

isa at a01b0000 {

/*the node name should start with "isa", because of below definition
* static int of_bus_isa_match(struct device_node *np)
* {
*	return !strcmp(np->name, "isa");
* }
*/
	compatible = "low-pin-count";
	device_type = "isa";
	#address-cells = <2>;
	#size-cells = <1>;
	reg = <0x0 0xa01b0000 0x0 0x10000>;
	ranges = <0x1 0x0 0x0 0x0 0x1000>;
/*
*  ranges is required, then i can get the IORESOURCE_IO <0xe4,4> from "reg = <0x1, 0x000000e4, 4>".
*
*/
	ipmi_0:ipmi at 000000e4{
		device_type = "ipmi";
		compatible = "ipmi-bt";
		reg = <0x1 0x000000e4 0x4>;
};

drivers\of\address.c
static int __of_address_to_resource(struct device_node *dev,
                 const __be32 *addrp, u64 size, unsigned int flags,
                 const char *name, struct resource *r)
{
         u64 taddr;

         if ((flags & (IORESOURCE_IO | IORESOURCE_MEM)) == 0)
                 return -EINVAL;
         taddr = of_translate_address(dev, addrp);
         if (taddr == OF_BAD_ADDR)
                 return -EINVAL;
         memset(r, 0, sizeof(struct resource));
         if (flags & IORESOURCE_IO) {
                 unsigned long port;

/*****************************************************************/
/*legacy port(< 0x1000) is reserved, and need no translation here*/
/*****************************************************************/
                 if(taddr + size < PCIBIOS_MIN_IO){
                         r->start = taddr;
                         r->end = taddr + size - 1;
                 }


                 else{
                         port = pci_address_to_pio(taddr);
                         if (port == (unsigned long)-1)
                                 return -EINVAL;
                         r->start = port;
                         r->end = port + size - 1;
                 }
         } else {
                 r->start = taddr;
                 r->end = taddr + size - 1;
         }
         r->flags = flags;
         r->name = name ? name : dev->full_name;

         return 0;
}



>
>  >         Arnd
