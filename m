From: sunil.kovvuri@gmail.com (Sunil Kovvuri)
Date: Wed, 24 Sep 2014 23:34:04 +0530
Subject: [PATCH 3/6] pci,
 thunder: Add PCIe host controller devicetree bindings
In-Reply-To: <3082935.e3X4GsVUDn@wuerfel>
References: <1411573068-12952-1-git-send-email-rric@kernel.org>
 <1411573068-12952-4-git-send-email-rric@kernel.org>
 <3082935.e3X4GsVUDn@wuerfel>
Message-ID: <CA+sq2Ce8sb=YGma05qEk_992Mc9M92TxCk+RWsyi6tY-FVOCXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 24, 2014 at 9:36 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 24 September 2014 17:37:45 Robert Richter wrote:
>>
>> +       pcie0 at 0x8480,00000000 {
>
> The name should be pci, not pci0.

Thanks, will change.

>
>> +               compatible = "cavium,thunder-pcie";
>> +               device_type = "pci";
>> +               msi-parent = <&its>;
>> +               bus-range = <0 255>;
>> +               #size-cells = <2>;
>> +               #address-cells = <3>;
>> +               reg = <0x8480 0x00000000 0 0x10000000>;  /* Configuration space */
>> +               ranges = <0x03000000 0x8010 0x00000000 0x8010 0x00000000 0x70 0x00000000>, /* mem ranges */
>> +                       <0x03000000 0x8300 0x00000000 0x8300 0x00000000 0x80 0x00000000>,
>> +                       <0x03000000 0x87e0 0x00000000 0x87e0 0x00000000 0x01 0x00000000>;
>> +        };
>
> If you claim the entire 0-255 bus range, I think you should also
> specify a domain, otherwise it's not predictable which domain you
> get.
>
> The interrupt-map and interrupt-map-mask properties are required for PCI,
> otherwise you can't do LSI interrupts.

This PCI controller supports only MSIx interrupts which are edge triggered.

>
> If your hardware can support it, you should also list I/O space and prefetchable
> memory spaces. Can you explain why you have multiple non-prefetchable ranges?

Our hardware is an ECAM based host controller and doesn't support I/O
and prefetchable memory spaces.
All on-board PCI devices connected to this PCI controller have fixed resources
and doesn't have to be allocated/reassigned. Some of these devices are
SRIOV based.
Kernel's SRIOV (pci/iov.c) is expecting 'resource->parent' hierarchy
to be set, otherwise doesn't
enable SRIOV device. So, here multiple non-prefetchable ranges of root bus
aid in resource claiming and setting res->parent hierarchy.

We do call "pci_claim_resource" in controller driver code.
"[PATCH 1/6] pci, thunder: Add support for Thunder PCIe host controller."

>
>         Arnd
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
