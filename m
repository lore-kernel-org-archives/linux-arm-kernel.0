From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 22 Sep 2014 09:26:51 +0200
Subject: [PATCH v4 1/2] bcma: register bcma as device tree driver
In-Reply-To: <1411339108-22307-1-git-send-email-hauke@hauke-m.de>
References: <1411339108-22307-1-git-send-email-hauke@hauke-m.de>
Message-ID: <4345256.UGZH9SeRYG@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 22 September 2014 00:38:27 Hauke Mehrtens wrote:
> +
> +- reg : iomem address range of chipcommon core
> +
> +The cores on the AXI bus are automatically detected by bcma with the
> +memory ranges they are using and they get registered afterwards.
> +Automatic detection of the IRQ number is not reliable on
> +BCM47xx/BCM53xx ARM SoCs. To assign IRQ numbers to the cores, provide
> +them manually through device tree. The IRQ number and the device tree
> +child entry will get assigned to the core with the matching reg address.
> +
> +Example:
> +
> +       axi at 18000000 {
> +               compatible = "brcm,bus-axi";
> +               reg = <0x18000000 0x1000>;
> +               ranges = <0x00000000 0x18000000 0x00100000>;
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +
> +               pcie at 12000 {
> +                       reg = <0x00012000 0x1000>;
> +                       interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
> +               };
> +
> +               ethernet at 24000 {
> +                       reg = <0x00024000 0x1000>;
> +                       interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
> +               };
> +
> +               ethernet at 25000 {
> +                       reg = <0x00025000 0x1000>;
> +                       interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
> +               };
> +       };
> 

While reading through this new version, I had a new idea about how
this could be handled better for any machines that have a unique
number in the interrupt field: If you do the same thing as PCI
and add an interrupt-map property [1], you can translate that
number into a real interrupt specifier for the child nodes.

This can work even if every device lists the local interrupt
as '0', since you can have device-specific lookup entries if you
use the correct interrupt-map-mask property.

	Arnd

[1] http://www.openfirmware.org/1275/practice/imap/imap0_9d.pdf
