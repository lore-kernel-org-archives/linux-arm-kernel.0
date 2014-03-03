From: tharvey@gateworks.com (Tim Harvey)
Date: Mon, 3 Mar 2014 15:40:43 -0800
Subject: [PATCH 0/7] PCI irq mapping fixes and cleanups
In-Reply-To: <CAJ+vNU3UL+LTWnoxW7scAig19=z2xoYCA-HZ6a7GUyGEXtKK9Q@mail.gmail.com>
References: <1393608523-17509-1-git-send-email-l.stach@pengutronix.de>
 <CAJ+vNU2VN5haOU2GN5o7UUg9vgYh06pAhvDaoGw6EzTBEbD0mg@mail.gmail.com>
 <20140301183059.GA6315@obsidianresearch.com>
 <000601cf36b8$330b3a90$9921afb0$%han@samsung.com>
 <CAJ+vNU3UL+LTWnoxW7scAig19=z2xoYCA-HZ6a7GUyGEXtKK9Q@mail.gmail.com>
Message-ID: <CAJ+vNU2ojt_o9=AOGfpbx6NCOE_kE6tsV8FvjoGYk9BBwP_OFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 3, 2014 at 9:49 AM, Tim Harvey <tharvey@gateworks.com> wrote:
> On Mon, Mar 3, 2014 at 12:11 AM, Jingoo Han <jg1.han@samsung.com> wrote:
>> On Sunday, March 02, 2014 3:31 AM, Jason Gunthorpe wrote:
>>> On Fri, Feb 28, 2014 at 04:53:33PM -0800, Tim Harvey wrote:
>>>
<snip>
> The configuration I'm testing is:
> root at OpenWrt:/# lspci -n
> 00:00.0 0604: 16c3:abcd (rev 01)
> 01:00.0 0604: 10b5:8609 (rev ba)
> 01:00.1 0880: 10b5:8609 (rev ba)
> 02:01.0 0604: 10b5:8609 (rev ba)
> 02:04.0 0604: 10b5:8609 (rev ba)
> 02:05.0 0604: 10b5:8609 (rev ba)
> 02:06.0 0604: 10b5:8609 (rev ba)
> 02:07.0 0604: 10b5:8609 (rev ba)
> 02:08.0 0604: 10b5:8609 (rev ba)
> 02:09.0 0604: 10b5:8609 (rev ba)
> 07:00.0 0280: 168c:002b (rev 01)
> 08:00.0 0200: 11ab:4380
> root at OpenWrt:/# lspci -tnv
> -[0000:00]---00.0-[01-09]--+-00.0-[02-09]--+-01.0-[03]--
>                            |               +-04.0-[04]--
>                            |               +-05.0-[05]--
>                            |               +-06.0-[06]--
>                            |               +-07.0-[07]----00.0  168c:002b
>                            |               +-08.0-[08]----00.0  11ab:4380
>                            |               \-09.0-[09]--
>                            \-00.1  10b5:8609
>
>
> The dev_info showing what of_irq_parse_and_map_pci() above produces:
> [    1.818485] pci 0000:00:00.0: dw_pcie_map_irq: 16c3:abcd slot0 pin1 irq20
> [    1.818703] pci 0000:01:00.0: dw_pcie_map_irq: 10b5:8609 slot0 pin1 irq20
> [    1.818939] pci 0000:01:00.1: dw_pcie_map_irq: 10b5:8609 slot0 pin2 irq0
> [    1.819179] pci 0000:02:01.0: dw_pcie_map_irq: 10b5:8609 slot0 pin2 irq0
> [    1.819395] pci 0000:02:04.0: dw_pcie_map_irq: 10b5:8609 slot0 pin1 irq20
> [    1.819631] pci 0000:02:05.0: dw_pcie_map_irq: 10b5:8609 slot0 pin2 irq0
> [    1.819859] pci 0000:02:06.0: dw_pcie_map_irq: 10b5:8609 slot0 pin3 irq0
> [    1.820087] pci 0000:02:07.0: dw_pcie_map_irq: 10b5:8609 slot0 pin4 irq0
> [    1.820404] pci 0000:02:08.0: dw_pcie_map_irq: 10b5:8609 slot0 pin1 irq20
> [    1.820650] pci 0000:02:09.0: dw_pcie_map_irq: 10b5:8609 slot0 pin2 irq0
> [    1.820881] pci 0000:07:00.0: dw_pcie_map_irq: 168c:002b slot0 pin4 irq0
> [    1.821100] pci 0000:08:00.0: dw_pcie_map_irq: 11ab:4380 slot0 pin1 irq20
>
> I'm not clear why irq 20 is getting returned for all the slots with
> (slot%4)=0 and func=0.  If I start debugging of_irq_parse_pci() I see
> that it walks up the tree until it gets to the pcie host controller
> then calls of_irq_parse_raw() which is returning irq20 or -EINVAL.

For the slots above that are swizzling to pin1 this appears to be an
issue with irq_create_of_mapping() called form
of_irq_parse_and_map_pci().  The GIC function that translates the
interrupt per domain is given irq_data: 0x123 0x04 0x00 (meaning GIC
IRQ 123, which should get 32 added to it for irq155).  Instead, the
implementation of gic_irq_domain_xlate()
(http://lxr.missinglinkelectronics.com/linux/drivers/irqchip/irq-gic.c#L832)
adds 32 to the 0x04 returning 20:
[    1.841781] of_irq_parse_raw:  /soc/pcie at 0x01000000:00000001
[    1.841813] of_irq_parse_raw: ipar=/soc/pcie at 0x01000000, size=1
[    1.841838]  -> addrsize=3
[    1.841870]  -> match=1 (imaplen=28)
[    1.841903]  -> newintsize=3, newaddrsize=1
[    1.841916]  -> imaplen=23
[    1.841928]  -> new parent: /interrupt-controller at 00a01000
[    1.841946]  -> got it !
[    1.841972] irq_create_of_mapping: calling xlate for 123/4/0 3
[    1.841984] irq_create_of_mapping got irq from xlate: 20
^^^^^ added debugging shows 3 u32's passed to xlate and returned value of 20
[    1.841998] irq: irq_create_mapping(0xbec10400, 0x14)
[    1.842009] irq: -> using domain @bec10400
[    1.842021] irq: -> existing mapping on virq 20
[    1.842032] irq_create_of_mapping created virq=20
[    1.842042] irq_create_of_mapping returning virq=20
[    1.842059] pci 0000:00:00.0: dw_pcie_map_irq: 16c3:abcd slot0 pin1 irq20

Perhaps this is a byte-ordering issue?  I'm wondering if the args
created in of_irq_parse_pci are getting put in the wrong place for
what irq_create_of_mapping() expects.

For the slots above that swizzle to pin2,3,4 of_irq_parse_raw()
returns -EINVAL because for some reason it can't match an interrupt
mapping for the pcie host controller:
[    1.842996] of_irq_parse_raw:  /soc/pcie at 0x01000000/pcie at 0,0:00000002
[    1.843046] of_irq_parse_raw: ipar=/soc/pcie at 0x01000000, size=1
[    1.843070]  -> addrsize=3
[    1.843100]  -> match=0 (imaplen=28)
^^^^^ indicates no match in interrupt map.

I think this is because size=1 above, when we should see an
interrupt-map of size 4.  I'm guessing that the function is confused
between the single interrupt in the DT for the host controller, vs the
interrupt-map for the PCI interrupts.

At this point, with no match, of_irq_parse_raw() will travel up to the
parent of the interrupt which is wrong.

Note the pcie host controller DT is:

    pcie: pcie at 0x01000000 {
      compatible = "fsl,imx6q-pcie", "snps,dw-pcie";
      reg = <0x01ffc000 0x4000>; /* DBI */
      #address-cells = <3>;
      #size-cells = <2>;
      device_type = "pci";
      ranges = <0x00000800 0 0x01f00000 0x01f00000 0 0x00080000 /*
configuration space */
          0x81000000 0 0          0x01f80000 0 0x00010000 /* downstream I/O */
          0x82000000 0 0x01000000 0x01000000 0 0x00f00000>; /*
non-prefetchable memory */
      num-lanes = <1>;

      interrupts = <0 123 0x04>;

      #interrupt-cells = <1>;
      interrupt-map-mask = <0 0 0 0x7>;
      interrupt-map = <0 0 0 1 &intc GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
                      <0 0 0 2 &intc GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
                      <0 0 0 3 &intc GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
                      <0 0 0 4 &intc GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;

      clocks = <&clks 189>, <&clks 187>, <&clks 206>, <&clks 144>;
      clock-names = "pcie_ref_125m", "sata_ref_100m", "lvds_gate", "pcie_axi";
      status = "disabled";
    };

Tim

>
> Tim
>
>> You can test i.MX PCIe with this.
>>
>> ./drivers/pci/host/pcie-designware.c
>> @@ -726,7 +727,7 @@ static struct pci_bus *dw_pcie_scan_bus(int nr, struct pci_sys_data *sys)
>>
>>         if (pp) {
>>                 pp->root_bus_nr = sys->busnr;
>> -               bus = pci_scan_root_bus(NULL, sys->busnr, &dw_pcie_ops,
>> +               bus = pci_scan_root_bus(pp->dev, sys->busnr, &dw_pcie_ops,
>>                                         sys, &sys->resources);
>>         } else {
>>                 bus = NULL;
>>
>> However, I think that we may need to replace 'pci_common_init()'
>> with 'pci_common_init_dev()'.
>>
>> Best regards,
>> Jingoo Han
>>
