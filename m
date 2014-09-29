From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 29 Sep 2014 16:42:18 +0200
Subject: [RFC 4/4] irqchip: gicv2m: Add supports for ARM GICv2m MSI(-X)
In-Reply-To: <1411937610-22125-5-git-send-email-suravee.suthikulpanit@amd.com>
References: <1411937610-22125-1-git-send-email-suravee.suthikulpanit@amd.com>
 <1411937610-22125-5-git-send-email-suravee.suthikulpanit@amd.com>
Message-ID: <2648363.DSa0NxqRJL@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 28 September 2014 15:53:30 suravee.suthikulpanit at amd.com wrote:
> +       interrupt-controller at e1101000 {
> +               compatible = "arm,gic-400";
> +               #interrupt-cells = >;
> +               #address-cells = <2>;
> +               #size-cells = <2>;
> +               interrupt-controller;
> +               interrupts = <1 8 0xf04>;
> +               ranges = <0 0 0 0xe1100000 0 0x100000>;
> +               reg = <0x0 0xe1110000 0 0x01000>,
> +                     <0x0 0xe112f000 0 0x02000>,
> +                     <0x0 0xe1140000 0 0x10000>,
> +                     <0x0 0xe1160000 0 0x10000>;
> +               v2m0: v2m at 0x8000 {
> +                       compatible = "arm,gic-v2m-frame";
> +                       msi-controller;
> +                       reg = <0x0 0x80000 0 0x1000>;
> +               };
> +
> +               ....
> +
> +               v2mN: v2m at 0x9000 {
> +                       compatible = "arm,gic-v2m-frame";
> +                       msi-controller;
> +                       reg = <0x0 0x90000 0 0x1000>;
> +               };
> +       };
> 

Could this just be modeled as a separate msi-controller node
outside of the GIC?

Instead of the arm,msi-base-spi/arm,msi-num-spis properties, how
about using regular "interrupts"/"interrupt-parent" properties listing
the exact interrupts? That would also make it more flexible in
case the same layout is used with a parent other than the GIC.

	ARnd
