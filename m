From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 22 Apr 2014 12:52:16 +0200
Subject: [PATCH RESEND 3/5] ARM: BCM63XX: add BCM63138 minimal Device Tree
In-Reply-To: <1398130758-19456-4-git-send-email-f.fainelli@gmail.com>
References: <1398130758-19456-1-git-send-email-f.fainelli@gmail.com>
 <1398130758-19456-4-git-send-email-f.fainelli@gmail.com>
Message-ID: <4701106.5EnjdVQgVO@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 21 April 2014 18:39:16 Florian Fainelli wrote:
> 
> +#include "skeleton.dtsi"
> +
> +/ {
> +       compatible = "brcm,bcm63138";
> +       model = "Broadcom BCM63138 DSL SoC";
> +       interrupt-parent = <&gic>;
> +
> +       cpus {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               cpu at 0 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a9";
> +                       next-level-cache = <&L2>;
> +                       reg = <0>;
> +               };
> +       };

Even if you don't support SMP yet, I can see no reason not
to list both CPUs here. The binding is known and the code
should ignore the extra cores if it doesn't know how to
turn them on.

> +
> +       /* ARM bus */
> +       axi at 80000000 {
> +               compatible = "simple-bus";
> +               ranges = <0 0x80000000 0x783003>;
> +               reg = <0x80000000 0x783003>;

The length seems odd, I would expect that the bus actually
translates all addresses in the 0x80000000 range to downstream
devices even if there is nothing connected. Just round it up
to your best knowledge.

I would also drop the 'reg' property. Since you don't have a
specific "compatible" value, there is no way to use the registers
in this node.

> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +
> +               L2: cache-controller at 1d000 {
> +                       compatible = "arm,pl310-cache";
> +                       reg = <0x1d000 0x1000>;
> +                       cache-unified;
> +                       cache-level = <2>;
> +                       interrupts = <GIC_PPI 0 IRQ_TYPE_LEVEL_HIGH>;
> +               };
> +
> +               mpcore at 1e000 {
> +                       compatible = "simple-bus";
> +                       reg = <0x1e000 0x20000>;
> +                       ranges = <0 0x1e000 0x20000>;
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;


Same thing here.

Also, can you explain why there is a separate 'mpcore' bus, and why the
cache controller is not part of that?

Do you have reason to believe that this is how the hardware actually
looks?

> +
> +       /* Legacy UBUS base */
> +       ubus at fffe8000 {
> +               compatible = "simple-bus";
> +               reg = <0xfffe8000 0x8053>;
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               ranges = <0 0xfffe8000 0x8053>;
> +       };
> +};


Again, use a proper 'length' here and remove the 'reg' property.

	Arnd
