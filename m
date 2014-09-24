From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 24 Sep 2014 18:06:04 +0200
Subject: [PATCH 3/6] pci,
 thunder: Add PCIe host controller devicetree bindings
In-Reply-To: <1411573068-12952-4-git-send-email-rric@kernel.org>
References: <1411573068-12952-1-git-send-email-rric@kernel.org>
 <1411573068-12952-4-git-send-email-rric@kernel.org>
Message-ID: <3082935.e3X4GsVUDn@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 24 September 2014 17:37:45 Robert Richter wrote:
> 
> +       pcie0 at 0x8480,00000000 {

The name should be pci, not pci0.

> +               compatible = "cavium,thunder-pcie";
> +               device_type = "pci";
> +               msi-parent = <&its>;
> +               bus-range = <0 255>;
> +               #size-cells = <2>;
> +               #address-cells = <3>;
> +               reg = <0x8480 0x00000000 0 0x10000000>;  /* Configuration space */
> +               ranges = <0x03000000 0x8010 0x00000000 0x8010 0x00000000 0x70 0x00000000>, /* mem ranges */
> +                       <0x03000000 0x8300 0x00000000 0x8300 0x00000000 0x80 0x00000000>,
> +                       <0x03000000 0x87e0 0x00000000 0x87e0 0x00000000 0x01 0x00000000>;
> +        };

If you claim the entire 0-255 bus range, I think you should also
specify a domain, otherwise it's not predictable which domain you
get.

The interrupt-map and interrupt-map-mask properties are required for PCI,
otherwise you can't do LSI interrupts.

If your hardware can support it, you should also list I/O space and prefetchable
memory spaces. Can you explain why you have multiple non-prefetchable ranges?

	Arnd
