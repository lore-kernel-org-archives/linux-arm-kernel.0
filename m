From: sriku.linux@gmail.com (Srikanth Thokala)
Date: Fri, 11 Apr 2014 23:10:59 +0530
Subject: [PATCH v2 2/6] PCI: tegra: use new OF interrupt mapping when
 possible
In-Reply-To: <1394127555.4582.1.camel@weser.hi.pengutronix.de>
References: <1394025951-32438-1-git-send-email-l.stach@pengutronix.de>
 <1394025951-32438-3-git-send-email-l.stach@pengutronix.de>
 <5318B232.2020507@wwwdotorg.org>
 <1394127555.4582.1.camel@weser.hi.pengutronix.de>
Message-ID: <CA+mB=1JCjDMzTuctvSQgjNhBnkyUPC2ooAzJOX_PC5L1gAau8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lucas/Tanmay,

On Thu, Mar 6, 2014 at 11:09 PM, Lucas Stach <l.stach@pengutronix.de> wrote:
> Am Donnerstag, den 06.03.2014, 10:36 -0700 schrieb Stephen Warren:
>> On 03/05/2014 06:25 AM, Lucas Stach wrote:
>> > This is the recommended method of doing the IRQ
>> > mapping. For old devicetrees we fall back to the
>> > previous practice.
>>
>> Tested-by: Stephen Warren <swarren@nvidia.com>
>>
>> I tested both with and without patch 1/6, and the PCIe-based NIC on
>> Beaver worked fine either way. Without patch 1/6, I do see:
>>
>> pci 0000:00:01.0: of_irq_parse_pci() failed with rc=-22
>>
>> ... but that seems reasonable given that the DT that of_irq_parse_pci()
>> parses is missing, and did correctly trigger the fallback path, so
>> everything still worked.
>
> Yes, this should be normal. It spits this error for old DTs, but keeps
> doing the right thing. I'm not sure if we should downgrade this to info
> or dbg.

I see this error too on my setup (Xilinx PCIe Root Complex Driver),
https://lkml.org/lkml/2014/3/3/183

After digging into it, I see I need to override the API
pcibios_get_phb_of_node()
to pass my device node.  Is this the only possible way?

>From the discussion in this thread, I feel am missing something in the dt node.
Below is my dt node, please let me know if you see any issues.

+++++++++++++++++++++++
pcie{
   reg = <XXXX>;
   ranges = <YYYY>;
   interrupts = <0 52 4>;

   pcie_intc: interrupt-controller {
       interrupt-controller;
       #address-cells = <0>;
       #interrupt-cells = <1>;
   }

   interrupt-map-mask = <0 0 0 7>;
   interrupt-map = <0 0 0 1 &pcie_intc 1>,
                          <0 0 0 2 &pcie_intc 2>,
                          <0 0 0 3 &pcie_intc 3>,
                          <0 0 0 4 &pcie_intc 4>;
};

Thanks in advance,
Srikanth.

>
> Regards,
> Lucas
> --
> Pengutronix e.K.                           | Lucas Stach                 |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-5076 |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
